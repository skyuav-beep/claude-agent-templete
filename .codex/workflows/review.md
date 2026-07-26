# Review Workflow

리뷰 요청을 받으면 코드 리뷰 관점으로 수행한다.

## 절차

1. `templates/review-request.md`를 읽어 리뷰 범위와 중점 항목을 확인한다.
2. `agents/reviewer-agent.md`를 기준으로 버그, 회귀, 테스트 누락을 우선 찾는다.
3. 변경 diff와 관련 호출부를 확인한다.
4. 발견 사항은 심각도 순서로 파일/라인 근거와 함께 제시한다.
5. 문제가 없으면 명확히 "발견한 문제 없음"이라고 말하고 잔여 리스크를 남긴다.
6. 리뷰 후 수정·검증·로컬 CI·push·머지로 이어지면 프로젝트 `AGENTS.md`와 `docs/local-dev-ci-guide.md` 경계를 따른다. 프로젝트 문서가 공용 reviewer 기준을 override하면 프로젝트 문서가 우선이다.
7. 사용자가 대상 PR과 base를 명시하거나 현재 PR을 모호하지 않게 지칭한 경우 검증 후 머지할 수 있다. 자발적 머지·보호 규칙 우회 금지, 머지 후 원격 base 반영 검증, 원격 배포/migration 사용자 수동 원칙은 유지한다.

## 산출물

- findings 우선 리뷰 결과
- open questions
- 검증/테스트 갭
