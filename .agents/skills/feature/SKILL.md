---
name: feature
description: 신규 기능, 화면, API, 명령, 문서, 템플릿, 설정을 추가할 때 사용한다.
---

# Feature Skill

> 경로 규칙: `templates/`·`agents/`·`docs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 공통본을 대신 읽었으면 보고에 한 줄로 밝힌다.
> 유형 판정이 애매하면 `AGENTS.md ## 작업 유형 선택 규칙`을 먼저 적용한다.

## 절차

1. `templates/feature-request.md`와 `STATE.md`를 읽는다.
2. 목표·배경·산출물·제약·검증 기준을 정리한다.
3. UI 영향이면 `design` Skill을 함께 적용한다.
4. 승인 전에는 읽기 전용 분석과 Git 계획만 수행한다.
5. 승인된 범위만 구현하고 관련 검증·문서·STATE를 갱신한다.

## 입력 처리

- 사용자 메시지에 기능 설명이 있으면 목표·배경을 먼저 채우고 부족한 항목만 질문한다.
- 설명이 부족하면 "어떤 기능을 추가하고 싶은지"부터 묻는다.

## 진행 규칙

- 질문을 한 번에 쏟지 않고 섹션 단위로 끊어서 진행한다.
- 사용자가 간단히 답하면 그대로 반영하고 다음으로 넘어간다.
- 검증 기준은 반드시 수집한다. 비어 있으면 구현에 들어가지 않는다.

## 다른 Skill 연계

- 기능 설명에 UI·화면·스타일·컴포넌트·색·spacing·radius·typography가 있거나 검증 기준에 시각 기준이 있으면 `design` Skill로 연계해 `DESIGN.md`를 1차 소스로 읽는다.
- `templates/feature-request.md`의 디자인 토큰 참조 섹션이 비어 있으면 토큰 호출 형식(`{group.name}`)으로 채운다.

## 산출물

구조화된 feature-request 블록이 1단계 산출물이다. 이후 2단계 읽기 전용 분석과 3단계 승인을 거쳐 구현한다.

상세 절차는 `.codex/workflows/feature.md`와 `agents/executor-agent.md`, 승인 단계 봉투는 `.codex/README.md ## 단계 실행 계약`을 따른다.
