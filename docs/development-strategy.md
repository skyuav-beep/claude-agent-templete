# 개발 전략 가이드

본 문서는 기능 개발을 시작할 때 `UI Mock First`와 `Logic/DB First` 중 어떤 방식으로 진행할지 판단하는 기준과 실행 순서를 정의한다.

## 기본 원칙

- 대부분의 신규 기능은 `UI Mock First`를 기본값으로 한다.
- 데이터 정합성, 금전, 권한, 재고, 토큰/지갑, 기존 migration 위험이 큰 기능은 `Logic/DB First` 예외 경로로 진행한다.
- 두 방식 모두 마지막에는 실제 API/DB 연결, 테스트, `STATE.md` 기록으로 마무리한다.
- UI와 DB/로직을 동시에 깊게 구현하지 않는다. 먼저 불확실성이 큰 영역을 얇게 검증한 뒤 나머지를 연결한다.

## 선택 기준

| 질문 | UI Mock First | Logic/DB First |
|---|---|---|
| 가장 큰 불확실성 | 화면 흐름, 사용성, 필드 구성 | 데이터 정합성, 상태 전이, 권한, 계산 규칙 |
| 초기 산출물 | 동작 가능한 mock 화면 | schema/API 계약, service 테스트 |
| 속도 특성 | 초반 속도가 빠르고 요구사항 발견에 유리 | 초반은 느리지만 핵심 리스크를 먼저 줄임 |
| 대표 작업 | admin 화면, dashboard, CRUD, 모바일 화면, 폼 | 결제, 정산, 포인트, 재고, 권한, 감사 로그, migration |
| 주요 위험 | mock 화면이 실제 데이터 제약을 과소평가 | UI 요구와 맞지 않는 과도한 구조를 먼저 만들 수 있음 |

## 기본 경로: UI Mock First

사용자가 실제로 보는 화면과 흐름이 가장 큰 불확실성일 때 사용한다. 일반 신규 프로젝트, admin/dashboard, CRUD 화면, 모바일 앱 화면은 이 경로를 우선 적용한다.

### 진행 순서

1. 화면 목적과 핵심 사용자 흐름을 정의한다.
2. `DESIGN.md`와 `docs/ui-decisions.md` 기준으로 주요 화면을 mock data로 만든다.
3. loading, empty, error, disabled, success 상태를 화면에 포함한다.
4. 화면 검수 후 실제로 필요한 필드, 상태값, 액션을 추출한다.
5. data contract를 작성한다.
6. DB schema, API, service/usecase를 최소 범위로 구현한다.
7. UI를 실제 API/DB에 연결한다.
8. 테스트, 빌드, 로컬 검증을 수행한다.
9. `STATE.md`에 완료 작업, 다음 작업, 알려진 TODO를 기록한다.

### 완료 기준

- 사용자가 주요 흐름을 화면 기준으로 검수할 수 있다.
- mock data가 실제 API 계약으로 옮겨갈 필드와 상태값을 드러낸다.
- UI 검수 전에는 불필요한 DB migration을 만들지 않는다.
- 실제 연결 단계로 넘어가기 전에 data contract가 작성되어 있다.

## 예외 경로: Logic/DB First

UI보다 데이터 정합성, 상태 전이, 권한, 계산 규칙이 더 위험한 기능에 사용한다.

### 진행 순서

1. 비즈니스 규칙과 실패/경계 시나리오를 정리한다.
2. 상태 모델과 데이터 불변 조건을 정의한다.
3. DB schema 또는 API 계약을 먼저 작성한다.
4. service/usecase 단위 테스트를 만든다.
5. 로컬 DB/migration을 검증한다.
6. 최소 UI를 연결한다.
7. 실제 화면 상태와 예외 메시지를 보강한다.
8. 통합 테스트와 빌드를 확인한다.
9. `STATE.md`에 완료 작업, 다음 작업, 알려진 TODO를 기록한다.

### 완료 기준

- 핵심 계산/상태 전이/권한 규칙이 테스트로 검증되어 있다.
- migration 영향 범위가 명확하다.
- 원격 migration 또는 배포 Action은 사용자 수동 인계 항목으로 남긴다.
- UI는 검증된 상태 모델을 기준으로 연결한다.

## 전환 조건

`UI Mock First`로 시작했더라도 다음 조건이 드러나면 `Logic/DB First` 검토로 전환한다.

- 화면에서 금전, 잔액, 재고, 권한, 감사 로그가 핵심 흐름으로 드러난다.
- 상태값이 5개 이상이고 상태 전이 규칙이 복잡하다.
- 기존 데이터 migration 또는 외부 시스템 호환이 필요하다.
- UI 검수보다 데이터 오류의 비용이 더 크다.

`Logic/DB First`로 시작했더라도 다음 조건이면 UI mock을 먼저 병행한다.

- 사용자가 어떤 화면에서 규칙을 실행할지 불명확하다.
- 필요한 필드가 화면마다 다르게 해석된다.
- 관리자 검수 또는 운영자 UX가 성공 기준에 포함된다.

## 권장 작업 분리

### UI Mock First 작업 단위

- 1차 commit: mock 화면, 상태, 디자인 토큰 적용
- 2차 commit: data contract, API 타입, schema 초안
- 3차 commit: 실제 API/DB 연결, 테스트

### Logic/DB First 작업 단위

- 1차 commit: 규칙 문서, schema/API 계약, migration
- 2차 commit: service/usecase와 테스트
- 3차 commit: UI 연결, 예외 상태, 통합 검증

> 위 1·2·3차 commit은 **로컬 commit 단위**다. push와 PR은 각 차수마다 쪼개지 말고, **사용자가 요청할 때** 누적 commit을 한 번에 올린다. 로컬 CI·push는 사용자 요청 기반이다(CI는 GitHub Actions가 아니라 로컬에서 실행하고, push는 CI를 트리거하지 않는다 — §6.2) (`docs/local-dev-ci-guide.md §1.1`).

## 관련 문서

- `docs/development-process.md`
- `docs/ui-decisions.md`
- `docs/business-logic-playbook.md`
- `templates/feature-request.md`
- `templates/business-logic-request.md`
- `DESIGN.md`
