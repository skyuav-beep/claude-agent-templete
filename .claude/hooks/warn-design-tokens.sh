#!/usr/bin/env bash
# PreToolUse/Write+Edit: 디자인 토큰 외 값 사용 정적 경고 (opt-in)
#
# 운영 정책: 경고만 출력하고 차단하지 않는다 (항상 exit 0).
# false-positive 우려와 정적 검출의 한계 때문에 settings.local.json에는
# 기본 등록하지 않는다. 프로젝트가 디자인 토큰 강제를 원할 때만 PreToolUse
# Write/Edit/MultiEdit hook으로 추가 등록한다.
#
# 검출 대상:
#   1) hex 색상 직접 사용(`#rrggbb` / `#rgb`)이 colors_and_type.css 외 파일에서 등장
#   2) 비-4의 배수 px 값(6, 10, 14, 18, 22) 등장
#
# 적용 파일: *.css, *.scss, *.less, *.tsx, *.jsx, *.ts, *.js, *.vue, *.svelte
# 외 파일은 즉시 통과.

INPUT=$(cat)

FILE_PATH=$(python3 -c "
import json, sys
try:
    d = json.loads('''$INPUT''')
    print(d.get('file_path') or d.get('path') or '')
except: pass
" 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

# 검사 대상 확장자만 진행
case "$FILE_PATH" in
  *.css|*.scss|*.less|*.tsx|*.jsx|*.ts|*.js|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

# colors_and_type.css는 hex 정의 원본이므로 hex 검사에서 제외
BASENAME=$(basename "$FILE_PATH")

CONTENT=$(python3 -c "
import json, sys
try:
    d = json.loads('''$INPUT''')
    print(d.get('content') or d.get('new_string') or '')
except: pass
" 2>/dev/null)

[ -z "$CONTENT" ] && exit 0

WARNED=0

# 1) hex 색상 직접 사용 (colors_and_type.css 제외)
if [ "$BASENAME" != "colors_and_type.css" ]; then
  HEX_HITS=$(echo "$CONTENT" | grep -oE '#[0-9a-fA-F]{3}([0-9a-fA-F]{3})?' | head -3)
  if [ -n "$HEX_HITS" ]; then
    echo "[Hooks L3 warn] $FILE_PATH: hex 색상 직접 사용 감지. DESIGN.md 토큰 호출({colors.*}) 또는 alias 사용을 검토하세요." >&2
    echo "$HEX_HITS" | sed 's/^/  /' >&2
    WARNED=1
  fi
fi

# 2) 비-4의 배수 px 값 (6, 10, 14, 18, 22)
NON4_HITS=$(echo "$CONTENT" | grep -oE '\b(6|10|14|18|22)px\b' | head -3)
if [ -n "$NON4_HITS" ]; then
  echo "[Hooks L3 warn] $FILE_PATH: 비-4의 배수 px 값 감지(6/10/14/18/22). DESIGN.md spacing/radius 사다리 사용을 검토하세요." >&2
  echo "$NON4_HITS" | sed 's/^/  /' >&2
  WARNED=1
fi

# 항상 exit 0 (경고 only, 차단하지 않음)
exit 0
