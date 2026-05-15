#!/usr/bin/env bash
# Claude Agent Template - Plugin Installer
# 사용법: bash .claude/plugins/install.sh [--force] [--dry-run] [--design <slug>] <대상 디렉터리>
#
# --design <slug>: 활성화할 디자인 시안. 기본값 wanted.
#                  install 후 designs/<slug>.md 가 root DESIGN.md로 복사된다.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MANIFEST="$SCRIPT_DIR/manifest.json"
VERSION_FILE="$SCRIPT_DIR/VERSION"

FORCE=false
DRY_RUN=false
DESIGN_SLUG="wanted"
TARGET=""

# 인수 파싱
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    --design)
      shift
      [ $# -gt 0 ] || { echo "오류: --design 다음에 슬러그가 필요합니다." >&2; exit 1; }
      DESIGN_SLUG="$1"; shift ;;
    *) TARGET="$1"; shift ;;
  esac
done

TARGET="${TARGET:-.}"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || { echo "오류: 대상 디렉터리 '$TARGET'를 찾을 수 없습니다."; exit 1; }

if [ "$TEMPLATE_ROOT" = "$TARGET" ]; then
  echo "오류: 대상 디렉터리가 템플릿 저장소 자체입니다."
  exit 1
fi

VERSION="$(cat "$VERSION_FILE")"
echo "Claude Agent Template v${VERSION} 설치"
echo "소스: $TEMPLATE_ROOT"
echo "대상: $TARGET"
[ "$DRY_RUN" = true ] && echo "[DRY-RUN 모드]"
echo "---"

# manifest.json에서 파일 목록 추출
FILES=$(python3 -c "
import json, sys
with open('$MANIFEST') as f:
    m = json.load(f)
for layer in m['layers'].values():
    for f in layer['files']:
        print(f['path'])
    if 'settings' in layer:
        print(layer['settings'])
designs = m.get('designs', {})
for f in designs.get('files', []):
    print(f['path'])
if 'selector' in designs:
    print(designs['selector'])
sup = m.get('supporting', {})
for a in sup.get('agents', []):
    print(a)
for t in sup.get('templates', []):
    print(t)
for d in sup.get('docs', []):
    print(d)
")

INSTALLED=0
SKIPPED=0

for FILE in $FILES; do
  SRC="$TEMPLATE_ROOT/$FILE"
  DST="$TARGET/$FILE"

  if [ ! -f "$SRC" ]; then
    echo "  건너뜀 (소스 없음): $FILE"
    continue
  fi

  if [ -f "$DST" ] && [ "$FORCE" != true ]; then
    echo "  건너뜀 (이미 존재): $FILE"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if [ "$DRY_RUN" = true ]; then
    echo "  [복사 예정] $FILE"
  else
    mkdir -p "$(dirname "$DST")"
    cp "$SRC" "$DST"
    # hook 스크립트는 실행 권한 부여
    if [[ "$FILE" == *.sh ]]; then
      chmod +x "$DST"
    fi
    echo "  설치됨: $FILE"
  fi
  INSTALLED=$((INSTALLED + 1))
done

# 버전 스탬프
if [ "$DRY_RUN" != true ]; then
  mkdir -p "$TARGET/.claude"
  echo "$VERSION" > "$TARGET/.claude/.plugin-version"
fi

# 디자인 시안 활성화: designs/<slug>.md → DESIGN.md
DESIGN_SRC="$TARGET/designs/${DESIGN_SLUG}.md"
DESIGN_DST="$TARGET/DESIGN.md"
if [ "$DRY_RUN" = true ]; then
  echo "  [활성화 예정] designs/${DESIGN_SLUG}.md → DESIGN.md"
elif [ -f "$DESIGN_SRC" ]; then
  cp "$DESIGN_SRC" "$DESIGN_DST"
  echo "$DESIGN_SLUG" > "$TARGET/.claude/.active-design"
  echo "  활성화: designs/${DESIGN_SLUG}.md → DESIGN.md"
else
  echo "  주의: --design '${DESIGN_SLUG}' 시안 파일이 대상에 없습니다($DESIGN_SRC). 활성화 건너뜀."
fi

echo "---"
echo "설치: ${INSTALLED}개 | 건너뜀: ${SKIPPED}개 | active-design: ${DESIGN_SLUG}"
[ "$DRY_RUN" = true ] && echo "(dry-run 모드이므로 실제 복사는 수행되지 않았습니다)"
[ "$SKIPPED" -gt 0 ] && [ "$FORCE" != true ] && echo "기존 파일을 덮어쓰려면 --force 플래그를 사용하세요."
echo "완료."
[ "$DRY_RUN" != true ] && echo "활성 시안 변경: bash .claude/plugins/select-design.sh <slug>"
