# Intake Workflow

개별 주제 intake 요청을 받으면 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 토픽 매핑

- project: `templates/project-intake.md`
- tech: `templates/tech-intake.md`
- ui: `templates/ui-intake.md`
- responsive: `templates/responsive-intake.md`
- i18n: `templates/i18n-intake.md`
- framework: `templates/framework-structure-intake.md`
- api: `templates/api-intake.md`
- error: `templates/error-intake.md`
- form: `templates/form-intake.md`
- format: `templates/format-intake.md`
- routing: `templates/routing-intake.md`
- qa: `templates/qa-intake.md`

## 절차

1. 사용자 요청에서 토픽을 식별한다.
2. 해당 intake 템플릿을 읽는다.
3. 사용자가 이미 말한 내용은 먼저 채운다.
4. 부족한 항목만 질문한다.
5. 답변을 확정/미정/제외/다음 액션으로 요약한다.

## 산출물

- 채워진 intake 요약
- 프로젝트 가이드 또는 관련 문서에 반영할 항목
