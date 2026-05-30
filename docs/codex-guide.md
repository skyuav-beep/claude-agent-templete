# Codex Guide

이 문서는 Codex가 이 템플릿을 사용할 때의 실행 기준이다. Codex는 `.claude/skills`, `.claude/commands`, `.claude/hooks`를 자동 실행하지 않으므로 `.codex/` 문서가 해당 동작을 절차로 재현한다.

## 시작 순서

1. `AGENTS.md`를 읽고 저장소 공통 규칙과 Context Map을 확인한다.
2. `STATE.md`에서 최근 변경, 다음 작업, 알려진 TODO를 확인한다.
3. 작업 유형에 맞는 `.codex/workflows/*.md`를 읽는다.
4. workflow가 지시하는 `templates/`, `docs/`, `DESIGN.md`를 공통 정본으로 사용한다.
5. 작업이 끝나면 `.codex/checks/finish-checklist.md`를 기준으로 검증과 인계를 정리한다.

## Claude 기능의 Codex 대응

| Claude 기능 | Codex 대응 |
|---|---|
| natural language skill activation | 사용자 요청을 분류한 뒤 `.codex/workflows/*.md`를 직접 따른다 |
| slash command | 명시 명령 대신 workflow 문서를 참조한다 |
| PreToolUse hook | Codex 승인/샌드박스와 safety checklist로 대체한다 |
| Agent subagent template | Codex subagent가 필요할 때 `.codex/agents/*.md`를 프롬프트 기준으로 쓴다 |
| state reminder hook | 작업 종료 전 finish checklist를 수행한다 |

## 작업 유형 라우팅

- 새 프로젝트 시작: `.codex/workflows/start.md`
- 개별 intake: `.codex/workflows/intake.md`
- 기능 요청: `.codex/workflows/feature.md`
- 버그 수정: `.codex/workflows/bugfix.md`
- 리팩터링: `.codex/workflows/refactor.md`
- 리뷰: `.codex/workflows/review.md`
- 비즈니스 로직 변경: `.codex/workflows/business-logic.md`
- UI/디자인 작업: `.codex/workflows/design.md`

## 운영 기준

- Codex는 실제 파일과 실행 결과를 우선한다.
- Claude 전용 파일은 참고 가능하지만 Codex 자동화로 가정하지 않는다.
- 파괴적 명령, 원격 배포, 원격 migration, `docker compose down -v`는 `AGENTS.md`의 사용자 확인 규칙을 따른다.
- 문서/설정 변경이 끝나면 `STATE.md`를 갱신하고 커밋한다.
