---
description: "여러 세션이 같은 저장소를 동시에 쓸 때 파일 점유와 Docker 자원을 조정한다: 세션 ID 고정 → 등록·현황 → 파일 claim → 종료 시 release"
argument-hint: "[status | claim <파일> | release | prune | 비워두면 현황 확인]"
---

# 세션 충돌 조정

여러 Claude·Codex 창이 같은 저장소를 동시에 열었을 때, 같은 파일을 겹쳐 고치거나 Docker 자원을 서로 덮어쓰는 것을 막는다.

> 경로 규칙: 아래 `docs/` 경로는 프로젝트 루트 기준이다. 프로젝트에 해당 파일이 없으면 `rules/` 아래 같은 경로를 읽는다.

## 실행 방법

1. **세션 ID 고정** — `eval "$(bash .claude/hooks/session-coordination.sh resource)"`를 가장 먼저 실행한다. 이 값이 없으면 명령마다 세션이 갈라져 등록 해제가 되지 않는다.
2. **등록과 현황** — `register` 후 `status`로 다른 active 세션과 겹치는 범위를 확인한다.
3. **파일 수정 전 점유** — `claim <파일 경로>`가 성공한 파일만 수정한다. 충돌하면 기다리거나 사용자 확인을 받는다.
4. **종료 시 해제** — `release`로 등록을 푼다. 만료된 등록은 `prune`으로 정리한다.

## Docker 자원 격리

Compose·DB를 동시에 쓸 때는 `eval "$(... resource)"`로 계산한 `COMPOSE_PROJECT_NAME`을 `docker compose -p`에 넘긴다. 프로젝트 Compose 파일이 해당 변수를 쓰도록 구성되어 있는지 먼저 확인하고, 아니면 포트·volume이 그대로 충돌하므로 사용자에게 알린다.

## 인수 처리

- 인수가 없으면 세션 ID 고정 후 현황만 보고한다(읽기 전용).
- `claim`은 대상 파일 경로가 필요하다.

## 안전 경계

- 다른 세션이 점유한 파일을 확인 없이 수정하지 않는다.
- 다른 세션의 등록을 임의로 해제하지 않는다. 만료된 등록만 `prune` 대상이다.
- 다른 세션이 띄운 컨테이너·volume을 지우지 않는다.
- 실제 파일 수정은 `docs/approval-workflow.md` 3단계 승인 뒤에 한다. 한계는 `docs/session-coordination-guide.md`를 따른다.
