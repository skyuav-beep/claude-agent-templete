---
name: request
description: 사용자의 작업 유형이 모호하거나 기능, 버그, 리팩터링, 리뷰, 비즈니스 로직이 섞여 있어 주 workflow를 선택해야 할 때 사용한다.
---

# Request Routing Skill

> 경로 규칙: `templates/`·`agents/`·`docs/`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다.

## 선택 우선순위

유형 키워드가 명확하면 이 Skill을 쓰지 않고 해당 개별 Skill을 바로 선택한다. 판정 기준의 정본은 `AGENTS.md ## 작업 유형 선택 규칙`이며, 두 런타임이 같은 기준을 쓴다.

## 절차

1. `agents/main-agent.md`의 요청 해석 기준을 읽는다.
2. 목표·산출물·제약·우선순위를 분리한다.
3. feature, bugfix, refactor, review, business-logic, design, dev-start 중 하나를 선택한다.
4. 복합 요청이면 주 workflow와 보조 Skill을 구분한다.
5. 결과가 크게 달라질 모호점만 사용자에게 확인한다.

## 분류 기준

| 신호 | 선택 |
|---|---|
| "추가하자", "만들자", 신규 화면·엔드포인트·명령 | `feature` |
| "안 된다", "에러 난다", 재현 절차 동반 | `bugfix` |
| "정리하자", "구조만", 동작 불변 조건 | `refactor` |
| 시나리오·권한·경계값·정책 변경 | `business-logic` |
| "검토해줘", PR·변경 범위 지정 | `review` |

## 작업 설명이 없을 때

위 5종을 목록으로 제시하고 선택을 요청한다.

## 산출물

선택한 유형의 `templates/*-request.md` 구조에 맞는 블록. 이후 단계 진행은 선택된 유형을 따르며, 한 턴에 한 단계 원칙을 유지한다.

분류 기준 상세는 `.codex/workflows/request.md`를 따른다.
