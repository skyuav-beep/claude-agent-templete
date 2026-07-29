#!/usr/bin/env bash
# Claude Agent Template - Design Selector
# 사용법:
#   bash .claude/plugins/select-design.sh <slug>      # 시안 활성화
#   bash .claude/plugins/select-design.sh --list      # 라이브러리 목록 + 현재 active
#   bash .claude/plugins/select-design.sh --current   # 현재 active 슬러그만 출력
#
# 동작:
#   designs/<slug>.md → DESIGN.md 로 복사한다.
#   .claude/.active-design 파일에 슬러그를 기록한다.
#   DESIGN.md가 라이브러리 어떤 시안과도 다른 직접 편집 상태면
#   DESIGN.md.bak 으로 백업한 뒤 덮어쓴다.

set -euo pipefail

# 프로젝트 루트(=DESIGN.md를 쓸 곳) 결정
# 우선순위: 환경변수 PROJECT_ROOT > 현재 작업 디렉터리
# 산출물(DESIGN.md/마커)은 항상 프로젝트 루트에 쓴다. 공통 템플릿을 오염시키지 않는다.
ROOT="${PROJECT_ROOT:-$(pwd)}"
ACTIVE_FILE="$ROOT/DESIGN.md"
MARKER="$ROOT/.claude/.active-design"

# 시안 라이브러리(소스) 결정: 프로젝트 자체 > rules/ symlink 공통 > 스크립트 위치 기준 추론
DESIGNS_DIR="$ROOT/designs"
if [ ! -d "$DESIGNS_DIR" ] && [ -d "$ROOT/rules/designs" ]; then
  DESIGNS_DIR="$ROOT/rules/designs"
fi
if [ ! -d "$DESIGNS_DIR" ]; then
  # 스크립트가 .claude/plugins/ 안에서 실행됐으면 두 단계 위가 템플릿 root (symlink 실경로)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
  CANDIDATE="$(cd "$SCRIPT_DIR/../.." && pwd -P)"
  if [ -d "$CANDIDATE/designs" ]; then
    DESIGNS_DIR="$CANDIDATE/designs"
  fi
fi

if [ ! -d "$DESIGNS_DIR" ]; then
  echo "오류: 시안 라이브러리를 찾지 못했습니다." >&2
  echo "  확인한 경로: $ROOT/designs, $ROOT/rules/designs" >&2
  echo "  install.sh로 템플릿을 먼저 설치하거나, PROJECT_ROOT 환경변수로 위치를 지정하세요." >&2
  exit 1
fi

list_designs() {
  local current=""
  [ -f "$MARKER" ] && current=$(cat "$MARKER" 2>/dev/null || echo "")

  echo "Design 라이브러리 (${DESIGNS_DIR})"
  echo "---"
  for f in "$DESIGNS_DIR"/*.md; do
    [ -e "$f" ] || continue
    local base
    base=$(basename "$f" .md)
    # README 등 라이브러리 외 문서는 제외
    if [ "$base" = "README" ]; then
      continue
    fi
    # _ 접두 파일은 메타(인프라)
    if [[ "$base" == _* ]]; then
      printf "  [meta] %s\n" "$base"
      continue
    fi
    if [ "$base" = "$current" ]; then
      printf "  [활성] %s ←\n" "$base"
    else
      printf "         %s\n" "$base"
    fi
  done
  echo "---"
  if [ -n "$current" ]; then
    echo "현재 활성: $current"
  else
    echo "현재 활성: (없음 — .claude/.active-design 미존재)"
  fi
}

print_current() {
  if [ -f "$MARKER" ]; then
    cat "$MARKER"
  else
    echo "(none)" >&2
    exit 1
  fi
}

# 인수 처리
if [ $# -eq 0 ]; then
  echo "사용법: bash $(basename "$0") <slug> | --list | --current" >&2
  exit 1
fi

case "$1" in
  --list|-l)   list_designs; exit 0 ;;
  --current|-c) print_current; exit 0 ;;
  --help|-h)
    sed -n '2,15p' "$0"
    exit 0
    ;;
esac

SLUG="$1"
SRC="$DESIGNS_DIR/${SLUG}.md"

if [ ! -f "$SRC" ]; then
  echo "오류: 시안 파일이 없습니다 → $SRC" >&2
  echo ""
  list_designs >&2
  exit 1
fi

# meta 파일(_ 접두)은 활성화 금지
if [[ "$SLUG" == _* ]]; then
  echo "오류: '$SLUG'는 메타 파일입니다(_ 접두). 활성화할 수 없습니다." >&2
  exit 1
fi

# DESIGN.md가 라이브러리 어떤 시안과도 다른 상태면 백업
if [ -f "$ACTIVE_FILE" ]; then
  IS_LIBRARY_COPY=false
  for f in "$DESIGNS_DIR"/*.md; do
    [ -e "$f" ] || continue
    if cmp -s "$ACTIVE_FILE" "$f"; then
      IS_LIBRARY_COPY=true
      break
    fi
  done

  if [ "$IS_LIBRARY_COPY" != true ]; then
    BACKUP="${ACTIVE_FILE}.bak"
    cp "$ACTIVE_FILE" "$BACKUP"
    echo "주의: DESIGN.md가 라이브러리 시안과 일치하지 않습니다(직접 편집된 상태)." >&2
    echo "  백업 → $BACKUP" >&2
  fi
fi

# 복사 + 마커 갱신
mkdir -p "$(dirname "$MARKER")"
cp "$SRC" "$ACTIVE_FILE"
echo "$SLUG" > "$MARKER"

echo "활성화 완료: $SLUG"
echo "  source : $SRC"
echo "  active : $ACTIVE_FILE"
echo "  marker : $MARKER"
