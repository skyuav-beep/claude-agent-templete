---
description: "사용자가 리팩터링, 구조 개선, 코드 정리, 동작 불변 변경을 언급할 때 활성화 (refactor, restructure, cleanup, reorganize)"
---

# 리팩터링 요청 구조화

리팩터링 요청을 대화형으로 구조화한다.

## 실행 방법

1. `templates/refactor-request.md` 파일을 읽는다.
2. 템플릿의 섹션(목표, 현재 문제, 범위, 유지 조건, 검증 기준)을 순서대로 질문한다.
3. 사용자 메시지에 리팩터링 대상이나 이유가 이미 포함되어 있으면 해당 항목을 먼저 채우고 부족한 부분만 추가 질문한다.
4. 모든 섹션이 채워지면 완성된 refactor-request 마크다운 블록을 출력한다.

## 입력 처리

- 사용자 메시지에 리팩터링 대상 설명이 포함되어 있으면 목표를 미리 채운다.
- 설명이 부족하면 "어떤 코드를 어떻게 정리하고 싶은지" 질문으로 시작한다.

## 진행 규칙

- 유지 조건(동작 불변 범위)을 반드시 확인한다.
- 범위가 넓으면 단계를 나눠서 진행할 것을 제안한다.
- 검증 기준은 반드시 수집한다.

## 완료 후

구조화된 refactor-request 마크다운 블록을 출력하고, 바로 구현을 시작할지 사용자에게 확인한다. 구현·검증 단계는 `docs/local-dev-ci-guide.md`를 따른다 — 로컬 Docker Desktop 검증, 로컬 CI·push는 사용자 요청 시(CI는 GitHub Actions가 아니라 로컬 실행 — 가이드의 로컬 CI 절).

## 다른 skill과의 연계

- 리팩터링 범위에 UI 컴포넌트, 스타일 파일(CSS/SCSS/Tailwind), 디자인 토큰 호출부, 다크 모드 대응 코드가 포함되면 `design` skill로 연계해 `DESIGN.md`의 토큰/Do-Don't 위반이 없는지 점검한다.
- 동작 불변 조건이 시각적 회귀(visual regression) 방지를 포함한다면 design skill의 alias/atomic 선택 규칙을 유지 조건으로 명시한다.
