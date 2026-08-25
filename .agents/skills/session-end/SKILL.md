---
name: session-end
description: 세션을 닫을 때 이번 작업 이력과 다음 재개 지점을 STATE.md에 기록하고, 미커밋·미push·열린 PR·잔여 브랜치·worktree를 남기지 않고 정리할 때 사용한다.
---

# Session End Skill

1. 작업 이력을 읽기 전용으로 수집한다. `git status`, diff, 마지막 STATE 기록 이후의 커밋, 대화에서 나온 결정 근거를 함께 모은다.
2. 완료 / 진행 중 / 보류로 나누고, 진행 중 항목에서 다음 세션의 재개 지점을 도출한다.
3. 미커밋 변경, 미push 커밋, 열린 PR, 잔여 브랜치·worktree를 전수 점검한다.
4. 이번 세션에 무엇을 했는지 먼저 요약하고, 정리 계획과 Git 수명주기를 제시해 승인받는다.
5. 승인 후 빠른 검증, STATE 기록, commit, push, PR, merge, base SHA 확인, cleanup 순으로 진행한다.
6. 배포·release·원격 migration·강제 push는 실행하지 않는다. 만들다 만 변경은 확인 없이 버리지 않는다.

상세 절차는 `.codex/workflows/session-end.md`를 따른다.
