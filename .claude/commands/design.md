---
description: "UI/스타일 작업에 DESIGN.md를 강제 로드하고 토큰 호출 형식으로 정리한다"
argument-hint: "[컴포넌트 | 화면 | 스타일 설명]"
---

# 디자인 시스템 적용

UI/스타일 산출물을 만들거나 검토할 때 `DESIGN.md`를 1차 소스로 로드한다.
동일 절차가 `.claude/skills/design/SKILL.md`로 자동 활성화되며, 본 command는 명시적 호출용이다.

> 경로 규칙: `DESIGN.md`·`docs/` 경로는 프로젝트 루트 기준이다. 프로젝트에 해당 파일이 없으면 `rules/` 아래 같은 경로를 읽는다(`rules/DESIGN.md`는 템플릿의 활성 시안이므로, 프로젝트 `AGENTS.md`가 정본 위치를 지정했으면 그 지정을 우선한다).

## 실행 방법

1. 프로젝트 루트 `DESIGN.md`를 먼저 읽는다. 없으면 `rules/DESIGN.md`를 읽고, **공통 템플릿의 활성 시안을 쓰고 있다는 사실을 답변에 한 줄로 밝힌다.**
2. 운영 메타 규칙이 필요하면 `docs/design-guidelines.md`를 읽는다(없으면 `rules/docs/design-guidelines.md`).
3. 색·간격·라운드·타이포 값을 hex/px로 직접 적지 않고 토큰 호출 형식(`{colors.bg-brand}`, `{spacing.space-16}`, `{rounded.radius-8}`, `{typography.body1}`)으로 표기한다.
4. `DESIGN.md`의 `## Do's and Don'ts`를 위반하지 않는지 답변 전 확인한다.

## 인수 처리

- `$ARGUMENTS`가 컴포넌트명(button, card, modal, bottom-sheet 등)이면 `DESIGN.md ## Components`의 해당 섹션을 우선 인용한다.
- `$ARGUMENTS`에 hex/px 값이 있으면 가장 가까운 토큰으로 변환해 제안한다.
- `$ARGUMENTS`가 비어 있으면 "어떤 화면·컴포넌트의 디자인을 다룰지" 질문으로 시작한다.

## 진행 규칙

세부 규칙(gradient 허용 위치, 비-4의 배수 금지, 이모지 금지, `gray-*` 사용 범위, 모달 닫기 방식)은 `.claude/skills/design/SKILL.md ## 진행 규칙`을 정본으로 따른다. 본 파일은 규칙을 중복 정의하지 않는다.

## 완료 후

- 사용한 토큰 목록을 끝에 짧게 정리한다(예: `사용 토큰: {colors.bg-brand}, {spacing.space-16}`).
- `DESIGN.md` 자체를 갱신했다면 `STATE.md`에 토큰/컴포넌트 변경 이력을 직접 남긴다. 기록 여부를 사용자에게 확인받지 않는다.
