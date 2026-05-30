# Review Workflow

리뷰 요청을 받으면 코드 리뷰 관점으로 수행한다.

## 절차

1. `templates/review-request.md`를 읽어 리뷰 범위와 중점 항목을 확인한다.
2. `agents/reviewer-agent.md`를 기준으로 버그, 회귀, 테스트 누락을 우선 찾는다.
3. 변경 diff와 관련 호출부를 확인한다.
4. 발견 사항은 심각도 순서로 파일/라인 근거와 함께 제시한다.
5. 문제가 없으면 명확히 "발견한 문제 없음"이라고 말하고 잔여 리스크를 남긴다.

## 산출물

- findings 우선 리뷰 결과
- open questions
- 검증/테스트 갭
