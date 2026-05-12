# Codex Reading Order

이 문서는 이 저장소에서 Codex가 작업할 때 어떤 규칙과 파일을 어떤 우선순위로 참조하는지 정리한 아티팩트다.

## 1. 상위 규칙 계층

Codex는 항상 다음 순서의 상위 규칙 영향을 받는다.

1. 시스템 수준 규칙
2. 개발자 수준 규칙
3. 저장소 로컬 가이드
4. 현재 프로젝트 문맥
5. 사용자의 최신 요청
6. 실제 코드와 구현 관례

## 2. 시스템/개발자 규칙의 실제 적용 방식

원문 자체를 노출할 수는 없지만, 현재 저장소 작업에서 실제로 적용되는 방식은 다음과 같다.

- 설명과 요약은 한국어로 작성한다.
- 코드, 명령어, 경로, 식별자는 원문 그대로 유지한다.
- 작업 전에 저장소 구조와 문서를 먼저 확인한다.
- 검색은 `rg`, `rg --files` 같은 빠른 도구를 우선 사용한다.
- 수동 파일 수정은 `apply_patch` 방식으로 반영한다.
- 사용자 변경사항이나 관련 없는 파일은 임의로 되돌리지 않는다.
- 작업 중에는 짧은 진행 공유를 하고, 종료 시에는 간결하게 결과를 정리한다.
- 리뷰 요청이면 요약보다 문제와 리스크를 먼저 보고한다.
- 현재 환경은 로컬 파일 읽기/수정 중심이며, 외부 네트워크 사용은 제한적이다.

## 3. 저장소에서 기본적으로 먼저 읽는 파일

Codex는 보통 다음 순서로 저장소 문서를 읽는다.

1. `AGENTS.md`
2. `STATE.md`
3. `README.md`
4. 작업 종류에 맞는 `agents/*.md`
5. 요청 유형에 맞는 `templates/*.md`
6. 기획/설계 단계라면 `docs/*.md`
7. 마지막으로 실제 코드와 폴더 구조

## 4. 작업 유형별 우선 참조 파일

### 일반 작업 시작

1. `AGENTS.md`
2. `STATE.md`
3. `README.md`

### 기능 구현

1. `AGENTS.md`
2. `STATE.md`
3. `agents/executor-agent.md`
4. `templates/feature-request.md`
5. 관련 코드 또는 문서

### 버그 수정

1. `AGENTS.md`
2. `STATE.md`
3. `agents/executor-agent.md`
4. `templates/bugfix-request.md`
5. 재현 경로와 관련 구현

### 코드 리뷰

1. `AGENTS.md`
2. `agents/reviewer-agent.md`
3. `templates/review-request.md`
4. 변경 파일

### 리팩터링

1. `AGENTS.md`
2. `STATE.md`
3. `agents/executor-agent.md`
4. `templates/refactor-request.md`
5. 영향 범위 코드

### 프로젝트 초기 설계

1. `AGENTS.md`
2. `README.md`
3. `templates/project-intake.md`
4. `templates/ui-intake.md`
5. `templates/responsive-intake.md`
6. `templates/tech-intake.md`
7. `docs/project-guide-template.md`

### 다국어(i18n) 설계 또는 구현

1. `AGENTS.md`
2. `templates/i18n-intake.md`
3. `docs/i18n-guidelines.md`
4. `agents/executor-agent.md`
5. `agents/reviewer-agent.md`
6. 관련 코드 또는 화면

## 5. 역할별 참조 포인트

### Main Agent

- 요청 해석
- 범위 통제
- 어떤 문서를 읽고 어떤 문서를 갱신할지 결정

### Executor Agent

- 구현 대상 파일 확인
- 검증 가능 여부 판단
- 관련 없는 변경 방지

### Reviewer Agent

- 버그, 회귀, 테스트 누락 우선 점검
- 문서와 상태 인계 누락 여부 확인

### Researcher Agent

- 기존 문서, 구조, 중복 여부 조사
- 구현 전에 필요한 근거 수집

## 6. 운영 메모

- 루트 `AGENTS.md`는 공통 규칙과 라우팅만 유지한다.
- 세부 구현 규칙은 `agents/`와 `docs/`로 위임한다.
- intake 문서는 정보 수집용이고, 실제 개발 기준은 `docs/` 아래 guide 문서다.
- 사용자의 최신 요청은 항상 중요하지만, 상위 규칙과 충돌하면 상위 규칙을 우선한다.
