#!/usr/bin/env bash
# PreToolUse/Agent,Task,EnterWorktree: .claude/ 아래 worktree 생성을 막는다.
#
# Agent 도구의 isolation:"worktree"와 EnterWorktree는 작업 폴더를
# <저장소>/.claude/worktrees/ 아래에 만든다. Claude Code는 .claude/를 보호 경로로
# 다뤄 auto 모드에서도 파일을 만들거나 고칠 때마다 확인 창을 띄우므로, 자동 진행이
# 끊긴다. 형제 폴더(<프로젝트>-worktrees/) worktree를 쓰도록 거부 사유로 안내한다.
# 정본 규칙: docs/subagent-guide.md ### 작업 폴더
#
# 입력: stdin JSON({"tool_name":"...","tool_input":{...}}). 판정 실패는 통과시킨다.

command -v python3 >/dev/null 2>&1 || exit 0

python3 -c '
import json, sys

try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

tool = data.get("tool_name") or ""
tool_input = data.get("tool_input") or {}

if tool in ("Agent", "Task"):
    if tool_input.get("isolation") != "worktree":
        sys.exit(0)
    reason = (
        "isolation:\"worktree\"는 <저장소>/.claude/worktrees/에 작업 폴더를 만들어 "
        "파일마다 확인 창이 뜹니다. isolation 없이 다시 호출하고, 세션 worktree"
        "(<프로젝트>-worktrees/<작업명>)의 절대 경로를 프롬프트에 넣어 그 안에서만 "
        "작업하게 하세요. 병렬 작업이면 형제 폴더에 git worktree add로 하나씩 더 만들어 "
        "나눠 주세요 (docs/subagent-guide.md ### 작업 폴더)."
    )
elif tool == "EnterWorktree":
    reason = (
        "EnterWorktree는 <저장소>/.claude/worktrees/에 작업 폴더를 만들어 파일마다 "
        "확인 창이 뜹니다. git worktree add로 형제 폴더(<프로젝트>-worktrees/<작업명>)에 "
        "만들어 작업하세요 (docs/subagent-guide.md ### 작업 폴더)."
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
'
