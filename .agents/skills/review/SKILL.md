---
name: review
description: 코드, 문서, PR 변경을 읽고 버그, 회귀, 보안 문제, 테스트 누락, 운영 리스크를 찾을 때 사용한다. 수정은 요청받은 경우에만 한다.
---

# Review Skill

1. `templates/review-request.md`와 `agents/reviewer-agent.md`를 읽는다.
2. diff와 관련 호출부를 확인한다.
3. Critical·High·Medium 순으로 문제를 보고한다.
4. 파일·라인 근거, 영향, 수정 방향을 제시한다.
5. 문제가 없으면 발견한 문제 없음과 잔여 리스크를 명시한다.

상세 절차는 `.codex/workflows/review.md`를 따른다.
