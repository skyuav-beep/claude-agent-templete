#!/usr/bin/env python3
"""Claude/Codex agent template installer."""

from __future__ import annotations

import argparse
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile


MARKER = "agent-template:project-guide-routing"
STATE_PATH = Path(".claude/.template-install-state.json")
VERSION_PATH = Path(".claude/.plugin-version")

# --link 모드에서 rules/ 아래 공통본으로 연결하는 실행 레이어.
# 개정이 즉시 전파되고 git worktree에도 상속된다.
LINK_TARGETS = (
    ".claude/CLAUDE.md",
    ".claude/skills",
    ".claude/commands",
    ".claude/agents",
    ".claude/hooks",
    ".claude/plugins",
    ".claude/statusline-notify.sh",
    ".codex",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Claude Agent Template installer")
    modes = parser.add_mutually_exclusive_group()
    modes.add_argument("--new", action="store_true", help="빈 프로젝트에 전체 설치")
    modes.add_argument("--adopt", action="store_true", help="기존 프로젝트에 최초 연결")
    modes.add_argument("--update", action="store_true", help="연결된 프로젝트 업데이트")
    modes.add_argument("--force", action="store_true", help="호환 alias: --update")
    parser.add_argument(
        "--force-project-files",
        action="store_true",
        help="지원 중단: 프로젝트 파일 전체 교체는 수동 병합",
    )
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument(
        "--link",
        action="store_true",
        help="실행 레이어를 복사 대신 rules/ symlink로 연결 (개정 즉시 전파)",
    )
    parser.add_argument(
        "--link-claude-dir",
        action="store_true",
        help="--link와 함께: .claude 디렉터리 전체를 symlink로 연결 (프로젝트 고유 설정 불가)",
    )
    parser.add_argument("--design", default="wanted")
    parser.add_argument(
        "--accept-local",
        action="append",
        default=[],
        metavar="PATH",
        help="수동 검토한 충돌 파일을 새 로컬 기준선으로 승인",
    )
    parser.add_argument("target", nargs="?", default=".")
    return parser.parse_args()


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def atomic_copy(src: Path, dst: Path) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(dir=dst.parent, delete=False) as tmp:
        temp_path = Path(tmp.name)
    try:
        shutil.copy2(src, temp_path)
        os.replace(temp_path, dst)
    finally:
        temp_path.unlink(missing_ok=True)


def atomic_write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(
        mode="w", encoding="utf-8", dir=path.parent, delete=False
    ) as tmp:
        tmp.write(text)
        temp_path = Path(tmp.name)
    try:
        os.replace(temp_path, path)
    finally:
        temp_path.unlink(missing_ok=True)


def manifest_files(manifest: dict) -> list[str]:
    paths: list[str] = []
    for layer in manifest["layers"].values():
        paths.extend(item["path"] for item in layer["files"])
        if "settings" in layer:
            paths.append(layer["settings"])
    designs = manifest.get("designs", {})
    paths.extend(item["path"] for item in designs.get("files", []))
    if "selector" in designs:
        paths.append(designs["selector"])
    paths.extend(item["path"] for item in manifest.get("codex", {}).get("files", []))
    supporting = manifest.get("supporting", {})
    for key in ("agents", "templates", "docs"):
        paths.extend(supporting.get(key, []))
    return paths


def destination_path(source_path: str) -> str:
    if source_path == ".claude/settings.template.json":
        return ".claude/settings.local.json"
    return source_path


def policy_for(source_path: str, install_policy: dict) -> str:
    if source_path in install_policy["merge_block"]:
        return "merge-block"
    if source_path in install_policy["project_owned"]:
        return "project-owned"
    if source_path in install_policy["seed_only"]:
        return "seed-only"
    if source_path.startswith(tuple(install_policy["managed_prefixes"])):
        return "managed"
    if source_path.startswith(tuple(install_policy["customizable_prefixes"])):
        return "customizable"
    return "managed"


def marker_counts(text: str) -> tuple[int, int]:
    return (
        text.count(f"<!-- {MARKER}:start -->"),
        text.count(f"<!-- {MARKER}:end -->"),
    )


def validate_markers(source: Path, target: Path | None) -> None:
    source_counts = marker_counts(source.read_text(encoding="utf-8"))
    if source_counts != (1, 1):
        raise ValueError(f"소스 관리 마커 손상: {source} {source_counts}")
    if target and target.exists():
        target_counts = marker_counts(target.read_text(encoding="utf-8"))
        if target_counts not in {(0, 0), (1, 1)}:
            raise ValueError(f"대상 관리 마커 손상: {target} {target_counts}")


def managed_block(source_text: str) -> str:
    start = f"<!-- {MARKER}:start -->"
    end = f"<!-- {MARKER}:end -->"
    start_at = source_text.index(start)
    end_at = source_text.index(end, start_at) + len(end)
    return source_text[start_at:end_at]


def merge_block(source: Path, target: Path) -> str:
    source_text = source.read_text(encoding="utf-8")
    block = managed_block(source_text)
    if not target.exists():
        return source_text
    target_text = target.read_text(encoding="utf-8")
    start = f"<!-- {MARKER}:start -->"
    end = f"<!-- {MARKER}:end -->"
    if marker_counts(target_text) == (1, 1):
        start_at = target_text.index(start)
        end_at = target_text.index(end, start_at) + len(end)
        return target_text[:start_at] + block + target_text[end_at:]
    lines = target_text.splitlines(keepends=True)
    insert_at = 1 if lines and lines[0].startswith("# ") else 0
    prefix = "".join(lines[:insert_at])
    suffix = "".join(lines[insert_at:])
    separator = "\n" if prefix and not prefix.endswith("\n\n") else ""
    return prefix + separator + block + "\n\n" + suffix.lstrip("\n")


def load_state(target: Path) -> dict | None:
    path = target / STATE_PATH
    if not path.exists():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def empty_enough(target: Path) -> bool:
    return not any(item.name != ".git" for item in target.iterdir())


def relative_link(rel: str) -> str:
    """대상 안에서 rules/ 아래 같은 경로를 가리키는 상대 symlink 문자열."""
    return "../" * rel.count("/") + "rules/" + rel


def link_layers(
    target: Path, template_root: Path, whole_dir: bool, dry_run: bool
) -> int:
    """실행 레이어를 복사 대신 rules/ symlink로 연결한다."""
    actions: list[tuple[str, str]] = []
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    backup_root = target / f".agent-template-backup-{stamp}"
    rules = target / "rules"
    want_rules = os.path.relpath(template_root, target)

    if rules.is_symlink():
        current = (target / os.readlink(rules)).resolve()
        if current == template_root:
            actions.append(("keep", "rules"))
        else:
            actions.append(("relink", "rules"))
            if not dry_run:
                rules.unlink()
                rules.symlink_to(want_rules)
    elif rules.exists():
        print("오류: rules가 이미 존재하지만 symlink가 아닙니다.", file=sys.stderr)
        return 2
    else:
        actions.append(("link", "rules"))
        if not dry_run:
            rules.symlink_to(want_rules)

    entries = (".claude",) if whole_dir else LINK_TARGETS
    for rel in entries:
        if not (template_root / rel).exists():
            actions.append(("skip", rel))
            continue
        link = target / rel
        want = relative_link(rel)
        if link.is_symlink():
            if os.readlink(link) == want:
                actions.append(("keep", rel))
                continue
            actions.append(("relink", rel))
            if not dry_run:
                link.unlink()
        elif link.exists():
            actions.append(("backup", rel))
            if not dry_run:
                moved = backup_root / rel
                moved.parent.mkdir(parents=True, exist_ok=True)
                shutil.move(str(link), str(moved))
        else:
            actions.append(("link", rel))
        if not dry_run:
            link.parent.mkdir(parents=True, exist_ok=True)
            link.symlink_to(want)

    for action, rel in actions:
        print(f"{action:>15}: {rel}")
    backed = [rel for action, rel in actions if action == "backup"]
    print(
        f"요약: 작업 {len(actions)} | 백업 {len(backed)}"
        + (" | DRY-RUN" if dry_run else "")
    )
    if backed and not dry_run:
        print(f"백업 위치: {backup_root}")
        print("백업에는 프로젝트 고유 설정이 들어 있을 수 있습니다. 확인 후 삭제하세요.")
    return 0


def diagnose(target: Path, state: dict | None) -> int:
    if state:
        print(f"진단: 연결된 프로젝트입니다. 권장: --update {target}")
    elif empty_enough(target):
        print(f"진단: 빈 프로젝트입니다. 권장: --new {target}")
    else:
        print(f"진단: 기존 미연결 프로젝트입니다. 권장: --adopt {target}")
    return 0


def record_entry(
    files_state: dict,
    dst_rel: str,
    source_rel: str,
    policy: str,
    src: Path,
    dst: Path,
    status: str,
) -> None:
    entry = {
        "source": source_rel,
        "policy": policy,
        "template_hash": sha256(src),
        "status": status,
    }
    if dst.exists():
        entry["installed_hash"] = sha256(dst)
    files_state[dst_rel] = entry


def main() -> int:
    args = parse_args()
    script_dir = Path(__file__).resolve().parent
    template_root = script_dir.parent.parent
    target = Path(args.target).resolve()
    if not target.is_dir():
        print(f"오류: 대상 디렉터리를 찾을 수 없습니다: {target}", file=sys.stderr)
        return 2
    if target == template_root:
        print("오류: 대상이 템플릿 저장소 자체입니다.", file=sys.stderr)
        return 2
    if args.force_project_files:
        print(
            "오류: --force-project-files는 2.0.0부터 지원하지 않습니다. "
            "프로젝트 파일은 diff 확인 후 수동 병합하세요.",
            file=sys.stderr,
        )
        return 2
    if args.link_claude_dir and not args.link:
        print("오류: --link-claude-dir는 --link와 함께 사용합니다.", file=sys.stderr)
        return 2
    if args.link:
        return link_layers(target, template_root, args.link_claude_dir, args.dry_run)

    mode = "update" if args.force else next(
        (name for name in ("new", "adopt", "update") if getattr(args, name)), None
    )
    try:
        manifest = json.loads((script_dir / "manifest.json").read_text(encoding="utf-8"))
        install_policy = manifest["install_policy"]
        version = (script_dir / "VERSION").read_text(encoding="utf-8").strip()
        state = load_state(target)
    except (OSError, KeyError, json.JSONDecodeError) as error:
        print(f"오류: 설치 메타데이터를 읽을 수 없습니다: {error}", file=sys.stderr)
        return 2
    if mode is None:
        return diagnose(target, state)
    if mode == "new" and not empty_enough(target):
        print("오류: --new는 빈 디렉터리(.git 제외)에서만 사용할 수 있습니다.", file=sys.stderr)
        return 2
    if mode == "adopt" and state:
        print("오류: 이미 연결된 프로젝트입니다. --update를 사용하세요.", file=sys.stderr)
        return 2
    if mode == "update" and not state:
        print("오류: 설치 상태가 없습니다. 기존 프로젝트는 --adopt를 사용하세요.", file=sys.stderr)
        return 2
    if args.force:
        print("주의: --force는 호환 alias이며 --update로 동작합니다.")

    source_paths = manifest_files(manifest)
    if len(source_paths) != len(set(source_paths)):
        print("오류: manifest에 중복 파일이 있습니다.", file=sys.stderr)
        return 2
    missing = [path for path in source_paths if not (template_root / path).is_file()]
    if missing:
        print("오류: manifest 소스 누락:\n" + "\n".join(missing), file=sys.stderr)
        return 2
    allowed_designs = {
        Path(item["path"]).stem
        for item in manifest.get("designs", {}).get("files", [])
        if Path(item["path"]).parent == Path("designs")
        and not Path(item["path"]).stem.startswith("_")
        and Path(item["path"]).stem != "README"
    }
    design_src = template_root / f"designs/{args.design}.md"
    if args.design not in allowed_designs or not design_src.is_file():
        print(f"오류: 디자인 시안을 찾을 수 없습니다: {args.design}", file=sys.stderr)
        return 2
    destination_paths = {destination_path(path): path for path in source_paths}
    accept_local = set(args.accept_local)
    invalid_accept = [
        path
        for path in accept_local
        if mode != "update"
        or path not in destination_paths
        or not (target / path).is_file()
        or policy_for(destination_paths[path], install_policy)
        in {"merge-block", "project-owned", "seed-only"}
    ]
    if invalid_accept:
        print(
            "오류: --accept-local을 적용할 수 없는 경로:\n"
            + "\n".join(sorted(invalid_accept)),
            file=sys.stderr,
        )
        return 2

    # 모든 쓰기 전에 관리 마커와 상태 구조를 검증한다.
    try:
        for rel in install_policy["merge_block"]:
            validate_markers(template_root / rel, target / rel)
        if state and state.get("schema") != 1:
            raise ValueError("지원하지 않는 설치 상태 schema")
        if state and state.get("template") != manifest["name"]:
            raise ValueError("다른 템플릿의 설치 상태입니다")
        if state and not isinstance(state.get("files"), dict):
            raise ValueError("설치 상태 files 형식이 올바르지 않습니다")
    except (ValueError, UnicodeDecodeError, json.JSONDecodeError) as error:
        print(f"오류: 사전검사 실패: {error}", file=sys.stderr)
        return 2

    previous_files = state.get("files", {}) if state else {}
    next_files = dict(previous_files)
    actions: list[tuple[str, str]] = []
    conflicts: list[str] = []
    protected: list[str] = []

    for source_rel in source_paths:
        if source_rel == "DESIGN.md":
            continue
        src = template_root / source_rel
        dst_rel = destination_path(source_rel)
        dst = target / dst_rel
        policy = policy_for(source_rel, install_policy)

        if policy == "merge-block":
            merged = merge_block(src, dst)
            changed = not dst.exists() or dst.read_text(encoding="utf-8") != merged
            actions.append(("merge" if changed else "keep", dst_rel))
            if not args.dry_run and changed:
                atomic_write(dst, merged)
            if not args.dry_run:
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
            continue

        if mode == "new":
            actions.append(("copy", dst_rel))
            if not args.dry_run:
                atomic_copy(src, dst)
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
            continue

        if not dst.exists():
            actions.append(("copy", dst_rel))
            if not args.dry_run:
                atomic_copy(src, dst)
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
            continue

        if policy in {"project-owned", "seed-only"}:
            protected.append(dst_rel)
            actions.append(("protect", dst_rel))
            if not args.dry_run:
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "protected")
            continue

        if mode == "adopt":
            if sha256(dst) == sha256(src):
                actions.append(("track", dst_rel))
                if not args.dry_run:
                    record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
            else:
                actions.append(("local-baseline", dst_rel))
                if not args.dry_run:
                    record_entry(next_files, dst_rel, source_rel, policy, src, dst, "local")
            continue

        previous = previous_files.get(dst_rel)
        current_hash = sha256(dst)
        template_hash = sha256(src)
        previous_status = previous.get("status") if previous else None
        previous_installed = previous.get("installed_hash") if previous else None
        previous_template = previous.get("template_hash") if previous else None

        if dst_rel in accept_local:
            actions.append(("accept-local", dst_rel))
            if not args.dry_run:
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "local")
        elif previous_status == "tracked" and previous_installed == current_hash:
            actions.append(("update", dst_rel))
            if not args.dry_run:
                atomic_copy(src, dst)
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
        elif current_hash == template_hash:
            actions.append(("track", dst_rel))
            if not args.dry_run:
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "tracked")
        elif previous and previous_template == template_hash:
            actions.append(("keep-local", dst_rel))
            if not args.dry_run:
                record_entry(next_files, dst_rel, source_rel, policy, src, dst, "local")
        else:
            conflicts.append(dst_rel)
            actions.append(("conflict", dst_rel))

    design_dst = target / "DESIGN.md"
    if mode == "new" or not design_dst.exists():
        actions.append(("activate-design", "DESIGN.md"))
        if not args.dry_run:
            atomic_copy(design_src, design_dst)
            record_entry(
                next_files,
                "DESIGN.md",
                f"designs/{args.design}.md",
                "project-owned",
                design_src,
                design_dst,
                "protected",
            )
            atomic_write(target / ".claude/.active-design", args.design + "\n")
    else:
        protected.append("DESIGN.md")
        actions.append(("protect", "DESIGN.md"))

    for action, rel in actions:
        print(f"{action:>15}: {rel}")
    print(
        f"요약: 작업 {len(actions)} | 보호 {len(protected)} | 충돌 {len(conflicts)}"
        + (" | DRY-RUN" if args.dry_run else "")
    )

    if not args.dry_run:
        complete = not conflicts
        next_state = {
            "schema": 1,
            "template": manifest["name"],
            "template_version": version if complete else (state or {}).get("template_version"),
            "last_attempt_version": version,
            "status": "complete" if complete else "partial",
            "mode": mode,
            "files": next_files,
            "conflicts": conflicts,
        }
        atomic_write(
            target / STATE_PATH,
            json.dumps(next_state, ensure_ascii=False, indent=2) + "\n",
        )
        if complete:
            atomic_write(target / VERSION_PATH, version + "\n")
        print(f"설치 상태: {next_state['status']}")
    return 1 if conflicts else 0


if __name__ == "__main__":
    raise SystemExit(main())
