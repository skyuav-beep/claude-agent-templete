# 로컬 개발 · CI 실행 가이드

agent가 로컬 개발 루프에서 Docker Desktop을 다루는 방식과 Git 마무리 게이트를 정의한다. 실행 승인 단계의 정본은 `docs/approval-workflow.md`다.

- 적용 범위: 전 작업 유형 공통 (feature / bugfix / refactor / business-logic).
- 실제 명령은 프로젝트 스택에 맞게 프로젝트별 `AGENTS.md ### Operational Commands`에서 치환한다. 본 문서는 정책과 판단 기준을 정의한다.
- 비즈니스 로직 변경의 단계별 실행 흐름·실패 대응은 `docs/business-logic-playbook.md §5`를 함께 본다.

## 0. 환경 호칭 정의 (3-tier)

마이그레이션·배포·검증 대상을 가리킬 때 아래 3개 호칭으로 통일한다. **"어디에(환경)"와 "어떻게(명령 모드)"는 별개 축**이므로 한 단어로 섞지 않는다.

| 호칭 | 실체 | 자동화 | 마이그레이션 명령(예: Prisma) |
|---|---|---|---|
| `local` | 내 PC Docker Desktop (로컬) | agent 상시 자동 | `prisma migrate dev` (생성+적용) |
| `develop` | 원격 개발서버 | 사용자 수동 | `prisma migrate deploy` (적용만) |
| `production` (`prod`) | 원격 운영서버 | 사용자 수동 | `prisma migrate deploy` (적용만) |

용어 규칙:

- **"dev" 단독 표기를 쓰지 않는다.** 환경은 `local` / `develop` / `production`으로, 명령은 항상 풀로(`prisma migrate dev` / `prisma migrate deploy`) 적는다. Prisma의 `migrate dev`에서 "dev"는 환경이 아니라 "개발 워크플로우 모드"이며, 환경 축과 직교한다.
- **개발서버 약어로 `dev`를 쓰지 않는다.** `migrate dev` 명령과 충돌하므로 `develop` 풀네임만 쓴다. (`prod`는 충돌 없어 허용)
- 본 문서에서 "dev 컨테이너 / dev 모드 / `pnpm dev` / `target: dev`"는 모두 **`local`(로컬 개발 컨테이너·명령)**을 가리키며, 원격 `develop` 환경과 무관하다.

자동화 경계 (마이그레이션):

- agent는 **`local`(내 PC Docker Desktop)에만** 마이그레이션을 적용한다. `develop`·`production`은 명령 종류와 무관하게 사용자 수동이다.
- 판단 기준은 **명령 이름이 아니라 연결 대상**이다. 실행 전 `DATABASE_URL`(또는 동등 연결 설정)이 `local` Docker를 가리키는지 확인한다. 원격을 가리키면 명령이 `migrate dev`라도 실행하지 않는다.

## 1. Agent 실행 경계 (핵심 규칙)

기준선: 단순 사실 조회 외 작업은 `docs/approval-workflow.md`의 1~3단계를 먼저 거친다. **3단계 승인 전에는 읽기 전용 분석만**, 승인 후에는 승인된 범위의 로컬 구현과 Git 수명주기를 수행한다. **원격 배포·원격 migration·릴리스 Action은 사용자 수동**이다.

| 영역 | 담당 | 비고 |
|---|---|---|
| 로컬 빌드 / 테스트 / 실행 (Docker Desktop) | **agent** | 컨테이너 기동·개발 루프 검증은 로컬에서 수행 |
| **빠른 범위 검증** | **3단계 승인 후 agent** | 6단계에서 기본 5분 이내로 실행 |
| **로컬 CI 전체 스위트** (lint+typecheck+unit+build[+e2e/smoke], 또는 `act`) | **배치 실행** | 3~5개 작업 누적·하루 종료·릴리스 전·사용자 요청 시 (§6.2) |
| DB migration — **`local`(Docker Desktop) 적용** | **agent** | 로컬 테스트 목적의 migration 파일 작성 + 로컬 DB 적용까지 (호칭·판단 기준 §0) |
| 작업 브랜치·worktree 생성 | **3단계 승인 후 agent** | 2단계에서 base·경로·브랜치를 먼저 확정 |
| commit / push / ready PR / merge / cleanup | **3단계 승인 범위 안에서 agent** | 6단계에서 연속 수행, 게이트 실패 시 중단 |
| ───────── 경계선 ───────── | | agent는 여기서 종료하고 인계 요약을 남긴다 |
| GitHub Actions 배포 / 릴리스 workflow 실행 | **사용자 수동** | agent는 dispatch/trigger 금지. push 자동 트리거 CI는 §6.4로 강등/제거 |
| **`develop`/`production`** DB migration 적용 | **사용자 수동** | "GitHub 이상" — agent 적용 금지 (§0) |
| 운영 반영 확인 / 롤백 판단 | **사용자 수동** | |

핵심: 3단계의 명시 승인이 없으면 파일 수정과 Git 쓰기를 실행하지 않는다. 2단계에 전체 Git 수명주기를 구체적으로 적고 승인받았다면 6단계에서 별도 재질문 없이 마무리한다. 배포·릴리스·원격 migration은 실행하지 않는다.

## 1.1. 승인 · 빠른 검증 · 전체 CI 배치

- 3단계 승인은 2단계에 적힌 정확한 수정 범위와 Git 수명주기에만 유효하다.
- 6단계에서는 변경 모듈 lint·관련 테스트·설정 구문·smoke 등 **빠른 범위 검증**을 기본 5분 이내로 수행한다.
- 전체 CI는 작업마다 실행하지 않는다. 3~5개 작업 누적, 하루 종료, 릴리스 전 또는 사용자 요청 시 별도 배치로 실행한다.
- 인증·권한·결제·정산·migration 관련 검증은 위험도가 높으므로 전체 CI 배치로 미루지 않는다.
- 전체 CI 미실행 항목은 `STATE.md`에 commit/PR, 필요한 스위트와 대기 사유를 남긴다.
- push가 GitHub Actions를 자동 실행하도록 의존하지 않는다. 남은 자동 워크플로 처리는 §6.4를 따른다.

## 2. Docker Desktop 개발 루프 전략

로컬 개발의 **기본 구조**는 개발 컨테이너를 상시 띄워두고, 소스를 bind mount로 연결하고, 앱 서버를 watch/hot reload로 실행하는 것이다(§2.1). 이 구조에서는 **코드 수정에 이미지 rebuild가 필요 없다** — 호스트 파일 수정이 컨테이너에 즉시 반영되고 hot reload가 다시 로드한다. rebuild는 의존성·이미지 정의가 바뀐 예외에서만 하며, 그때 증분(§2.2)과 강력 재빌드(§2.3) 중 §2.4 결정 트리로 모드를 택한다.

### 2.0. 개발 세션 부트스트랩 (PC 켜고 시작)

PC를 켜고 개발을 재개할 때, 아래 3단계를 한 번에 수행해 **"지금까지의 작업 상태 + 즉시 반영되는 dev 환경 + UI/로직 점검 준비"**를 부팅한다. 사용자가 "개발 시작"(또는 "이어서 개발", "세션 시작", "환경 셋팅해", "다음 작업은") 류로 세션을 재개하면 이 절차를 실행한다. 모두 로컬 작업이라 agent 자동 실행 범위 안이다(§1).

1. 상태 브리핑 — `STATE.md`의 `## 이번 세션에서 완료한 작업`과 `## 다음 작업`을 읽고, 직전 작업 지점과 바로 이어서 할 일을 한 줄로 요약한다.
2. dev 컨테이너 기동 — `docker compose up -d`를 실행한다. `docker compose ps`로 상태를 확인하고, `docker compose logs -f <svc>`에서 watcher 기동 로그(HMR/recompiled/reload)를 본다. 컨테이너는 §2.1 개발 컨테이너 모델(상시 기동 + bind mount + hot reload)을 전제한다.
3. UI/로직 점검 준비 — 서비스 URL(`localhost:<port>`)과 (있으면) preview HTML 경로를 안내하고, 트리비얼 변경 1줄로 hot reload가 실제로 반영되는지 확인한다(§2.1 검증). 점검이 끝나면 `STATE.md ## 다음 작업`부터 바로 개발을 이어간다.

기동 정책: 세션 시작 시 컨테이너 기동은 **항상 `docker compose up -d`**로 한다(상태 확인 후 분기하지 않는다 — `up -d`는 멱등이라 이미 기동 중이면 재생성하지 않는다). rebuild 여부는 §2.4 결정 트리를 따르며, **세션 시작이라는 이유만으로 rebuild하지 않는다.** 실제 명령·서비스명·포트는 프로젝트별 `AGENTS.md ### Operational Commands`에서 치환한다.

### 2.1. 개발 컨테이너 모델 (기본값)

원칙:

- dev 컨테이너는 `docker compose up -d`로 한 번 띄우고 **상시 기동**한다. 매 변경마다 끄거나 rebuild하지 않는다.
- 소스는 이미지에 COPY하지 않고 **bind mount**로 연결한다 → 호스트 수정이 컨테이너에 즉시 반영.
- 앱 서버는 **watch/hot reload** 모드로 실행한다(개발용 `command` override).
- 이미지 rebuild는 코드 수정 대상이 아니다 — 의존성·이미지 정의 변경 시에만(§2.2 / §2.3).

구성 패턴 (stack-agnostic 예시 — 명령·경로·포트는 프로젝트에 맞게 치환):

```yaml
services:
  api:
    build:
      context: .
      target: dev            # 멀티스테이지면 dev 타깃
    command: pnpm dev        # watch 실행 (예: vite/next dev, nodemon, uvicorn --reload)
    volumes:
      - ./:/app              # 소스 bind mount → 즉시 반영
      - /app/node_modules    # 익명 볼륨: 호스트가 컨테이너 의존성 디렉터리를 덮어쓰지 않게
    environment:
      - CHOKIDAR_USEPOLLING=true   # WSL2/Docker Desktop 파일 감지 (아래 주의)
    ports:
      - "3000:3000"
```

- Compose 2.22+는 `docker compose watch` + `develop.watch`(`action: sync` 코드 동기화 / `action: rebuild` 의존성 변경 시 자동 rebuild)로 더 정밀하게 운용할 수 있다.

파일 감지 신뢰성 (WSL2 + Docker Desktop 주의):

- bind mount는 inotify 이벤트가 컨테이너로 전달되지 않을 수 있어 watcher가 변경을 못 본다. 이때 **폴링**을 켠다:
  - Node 일반 `CHOKIDAR_USEPOLLING=true` / webpack `WATCHPACK_POLLING=true`
  - Vite `server.watch.usePolling=true` / nodemon `--legacy-watch`(`-L`) / Python `uvicorn --reload`(필요 시 `--reload-dir`)
- 소스는 WSL2 네이티브 파일시스템(`~/projects/...`)에 둔다. Windows 마운트(`/mnt/c/...`)는 I/O가 느리고 inotify가 약하다.

반영 방법 결정 (rebuild보다 먼저 판단):

| 변경 종류 | 반영 방법 | rebuild |
|---|---|---|
| 소스 코드(`src/**`) | hot reload 자동 반영 — 아무것도 안 함 | 불필요 |
| hot reload가 안 먹음 | 폴링 env 추가 후 컨테이너 `restart` | 불필요 |
| 환경변수(`.env`/compose env) | 컨테이너 재시작 `up -d <svc>` | 불필요 |
| 의존성·`Dockerfile`·`compose` | §2.2 / §2.3 rebuild | 필요 |

검증 (hot reload 작동 확인):

- `docker compose logs -f <svc>`에서 watcher 기동 + 변경 시 recompiled/HMR/reload 로그를 확인한다.
- 주석 1줄 등 트리비얼 변경 후 반영되는지 본다. 안 되면 위 폴링 env를 추가하고 재시작한다.

### 2.2. 빠른 증분 (rebuild가 필요한 경우의 기본 모드)

- 언제: hot reload가 동작하지 않는 서비스이거나, 코드가 이미지에 빌드돼야 반영되는 경우(컴파일 산출물 등). 의존성·이미지 정의는 그대로. (hot reload가 되는 서비스면 §2.1로 rebuild 자체가 불필요)
- 명령:
  ```bash
  # (a) volume mount + 핫리로드 환경이면 rebuild 불필요 — 저장 시 자동 반영
  # (b) 빌드가 필요하면 변경 서비스만:
  docker compose up -d --build <changed-service>
  # 의존 서비스까지 건드리지 않으려면:
  docker compose up -d --build --no-deps <changed-service>
  ```
- 특징: 빌드 캐시를 최대한 활용하고 변경된 서비스만 재생성한다. 빠르다.

### 2.3. 캐시 없는 강력 재빌드 (조건 자동 판단)

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

### 2.4. 결정 트리

```
변경 내용 판단:
├─ src/** 코드 + hot reload 동작      → [rebuild 불필요] 즉시 반영 (§2.1)
├─ src/** 코드 + hot reload 미동작    → [증분] up -d --build <svc> (§2.2)
├─ package.json·lock / requirements  → [강력] build --no-cache <svc> + up -d --force-recreate
├─ Dockerfile·compose·.dockerignore  → [강력] build --no-cache <svc>
├─ base image 갱신                   → [강력] (해당 svc) build --no-cache + force-recreate
├─ 캐시 꼬임 / 원인불명 런타임 이상   → [강력] (전체) 클린 재현
└─ 사용자 "클린 재빌드" 지시          → [강력]
```

판단 결과는 PR 본문(또는 작업 요약)에 한 줄로 남긴다 — 예: `재빌드: 증분 (src/만 변경)` 또는 `재빌드: 강력 (pnpm-lock.yaml 갱신 → build --no-cache api)`.

## 3. 승인 후 구현 → Git 마무리 흐름

```
[1~3단계 — 요청 정리, 읽기 전용 분석, 실행 승인]
  1) base·작업 브랜치·worktree·Git 수명주기 확정
[4단계 — 구현]
  2) 전용 worktree/branch 생성
  3) 승인 범위 구현 + 변경 모듈 검증
[5단계 — 읽기 전용 사후 감사]
  4) diff·요구사항·회귀·문서 누락 감사
[6단계 — 빠른 검증과 Git 마무리]
  5) 빠른 범위 검증
  6) STATE 및 전체 CI 대기열 기록
  7) commit → push → ready PR
  8) 게이트 확인 → merge → 원격 base SHA 검증
  9) 원격/로컬 작업 브랜치와 worktree 정리
──────────────────── 경계선 ────────────────────
[사용자 수동 — 원격 운영]
  10) GitHub Actions 배포/릴리스 실행 (있다면)
  11) 원격(`develop`/`production`) migration 적용
  12) 운영 반영 확인 / 롤백 판단
```

각 단계 통과 기준과 실패 대응은 `docs/business-logic-playbook.md §5.1 / §5.4`를 따른다.

## 4. 인계 요약 (agent가 작업/푸시 후 남기는 것)

agent는 로컬 검증을 마친 뒤(또는 사용자 요청으로 push한 뒤) 다음을 요약으로 남기고 종료한다.

- 변경 요약 (무엇을 왜)
- 적용한 **재빌드 모드 + 사유** (증분 / 강력)
- **로컬 migration 적용 여부와 내용** (적용했다면 어떤 변경인지)
- **빠른 검증 결과**와 필수 고위험 검증 여부
- **전체 CI 대기열**: 대상 commit/PR, 필요한 스위트, 배치 실행 조건
- **Git 마무리 결과**: commit, PR, merge SHA, 원격 base 검증, cleanup
- **[수동 TODO]** 사용자가 직접 진행할 것:
  - GitHub Actions 배포/릴리스 실행
  - 원격 migration 적용 (적용 순서·주의점 포함)
  - 운영 반영 확인

## 5. 금지 사항

- agent는 GitHub Actions 배포/릴리스 workflow를 trigger/dispatch하지 않는다 (`gh workflow run`, `gh release create`, 배포 스크립트 직접 실행 등 금지).
- agent는 검증을 **로컬 CI**(§6.2)로 한다. push로 원격 GitHub Actions CI를 트리거해 검증을 대신하지 않는다. push 자동 트리거 워크플로가 있으면 §6.4로 강등·제거한다.
- agent는 원격(`develop`/`production`) DB에 migration을 적용하지 않는다. migration 적용은 **`local`(Docker Desktop)까지만**. 실행 전 `DATABASE_URL`이 `local`을 가리키는지 확인하고, 원격을 가리키면 명령이 `migrate dev`라도 실행하지 않는다(§0).
- `docker compose down -v` 등 로컬 DB 데이터를 삭제하는 명령은 사용자 확인 없이 실행하지 않는다.
- `git push --force`는 본인 작업 브랜치에서 `--force-with-lease`로만. `main`/`master`/`develop`에는 금지 (`block-destructive.sh` hook이 차단).

## 6. 브랜치 · 로컬 CI · 머지 · 정리

git 작업(브랜치 생성 → 빠른 검증 → push → 머지 → 정리)의 정본 절차. 승인 경계는 `docs/approval-workflow.md`, 전체 CI 배치는 §6.2를 따른다.

### 6.1. 브랜치 생성·네이밍

- 작업당 1 브랜치. base를 먼저 정렬한 뒤 만든다.
  ```bash
  git checkout main && git pull --rebase origin main   # 또는 develop
  git checkout -b feat/orders-cancel-window
  ```
- 네이밍: `feat|fix|refactor|chore/<scope>-<short>` (Conventional Commits 접두사 + 범위).
- 2단계에서 base·브랜치·worktree를 확인하고 3단계 승인 후 생성한다.

### 6.2. 빠른 검증과 전체 CI 배치

6단계의 기본 게이트는 5분 이내의 빠른 범위 검증이다. 전체 로컬 CI는 3~5개 작업 누적·하루 종료·릴리스 전·사용자 요청 시 별도 배치로 실행한다.

실행 방식 (프로젝트 스택에 맞게 치환):

- **기본 — 로컬 스크립트 스위트** (가볍고 워크플로 파일 불필요):
  ```bash
  pnpm lint && pnpm typecheck && pnpm test && pnpm build
  # Docker 프로젝트면 smoke까지: docker compose up -d --build && <healthcheck>
  ```
  프로젝트에 단일 진입점(예: `pnpm ci:local` = 위 묶음)을 두면 호출이 단순해진다.
- **옵션 — `act`로 GitHub Actions 워크플로를 로컬 재현** (CI 환경 동등성이 필요할 때):
  ```bash
  act -j build                      # .github/workflows의 job을 로컬 Docker로 실행
  act pull_request                  # PR 이벤트 트리거 재현
  ```
  Docker 부하가 크므로 환경 동등성 검증이 꼭 필요한 경우에 쓴다. 워크플로 파일은 §6.4 기준으로 GitHub 자동 실행은 막아 둔 채 `act`로만 돌린다.

원칙: 빠른 검증은 해당 작업에서 끝내고 전체 CI 대기열은 `STATE.md`에 남긴다. 고위험 검증은 미루지 않으며, push가 원격 CI를 대신 돌리게 두지 않는다.

### 6.3. 머지 (3단계 승인 범위)

- 권한: 2단계에서 head/base·머지 방식·cleanup까지 적고 3단계에서 전체 수명주기를 승인받은 경우 agent가 수행한다.
- 게이트: PR이 open·비초안이고, head/base가 의도와 일치하며, 충돌이 없고, 필수 검사와 프로젝트가 요구하는 빠른 검증 또는 고위험 검증이 green이어야 한다.
- 금지: branch protection·필수 review·필수 check를 admin/force 옵션으로 우회하지 않는다. 게이트가 불명확하거나 실패하면 머지하지 않고 보고한다.
- 방식: 프로젝트 또는 사용자가 지정한 전략을 우선한다. 별도 지정이 없으면 **squash merge를 권장**한다.
- 절차:
  ```bash
  # PR 기반: GitHub UI 또는
  gh pr merge <num> --squash --delete-branch
  # 로컬 직접 머지(프로젝트 정책이 허용할 때):
  git checkout main && git pull --rebase origin main
  git merge --squash feat/orders-cancel-window && git commit
  git push origin main
  ```
- 완료 검증: PR 상태가 merged인지 확인하고 `git fetch origin` 후 원격 base가 머지 결과를 포함하는지 확인한다. 검증 전에는 완료로 보고하거나 브랜치를 삭제하지 않는다.

### 6.4. GitHub Actions 처리 (자동 CI 비활성)

- **push/PR로 자동 실행되는 CI 워크플로를 두지 않는다.** 검증 정본은 로컬 CI(§6.2)다.
- 기존 워크플로가 있으면 둘 중 하나:
  - **강등(권장)**: 트리거를 `on: workflow_dispatch`(또는 수동)로 바꿔 push/PR 자동 실행을 끈다. 파일은 남아 `act` 로컬 재현·필요 시 수동 dispatch에 쓸 수 있다.
  - **제거**: 워크플로 파일을 삭제한다.
- 배포/릴리스 워크플로는 agent가 trigger/dispatch하지 않는다(§5, 사용자 수동).

### 6.5. 브랜치 정리 (cleanup)

머지가 끝나면 작업 브랜치를 정리한다.

```bash
# 로컬 머지 브랜치 삭제 — unmerged면 git이 거부(안전)
git branch -d feat/orders-cancel-window
# 원격 브랜치 삭제 — 3단계에서 승인된 수명주기 범위
git push origin --delete feat/orders-cancel-window
# 삭제된 원격 추적 ref 정리
git fetch --prune
```

- 로컬 `git branch -d`는 머지 안 된 브랜치를 거부하므로 안전하다.
- `git branch -D`(강제 삭제)는 미머지 작업을 잃으므로 사용자 확인 없이는 쓰지 않는다(`block-destructive.sh` 점검 대상).
- 원격 삭제·`--prune`는 3단계에서 승인되고 원격 base의 머지 반영을 검증한 뒤 수행한다.
