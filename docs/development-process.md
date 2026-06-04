# 개발 프로세스 가이드

AGENTS 템플릿을 활용한 개발 진행 절차와 각 단계별 수행 항목을 정리한 문서다.

---

## 전체 흐름

```
[1] 저장소 준비
      ↓
[2] Startup QnA (에이전트 × 사용자)
      ↓
[3] 프로젝트 가이드 문서 생성
      ↓
[4] 작업 요청 → 구현 → 검증
      ↓
[5] STATE.md 업데이트 → 다음 작업 인계
```

---

## Phase 1 — 저장소 준비

**언제:** 새 프로젝트를 시작할 때

### 수행 항목

1. 이 템플릿 저장소를 새 프로젝트 디렉터리로 복제한다.
2. `README.md`를 프로젝트 소개·실행 방법 중심으로 재작성한다.
3. `AGENTS.md`의 `Operational Commands` 섹션에 실제 실행 명령을 채운다.
   - 예: `npm run dev`, `pnpm test`, `docker compose up`
4. `agents/*.md` 중 이 프로젝트에 필요 없는 역할 파일은 제거하거나 비워둔다.
5. `STATE.md`를 초기 상태로 리셋한다.

### 참조 문서

- [AGENTS.md](../AGENTS.md) — 공통 원칙 확인
- [README.md](../README.md) — 템플릿 사용법

---

## Phase 2 — Startup QnA

**언제:** 저장소 준비 직후, 첫 구현 전

에이전트가 `templates/startup-checklist.md`를 기준으로 사용자에게 순서대로 질문하고 답변을 수집한다.

### 11개 섹션 진행 순서

| 섹션 | 주제 | 핵심 수집 항목 |
|---|---|---|
| 1 | 프로젝트 기본 정보 | 목적, 필수 기능, 제외 기능, 일정, 제약 |
| 2 | 기술 스택 | 프레임워크, DB, 패키지 매니저, 테스트, 배포 환경 |
| 3 | UI 및 디자인 기준 | 스타일 방향, 주요 사용자 흐름, 화면 상태, 접근성 |
| 4 | 모달 방식 | 구현 방식, 애니메이션, 닫기 방법, 스크롤 처리 |
| 5 | 반응형 및 레이아웃 | PC/모바일 우선순위, 브레이크포인트, 모바일 모달 처리 |
| 6 | 다국어(i18n) | 지원 언어, 기본 locale, 번역 범위 |
| 7 | 상태 관리 | 전역 상태, 서버 상태, 인증/권한 |
| 8 | 포맷 및 현지화 | UTC 기준, 화폐, 숫자 표기 |
| 9 | API 및 예외 처리 | 통신 방식, Mocking, Error Boundary |
| 10 | 라우팅 및 폼 검증 | URL 상태 동기화, Protected Route, 폼 검증 전략 |
| 11 | 협업 및 배포 환경 | 테스트 강제 여부, 커밋 컨벤션, CI/CD |

### 섹션 처리 규칙

- 섹션 하나가 끝날 때마다 **확정 / 미정 / 제외** 로 분류해서 요약한다.
- 전체 완료 후 결과 요약과 다음 액션을 제안한다.

### 참조 문서

- [templates/startup-checklist.md](../templates/startup-checklist.md) — 전체 QnA 질문지

---

## Phase 3 — 프로젝트 가이드 문서 생성

**언제:** Startup QnA 완료 직후

QnA 답변을 바탕으로 이 프로젝트에만 적용되는 기준 문서를 생성한다.

### 수행 항목

1. `docs/project-guide-template.md`를 복사해 프로젝트 전용 가이드를 작성한다.
2. 기술 스택이 확정되면 `AGENTS.md`의 `Operational Commands`를 갱신한다.
3. 다국어 지원이 확정되면 `docs/i18n-guidelines.md`를 작성한다.
4. 프레임워크/디렉터리 구조 설계가 필요하면 `docs/framework-structure-guide.md`를 작성한다.
5. 비즈니스 로직이 복잡하면 `docs/business-logic-playbook.md`를 작성한다.
6. UI/디자인 의사결정 기록은 `docs/ui-decisions.md` 템플릿을 사용한다. startup-checklist 섹션 3~5(UI/디자인, 모달, 반응형) 답변과 `templates/ui-intake.md` · `templates/responsive-intake.md` · `templates/form-intake.md` · `templates/data-table-density.md`에서 합의한 결정을 한 곳에 통합한다. 프로젝트별로 필요 섹션만 채우고 미정 항목은 `[미정]` 태그로 둔다.

### 생성 기준

- 확정 사항만 문서에 반영하고, 미정 사항은 `[미정]` 태그로 표시한다.
- 초안은 짧고 명확하게 유지하고, 실제 개발 중에 갱신한다.

### 참조 문서

- [docs/project-guide-template.md](./project-guide-template.md)
- [docs/i18n-guidelines.md](./i18n-guidelines.md)
- [docs/framework-structure-guide.md](./framework-structure-guide.md)
- [docs/business-logic-playbook.md](./business-logic-playbook.md)

---

## Phase 4 — 작업 요청 → 구현 → 검증

**언제:** 프로젝트 가이드 완료 후, 반복 수행

모든 개발 작업은 이 사이클을 반복한다.

---

### Step 4-1 — 작업 요청 (사용자)

목적에 맞는 요청 템플릿을 선택해 작업을 구조화한다.

| 작업 유형 | 사용 템플릿 |
|---|---|
| 신규 기능 개발 | [templates/feature-request.md](../templates/feature-request.md) |
| 버그 수정 | [templates/bugfix-request.md](../templates/bugfix-request.md) |
| 코드 리팩터링 | [templates/refactor-request.md](../templates/refactor-request.md) |
| 비즈니스 로직 변경 | [templates/business-logic-request.md](../templates/business-logic-request.md) |
| 코드 리뷰 요청 | [templates/review-request.md](../templates/review-request.md) |

---

### Step 4-2 — Main Agent: 요청 해석 및 범위 설정

**역할:** [agents/main-agent.md](../agents/main-agent.md)

수행 항목:

1. 요청에서 `목표 / 산출물 / 제약 / 우선순위`를 분리한다.
2. 어떤 파일을 읽고 어떤 파일을 수정할지 먼저 밝힌다.
3. 파괴적 변경이나 범위가 큰 리팩터링은 수행 전 사용자에게 재확인한다.
4. `docs/development-strategy.md` 기준으로 개발 전략을 선택한다.
   - 일반 신규 기능, admin/dashboard, CRUD, 모바일 화면: `UI Mock First`를 기본값으로 한다.
   - 결제, 정산, 포인트, 재고, 권한, 감사 로그, 토큰/지갑, migration 위험 작업: `Logic/DB First` 예외 경로를 사용한다.
5. 작은 단위로 작업을 분리해서 실행 순서를 정한다.

---

### Step 4-3 — Researcher Agent: 기존 구조 조사

**역할:** [agents/researcher-agent.md](../agents/researcher-agent.md)

수행 항목:

1. 관련 파일, 기존 구현, 중복 코드 존재 여부를 검색한다.
2. `rg`, `rg --files` 같은 도구로 패턴 탐색을 먼저 수행한다.
3. 조사 결과를 근거로 구현 전에 영향 범위를 정리한다.
4. 외부 의존성이나 새로운 라이브러리 필요 여부를 확인한다.

---

### Step 4-4 — Executor Agent: 구현

**역할:** [agents/executor-agent.md](../agents/executor-agent.md)

수행 항목:

1. 기존 패턴, 네이밍 컨벤션, 디렉터리 구조를 먼저 파악하고 따른다.
2. 한 번에 큰 리라이트보다 작은 단위로 변경한다.
3. 기능 추가, 버그 수정, 리팩터링은 목적을 섞지 않고 분리해서 처리한다.
4. 테스트를 추가할 수 있으면 기능 코드와 함께 추가한다.
5. 테스트를 추가하지 못했다면 이유와 남은 위험을 기록한다.
6. UI 문자열을 하드코딩하지 않는다 (다국어 프로젝트 기준).

---

### Step 4-5 — Reviewer Agent: 검증

**역할:** [agents/reviewer-agent.md](../agents/reviewer-agent.md)

수행 항목:

1. 구현이 요청 범위를 벗어나지 않았는지 확인한다.
2. 기존 기능의 회귀(regression)가 없는지 점검한다.
3. 테스트 누락 여부와 예외 처리 누락 여부를 확인한다.
4. 리스크가 남아 있다면 명확하게 기록한다.
5. 동작 검증 없이 완료로 단정하지 않는다.

---

## Phase 5 — STATE.md 업데이트 및 인계

**언제:** 하나의 논리적 작업이 끝날 때마다, 세션 종료 전 (여기서 커밋은 **로컬 커밋** 누적이며, `git push`·`PR`·CI는 별도 — **사용자 요청 시에만**, 세션 종료 백업 push는 `[skip ci]`: `docs/local-dev-ci-guide.md §1.1`)

### 수행 항목

1. `STATE.md`의 `이번 세션에서 완료한 작업` 섹션에 변경 내용을 추가한다.
2. `다음 작업` 섹션을 실행 가능한 문장으로 갱신한다.
3. 미해결 리스크나 알려진 TODO를 `알려진 TODO` 섹션에 기록한다.
4. 현재 기준 파일 목록이 바뀌었으면 함께 갱신한다.

### 참조 문서

- [STATE.md](../STATE.md)

---

## 역할별 책임 요약

```
사용자          → 요청 템플릿 작성, QnA 답변, 확인 응답
main-agent      → 요청 해석, 범위 통제, 우선순위 결정
researcher-agent → 기존 구조 조사, 중복 확인, 근거 수집
executor-agent  → 실제 구현 (코드/문서)
reviewer-agent  → 리스크 점검, 회귀 확인, 테스트 누락 검토
```

---

## 사용자 확인이 필요한 상황

다음 상황은 에이전트가 자체 판단으로 진행하지 않고 반드시 사용자에게 먼저 확인한다.

- 파일 삭제, 디렉터리 대이동, 대규모 의존성 추가
- 기존 구현을 뒤집는 리팩터링
- 요구사항 해석에 따라 결과가 크게 달라지는 경우
- 테스트 실패 원인이 코드인지 환경인지 불분명한 경우

---

## Context Map (빠른 참조)

- **공통 원칙** → [AGENTS.md](../AGENTS.md)
- **현재 상태 / 인계** → [STATE.md](../STATE.md)
- **새 프로젝트 QnA** → [templates/startup-checklist.md](../templates/startup-checklist.md)
- **프로젝트 가이드** → [docs/project-guide-template.md](./project-guide-template.md)
- **기능 요청** → [templates/feature-request.md](../templates/feature-request.md)
- **버그 수정** → [templates/bugfix-request.md](../templates/bugfix-request.md)
- **리팩터링** → [templates/refactor-request.md](../templates/refactor-request.md)
- **비즈니스 로직** → [templates/business-logic-request.md](../templates/business-logic-request.md)
- **코드 리뷰** → [templates/review-request.md](../templates/review-request.md)
- **다국어 가이드** → [docs/i18n-guidelines.md](./i18n-guidelines.md)
- **구조 설계 가이드** → [docs/framework-structure-guide.md](./framework-structure-guide.md)
- **비즈니스 로직 플레이북** → [docs/business-logic-playbook.md](./business-logic-playbook.md)
- **개발 전략 가이드** → [docs/development-strategy.md](./development-strategy.md)
