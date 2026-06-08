# Business Logic Playbook

이 문서는 비즈니스 로직과 관련된 작업을 어떤 프로세스로 진행하고, 각 단계에서 무엇을 확인해야 하는지 정리한 운영 가이드다.

## 1. 목적

- 비즈니스 로직 변경을 UI 변경과 구분해서 관리한다.
- 요구사항, 시나리오, 구현, 검증, 배포 준비를 한 흐름으로 통제한다.
- 로직 변경 시 발생할 수 있는 회귀와 사이드 이펙트를 조기에 발견한다.

## 2. 기본 원칙

- 비즈니스 로직은 먼저 요구사항과 규칙을 문장으로 명확히 정의한 뒤 구현한다.
- happy path만 보지 말고 예외, 실패, 경계값, 권한, 중복 요청을 함께 검토한다.
- UI 설명으로 비즈니스 로직을 대체하지 않는다.
- 로직 변경 전에는 영향 범위와 데이터 흐름을 먼저 확인한다.
- 구현이 끝나면 테스트, 빌드, 감사, Git 작업까지 하나의 흐름으로 확인한다.

## 3. 표준 진행 프로세스

### Step 1. 요구사항 정리

- 무엇이 바뀌는지 한 문장으로 정의한다.
- 변경 이유와 비즈니스 목적을 적는다.
- 입력, 출력, 제약, 예외 조건을 정리한다.
- 이번 변경 범위와 제외 범위를 구분한다.

### Step 2. 시나리오 정의

- 정상 시나리오(happy path)
- 실패 시나리오(failure path)
- 경계값 시나리오(boundary cases)
- 권한 또는 상태별 시나리오
- 중복 요청, race condition 가능성

### Step 3. 계획 수립

- 어떤 모듈, 함수, API, DB가 영향을 받는지 적는다.
- 어떤 테스트를 추가하거나 수정해야 하는지 적는다.
- 빌드, 배포, 마이그레이션 필요 여부를 확인한다.
- rollback 또는 fallback 방법이 필요한지 검토한다.

### Step 4. 구현

- 요구사항과 직접 연결된 로직부터 수정한다.
- 관련 없는 리팩터링은 분리한다.
- 로그, 에러 처리, validation이 빠지지 않았는지 본다.
- 문자열, 날짜, 금액, 상태값 같은 도메인 데이터를 일관되게 처리한다.

### Step 5. 다각도 검토

- 시나리오별 동작이 요구사항과 맞는지 확인한다.
- 누락된 예외 처리나 잘못된 분기가 없는지 본다.
- 기존 기능에 회귀가 없는지 확인한다.
- 데이터 정합성, 중복 저장, 상태 불일치를 점검한다.

### Step 6. 소스 검토 및 감사

- 변경 이유가 코드에서 이해 가능한지 본다.
- 불필요한 변경이 섞였는지 확인한다.
- 비밀값, 임시 코드, 디버그 코드가 남지 않았는지 점검한다.
- 도메인 규칙이 하드코딩된 값으로 흩어져 있지 않은지 확인한다.

### Step 7. 실행 검증

- 테스트 실행
- 정적 분석 또는 lint 실행
- 빌드 실행
- 필요 시 Docker 이미지 재빌드

### Step 8. Git 및 배포 준비

- 최신 브랜치 상태 확인
- 필요 시 `git pull`
- 변경 요약 정리
- commit 메시지 작성
- push 전 민감 정보 및 불필요 파일 재확인

## 4. 단계별 체크리스트

### 요구사항 체크

- 변경 목적이 문장으로 정의되었는가
- 입력과 출력이 명확한가
- 예외 조건이 적혀 있는가
- 제외 범위가 분리되었는가

### 시나리오 체크

- 정상 흐름이 정의되었는가
- 실패 흐름이 정의되었는가
- 경계값이 정의되었는가
- 권한 또는 상태별 차이가 정리되었는가

### 구현 체크

- 기존 로직과의 충돌을 확인했는가
- validation과 에러 처리가 있는가
- 하드코딩된 비즈니스 규칙이 늘어나지 않았는가
- 테스트 대상이 분명한가

### 검증 체크

- 단위 테스트 또는 통합 테스트가 있는가
- `npm build` 또는 해당 빌드 명령이 통과하는가
- Docker 사용 프로젝트라면 재빌드가 필요한가
- 로그와 에러 메시지가 운영 가능한 수준인가

### Git 체크

- 현재 브랜치와 대상 브랜치를 알고 있는가
- `git pull` 필요 여부를 확인했는가
- commit 메시지가 변경 목적을 설명하는가
- push 전에 민감 정보가 없는지 확인했는가

## 5. 명령 실행 가이드

agent 실행 경계(로컬 Docker Desktop·migration·commit·push·CI까지, 배포 Action·원격 migration은 사용자 수동)와 Docker 재빌드 2모드(증분/강력 no-cache) 판단 기준은 `docs/local-dev-ci-guide.md`를 정본으로 따른다. 본 §5는 비즈니스 로직 변경의 단계별 흐름을 다룬다.

실제 명령은 프로젝트별 `AGENTS.md` 또는 guide 문서에 맞게 적되, 아래 항목은 항상 확인한다.

- 개발 서버 실행 명령
- 테스트 실행 명령
- 빌드 명령
- lint 명령
- Docker rebuild 명령
- DB migration 명령

기본 명령 레퍼런스(프로젝트 스택에 맞게 치환):

- `npm test` / `pnpm test` / `vitest run`
- `npm run build` / `pnpm build`
- `npm run lint` / `pnpm lint` / `biome check .`
- `docker compose build` / `docker compose up -d --build`
- `git pull --rebase` / `git status` / `git add <path>` / `git commit -m "..."` / `git push`
- `pnpm db:migrate` / `prisma migrate deploy` / `supabase db push`

### 5.1. 단계별 실행 흐름 (Step 7 상세)

비즈니스 로직 변경이 끝난 뒤 다음 6단계를 순서대로 실행한다. 각 단계는 직전 단계가 통과해야 진행한다 — 실패 시 5.4를 따른다.

```
1) git status로 작업 트리 확인           → 의도 외 파일이 staged면 unstage
2) lint                                  → 정적 분석 실패 시 즉시 수정
3) unit test (변경 모듈 + 인접)           → red면 코드 수정, green이면 다음
4) build                                 → 타입 오류·번들 실패 차단
5) e2e (선택, happy path 1~2개)          → 가능한 경우만, 환경 미구성이면 사유 기록
6) docker rebuild 판단 (5.2)             → 증분/강력 판단 후 rebuild + smoke
7) DB migration (해당 시)                → `local`(Docker Desktop)에만 적용·검증 (`develop`/`production`은 수동, §0)
8) git commit (로컬 누적)                → 1~7 반복하며 commit만 쌓는다 (push 아님)
9) 사용자 요청 시 push + PR 1개          → 누적 commit 일괄 (`docs/local-dev-ci-guide.md §1.1`). 그 전엔 로컬 검증만으로 완료 보고
   CI 결과 확인 (push로 트리거됨)         → 실패 시 원인 수정 후 재push
──────────────── agent 종료 / 사용자 수동 인계 ────────────────
10) [수동] GitHub Actions 배포·릴리스 실행
11) [수동] 원격(`develop`/`production`) migration 적용
```

각 단계의 통과 기준:

- lint: exit 0. warning은 허용하되 PR 본문에 개수와 사유를 기록.
- unit test: 변경 모듈 + 인접 모듈 모두 green. 신규 시나리오 테스트는 본 변경 PR 안에 포함.
- build: production 모드(`NODE_ENV=production` 또는 build script)로 실행. dev 모드 통과만으로는 미흡.
- e2e: 환경 변수·DB 시드가 갖춰진 경우만 실행. 미갖춰진 경우 그 사실과 "다음 단계에서 자동 실행될 위치"를 PR 본문에 명시.

### 5.2. Docker rebuild 판단 기준

0순위: dev 컨테이너가 bind mount + hot reload 구조(`docs/local-dev-ci-guide.md §2.1`)면 코드 수정은 rebuild 자체가 불필요하다 — 즉시 반영된다. 아래 표·증분/강력 판단은 그 구조가 아니거나 의존성·이미지가 바뀐 경우에 적용한다.

Docker를 쓰는 프로젝트에서 (hot reload로 해결되지 않는) 변경의 rebuild 필요 여부는 변경 파일 종류로 판단한다. 모드(빠른 증분 vs 캐시 없는 강력 재빌드) 선택의 정본 결정 트리는 `docs/local-dev-ci-guide.md §2.4`를 따른다 — 의존성/이미지 정의 변경·캐시 꼬임은 강력(`--no-cache`), 그 외 rebuild는 증분.

| 변경 위치 | rebuild 필요? | 명령 |
|---|---|---|
| `src/**` 애플리케이션 소스만 | **불필요**. dev 컨테이너는 volume mount면 즉시 반영. 운영 이미지는 다음 배포에서 자연스럽게 빌드 | — |
| `package.json` / `pnpm-lock.yaml` / `requirements.txt` 의존성 | **필요**. 이미지 레이어가 의존성 설치 단계에서 시작 | `docker compose build --no-cache <service>` |
| `Dockerfile` / `docker-compose.yml` / `.dockerignore` | **필요**. 이미지 정의 자체 변경 | `docker compose build <service>` |
| 환경 변수(`.env`, `compose` env) | rebuild 불필요. 컨테이너만 재시작 | `docker compose up -d <service>` |
| migration SQL · seed 데이터 | rebuild 불필요. **`local`(Docker Desktop)에만 적용**(agent), `develop`/`production`은 사용자 수동 (§0) | `docker compose exec <service> <migration cmd>` (`local` 한정) |
| nginx/reverse-proxy 설정 | proxy 컨테이너만 rebuild + restart | `docker compose build proxy && docker compose up -d proxy` |

판단 후 PR 본문 `## 검증 계획`에 "Docker rebuild: 불필요 (src/만 변경)" 또는 "필요 (pnpm-lock.yaml 갱신 → `docker compose build --no-cache api`)" 같이 사유를 명시한다.

### 5.3. Git 작업 흐름 시나리오

표준 단일 PR 흐름:

```bash
# 1) 작업 시작 전 — 최신 base로 정렬
git status                          # 작업 트리 clean 확인
git checkout main                   # 또는 develop
git pull --rebase origin main

# 2) 작업 브랜치 생성 (Conventional Commits + scope)
git checkout -b feat/orders-cancel-window

# 3) 작업 진행 — 로컬 commit 누적 (push 아님, 사용자 요청까지 쌓기. §1.1)
git add src/server/orders/cancelService.ts
git add src/server/orders/__tests__/cancelService.test.ts
git commit -m "feat(orders): extend self-cancel window to 60m"

# 4) 5.1 단계별 검증 통과 후 push 전
git status                          # untracked가 있다면 의도 확인
git diff --staged --check           # whitespace/trailing 검출
grep -nE "console\.(log|debug)|TODO\(self\)" -r src/  # 디버그 잔재
git log --oneline main..HEAD        # 본 브랜치 commit 개수와 순서 확인

# 5) 사용자 요청 시 (§1.1) — 누적 commit 일괄 push + PR 1개
#    (매 commit/slice가 아니라 사용자가 push/CI를 지시할 때. 세션 종료 백업은 [skip ci])
git push -u origin feat/orders-cancel-window
# gh pr create --title ... --body ... (또는 웹 UI)
```

push 전 강제 점검 항목:

- [ ] `git status`에 의도 외 파일이 없다
- [ ] commit 메시지가 Conventional Commits 규칙(`feat|fix|refactor|chore(scope): ...`)을 따른다
- [ ] commit이 논리 단위로 분리됐다 (테스트·구현·문서가 한 commit에 섞이지 않음, 단 작은 변경은 한 commit OK)
- [ ] `.env`, `*.pem`, `*.key`, `credentials.json` 같은 비밀 파일이 staged되지 않았다 (block-secret-files hook이 1차 방어, 수동 재확인)
- [ ] generated 파일(`dist/`, `.next/`, `coverage/`)이 staged되지 않았다
- [ ] PR 본문에 "검증 통과 증거"(테스트 결과 / 빌드 결과 / docker rebuild 여부)가 포함됐다

base 갱신 중 충돌:

```bash
git fetch origin
git rebase origin/main              # main이 앞서갔다면
# 충돌 발생 시: 파일 수정 → git add → git rebase --continue
# 포기 시: git rebase --abort
```

`git push --force`는 본인 작업 브랜치에서 `--force-with-lease`로만 허용. `main`/`master`/`develop`에는 절대 금지(`block-destructive.sh` hook이 차단).

push/PR과 CI 결과 확인까지가 agent 범위다. 이후 GitHub Actions 배포·릴리스 실행과 원격 migration 적용은 사용자가 수동으로 진행하며, agent는 `docs/local-dev-ci-guide.md §4` 인계 요약을 남기고 종료한다.

### 5.4. 실패 케이스 대응

각 단계에서 실패가 발생하면 단계 자체에서 멈추고 근본 원인을 해결한 뒤 처음부터 다시 실행한다.

- **lint 실패**: 자동 수정 가능하면 `--fix` 또는 `biome format`. 규칙 자체에 이견이면 PR 분리해 별도 논의.
- **unit test 실패**: 실패 메시지가 비즈니스 규칙과 어긋나는지 확인. 테스트가 잘못된 가정인지 코드가 잘못됐는지 먼저 판단. 단순히 테스트를 삭제·skip하지 않는다.
- **build 실패 (타입 오류)**: 임시로 `any`/`as unknown as`로 우회하지 않는다. 타입 정의를 수정하거나 호출부를 정렬.
- **build 실패 (번들·imports)**: barrel index 순서, dynamic import 경로 확인.
- **docker rebuild 실패**: 캐시 문제면 `--no-cache`. 의존성 설치 실패면 lock 파일과 base 이미지 버전 정합 확인.
- **push 거부 (non-fast-forward)**: `git pull --rebase` 후 충돌 해결. 강제 push는 본인 브랜치 + `--force-with-lease`만 사용.
- **CI 실패**: 로컬에서 동일 명령 재현. 환경 차이(NODE_ENV, OS, 시간대)부터 점검.

실패 후 우회·skip을 코드로 남기지 않는다. 원인 해결 후 PR 본문 또는 commit 메시지에 "원인 + 해결" 한 줄 기록.

## 6. 리뷰 포인트

- 요구사항 대비 구현 누락이 있는가
- 비즈니스 규칙이 잘못 해석된 부분이 있는가
- 예외 상황 처리가 부족한가
- 테스트가 happy path만 검증하는가
- 운영 시 장애 포인트가 될 코드가 남아 있는가

## 7. 권장 산출물

- 요구사항 정리 문서
- 시나리오 목록
- 구현 계획
- 변경된 코드
- 테스트 결과
- 빌드 결과
- 최종 변경 요약
