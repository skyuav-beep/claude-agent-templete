#!/usr/bin/env bash
# PreToolUse/Bash: git commit 시 STATE.md 갱신 리마인더
# Golden Rule: "작업이 끝나면 STATE.md를 갱신한다"
# 의도: 차단하지 않고 경고만 출력한다 (항상 exit 0).
# STATE.md 갱신이 불필요한 경우도 있으므로 판단은 에이전트/사용자에게 맡긴다.

COMMAND=$(python3 -c "
import json, sys
try:
    d = json.loads(sys.stdin.read())
    print(d.get('command', ''))
except: pass
" <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null)

echo "$COMMAND" | grep -q "git commit" || exit 0

# STATE.md가 staged 또는 unstaged 변경에 포함되어 있으면 통과
git diff --name-only 2>/dev/null | grep -q "STATE.md" && exit 0
git diff --cached --name-only 2>/dev/null | grep -q "STATE.md" && exit 0

echo "[Hooks L3] STATE.md가 이번 커밋에 포함되지 않았습니다. 작업 내용을 STATE.md에 반영했는지 확인하세요."
exit 0
