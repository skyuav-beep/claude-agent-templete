---
name: bugfix
description: 버그, 오류, 깨진 화면, 기대 동작과 실제 동작의 차이를 재현하고 수정할 때 사용한다.
---

# Bugfix Skill

1. `templates/bugfix-request.md`를 읽는다.
2. 재현·기대 동작·영향 범위·검증 기준을 정리한다.
3. 최소 재현 범위를 찾고 원인을 확인한다.
4. 승인 후 원인을 좁게 수정하고 회귀 검증을 실행한다.
5. 실패 원인과 남은 위험을 기록한다.

상세 절차는 `.codex/workflows/bugfix.md`와 `agents/executor-agent.md`를 따른다.
