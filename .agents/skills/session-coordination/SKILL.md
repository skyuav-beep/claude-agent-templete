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

## 브랜치·worktree 를 지우는 명령

다른 세션이 등록돼 있으면 아래 형태는 실행 전 확인을 요청한다. 한쪽이 만든 브랜치를 다른 창이 지우면 커밋을 되짚을 단서가 reflog 밖에 남지 않는다.

- 브랜치 삭제 `git branch -D|--delete`
- 원격 ref 삭제 `git push origin --delete <ref>`, `git push origin :refs/heads/<ref>`, `git update-ref -d`
- worktree 제거 `git worktree remove|prune`
- 이력 덮어쓰기 `git push --force|--force-with-lease|--mirror`

`git push origin main`, `git branch <new>`, `git worktree add` 는 통과한다. 등록된 다른 세션이 없으면 아무것도 막지 않는다. 확인 요청을 받으면 **그 브랜치가 본인 것인지 먼저 확인**하고, 남의 것이면 지우지 말고 사용자에게 알린다.
