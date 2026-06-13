# Request Routing Workflow

사용자가 작업 유형을 명확히 말하지 않았거나, 기능/버그/리팩터링/리뷰/비즈니스 로직이 섞인 요청을 했을 때 이 절차를 따른다.

## 우선순위 규칙

- 사용자 메시지에 명확한 유형 키워드가 있으면 해당 개별 workflow를 바로 따른다.
  - 기능 추가, 신규 화면/엔드포인트/명령: `.codex/workflows/feature.md`
  - 버그, 에러, 깨짐, 동작 안 함: `.codex/workflows/bugfix.md`
  - 구조 개선, 코드 정리, 동작 불변: `.codex/workflows/refactor.md`
  - 코드 리뷰, PR 검토, 변경 점검: `.codex/workflows/review.md`
  - 정책/권한/시나리오/경계값 변경: `.codex/workflows/business-logic.md`
- 유형이 모호하거나 복합적일 때만 이 workflow를 사용한다.
- UI/디자인 영향이 있으면 주 workflow와 함께 `.codex/workflows/design.md`를 적용한다.
- 개발 세션 재개 요청이면 `.codex/workflows/dev-start.md`를 우선한다. 단, "개발 시작"이 만들 기능을 설명하는 맥락이면 feature/bugfix/business-logic으로 분류한다.

## 절차

1. `agents/main-agent.md`의 요청 해석 기준을 읽는다.
2. 사용자 요청에서 목표, 산출물, 제약, 우선순위를 분리한다.
3. 아래 기준으로 주 workflow를 하나 선택한다.
4. 복합 요청이면 주 workflow를 먼저 정하고, 보조 workflow는 검증/후속 항목으로 연결한다.
5. 분류가 결과를 크게 바꿀 정도로 애매하면 한 줄로 확인한 뒤 진행한다.
6. 분류가 끝나면 해당 `.codex/workflows/*.md`를 읽고 그 절차로 전환한다.

## 분류 기준

- Feature: 없던 산출물을 새로 만든다. 화면, API, 명령, 문서, 템플릿, 설정 추가가 중심이다.
- Bugfix: 기대 동작과 실제 동작의 차이를 고친다. 재현 경로, 오류 메시지, 깨진 화면이 중심이다.
- Refactor: 동작은 유지하고 구조, 중복, 이름, 파일 배치를 개선한다.
- Review: 변경을 읽고 문제, 회귀, 테스트 누락을 찾는다. 수정은 별도 요청이 있을 때만 한다.
- Business Logic: 정책, 권한, 상태 전이, 정산, 주문, 결제, migration 같은 도메인 규칙을 바꾼다.
- Design: UI, 스타일, 색상, spacing, radius, typography, component, dark mode 영향이 있다.
- Dev Start: PC를 켜고 이어서 개발하기 위한 상태 브리핑, 컨테이너 기동, hot reload 점검이 목적이다.

## 작업 설명이 없을 때

아래 선택지를 짧게 제시하고, 사용자가 고른 유형의 workflow로 전환한다.

```text
작업 유형을 선택하거나 작업 내용을 설명해 주세요.

- feature: 신규 기능 추가
- bugfix: 버그 수정
- refactor: 구조 개선, 동작 불변
- review: 코드 리뷰
- business-logic: 정책/권한/시나리오 변경
- design: UI/스타일/디자인 시스템 작업
- dev-start: 개발 세션 재개
```

## 산출물

- 선택한 주 workflow
- 보조로 함께 적용할 workflow
- 분류 근거
- 사용자 확인이 필요한 모호점
