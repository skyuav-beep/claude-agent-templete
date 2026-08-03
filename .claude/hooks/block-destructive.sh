#!/usr/bin/env bash
# PreToolUse/Bash: 파괴적 명령 차단
# Golden Rule: "사용자 요청 없이 파괴적 명령을 실행하지 않는다"
#
# 입력 규약: Claude Code는 훅에 stdin으로 JSON을 전달한다.
#   {"hook_event_name":"PreToolUse","tool_name":"Bash","tool_input":{"command":"..."}}
# 구 규약($CLAUDE_TOOL_INPUT 환경변수)은 현행 CLI에 존재하지 않으므로 stdin이 1차,
# 환경변수는 폴백으로만 둔다.
# 차단 시 exit 2 + stderr 출력이 에이전트에게 전달되는 규약이다.
#
# payload를 argv나 환경변수로 넘기면 MAX_ARG_STRLEN(128KB)에 걸린다. Write의
# tool_input에는 파일 본문 전체가 실려 수백 KB가 되므로, 파이썬 스크립트는
# fd 3으로 주고 stdin은 payload 전용으로 남긴다.

COMMAND=$(python3 /dev/fd/3 3<<'PY' 2>/dev/null
import json, os, re, sys

# 아래 패턴 검사는 명령 문자열 전체를 훑는다. 그대로 두면 "실행되지 않는 텍스트"
# (heredoc으로 넘기는 스크립트 본문, 인용부호 안의 데이터)에도 반응해 오차단된다.
# 실행 문맥만 남기고 데이터 문맥을 걷어낸 뒤 검사한다.

# 인용문이 곧 코드가 되는 호출(`bash -c '...'`, eval, xargs). 이때는 원문을 그대로
# 검사해야 우회를 막는다. `bash -n script.sh`나 `x.sh` 같은 파일명에는 반응하지 않도록
# 셸이 실제 명령 위치에 오고 -c 계열 플래그가 붙은 경우만 본다.
SHELL_EVAL = re.compile(
    r"(?:^|[|;&]\s*)(?:ba|z|k|da)?sh\s+(?:-[A-Za-z]+\s+)*-[A-Za-z]*c\b"
    r"|\b(?:eval|xargs|ssh)\b",
    re.M,
)

# heredoc 본문이 코드가 되는 경우(`bash <<'EOF'`)는 -c 없이도 성립한다.
SHELL_HEREDOC = re.compile(r"(?:^|[|;&]\s*)(?:ba|z|k|da)?sh\b|\b(?:eval|xargs)\b", re.M)


def strip_heredocs(cmd: str) -> str:
    """heredoc 본문은 데이터다. 단 셸에 그대로 먹이는 경우는 본문도 명령이므로 남긴다."""
    lines = cmd.split("\n")
    kept, i = [], 0
    while i < len(lines):
        line = lines[i]
        kept.append(line)
        i += 1
        m = re.search(r"<<-?\s*['\"]?([A-Za-z_][A-Za-z0-9_]*)['\"]?", line)
        if not m or SHELL_HEREDOC.search(line):
            continue
        delim = m.group(1)
        while i < len(lines) and lines[i].strip() != delim:
            i += 1
        i += 1  # 종료 구분자 라인도 건너뛴다
    return "\n".join(kept)


def strip_comments(cmd: str) -> str:
    """셸 주석은 실행되지 않는 텍스트다.

    설명문에 적어 둔 `# rm -rf 금지` 같은 문구에 반응해 오차단되는 것을 막는다.
    셸과 같은 규칙으로 단어 시작 위치(줄 처음 또는 공백 뒤)의 `#`만 주석으로 본다.
    그래서 `$#`, `${#var}`, `sed 's#a#b#'`, URL의 `#fragment`는 앞이 공백이 아니라
    그대로 남는다. 인용부호 안의 `#`도 잘리지만 그 부분은 어차피 데이터다.
    """
    return re.sub(r"(?m)(?:(?<=^)|(?<=\s))#.*$", " ", cmd)


def strip_quoted(cmd: str) -> str:
    """인용부호 안 문자열은 데이터로 본다. 셸 호출이 섞여 있으면 보수적으로 원문 유지."""
    if SHELL_EVAL.search(cmd):
        return cmd
    return re.sub(r"'[^']*'|\"[^\"]*\"", " ", cmd)


raw = sys.stdin.read()
if not raw.strip():
    raw = os.environ.get("CLAUDE_TOOL_INPUT", "")
if not raw.strip():
    sys.exit(0)
try:
    d = json.loads(raw)
except Exception:
    sys.exit(0)
if not isinstance(d, dict):
    sys.exit(0)
ti = d.get("tool_input")
ti = ti if isinstance(ti, dict) else {}
print(strip_quoted(strip_comments(strip_heredocs(ti.get("command") or d.get("command") or ""))))
PY
)
[ -z "$COMMAND" ] && exit 0

BLOCKED=""

# rm: -r과 -f가 같은 그룹이든 분리되어 있든 모두 차단.
# 위치 제약(줄 시작/체인 뒤)을 두면 `find ... -exec rm -rf {}`나 `sh -c "rm -rf /"`를
# 놓친다. 데이터 문맥은 앞 단계에서 제거되므로 위치 제약 없이 검사하되, `docker run --rm`
# 처럼 '-'가 앞에 붙은 플래그는 제외한다.
if echo "$COMMAND" | grep -qE "(^|[[:space:];&|(\"'])rm[[:space:]]"; then
  if echo "$COMMAND" | grep -qE '\s-[a-zA-Z]*r' && echo "$COMMAND" | grep -qE '\s-[a-zA-Z]*f'; then
    BLOCKED="rm -rf"
  fi
fi

echo "$COMMAND" | grep -qE 'git\s+reset\s+--hard' && BLOCKED="git reset --hard"
echo "$COMMAND" | grep -qE 'git\s+push\s+.*(-f|--force)\b' && BLOCKED="git push --force"
echo "$COMMAND" | grep -qE 'git\s+clean\s+.*-[a-zA-Z]*f' && BLOCKED="git clean -f"
echo "$COMMAND" | grep -qE 'git\s+checkout\s+\.\s*$' && BLOCKED="git checkout ."

if [ -n "$BLOCKED" ]; then
  echo "[Hooks L3] 차단: '$BLOCKED' 패턴이 감지되었습니다. 파괴적 명령은 사용자 확인 후 실행하세요." >&2
  exit 2
fi

exit 0
