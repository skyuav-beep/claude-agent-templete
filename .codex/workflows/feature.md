# Feature Workflow

기능 추가 요청을 받으면 이 절차를 따른다.

## 절차

1. `templates/feature-request.md`를 읽는다.
2. 목표, 배경, 산출물, 제약, 검증 기준을 분리한다.
3. UI 영향이 있으면 `.codex/workflows/design.md`를 함께 적용한다.
4. 구현 전 `agents/executor-agent.md`와 관련 `docs/`를 확인한다.
5. 구현 후 테스트 가능 범위를 실행한다.
6. 로컬 검증·Docker 재빌드 판단·Git 절차는 `docs/local-dev-ci-guide.md`를 따른다. 로컬 CI·push·PR·머지·브랜치 정리는 사용자 명시 요청 시 수행하며, 머지는 §6.3 게이트를 통과해야 한다. 배포/원격 migration은 사용자 수동이다.
7. 문서나 운영 규칙이 바뀌면 `STATE.md`를 갱신한다.

## 산출물

- 구현 변경 사항
- 검증 결과
- 남은 리스크 또는 후속 작업
