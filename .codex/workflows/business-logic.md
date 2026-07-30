# Business Logic Workflow

비즈니스 로직 변경 요청을 받으면 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 절차

1. `templates/business-logic-request.md`를 읽는다.
2. `docs/business-logic-playbook.md`를 함께 확인한다.
3. 변경 목표, 현재 문제, 요구사항, 시나리오, 영향 범위, 검증 계획, Git 작업 계획을 정리한다.
4. 정상/실패/경계값/권한별 시나리오를 반드시 수집한다.
5. 로컬 검증, Docker 재빌드 판단, 로컬 CI·push 인계 기준은 `docs/local-dev-ci-guide.md`를 따른다.
6. 원격 배포/migration은 사용자 수동 영역으로 남긴다.

## 산출물

- 비즈니스 로직 요청서 또는 구현 결과
- 시나리오별 검증 결과
- 원격 수동 작업 인계
