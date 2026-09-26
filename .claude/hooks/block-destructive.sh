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

# Python 본문은 임시 파일로 넘긴다. Windows(MSYS)에서 /dev/fd/3은 네이티브
# Python이 열 수 없는 경로로 번역되어 판정이 조용히 통과된다.
# payload는 계속 stdin 전용으로 남으므로 MAX_ARG_STRLEN 제약을 받지 않는다.
# `git reset --hard` 판정은 payload를 한 번 더 읽어야 하므로 stdin을 임시 파일에
# 받아 두고 두 스크립트에 각각 리다이렉트로 넘긴다.
PYSRC=$(mktemp) || exit 0
trap 'rm -f "$PYSRC" "$RESETSRC" "$PAYLOAD"' EXIT
RESETSRC=$(mktemp) || exit 0
PAYLOAD=$(mktemp) || exit 0
cat >"$PAYLOAD"
cat >"$PYSRC" <<'PY'
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
COMMAND=$(python3 "$PYSRC" <"$PAYLOAD" 2>/dev/null)
[ -z "$COMMAND" ] && exit 0

# `git reset --hard`는 막지 않고 실행 직전에 확인받는다. 다만 커밋하지 않은 변경이나
# 원격 어디에도 없는 커밋이 있으면 reset이 그것을 되돌릴 수 없게 지우므로, 먼저
# Git 정리(커밋 -> push -> PR -> 머지)로 보존하도록 보류한다.
# 추적하지 않는 파일은 보통 남지만, 대상 커밋에 같은 경로가 있으면 경고 없이 덮어써지므로
# 그 경우만 보존 대상에 넣는다.
# 사용자가 버려도 된다고 분명히 말하면 에이전트가 일회용 폐기 확인 파일을 만들고,
# 이 판정은 그 파일을 읽는 즉시 지운 뒤 사라질 작업을 경고하며 확인을 요청한다.
cat >"$RESETSRC" <<'PY'
import json, os, re, shlex, subprocess, sys


def git(cwd, *args):
    result = subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True, timeout=15)
    return result.stdout.strip() if result.returncode == 0 else None


def split_args(text):
    try:
        return shlex.split(text)
    except ValueError:
        return text.split()


def hold(reason):
    print(f"[Hooks L3] 보류: {reason}", file=sys.stderr)
    sys.exit(2)


def ask(reason):
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "ask",
            "permissionDecisionReason": f"[Hooks L3] {reason}",
        }
    }, ensure_ascii=False))
    sys.exit(0)


raw = sys.stdin.read()
if not raw.strip():
    raw = os.environ.get("CLAUDE_TOOL_INPUT", "")
try:
    payload = json.loads(raw)
except Exception:
    payload = {}
payload = payload if isinstance(payload, dict) else {}
ti = payload.get("tool_input")
ti = ti if isinstance(ti, dict) else {}
command = ti.get("command") or payload.get("command") or ""

# reset 호출을 찾는다. git 전역 옵션(-C, -c)이나 reset 옵션(-q)이 사이에 끼거나
# --hard가 대상 커밋 뒤에 와도 같은 호출로 본다.
call = None
for found in re.finditer(r"\bgit\s+(?:([^;&|\n]*?)\s+)?reset\s+([^;&|)\n]*)", command):
    reset_args = split_args(found.group(2))
    if "--hard" in reset_args:
        call = found
        break
if not call:
    hold("'git reset --hard' 위치를 명령에서 찾지 못해 보존 여부를 확인할 수 없습니다.")


def move(base, dest):
    if dest == "-" or "$" in dest or "`" in dest:
        hold(f"reset 대상 경로 '{dest}'를 해석할 수 없어 대상 저장소를 확인하지 못했습니다. 저장소 안에서 직접 실행하세요.")
    return os.path.normpath(os.path.join(base, os.path.expanduser(dest)))


# 대상 저장소: 작업 위치에서 reset 앞의 cd/pushd를 순서대로 따라간 뒤 git -C를 적용한다.
workdir = payload.get("cwd") or os.getcwd()
for cd in re.finditer(r"(?:^|[;&|(\n])\s*(?:cd|pushd)(?=[\s;&|)]|$)([^;&|)\n]*)", command[:call.start()]):
    dests = [p for p in split_args(cd.group(1)) if p == "-" or not p.startswith("-")]
    workdir = move(workdir, dests[0] if dests else "~")
global_args = split_args(call.group(1) or "")
index = 0
while index < len(global_args):
    arg = global_args[index]
    if arg.startswith("--git-dir") or arg.startswith("--work-tree"):
        hold("--git-dir나 --work-tree로 지정한 저장소는 보존 여부를 확인하지 못합니다. 저장소 안에서 직접 실행하세요.")
    if arg in ("-C", "-c") and index + 1 < len(global_args):
        if arg == "-C":
            workdir = move(workdir, global_args[index + 1])
        index += 2
        continue
    index += 1

top = git(workdir, "rev-parse", "--show-toplevel") if os.path.isdir(workdir) else None
if not top:
    hold(f"reset 대상 저장소를 확인하지 못했습니다(위치: {workdir}). 보존할 작업이 있는지 알 수 없어 실행하지 않습니다.")

# 대상 커밋: reset 인자 중 첫 비옵션 인자. 없으면 HEAD다.
reset_args = split_args(call.group(2))
if "--" in reset_args:
    reset_args = reset_args[:reset_args.index("--")]
target = next((t for t in reset_args if not t.startswith("-")), "HEAD")

status = git(top, "status", "--porcelain", "--untracked-files=no")
if status is None:
    hold(f"저장소 상태를 읽지 못했습니다({top}).")
dirty = len([line for line in status.splitlines() if line.strip()])

head_exists = git(top, "rev-parse", "--verify", "--quiet", "HEAD") is not None
target_sha = git(top, "rev-parse", "--verify", "--quiet", f"{target}^{{commit}}")

# reset 뒤 원격 어디에도 남지 않는 커밋. 대상을 해석하지 못하면 대상 없이 보수적으로 센다.
lost = 0
if head_exists:
    args = ["rev-list", "--count", "HEAD", "--not", "--remotes"]
    if target_sha:
        args.append(target_sha)
    counted = git(top, *args)
    if counted is None or not counted.isdigit():
        hold(f"원격에 없는 커밋을 세지 못했습니다({top}).")
    lost = int(counted)

# 대상 커밋에서 새로 생기는 경로에 추적하지 않는 파일이 있으면 reset이 덮어쓴다.
# 상위 경로 자리에 파일이 있어 디렉터리로 바뀌는 경우도 같다. 색인에 있는 파일은
# 이미 커밋하지 않은 변경으로 셌으므로 뺀다.
clobbered = []
if head_exists and target_sha:
    added = git(top, "diff", "--name-only", "--no-renames", "--diff-filter=A", "-z", "HEAD", target_sha)
    if added is None:
        hold(f"대상 커밋과 겹치는 파일을 확인하지 못했습니다({top}).")
    at_risk = set()
    for rel in filter(None, added.split("\0")):
        parts = rel.split("/")
        for depth in range(1, len(parts) + 1):
            full = os.path.join(top, *parts[:depth])
            if depth == len(parts):
                if os.path.lexists(full):
                    at_risk.add(rel)
            elif os.path.lexists(full) and not os.path.isdir(full):
                at_risk.add("/".join(parts[:depth]))
                break
            elif not os.path.isdir(full):
                break
    if at_risk:
        indexed = git(top, "ls-files", "-z")
        if indexed is None:
            hold(f"추적 중인 파일 목록을 읽지 못했습니다({top}).")
        clobbered = sorted(at_risk - set(indexed.split("\0")))

work = f"커밋하지 않은 변경 {dirty}개, 원격에 없는 커밋 {lost}개, 덮어써질 추적 안 되는 파일 {len(clobbered)}개"
if clobbered:
    work += "(" + ", ".join(clobbered[:5]) + (" 등" if len(clobbered) > 5 else "") + ")"

common = git(top, "rev-parse", "--path-format=absolute", "--git-common-dir")
main_repo = os.path.dirname(os.path.realpath(common)) if common else top
session_id = re.sub(r"[^A-Za-z0-9_.-]", "_", str(payload.get("session_id") or ""))
marker_name = f"{session_id}.reset-discard" if session_id else "reset-discard"
marker = os.path.join(main_repo, ".claude", ".approval", marker_name)
discard = os.path.exists(marker)
if discard:
    try:
        os.remove(marker)
    except OSError:
        pass

if dirty or lost or clobbered:
    if not discard:
        hold(
            f"'git reset --hard'가 지울 작업이 남아 있습니다(저장소 {top}: {work}). "
            "먼저 Git 정리 절차(git-cleanup)로 커밋 -> push -> PR -> 머지를 마치고, fetch로 원격 기준을 갱신한 뒤 다시 실행하세요. "
            + ("덮어써질 추적 안 되는 파일은 커밋하거나 다른 위치로 옮기세요. " if clobbered else "")
            + "작업 브랜치 삭제는 reset 뒤에 합니다. 먼저 지우면 이미 머지된 커밋도 원격에 없는 것으로 판정됩니다. "
            f"사용자가 이 작업을 버려도 된다고 분명히 말한 경우에만 폐기 확인 파일 {marker}을 만든 뒤 다시 실행하세요. "
            "파일은 한 번 쓰면 지워지고, 실행 직전 확인을 한 번 더 받습니다."
        )
    ask(
        f"경고: 사용자의 폐기 확인에 따라 정리 없이 'git reset --hard'를 실행합니다. "
        f"저장소 {top}의 작업이 사라집니다({work}). 버려도 되면 허용하세요."
    )
ask(
    f"확인: 'git reset --hard'를 실행합니다. 저장소 {top}에 보존할 작업"
    "(커밋하지 않은 변경, 원격에 없는 커밋, 덮어써질 추적 안 되는 파일)은 없습니다. 진행하려면 허용하세요."
)
PY

BLOCKED=""

# rm: 재귀 삭제는 강제 플래그 유무와 무관하게 차단한다. -r·-R·--recursive를 모두 본다.
# -f를 함께 요구하면 `rm -Rf`(대문자)와 `rm --recursive --force`(장문)가 빠져나가고,
# 강제 없는 `rm -r`도 그대로 통과한다. 셋 다 되돌릴 수 없는 재귀 삭제다.
# 위치 제약(줄 시작/체인 뒤)을 두면 `find ... -exec rm -rf {}`나 `sh -c "rm -rf /"`를
# 놓친다. 데이터 문맥은 앞 단계에서 제거되므로 위치 제약 없이 검사하되, `docker run --rm`
# 처럼 '-'가 앞에 붙은 플래그는 제외한다.
# 플래그는 rm 호출 구간(다음 ; && || | 전까지)에서만 찾는다. 명령줄 전체를 훑으면
# `grep -rn ... && docker compose -f x.yaml rm --force svc`처럼 서로 다른 명령의
# 플래그를 rm의 것으로 오판해 무해한 명령을 막는다.
# `git rm --cached`는 색인에서만 빼고 작업 트리 파일은 남긴다. 재귀여도 삭제가 아니므로
# 제외한다. 다만 `git` 접두어까지 함께 확인한다. 그러지 않으면 `rm -rf dir --cached`처럼
# 무의미한 인자를 붙이는 것만으로 차단을 지나갈 수 있다.
RM_ARGS=$(echo "$COMMAND" \
  | grep -oE "(^|[[:space:];&|(\"'])(git[[:space:]]+)?rm[[:space:]][^;&|]*" \
  | grep -vE 'git[[:space:]]+rm[[:space:]].*\s--cached\b')
if [ -n "$RM_ARGS" ]; then
  if echo "$RM_ARGS" | grep -qE '\s-[a-zA-Z]*[rR]|\s--recursive\b'; then
    BLOCKED="rm -r"
  fi
fi

# reset: `git -C dir reset --hard`, `git reset -q --hard`, `git reset <커밋> --hard`처럼
# git 전역 옵션이나 reset 옵션이 끼어도, --hard가 뒤에 와도 같은 명령이다.
RESET_HARD=""
echo "$COMMAND" | grep -qE 'git\s+([^;&|]*\s)?reset\s+([^;&|]*\s)?--hard\b' && RESET_HARD="git reset --hard"
# push: 강제 옵션은 push 호출 구간(다음 ; && || | 전까지)에서, 공백 뒤 옵션 토큰으로만 찾는다.
# 구간을 넘기면 `git push origin --delete x; rm -f y`의 `rm -f`를 push 강제로 오판하고,
# 토큰 경계를 보지 않으면 `topic-f` 같은 브랜치 이름까지 막는다. 옵션 뒤 경계는 공백만이 아니라
# 이름에 쓰이지 않는 모든 문자로 본다. `git push -f;ls`, `(git push -f)`, `bash -c "git push -f"`처럼
# 기호가 바로 붙어도 강제 push다.
# reset과 같이 `git -C dir push -f`, `git -c k=v push --force`처럼 git 전역 옵션이 끼어도 같은 명령이다.
# refspec 앞의 `+`(`git push origin +main`)도 옵션 없이 원격 이력을 덮어쓴다. 공백 뒤 토큰의
# 첫 글자일 때만 보므로 `feature+x`처럼 이름 중간의 `+`는 걸리지 않는다.
echo "$COMMAND" | grep -qE 'git\s+([^;&|]*\s)?push\s+([^;&|]*\s)?(-[a-zA-Z]*f[a-zA-Z]*|--force(-with-lease|-if-includes)?)(=[^[:space:]]*)?([^[:alnum:]_-]|$)' && BLOCKED="git push --force"
echo "$COMMAND" | grep -qE 'git\s+([^;&|]*\s)?push\s+([^;&|]*\s)?\+[^[:space:];&|]' && BLOCKED="git push --force"
echo "$COMMAND" | grep -qE 'git\s+clean\s+.*-[a-zA-Z]*f' && BLOCKED="git clean -f"
echo "$COMMAND" | grep -qE 'git\s+checkout\s+\.\s*$' && BLOCKED="git checkout ."

if [ -n "$BLOCKED" ]; then
  echo "[Hooks L3] 차단: '$BLOCKED' 패턴이 감지되었습니다. 파괴적 명령은 사용자 확인 후 실행하세요." >&2
  exit 2
fi

# 판정이 확인 요청(0)이나 보류(2) 외의 코드로 끝나면 보존 여부를 모르는 것이므로
# 종전처럼 막는다.
if [ -n "$RESET_HARD" ]; then
  python3 "$RESETSRC" <"$PAYLOAD"
  rc=$?
  if [ "$rc" -ne 0 ] && [ "$rc" -ne 2 ]; then
    echo "[Hooks L3] 차단: '$RESET_HARD'의 보존 여부 판정에 실패했습니다. 사용자 확인 후 실행하세요." >&2
    exit 2
  fi
  exit "$rc"
fi

exit 0
