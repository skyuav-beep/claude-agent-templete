#!/usr/bin/env bash
# Claude Agent Template - Plugin Installer
# 사용법: bash .claude/plugins/install.sh [--force] [--dry-run] <대상 디렉터리>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MANIFEST="$SCRIPT_DIR/manifest.json"
VERSION_FILE="$SCRIPT_DIR/VERSION"

FORCE=false
DRY_RUN=false
TARGET=""

# 인수 파싱
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
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

echo "---"
echo "설치: ${INSTALLED}개 | 건너뜀: ${SKIPPED}개"
[ "$DRY_RUN" = true ] && echo "(dry-run 모드이므로 실제 복사는 수행되지 않았습니다)"
[ "$SKIPPED" -gt 0 ] && [ "$FORCE" != true ] && echo "기존 파일을 덮어쓰려면 --force 플래그를 사용하세요."
echo "완료."
