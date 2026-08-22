---
name: request
description: 사용자의 작업 유형이 모호하거나 기능, 버그, 리팩터링, 리뷰, 비즈니스 로직이 섞여 있어 주 workflow를 선택해야 할 때 사용한다.
---

# Request Routing Skill

1. `agents/main-agent.md`의 요청 해석 기준을 읽는다.
2. 목표·산출물·제약·우선순위를 분리한다.
3. feature, bugfix, refactor, review, business-logic, design, dev-start 중 하나를 선택한다.
4. 복합 요청이면 주 workflow와 보조 Skill을 구분한다.
5. 결과가 크게 달라질 모호점만 사용자에게 확인한다.

분류 기준은 `.codex/workflows/request.md`를 따른다.
