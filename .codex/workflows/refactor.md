# Refactor Workflow

리팩터링 요청을 받으면 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 절차

1. `templates/refactor-request.md`를 읽는다.
2. 리팩터링 목표와 유지해야 할 동작을 분리한다.
3. 구조 변경 범위가 크면 사용자 확인을 먼저 받는다.
4. 기존 테스트나 사용 경로를 확인한다.
5. 동작 변경 없이 구조만 정리한다.
6. 검증 기준에 맞게 테스트 또는 정적 확인을 실행한다.
7. 승인·Git 수명주기는 `docs/approval-workflow.md`, 빠른 검증·Docker 판단은 `docs/local-dev-ci-guide.md`를 따른다.

## 산출물

- 변경 전후 구조 요약
- 유지된 동작
- 검증 결과
