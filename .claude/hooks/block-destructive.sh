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
import json, os, sys

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
print(ti.get("command") or d.get("command") or "")
PY
)
[ -z "$COMMAND" ] && exit 0

BLOCKED=""

# rm: -r과 -f가 같은 그룹이든 분리되어 있든 모두 차단
if echo "$COMMAND" | grep -qE '^rm\s' || echo "$COMMAND" | grep -qE ';\s*rm\s|&&\s*rm\s|\|\|\s*rm\s'; then
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
