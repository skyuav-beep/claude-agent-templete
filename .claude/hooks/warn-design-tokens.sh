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
#
# 입력 규약: 다른 L3 훅과 동일하게 stdin JSON이 1차, 구 규약 $CLAUDE_TOOL_INPUT은
# 폴백이며 tool_input 중첩을 우선 파싱한다. payload를 파이썬 소스에 문자열로
# 끼워 넣으면 파일 본문이 코드로 해석될 수 있으므로, 스크립트는 fd 3으로 주고
# payload는 stdin으로만 전달한다.

PARSED=$(python3 /dev/fd/3 3<<'PY' 2>/dev/null
import json, os, sys

raw = sys.stdin.read()
if not raw.strip():
    raw = os.environ.get("CLAUDE_TOOL_INPUT", "")
if not raw.strip():
    sys.exit(0)
try:
    payload = json.loads(raw)
except Exception:
    sys.exit(0)
if not isinstance(payload, dict):
    sys.exit(0)

tool_input = payload.get("tool_input")
data = tool_input if isinstance(tool_input, dict) else payload

file_path = data.get("file_path") or data.get("path") or ""
if not file_path:
    sys.exit(0)

# Write는 content, Edit는 new_string, MultiEdit는 edits[].new_string을 쓴다.
chunks = []
single = data.get("content") or data.get("new_string") or ""
if single:
    chunks.append(single)
edits = data.get("edits")
if isinstance(edits, list):
    for edit in edits:
        if isinstance(edit, dict) and edit.get("new_string"):
            chunks.append(edit["new_string"])

# 첫 줄은 파일 경로, 나머지는 검사 대상 본문.
sys.stdout.write(file_path + "\n" + "\n".join(chunks))
PY
)

[ -z "$PARSED" ] && exit 0
FILE_PATH=$(printf '%s\n' "$PARSED" | head -n 1)

[ -z "$FILE_PATH" ] && exit 0

# 검사 대상 확장자만 진행
case "$FILE_PATH" in
  *.css|*.scss|*.less|*.tsx|*.jsx|*.ts|*.js|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

# colors_and_type.css는 hex 정의 원본이므로 hex 검사에서 제외
BASENAME=$(basename "$FILE_PATH")

CONTENT=$(printf '%s\n' "$PARSED" | tail -n +2)

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
