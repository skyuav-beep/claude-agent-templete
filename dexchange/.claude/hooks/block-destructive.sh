#!/usr/bin/env bash
# PreToolUse/Bash: 파괴적 명령 차단
# Golden Rule: "사용자 요청 없이 파괴적 명령을 실행하지 않는다"

COMMAND=$(python3 -c "
import json, sys
try:
    d = json.loads(sys.stdin.read())
    print(d.get('command', ''))
except: pass
" <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null)
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
  echo "[Hooks L3] 차단: '$BLOCKED' 패턴이 감지되었습니다. 파괴적 명령은 사용자 확인 후 실행하세요."
  exit 2
fi

exit 0
