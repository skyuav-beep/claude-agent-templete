---
name: session-end
description: 세션 종료·마감·인계 정리·오늘 작업 끝 요청에서 이번 작업 이력과 다음 재개 지점을 STATE.md에 기록하고 Git 잔여물을 정리할 때 사용한다. Git 상태만 정리하면 git-cleanup을 사용하며, state는 STATE 기록만, git은 Git 정리만 수행한다.
---

# Session End Skill

1. 인수가 없으면 전체 세션 종료 절차를, `state`면 STATE 기록만을, `git`이면 Git 정리만을 수행하는 모드로 해석한다.
2. 작업 이력을 읽기 전용으로 수집한다. `git status`, diff, 마지막 STATE 기록 이후의 커밋, 대화에서 나온 결정 근거를 함께 모은다.
3. 완료 / 진행 중 / 보류로 나누고, 진행 중 항목에서 다음 세션의 재개 지점을 도출한다.
4. 미커밋 변경, 미push 커밋, 열린 PR, 잔여 브랜치·worktree를 전수 점검한다.
5. 이번 세션에 무엇을 했는지 먼저 요약하고, 선택한 모드에 맞는 정리 계획과 Git 수명주기를 제시해 승인받는다.
6. 승인 후 전체 모드는 빠른 검증, STATE 기록, commit, push, PR, merge, base SHA 확인, cleanup 순으로 진행한다. `state` 모드는 STATE 기록까지만, `git` 모드는 Git 정리까지만 진행한다.
7. 배포·release·원격 migration·강제 push는 실행하지 않는다. 만들다 만 변경은 확인 없이 버리지 않는다.

상세 절차는 `.codex/workflows/session-end.md`를 따른다.
