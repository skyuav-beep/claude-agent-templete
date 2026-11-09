#!/usr/bin/env bash
# PreToolUse/Edit,Write: 승인 전 파일 수정에 사용자 확인 요청
#
# Claude Code 전용 게이트다. Codex는 저장소 훅을 자동 실행하지 않으므로
# .codex/workflows와 체크리스트의 단계 계약을 별도로 적용한다.

# Python 본문은 임시 파일로 넘긴다. Windows(MSYS)에서 /dev/fd/3은 네이티브
# Python이 열 수 없는 경로로 번역되어 판정이 조용히 통과된다.
# payload는 계속 stdin 전용으로 남으므로 MAX_ARG_STRLEN 제약을 받지 않는다.
PYSRC=$(mktemp) || exit 0
trap 'rm -f "$PYSRC"' EXIT
cat >"$PYSRC" <<'PY'
import json
import os
import subprocess
import sys


def git(cwd, *args):
    try:
        result = subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True, timeout=5)
    except Exception:
        return ""
    return result.stdout.strip() if result.returncode == 0 else ""


raw = sys.stdin.read() or os.environ.get("CLAUDE_TOOL_INPUT", "")
try:
    payload = json.loads(raw)
except Exception:
    sys.exit(0)

data = payload.get("tool_input", payload)
if not isinstance(data, dict):
    sys.exit(0)
file_path = data.get("file_path") or data.get("notebook_path") or ""
if not file_path:
    sys.exit(0)

cwd = payload.get("cwd") or os.getcwd()
target = os.path.realpath(os.path.join(cwd, file_path))
project_git = git(cwd, "rev-parse", "--path-format=absolute", "--git-common-dir")
if not project_git:
    sys.exit(0)
project_git = os.path.realpath(project_git)
target_dir = os.path.dirname(target)
while target_dir != "/" and not os.path.isdir(target_dir):
    target_dir = os.path.dirname(target_dir)
target_git = git(target_dir, "rev-parse", "--path-format=absolute", "--git-common-dir")
if os.path.realpath(target_git) != project_git:
    sys.exit(0)

# A worktree has its own git-dir. The main checkout points directly at the
# common git directory.
target_repo_git = git(target_dir, "rev-parse", "--path-format=absolute", "--git-dir")
in_worktree = bool(target_repo_git) and os.path.realpath(target_repo_git) != project_git


def passthrough(why):
    # Worktrees usually live in a sibling folder outside the session's working
    # directory, so Claude Code asks "Do you want to create ...?" even after the
    # gate has nothing to ask. Answer allow for this repository's worktrees so an
    # approved session runs without that prompt. Deny rules still apply.
    if in_worktree:
        print(json.dumps({
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "allow",
                "permissionDecisionReason": why,
            }
        }, ensure_ascii=False))
    sys.exit(0)


# Fact records are covered by every Step 3 approval (docs/approval-workflow.md
# "## 재확인하지 않는 작업"), so asking again only interrupts the finish step,
# typically after the marker has already been removed. This applies in the main
# checkout and in worktrees alike. docs/99-archive/ is not a record: moving a
# document there is a structure change and still needs approval.
target_top = git(target_dir, "rev-parse", "--show-toplevel")
if target_top:
    relative = os.path.relpath(target, os.path.realpath(target_top)).replace(os.sep, "/")
    if relative == "STATE.md" or relative.startswith("docs/archive/"):
        passthrough("사실 기록 파일은 3단계 승인에 포함됩니다.")

# The Step 3 marker is checked next: once the session is approved the user
# should not be asked again, whichever tree the change lands in.
session_id = payload.get("session_id") or "<session_id>"
marker = os.path.join(os.path.dirname(project_git), ".claude", ".approval", session_id)
AUTO_MODES = {"auto", "acceptEdits", "bypassPermissions"}
auto_mode = payload.get("permission_mode") in AUTO_MODES

# A Markdown document still being drafted (a plan, analysis or note that does
# not exist yet or is not tracked by Git) touches no committed content, so an
# approved or auto-mode session is not asked again to create or edit it, even in
# the main checkout (docs/approval-workflow.md "## 재확인하지 않는 작업"). The
# session may have started in a subfolder such as backend/, so answer allow
# explicitly to skip the "Do you want to create/make this edit ...?" prompt as
# well. Editing a committed file is still asked below, and docs/99-archive/
# stays a structure change.
draft_markdown = (
    target.lower().endswith(".md")
    and not (target_top and relative.startswith("docs/99-archive/"))
    and (not os.path.exists(target) or not git(target_dir, "ls-files", "--", target))
)
if draft_markdown and (auto_mode or os.path.exists(marker)):
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "allow",
            "permissionDecisionReason": "커밋 전 작성 중인 Markdown 문서의 생성·수정은 다시 묻지 않습니다.",
        }
    }, ensure_ascii=False))
    sys.exit(0)

if os.path.exists(marker):
    passthrough("3단계 승인을 받은 세션의 worktree 수정입니다.")

# In auto mode the work request itself is the Step 3 approval
# (docs/approval-workflow.md "## 진행 모드"). Agents and their subagents still
# forget the marker, and every worktree file then stops on a prompt. Allow
# worktree edits in these modes even without the marker; the main checkout is
# still asked below because implementation belongs in a worktree.
if in_worktree and auto_mode:
    passthrough("오토 모드에서는 작업 요청이 3단계 승인을 대신하므로 worktree 수정을 허용합니다.")

# Flag the main checkout separately in the confirmation message.
if not in_worktree:
    reason = (
        "Step 3 사용자 승인 마커가 없고, 메인 체크아웃을 직접 수정하려 합니다. "
        "절차상 구현은 세션 전용 worktree에서 진행합니다. 이미 승인한 작업이면 허용해 주세요. "
        f"마커 경로: {marker}"
    )
else:
    reason = (
        "Step 3 사용자 승인 마커가 없습니다. 이미 승인한 작업이면 허용하고, "
        "아직 승인 전이면 거부한 뒤 분석·Git 계획부터 받으세요. "
        f"마커 경로: {marker}"
    )

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "ask",
        "permissionDecisionReason": reason,
    }
}, ensure_ascii=False))
PY
python3 "$PYSRC"
