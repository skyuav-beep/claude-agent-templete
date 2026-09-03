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

# The Step 3 marker is checked first: once the session is approved the user
# should not be asked again, whichever tree the change lands in.
session_id = payload.get("session_id") or "<session_id>"
marker = os.path.join(os.path.dirname(project_git), ".claude", ".approval", session_id)
if os.path.exists(marker):
    sys.exit(0)

# A worktree has its own git-dir. The main checkout points directly at the
# common git directory, so flag it separately in the confirmation message.
target_repo_git = git(target_dir, "rev-parse", "--path-format=absolute", "--git-dir")
if os.path.realpath(target_repo_git) == project_git:
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
