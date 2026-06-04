# 로컬 개발 · CI 실행 가이드

agent가 로컬 개발 루프에서 Docker Desktop을 다루는 방식과, **agent 자동 실행의 경계**(어디까지 agent가 하고, 어디부터 사용자가 수동으로 하는지)를 정의한다.

- 적용 범위: 전 작업 유형 공통 (feature / bugfix / refactor / business-logic).
- 실제 명령은 프로젝트 스택에 맞게 프로젝트별 `AGENTS.md ### Operational Commands`에서 치환한다. 본 문서는 정책과 판단 기준을 정의한다.
- 비즈니스 로직 변경의 단계별 실행 흐름·실패 대응은 `docs/business-logic-playbook.md §5`를 함께 본다.

## 1. Agent 실행 경계 (핵심 규칙)

기준선: **로컬(Docker Desktop) + commit = agent 상시**, **push + CI = 사용자 요청 시에만(§1.1)**, **"GitHub 이상"(원격 배포·원격 migration·릴리스 Action) = 사용자 수동**.

| 영역 | 담당 | 비고 |
|---|---|---|
| 로컬 빌드 / 테스트 / 실행 (Docker Desktop) | **agent** | 컨테이너 기동·검증은 로컬에서 수행 |
| DB migration — **로컬 Docker Desktop 적용** | **agent** | 로컬 테스트 목적의 migration 파일 작성 + 로컬 DB 적용까지 |
| `git commit` | **agent** | Conventional Commits, 논리 단위 분리. **로컬 누적 가능**(push와 분리) |
| `git push` | **사용자 요청 시 agent** | 사용자가 지시할 때만(§1.1). 예외: 세션 종료 백업 push 1회(`[skip ci]`) |
| `gh pr create` / PR 생성 | **사용자 요청 시 agent** | push와 함께 1회, slice마다 쪼개지 않음 (§1.1) |
| CI (push로 자동 트리거, 결과 확인) | **사용자 요청 시 agent** | push가 요청 시에만 일어나므로 CI도 그때만. 실패 시 원인 수정 후 재push |
| ───────── 경계선 ───────── | | agent는 여기서 종료하고 인계 요약을 남긴다 |
| GitHub Actions 배포 / 릴리스 workflow 실행 | **사용자 수동** | agent는 dispatch/trigger 금지 |
| 원격(staging/prod) DB migration 적용 | **사용자 수동** | "GitHub 이상" — agent 적용 금지 |
| 운영 반영 확인 / 롤백 판단 | **사용자 수동** | |

핵심: agent는 **"GitHub 이상"의 원격 작업을 자동 실행하지 않는다.** push까지 마치면 `## 4. 인계 요약`을 남기고 종료한다. migration은 **로컬 Docker Desktop에서만** 적용하고, 원격 적용은 사용자에게 인계한다.

## 1.1. push / CI 게이트 (사용자 요청 기반)

`git commit`(로컬)과 `git push`·`PR 생성`·CI(원격 노출)를 분리한다. **push 1회 = CI 1회 = 리뷰/머지 1회**이므로, push 빈도가 곧 CI 실행 빈도다. CI를 통제하려면 push를 통제하면 된다.

기본 규칙: **push·PR·CI는 사용자가 명시 지시할 때만 수행한다. agent는 스스로 push하지 않는다.**

- 로컬 commit은 자유롭게 자주 한다 — 체크포인트·되돌리기 목적. 논리 단위마다 누적해도 된다.
- 완료 판단과 검증은 **로컬에서만** 한다 (lint / 단위 테스트 / build / Docker smoke). agent는 로컬 검증만으로 "완료"를 보고하고 push하지 않는다.
- 사용자가 `push` / `올려` / `PR` / `CI 돌려` 를 명시하면 → 그때 누적 commit을 일괄 push하고 필요 시 **PR 1개**를 만든다(slice마다 쪼개지 않는다).
- 검증이 **CI에서만 가능**하다고 판단되면, 자동 push하지 말고 사용자에게 "CI를 돌릴까요?"라고 묻고 요청을 받는다.

세션 종료·인계 예외 (유실 방지 백업):

- 세션을 종료하며 작업을 원격에 보존해야 하면, 백업 목적으로 **1회 push를 허용**한다.
- 단 이 백업 push는 **CI를 트리거하지 않는다** — 마지막 commit 메시지에 CI provider가 인식하는 skip 토큰(GitHub Actions: `[skip ci]` / `[ci skip]` 등)을 넣어 워크플로 실행을 건너뛴다.
- skip 토큰을 지원하지 않는 CI를 쓰는 프로젝트는 이 백업 push를 생략하거나 사용자 확인을 받는다.

머지는 agent 범위 밖이다(§1 경계선). 사용자가 별도 정책(작업당 PR, trunk-based 직접 push 등)을 지정하면 그 정책을 우선한다.

## 2. Docker Desktop 재빌드 전략 (2모드)

로컬 개발이 계속 진행될 때, 변경 내용에 따라 두 모드 중 하나를 택한다. **기본은 증분**이며, 아래 자동 판단 조건에 걸리면 강력 재빌드로 전환한다.

### 2.1. 빠른 증분 (기본)

- 언제: `src/**` 애플리케이션 코드만 변경한 일상 반복 루프.
- 명령:
  ```bash
  # (a) volume mount + 핫리로드 환경이면 rebuild 불필요 — 저장 시 자동 반영
  # (b) 빌드가 필요하면 변경 서비스만:
  docker compose up -d --build <changed-service>
  # 의존 서비스까지 건드리지 않으려면:
  docker compose up -d --build --no-deps <changed-service>
  ```
- 특징: 빌드 캐시를 최대한 활용하고 변경된 서비스만 재생성한다. 빠르다.

### 2.2. 캐시 없는 강력 재빌드 (조건 자동 판단)

- 언제 (아래 중 하나라도 해당하면 agent가 자동 전환):
  - 의존성 변경 — `package.json` / `pnpm-lock.yaml` / `yarn.lock` / `requirements.txt` / `go.mod` 등
  - 이미지 정의 변경 — `Dockerfile` / `docker-compose.yml` / `.dockerignore`
  - base image 갱신 (`FROM` 태그 변경, pull 갱신)
  - 빌드 캐시 꼬임 의심 / 원인불명 런타임 이상 → 클린 재현이 필요할 때
  - 사용자가 "클린 재빌드 / 클린 재현"을 명시할 때
- 명령:
  ```bash
  docker compose build --no-cache <service>          # 또는 전체
  docker compose up -d --force-recreate <service>
  # 컨테이너/네트워크까지 초기화가 필요하면:
  docker compose down && docker compose build --no-cache && docker compose up -d
  ```
- 주의: `docker compose down -v`(볼륨 삭제)는 **로컬 DB 데이터가 소실**되므로 자동 실행하지 않는다. 필요 시 사용자 확인을 받는다.
- 특징: 캐시를 무시한 전체 재빌드. 느리지만 결정적이다.

### 2.3. 결정 트리

```
변경 내용 판단:
├─ src/** 애플리케이션 코드만        → [증분] 핫리로드 자동반영 / 또는 up -d --build <svc>
├─ package.json·lock / requirements  → [강력] build --no-cache <svc> + up -d --force-recreate
├─ Dockerfile·compose·.dockerignore  → [강력] build --no-cache <svc>
├─ base image 갱신                   → [강력] (해당 svc) build --no-cache + force-recreate
├─ 캐시 꼬임 / 원인불명 런타임 이상   → [강력] (전체) 클린 재현
└─ 사용자 "클린 재빌드" 지시          → [강력]
```

판단 결과는 PR 본문(또는 작업 요약)에 한 줄로 남긴다 — 예: `재빌드: 증분 (src/만 변경)` 또는 `재빌드: 강력 (pnpm-lock.yaml 갱신 → build --no-cache api)`.

## 3. 로컬 검증 → CI 인계 흐름

```
[agent — 로컬 반복 루프 (push 없이 반복)]
  1) 코드 변경
  2) lint
  3) unit test (변경 모듈 + 인접)
  4) build
  5) Docker 재빌드 (2모드 판단) + smoke
  6) DB migration — 로컬 Docker Desktop 적용 + 검증 (해당 시)
  7) git commit (로컬 누적 — 1~6을 여러 번 반복하며 commit만 쌓는다)
─────────── 사용자가 push/CI를 요청할 때만 (§1.1) ───────────
  8) git push (누적 commit 일괄) + 필요 시 PR 1개   ← 사용자 지시 시
  9) CI 결과 확인 (push로 트리거됨, 실패 시 원인 수정 후 재push)
──────────────────── 경계선 ────────────────────
[사용자 수동]
  10) GitHub Actions 배포/릴리스 실행
  11) 원격(staging/prod) migration 적용
  12) 운영 반영 확인 / 롤백 판단
```

각 단계 통과 기준과 실패 대응은 `docs/business-logic-playbook.md §5.1 / §5.4`를 따른다.

## 4. 인계 요약 (agent가 작업/푸시 후 남기는 것)

agent는 로컬 검증을 마친 뒤(또는 사용자 요청으로 push한 뒤) 다음을 요약으로 남기고 종료한다.

- 변경 요약 (무엇을 왜)
- 적용한 **재빌드 모드 + 사유** (증분 / 강력)
- **로컬 migration 적용 여부와 내용** (적용했다면 어떤 변경인지)
- **push 여부**: 미push(로컬 commit만) / 사용자 요청 push / 세션 종료 백업 push(`[skip ci]`, CI 미실행)
- CI 상태: 사용자가 CI를 요청해 push한 경우만 "트리거됨, 결과 확인 필요". 그 외엔 "CI 미실행(요청 시 실행)"
- **[수동 TODO]** 사용자가 직접 진행할 것:
  - GitHub Actions 배포/릴리스 실행
  - 원격 migration 적용 (적용 순서·주의점 포함)
  - 운영 반영 확인

## 5. 금지 사항

- agent는 GitHub Actions 배포/릴리스 workflow를 trigger/dispatch하지 않는다 (`gh workflow run`, `gh release create`, 배포 스크립트 직접 실행 등 금지).
- agent는 원격(staging/prod) DB에 migration을 적용하지 않는다. migration 적용은 **로컬 Docker Desktop까지만**.
- `docker compose down -v` 등 로컬 DB 데이터를 삭제하는 명령은 사용자 확인 없이 실행하지 않는다.
- `git push --force`는 본인 작업 브랜치에서 `--force-with-lease`로만. `main`/`master`/`develop`에는 금지 (`block-destructive.sh` hook이 차단).
