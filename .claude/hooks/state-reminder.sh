#!/usr/bin/env bash
# PreToolUse/Bash: git commit 시 STATE.md 갱신 리마인더
# Golden Rule: "작업이 끝나면 STATE.md를 갱신한다"
# 의도: 차단하지 않고 경고만 전달한다 (항상 exit 0).
# STATE.md 갱신이 불필요한 경우도 있으므로 판단은 에이전트/사용자에게 맡긴다.
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
import subprocess
import sys


def git(cwd, *args):
    try:
        r = subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True, timeout=5)
    except Exception:
        return ""
    return r.stdout if r.returncode == 0 else ""


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
staged = git(cwd, "diff", "--cached", "--name-only")
unstaged = git(cwd, "diff", "--name-only")
if "STATE.md" in staged or "STATE.md" in unstaged:
    sys.exit(0)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "additionalContext": (
            "STATE.md가 이번 커밋에 포함되지 않았습니다. 작업 내용을 STATE.md에 반영했는지 "
            "확인하세요. 단순 질의·일회성 분석처럼 갱신 대상이 아닌 작업이면 그대로 진행하면 됩니다."
        ),
    }
}, ensure_ascii=False))
PY
