# Business Logic Request Template

## 변경 목표

- 어떤 비즈니스 로직을 왜 바꾸려는지 적는다.

## 현재 문제

- 현재 어떤 문제가 있는지 적는다.
- 비즈니스적으로 어떤 영향이 있는지 적는다.

## 요구사항

- 입력 조건
- 기대 결과
- 제약 사항
- 제외 범위

## 시나리오

- 정상 시나리오
- 실패 시나리오
- 경계값 시나리오
- 권한 또는 상태별 시나리오

## 영향 범위

- 관련 API
- 관련 화면
- 관련 서비스 또는 모듈
- 관련 데이터 구조

## 검증 계획

- 필요한 테스트
- 필요한 빌드 확인
- Docker 재빌드 모드 + 사유 (증분 / 강력 no-cache — `docs/local-dev-ci-guide.md §2`)
- DB migration: 로컬 Docker Desktop 적용 여부 (원격 적용은 사용자 수동)
- 배포 전 확인 항목

## Git 작업 계획

- `git pull` 필요 여부
- commit 메시지 방향
- push 전 확인할 점
- agent 종료 지점 = 로컬 CI(요청 시)·push까지. 이후 수동 인계 항목(머지·브랜치 정리 / 배포 Action / 원격 migration) 명시

## 작성 예시

```
## 변경 목표
- 주문 취소 가능 시간을 결제 후 30분에서 1시간으로 연장한다.

## 현재 문제
- CS팀에 "결제 직후 실수 취소" 문의가 다수 누적.
- 30분 제한이 모바일 결제 후 알림 확인 시점과 어긋난다.

## 요구사항
- 입력 조건: 주문 상태가 `paid`이고 결제 시각으로부터 60분 이내
- 기대 결과: 사용자가 직접 취소 가능, 환불은 자동 처리
- 제약: 배송이 시작된 주문은 시간과 무관하게 취소 불가
- 제외: 정기 결제 주문은 본 변경 대상 아님

## 시나리오
- 정상: 결제 후 45분 → 취소 성공, 환불 처리 큐 진입
- 실패: 결제 후 70분 → "취소 가능 시간이 지났습니다" 메시지
- 경계값: 결제 후 정확히 60분 0초 → 취소 가능
- 권한: 관리자 콘솔에서는 시간 제한 무시 가능

## 영향 범위
- API: `POST /api/orders/:id/cancel`
- 화면: 주문 상세, 주문 목록 취소 버튼 노출 조건
- 서비스: `OrderCancelService.canCancel()`
- 데이터: 변경 없음 (시간 비교 상수만 수정)

## 검증 계획
- 단위 테스트: `OrderCancelService.canCancel()` 30/59/60/61분 4개 경계값 + 관리자 우회 1개
- 통합 테스트: `POST /api/orders/:id/cancel`를 paid 주문 / 배송 시작 주문 / 시간 초과 주문 3종으로 호출
- 수동: 주문 상세 페이지에서 시간대별 버튼 노출/disabled 상태 확인
- 빌드 확인 흐름 (playbook §5.1 순서):
  1. `pnpm lint` (Biome) — exit 0
  2. `pnpm test src/server/orders` — 변경 모듈 단위 테스트 green
  3. `pnpm test` — 전체 회귀 green
  4. `pnpm build` (production 모드) — 타입 + 번들 오류 없음
  5. e2e: `pnpm test:e2e orders/cancel.spec.ts` (로컬 CI 스위트에 포함, §6.2. 환경 미구성 시 PR 본문에 사유 기록)
- Docker rebuild 판단 (playbook §5.2):
  - 변경 파일이 `src/server/orders/` 코드만이므로 **불필요**.
  - dev 환경은 volume mount로 즉시 반영. 운영 이미지는 다음 배포에서 자연 빌드.
  - 만약 `pnpm-lock.yaml`이 함께 갱신됐다면 `docker compose build --no-cache api` 필요.
- 배포 전: 관리자 권한 우회 경로 회귀 확인 + Sentry 에러율 베이스라인 캡처

## Git 작업 계획 (playbook §5.3)
- 작업 시작:
  - `git status`로 작업 트리 clean 확인
  - `git checkout main && git pull --rebase origin main`
  - `git checkout -b feat/orders-cancel-window`
- 작업 중: 구현·테스트를 한 commit으로 묶거나(변경이 작으면) 분리 commit (구현 + 테스트). commit 메시지는 Conventional Commits.
  - 예: `feat(orders): extend self-cancel window from 30m to 60m`
  - 예: `test(orders): add boundary cases for canCancel (30/59/60/61m)`
- push 전 점검:
  - `git diff --staged --check` (whitespace)
  - `grep -rnE "console\.(log|debug)" src/server/orders` (디버그 잔재 0건)
  - `.env`/`*.key`/`*.pem` staged 여부 재확인
  - 단위 + 통합 + e2e 통과 증거를 PR 본문 `## Test plan`에 붙임
- 로컬 CI (사용자 "CI 돌려" 시): `pnpm lint && pnpm typecheck && pnpm test && pnpm build` (또는 `act`) — 로컬 실행, GitHub Actions 아님(§6.2). green이 push 게이트.
- push (사용자 요청 시 1회): `git push -u origin feat/orders-cancel-window` → `gh pr create` — 매 commit이 아니라 사용자가 push를 지시할 때 누적 commit 일괄. push는 CI를 트리거하지 않는다 (`docs/local-dev-ci-guide.md §1.1`)
- PR 본문 필수 항목: 변경 요약 / 검증 통과 결과 / Docker rebuild 여부 + 사유 / rollback 방법(코드 상수만 되돌리면 즉시 복귀 가능)
- [사용자 수동] 머지(squash) 후 브랜치 정리: `git branch -d` + `git push origin --delete` + `git fetch --prune` (§6.5)
```
