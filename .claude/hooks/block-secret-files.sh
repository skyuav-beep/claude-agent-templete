#!/usr/bin/env bash
# PreToolUse/Write,Edit: 비밀 파일 쓰기 차단
# Golden Rule: "확인하지 않은 비밀값, API 키를 임의로 추가하지 않는다"

FILE_PATH=$(python3 -c "
import json, sys
try:
    d = json.loads(sys.stdin.read())
    print(d.get('file_path', ''))
except: pass
" <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null)
[ -z "$FILE_PATH" ] && exit 0

BASENAME=$(basename "$FILE_PATH")

case "$BASENAME" in
  .env|.env.*|credentials.json|secrets.json|service-account*.json)
    BLOCKED=true ;;
  *.pem|*.key|*.p12|*.pfx)
    BLOCKED=true ;;
  id_rsa|id_rsa.*|id_ed25519|id_ed25519.*)
    BLOCKED=true ;;
  *)
    BLOCKED=false ;;
esac

if [ "$BLOCKED" = true ]; then
  echo "[Hooks L3] 차단: '$BASENAME' 은 비밀/인증 파일로 판단됩니다. 직접 확인 후 수동으로 생성하세요."
  exit 2
fi

exit 0
