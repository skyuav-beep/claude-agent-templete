# Bugfix Workflow

버그 수정 요청을 받으면 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 절차

1. `templates/bugfix-request.md`를 읽는다.
2. 문제 요약, 재현 방법, 기대 동작, 영향 범위, 검증 기준을 정리한다.
3. 재현 가능한 최소 범위를 먼저 찾는다.
4. 원인 수정은 좁게 한다.
5. 회귀 검증을 실행한다.
6. 승인·Git 수명주기는 `docs/approval-workflow.md`, 빠른 검증·Docker 판단은 `docs/local-dev-ci-guide.md`를 따른다.
7. 검증이 불가능하면 환경/데이터/권한 등 이유를 명확히 남긴다.

## 산출물

- 원인 요약
- 수정 파일
- 재현/검증 결과
