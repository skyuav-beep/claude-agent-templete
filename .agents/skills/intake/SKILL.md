---
name: intake
description: 프로젝트, 기술 스택, UI, 반응형, i18n, API, 에러, 폼, 라우팅, QA, 지식 관리 등 특정 주제의 요구사항을 수집할 때 사용한다.
---

# Intake Skill

> 경로 규칙: `templates/`·`docs/`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다.

## 절차

1. 요청에서 intake 토픽을 식별한다.
2. 대응하는 `templates/*-intake.md`를 읽는다.
3. 이미 제공된 답변은 먼저 채우고 부족한 항목만 질문한다.
4. 확정·미정·제외·다음 액션으로 요약한다.
5. 확정 내용은 project guide 또는 관련 문서에 반영할 대상으로 분리한다.

## 토픽 매핑

`project`·`tech`·`ui`·`responsive`·`i18n`·`framework`·`api`·`error`·`form`·`format`·`routing`·`qa`는 동명의 `templates/<토픽>-intake.md`, `knowledge`는 `templates/knowledge-entry.md`를 쓴다. (`framework`는 `templates/framework-structure-intake.md`)

## 입력 처리

- 토픽명이 없으면 위 13종 목록을 제시하고 선택을 요청한다.
- 여러 토픽이 동시에 언급되면 우선순위가 높은 것부터 진행하고 나머지는 대기열에 남긴다.

## 진행 규칙

- 템플릿 원문의 질문을 그대로 쓰되 대화형으로 자연스럽게 진행한다.
- 섹션 단위로 끊어서 진행한다.
- "모름"은 미정으로 분류하고 넘어간다.

## 산출물

토픽별 확정·미정·제외 요약과, 문서 반영 대상 목록. 문서를 실제로 고치는 단계부터 6단계 승인 절차를 적용한다.

토픽 매핑과 상세 절차는 `.codex/workflows/intake.md`를 따른다.
