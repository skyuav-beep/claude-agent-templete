---
description: "여러 세션(창)이 같은 저장소 파일·worktree·Docker 자원을 동시에 쓸 때 충돌을 조정할 때 활성화 (세션 충돌, 동시 작업, 다른 창, 파일 점유, 같은 파일 수정, session coordination, 세션 정리)"
---

# 세션 충돌 조정

여러 Claude·Codex 창이 같은 저장소를 동시에 열었을 때, 같은 파일을 겹쳐 고치거나 Docker 자원을 서로 덮어쓰는 것을 막는다.

> 경로 규칙: 아래 `docs/` 경로는 프로젝트 루트 기준이다. 프로젝트에 해당 파일이 없으면 `rules/` 아래 같은 경로를 읽는다(공통 템플릿을 `rules/` symlink로 연결한 프로젝트).

## 실행 방법

### 1. 세션 ID 고정 (가장 먼저)

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
```

명령마다 새 셸을 띄우는 실행기에서는 이 값이 없으면 `register`·`claim`·`release`가 서로 다른 세션으로 갈라져 등록 해제가 되지 않는다. 반드시 먼저 실행한다.

### 2. 등록과 현황 확인

```bash
bash .claude/hooks/session-coordination.sh register
bash .claude/hooks/session-coordination.sh status
```

다른 active 세션이 같은 기능·파일을 다루면 범위가 겹치지 않게 조정한다. 독립 작업이면 승인 후 전용 worktree에서 진행한다.

### 3. 파일 수정 전 점유

```bash
bash .claude/hooks/session-coordination.sh claim <파일 경로>
```

`claim`이 성공한 파일만 수정 대상으로 삼는다. 충돌 응답이 나오면 기존 세션이 끝나기를 기다리거나 사용자 확인을 받는다.

### 4. 종료 시 해제

```bash
bash .claude/hooks/session-coordination.sh release
```

오래된 등록이 남아 있으면 `prune`으로 정리한다. 보존 시간은 `SESSION_COORD_TTL_SECONDS`로 조정한다.

## Docker 자원 격리

Compose·DB 개발환경을 동시에 쓸 때는 실행 전에 세션별 리소스 이름을 계산한다.

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
docker compose -p "$COMPOSE_PROJECT_NAME" up -d
```

프로젝트 Compose 파일이 해당 변수를 사용하도록 구성되어 있는지 먼저 확인한다. 구성되어 있지 않으면 포트·volume이 그대로 충돌하므로 사용자에게 알린다.

## 안전 경계

- 다른 세션이 점유한 파일을 확인 없이 수정하지 않는다.
- 다른 세션의 등록을 임의로 해제하지 않는다. 만료된 등록만 `prune` 대상이다.
- 다른 세션이 띄운 컨테이너·volume을 지우지 않는다.

## 승인 절차 연결

- 점유 확인과 현황 조회는 읽기 전용이라 2단계에서 수행한다.
- 실제 파일 수정은 `docs/approval-workflow.md` 3단계 승인 뒤 4단계에서 진행한다.
- 한계와 조정 기준은 `docs/session-coordination-guide.md`를 따른다.
