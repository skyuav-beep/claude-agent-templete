---
name: session-coordination
description: Claude와 Codex 여러 세션이 같은 저장소 파일, worktree, Compose·DB 자원을 동시에 사용할 때 충돌을 조정할 때 사용한다.
---

# Session Coordination Skill

1. `eval "$(bash .claude/hooks/session-coordination.sh resource)"`로 세션 ID를 고정한다.
2. 세션을 register하고 active 상태를 확인한다.
3. 수정 전 대상 파일을 claim한다.
4. 충돌 시 기다리거나 사용자 확인을 받는다.
5. 종료 시 release하고, 동시 개발이면 Compose·DB·port 격리 기준을 확인한다.

상세 절차는 `.codex/workflows/session-coordination.md`를 따른다.
