#!/usr/bin/env bash
# PreToolUse/Bash: git commit 시 STATE.md 갱신 리마인더
# Golden Rule: "작업이 끝나면 STATE.md를 갱신한다"
# 의도: 차단하지 않고 경고만 전달한다 (항상 exit 0).
# STATE.md 갱신이 불필요한 경우도 있으므로 판단은 에이전트에게 맡긴다.
# 갱신이 필요한 경우에는 사용자에게 되묻지 않고 바로 반영한다
# (docs/approval-workflow.md "재확인하지 않는 작업").
#
# 입력 규약: stdin JSON({"cwd":"...","tool_input":{"command":"..."}})이 1차,
# 구 규약 $CLAUDE_TOOL_INPUT는 폴백.
# payload는 argv가 아니라 stdin으로 받는다(대용량 tool_input 대응, block-destructive.sh 주석 참조).
#
# 출력 규약: exit 0 + stdout JSON의 additionalContext.
# 종전에는 exit 0 + stderr로 경고했지만 Claude Code는 exit 0의 stderr를 버리고
# exit 2의 stderr만 모델에게 전달한다. 즉 경고가 아무에게도 도달하지 않았다.
# 차단하지 않으면서 모델에게 전달하는 방법은 stdout JSON뿐이다.

python3 /dev/fd/3 3<<'PY'
import json
import os
import re
import subprocess
import sys


def git(cwd, *args):
    try:
        r = subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True, timeout=5)
    except Exception:
        return ""
    return r.stdout if r.returncode == 0 else ""


def candidate_dirs(command, cwd):
    """검사할 저장소 후보를 모은다.

    도구가 알려주는 cwd는 Bash 도구 호출 시점의 것이라, 명령 안에서
    `cd other-repo && git commit`처럼 이동하면 엉뚱한 저장소를 본다.
    실제로 worktree에서 커밋할 때 상태 기록이 포함됐는데도 경고가 떴다.
    명령 문자열의 이동 대상까지 후보에 넣고, 어느 하나라도 STATE.md를
    담고 있으면 통과시킨다(차단이 아닌 경고이므로 관대하게 판정한다).
    """
    found = [cwd]
    patterns = (
        r"(?:^|[;&|]\s*)cd\s+(?:--\s+)?([^\s;&|]+)",
        r"\bgit\s+(?:-[a-zA-Z]\s+\S+\s+)*-C\s+([^\s;&|]+)",
    )
    for pattern in patterns:
        for match in re.finditer(pattern, command, re.M):
            path = match.group(1).strip("'\"")
            if not path or path == "-" or path.startswith("$"):
                continue
            path = os.path.expanduser(path)
            if not os.path.isabs(path):
                path = os.path.normpath(os.path.join(cwd, path))
            found.append(path)

    seen, dirs = set(), []
    for path in found:
        if path not in seen and os.path.isdir(path):
            seen.add(path)
            dirs.append(path)
    return dirs


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
command = data.get("command") or ""
if "git commit" not in command:
    sys.exit(0)

# 훅 프로세스의 cwd가 아니라 도구가 실행되는 cwd 기준으로 본다(worktree 대응).
cwd = payload.get("cwd") or os.getcwd()
dirs = candidate_dirs(command, cwd)
if not dirs:
    sys.exit(0)

for path in dirs:
    staged = git(path, "diff", "--cached", "--name-only")
    unstaged = git(path, "diff", "--name-only")
    if "STATE.md" in staged or "STATE.md" in unstaged:
        sys.exit(0)

checked = ", ".join(dirs)
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "additionalContext": (
            f"STATE.md가 이번 커밋에 포함되지 않았습니다(검사 경로: {checked}). 작업 내용을 "
            "STATE.md에 반영했는지 점검하고, 필요하면 사용자에게 되묻지 말고 바로 갱신해 "
            "이번 커밋에 포함하세요. 단순 질의·일회성 분석처럼 갱신 대상이 아닌 작업이면 "
            "그대로 진행하면 됩니다. 검사 경로가 실제 커밋 대상과 다르면 이 경고는 무시해도 됩니다."
        ),
    }
}, ensure_ascii=False))
PY
