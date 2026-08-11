#!/usr/bin/env bash
# PreToolUse/Edit,Write: 승인 전 파일 수정 차단
#
# Claude Code 전용 게이트다. Codex는 저장소 훅을 자동 실행하지 않으므로
# .codex/workflows와 체크리스트의 단계 계약을 별도로 적용한다.

python3 /dev/fd/3 3<<'PY'
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
# common git directory and is never an implementation target.
target_repo_git = git(target_dir, "rev-parse", "--path-format=absolute", "--git-dir")
if os.path.realpath(target_repo_git) == project_git:
    reason = "메인 트리 직접 수정은 허용하지 않습니다. 구현은 세션 전용 worktree에서 진행하세요."
else:
    session_id = payload.get("session_id") or "<session_id>"
    marker = os.path.join(os.path.dirname(project_git), ".claude", ".approval", session_id)
    if not os.path.exists(marker):
        reason = (
            "Step 3 사용자 승인 마커가 없어 파일 수정을 차단했습니다. "
            "분석·Git 계획을 먼저 제시하고 사용자의 승인을 받은 뒤, "
            f"승인된 세션 마커를 생성하세요: {marker}"
        )
    else:
        sys.exit(0)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": reason,
    }
}, ensure_ascii=False))
PY
