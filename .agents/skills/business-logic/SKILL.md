---
name: business-logic
description: 정책, 권한, 상태 전이, 주문, 결제, 정산, 금액·수량, migration 같은 도메인 규칙을 변경할 때 사용한다.
---

# Business Logic Skill

1. `templates/business-logic-request.md`와 `docs/business-logic-playbook.md`를 읽는다.
2. 규칙·시나리오·경계값·영향 범위를 정리한다.
3. 인증·권한·결제·정산·migration 무결성 검증을 우선 계획한다.
4. 승인 후 구현하고 시나리오별 검증을 실행한다.
5. 원격 migration과 배포는 사용자 수동 영역으로 남긴다.

상세 절차는 `.codex/workflows/business-logic.md`를 따른다.
