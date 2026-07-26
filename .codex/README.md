# Codex Runtime Guide

이 디렉터리는 Codex가 Claude Code 전용 자동화 없이 같은 운영 절차를 수행하도록 돕는 런타임 어댑터다.

## 읽기 순서

1. `AGENTS.md`
2. `CLAUDE.md`의 `## 커뮤니케이션`, `## 답변 포맷`
3. `STATE.md`
4. `docs/project-guide.md`가 있으면 해당 문서와 현재 작업 영역의 하위 `AGENTS.md`
5. `.codex/checks/safety-checklist.md`
6. `.codex/workflows/<작업유형>.md`
7. workflow가 가리키는 프로젝트 로컬 `templates/`, `docs/`, `DESIGN.md`
8. `.codex/checks/finish-checklist.md`

## 작업 라우팅

- 새 프로젝트 시작: `workflows/start.md`
- 개발 세션 재개(PC 켜고 시작): `workflows/dev-start.md`
- 토픽별 intake: `workflows/intake.md`
- 모호한 작업 요청 분류: `workflows/request.md`
- 기능 개발: `workflows/feature.md`
- 버그 수정: `workflows/bugfix.md`
- 리팩터링: `workflows/refactor.md`
- 리뷰: `workflows/review.md`
- 비즈니스 로직 변경: `workflows/business-logic.md`
- 디자인/UI 작업: `workflows/design.md`

## 종료 규칙

- 가능한 검증을 실행한다.
- 실행하지 못한 검증은 이유를 남긴다.
- 긴 답변과 최종 통합은 `CLAUDE.md ## 답변 포맷`을 따른다.
- 문서/운영 규칙 변경 시 `STATE.md`를 갱신한다.
- 저장소 규칙이 요구하면 커밋까지 완료한다.

## 동등성 기준

- `.codex/workflows/*`는 `.claude/skills/*`와 `.claude/commands/*`가 수행하는 절차를 Codex에서 명시적으로 재현한다.
- `.codex/agents/*`는 `.claude/agents/*`의 역할과 같은 책임을 수행하되, Codex 도구·승인·샌드박스 모델에 맞춰 실행한다.
- 모든 workflow와 agent guide는 `AGENTS.md ## 프로젝트 로컬 가이드 우선`을 선행 기준으로 적용한다.
- 상세 정책은 중복 정의하지 않고 `AGENTS.md`, `agents/*.md`, `templates/*.md`, `docs/*.md`, `DESIGN.md`를 공통 정본으로 사용한다.
