# Session Coordination Workflow

Claude/Codex 세션이 같은 저장소에서 겹치는 작업을 피하도록 공용 세션 레지스트리를 사용한다.

## 작업 시작

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
bash .claude/hooks/session-coordination.sh register
bash .claude/hooks/session-coordination.sh status
```

첫 줄의 `eval`은 `SESSION_COORD_SESSION_ID`를 현재 셸에 고정한다. 명령마다 새 셸을 띄우는
실행기에서는 이 값이 없으면 `register`, `claim`, `release`가 서로 다른 세션으로 갈라지므로
반드시 먼저 실행한다.

기존 active 세션이 같은 기능이나 파일을 다루면 작업을 겹치지 않게 조정한다. 다른 파일을 다루는 독립 작업은 승인 후 전용 worktree에서 진행한다.

## 파일 수정 전

```bash
bash .claude/hooks/session-coordination.sh claim <absolute-or-relative-file>
```

충돌 응답이 나오면 기존 세션 완료를 기다리거나 사용자 확인을 받은 뒤 진행한다. `claim`이 성공한 파일만 수정 대상으로 삼는다.

## 작업 종료

```bash
bash .claude/hooks/session-coordination.sh release
```

승인·worktree·Git 수명주기는 `docs/approval-workflow.md`를 따르고, Docker 포트·DB·volume은 `docs/session-coordination-guide.md`의 한계를 적용한다.

Compose/DB 개발환경을 동시에 사용할 때는 실행 전에 리소스 이름을 세션별로 계산한다.

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
docker compose -p "$COMPOSE_PROJECT_NAME" up -d
```

프로젝트 Compose 파일이 해당 변수들을 사용하도록 구성되어 있는지 먼저 확인한다.

## 브랜치·worktree 를 지우는 명령

다른 세션이 등록돼 있으면 아래 형태는 실행 전 확인을 요청한다. 한쪽이 만든 브랜치를 다른 창이 지우면 커밋을 되짚을 단서가 reflog 밖에 남지 않는다.

- 브랜치 삭제 `git branch -D|--delete`
- 원격 ref 삭제 `git push origin --delete <ref>`, `git push origin :refs/heads/<ref>`, `git update-ref -d`
- worktree 제거 `git worktree remove|prune`
- 이력 덮어쓰기 `git push --force|--force-with-lease|--mirror`

`git push origin main`, `git branch <new>`, `git worktree add` 는 통과한다. 등록된 다른 세션이 없으면 아무것도 막지 않는다. 확인 요청을 받으면 **그 브랜치가 본인 것인지 먼저 확인**하고, 남의 것이면 지우지 말고 사용자에게 알린다.
