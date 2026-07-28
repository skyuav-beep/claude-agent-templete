#!/usr/bin/env bash
# PreToolUse/Bash: git commit 시 STATE.md 갱신 리마인더
# Golden Rule: "작업이 끝나면 STATE.md를 갱신한다"
# 의도: 차단하지 않고 경고만 출력한다 (항상 exit 0).
# STATE.md 갱신이 불필요한 경우도 있으므로 판단은 에이전트/사용자에게 맡긴다.
#
# 입력 규약: stdin JSON({"tool_input":{"command":"..."}})이 1차,
# 구 규약 $CLAUDE_TOOL_INPUT는 폴백.

INPUT=$(cat 2>/dev/null)
[ -z "$INPUT" ] && INPUT="${CLAUDE_TOOL_INPUT:-}"
[ -z "$INPUT" ] && exit 0

COMMAND=$(python3 - "$INPUT" <<'PY' 2>/dev/null
import json, sys
try:
    d = json.loads(sys.argv[1])
except Exception:
    sys.exit(0)
if not isinstance(d, dict):
    sys.exit(0)
ti = d.get('tool_input')
ti = ti if isinstance(ti, dict) else {}
print(ti.get('command') or d.get('command') or '')
PY
)

echo "$COMMAND" | grep -q "git commit" || exit 0

# STATE.md가 staged 또는 unstaged 변경에 포함되어 있으면 통과
git diff --name-only 2>/dev/null | grep -q "STATE.md" && exit 0
git diff --cached --name-only 2>/dev/null | grep -q "STATE.md" && exit 0

echo "[Hooks L3] STATE.md가 이번 커밋에 포함되지 않았습니다. 작업 내용을 STATE.md에 반영했는지 확인하세요." >&2
exit 0
