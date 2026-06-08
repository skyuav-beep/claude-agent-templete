# Codex Runtime Guide

이 디렉터리는 Codex가 Claude Code 전용 자동화 없이 같은 운영 절차를 수행하도록 돕는 런타임 어댑터다.

## 읽기 순서

1. `AGENTS.md`
2. `STATE.md`
3. `.codex/workflows/<작업유형>.md`
4. workflow가 가리키는 `templates/`, `docs/`, `DESIGN.md`
5. `.codex/checks/finish-checklist.md`

## 작업 라우팅

- 새 프로젝트 시작: `workflows/start.md`
- 개발 세션 재개(PC 켜고 시작): `workflows/dev-start.md`
- 토픽별 intake: `workflows/intake.md`
- 기능 개발: `workflows/feature.md`
- 버그 수정: `workflows/bugfix.md`
- 리팩터링: `workflows/refactor.md`
- 리뷰: `workflows/review.md`
- 비즈니스 로직 변경: `workflows/business-logic.md`
- 디자인/UI 작업: `workflows/design.md`

## 종료 규칙

- 가능한 검증을 실행한다.
- 실행하지 못한 검증은 이유를 남긴다.
- 문서/운영 규칙 변경 시 `STATE.md`를 갱신한다.
- 저장소 규칙이 요구하면 커밋까지 완료한다.
