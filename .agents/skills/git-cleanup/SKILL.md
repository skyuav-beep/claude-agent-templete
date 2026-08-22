---
name: git-cleanup
description: 미커밋 변경, 미push 커밋, 열린 PR, 남은 브랜치·worktree, STATE 기록 누락을 점검하고 Git 작업을 마무리할 때 사용한다.
---

# Git Cleanup Skill

1. `git status`, 원격 대비, PR, 브랜치, worktree를 읽기 전용으로 점검한다.
2. 개발 내용과 완결·미완료 변경을 먼저 요약한다.
3. 정리 계획과 Git 수명주기를 제시하고 승인받는다.
4. 승인 후 빠른 검증, STATE, commit, push, PR, merge, base SHA 확인, cleanup 순으로 진행한다.
5. 배포·release·원격 migration·강제 push는 실행하지 않는다.

상세 절차는 `.codex/workflows/git-cleanup.md`를 따른다.
