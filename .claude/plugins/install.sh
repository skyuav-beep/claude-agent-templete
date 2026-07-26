#!/usr/bin/env bash
# Claude Agent Template - Plugin Installer
# 사용법: bash .claude/plugins/install.sh [--force] [--force-project-files] [--dry-run] [--design <slug>] <대상 디렉터리>
#
# --force: 런타임 어댑터와 공용 템플릿 파일을 갱신하되 프로젝트 소유 파일은 보호한다.
# --force-project-files: AGENTS.md 등 프로젝트 소유 파일까지 명시적으로 덮어쓴다.
# --design <slug>: 활성화할 디자인 시안. 기본값 wanted.
#                  install 후 designs/<slug>.md 가 root DESIGN.md로 복사된다.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MANIFEST="$SCRIPT_DIR/manifest.json"
VERSION_FILE="$SCRIPT_DIR/VERSION"

FORCE=false
FORCE_PROJECT_FILES=false
DRY_RUN=false
DESIGN_SLUG="wanted"
TARGET=""

# 인수 파싱
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=true; shift ;;
    --force-project-files) FORCE=true; FORCE_PROJECT_FILES=true; shift ;;
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

DESIGN_PREEXISTED=false
[ -f "$TARGET/DESIGN.md" ] && DESIGN_PREEXISTED=true

is_project_owned_file() {
  case "$1" in
    AGENTS.md|CLAUDE.md|STATE.md|DESIGN.md|docs/project-guide.md) return 0 ;;
    *) return 1 ;;
  esac
}

sync_managed_block() {
  local src="$1"
  local dst="$2"
  local marker="agent-template:project-guide-routing"

  [ -f "$src" ] && [ -f "$dst" ] || return 0

  if [ "$DRY_RUN" = true ]; then
    echo "  [관리 블록 갱신 예정] ${dst#"$TARGET/"}"
    return 0
  fi

  python3 - "$src" "$dst" "$marker" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
marker = sys.argv[3]
start = f"<!-- {marker}:start -->"
end = f"<!-- {marker}:end -->"

source_text = src.read_text(encoding="utf-8")
target_text = dst.read_text(encoding="utf-8")
source_start = source_text.index(start)
source_end = source_text.index(end, source_start) + len(end)
block = source_text[source_start:source_end]

if start in target_text and end in target_text:
    target_start = target_text.index(start)
    target_end = target_text.index(end, target_start) + len(end)
    updated = target_text[:target_start] + block + target_text[target_end:]
else:
    lines = target_text.splitlines(keepends=True)
    insert_at = 1 if lines and lines[0].startswith("# ") else 0
    prefix = "".join(lines[:insert_at])
    suffix = "".join(lines[insert_at:])
    separator = "\n" if prefix and not prefix.endswith("\n\n") else ""
    updated = prefix + separator + block + "\n\n" + suffix.lstrip("\n")

dst.write_text(updated, encoding="utf-8")
PY
  echo "  관리 블록 갱신: ${dst#"$TARGET/"}"
}

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
codex = m.get('codex', {})
for f in codex.get('files', []):
    print(f['path'])
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
PROTECTED=0
UNRESOLVED_SKIPS=0

for FILE in $FILES; do
  SRC="$TEMPLATE_ROOT/$FILE"
  DST_FILE="$FILE"
  if [ "$FILE" = ".claude/settings.template.json" ]; then
    DST_FILE=".claude/settings.local.json"
  fi
  DST="$TARGET/$DST_FILE"

  if [ ! -f "$SRC" ]; then
    echo "  건너뜀 (소스 없음): $FILE"
    continue
  fi

  if [ -f "$DST" ]; then
    if is_project_owned_file "$DST_FILE" && [ "$FORCE_PROJECT_FILES" != true ]; then
      echo "  보호됨 (프로젝트 소유): $DST_FILE"
      PROTECTED=$((PROTECTED + 1))
      if [ "$FORCE" != true ]; then
        UNRESOLVED_SKIPS=$((UNRESOLVED_SKIPS + 1))
      fi
      continue
    fi
    if [ "$FORCE" != true ]; then
      echo "  건너뜀 (이미 존재): $FILE"
      SKIPPED=$((SKIPPED + 1))
      UNRESOLVED_SKIPS=$((UNRESOLVED_SKIPS + 1))
      continue
    fi
  fi

  if [ "$DRY_RUN" = true ]; then
    if [ "$FILE" = "$DST_FILE" ]; then
      echo "  [복사 예정] $FILE"
    else
      echo "  [복사 예정] $FILE -> $DST_FILE"
    fi
  else
    mkdir -p "$(dirname "$DST")"
    cp "$SRC" "$DST"
    if [ "$DST_FILE" = ".claude/settings.local.json" ]; then
      python3 - "$DST" "$TEMPLATE_ROOT" "$TARGET" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
template_root = sys.argv[2]
target_root = sys.argv[3]
path.write_text(path.read_text(encoding="utf-8").replace(template_root, target_root), encoding="utf-8")
PY
    fi
    # hook 스크립트는 실행 권한 부여
    if [[ "$FILE" == *.sh ]]; then
      chmod +x "$DST"
    fi
    if [ "$FILE" = "$DST_FILE" ]; then
      echo "  설치됨: $FILE"
    else
      echo "  설치됨: $FILE -> $DST_FILE"
    fi
  fi
  INSTALLED=$((INSTALLED + 1))
done

# 공용 업데이트에서는 프로젝트 파일 전체 대신 필수 라우팅 블록만 안전하게 병합한다.
if [ "$FORCE" = true ] && [ "$FORCE_PROJECT_FILES" != true ]; then
  sync_managed_block "$TEMPLATE_ROOT/AGENTS.md" "$TARGET/AGENTS.md"
  sync_managed_block "$TEMPLATE_ROOT/CLAUDE.md" "$TARGET/CLAUDE.md"
fi

# 버전 스탬프: 일부 기존 파일을 갱신하지 못한 일반 설치에는 최신 버전을 기록하지 않는다.
if [ "$DRY_RUN" != true ] && [ "$UNRESOLVED_SKIPS" -eq 0 ]; then
  mkdir -p "$TARGET/.claude"
  echo "$VERSION" > "$TARGET/.claude/.plugin-version"
elif [ "$DRY_RUN" != true ]; then
  echo "  버전 기록 보류: 갱신되지 않은 기존 파일 ${UNRESOLVED_SKIPS}개"
fi

# 디자인 시안 활성화: designs/<slug>.md → DESIGN.md
DESIGN_SRC="$TARGET/designs/${DESIGN_SLUG}.md"
DESIGN_DST="$TARGET/DESIGN.md"
if [ "$DESIGN_PREEXISTED" = true ] && [ "$FORCE_PROJECT_FILES" != true ]; then
  echo "  보호됨 (프로젝트 소유): DESIGN.md 활성화 건너뜀"
elif [ "$DRY_RUN" = true ]; then
  echo "  [활성화 예정] designs/${DESIGN_SLUG}.md → DESIGN.md"
elif [ -f "$DESIGN_SRC" ]; then
  cp "$DESIGN_SRC" "$DESIGN_DST"
  echo "$DESIGN_SLUG" > "$TARGET/.claude/.active-design"
  echo "  활성화: designs/${DESIGN_SLUG}.md → DESIGN.md"
else
  echo "  주의: --design '${DESIGN_SLUG}' 시안 파일이 대상에 없습니다($DESIGN_SRC). 활성화 건너뜀."
fi

echo "---"
echo "설치: ${INSTALLED}개 | 건너뜀: ${SKIPPED}개 | 보호: ${PROTECTED}개 | active-design: ${DESIGN_SLUG}"
[ "$DRY_RUN" = true ] && echo "(dry-run 모드이므로 실제 복사는 수행되지 않았습니다)"
[ "$UNRESOLVED_SKIPS" -gt 0 ] && echo "공용 파일을 갱신하려면 --force를 사용하세요. 프로젝트 소유 파일은 계속 보호됩니다."
[ "$PROTECTED" -gt 0 ] && echo "프로젝트 소유 파일까지 교체하려면 변경사항을 백업한 뒤 --force-project-files를 명시하세요."
echo "완료."
[ "$DRY_RUN" != true ] && echo "활성 시안 변경: bash .claude/plugins/select-design.sh <slug>"
exit 0
