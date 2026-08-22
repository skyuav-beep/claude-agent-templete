# Session Coordination Workflow

Claude/Codex 세션이 같은 저장소에서 겹치는 작업을 피하도록 공용 세션 레지스트리를 사용한다.

## 작업 시작

```bash
bash .claude/hooks/session-coordination.sh register
bash .claude/hooks/session-coordination.sh status
```

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
