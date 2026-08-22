# Codex Guide

이 문서는 Codex가 이 템플릿을 사용할 때의 실행 기준이다. Codex 네이티브 Skill은 `.agents/skills/`에서 자동 선택하고, `.codex/`는 승인·검증·호환 절차를 제공한다. Claude 전용 `.claude/*`는 Codex 자동화로 가정하지 않는다.

## 시작 순서

1. `AGENTS.md`를 읽고 저장소 공통 규칙과 Context Map을 확인한다.
2. `CLAUDE.md ## 답변 포맷`에서 단계별 응답과 최종 통합을 포함한 공통 응답 정책을 확인한다.
3. `STATE.md`에서 최근 변경, 다음 작업, 알려진 TODO를 확인한다.
4. `docs/project-guide.md`가 있으면 읽고 현재 작업 영역의 하위 `AGENTS.md`와 관련 로컬 문서를 확인한다.
5. `.codex/checks/safety-checklist.md`로 작업 전 사용자 확인 경계를 확인한다.
6. 작업 유형에 맞는 `.agents/skills/<type>/SKILL.md`를 읽는다. 명시적 단계나 호환 절차가 필요하면 `.codex/workflows/<type>.md`를 함께 읽는다.
7. workflow가 지시하는 `templates/`, `agents/`, `docs/`, `designs/`, `DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.
8. 작업이 끝나면 `.codex/checks/finish-checklist.md`를 기준으로 검증과 인계를 정리한다.

## Claude 기능의 Codex 대응

| Claude 기능 | Codex 대응 |
|---|---|
| natural language skill activation | `.agents/skills/*/SKILL.md`의 description 기반 자동 선택 |
| slash command | 명시 명령 대신 같은 이름의 workflow 문서를 참조한다 |
| PreToolUse hook | Codex 승인/샌드박스와 safety checklist로 대체한다 |
| Agent subagent template | Codex subagent가 필요할 때 `.codex/agents/*.md`를 프롬프트 기준으로 쓴다 |
| state reminder hook | 작업 종료 전 finish checklist를 수행한다 |
| Stop hook 작업 완료 알림 | `notify` 설정에 `.codex/hooks/notify-codex.sh`를 등록한다. 어댑터가 Claude 알림 훅을 그대로 호출한다 |
| UserPromptSubmit hook 확인 추적 | 해당 훅이 없다. rollout 기록 파일의 갱신을 감시해 확인 여부를 판정한다 |
| statusLine 대기 현황 | Codex TUI에는 없다. Claude Code 창을 하나 띄워 두면 그 상태줄에 Codex 대기까지 함께 보인다 |

## 작업 유형 라우팅

- 새 프로젝트 시작: `.agents/skills/start/SKILL.md` → `.codex/workflows/start.md`
- 개발 세션 재개: `.agents/skills/dev-start/SKILL.md` → `.codex/workflows/dev-start.md`
- 개별 intake: `.agents/skills/intake/SKILL.md` → `.codex/workflows/intake.md`
- 모호한 작업 요청 분류: `.agents/skills/request/SKILL.md` → `.codex/workflows/request.md`
- 기능 요청: `.agents/skills/feature/SKILL.md` → `.codex/workflows/feature.md`
- 버그 수정: `.agents/skills/bugfix/SKILL.md` → `.codex/workflows/bugfix.md`
- 리팩터링: `.agents/skills/refactor/SKILL.md` → `.codex/workflows/refactor.md`
- 리뷰: `.agents/skills/review/SKILL.md` → `.codex/workflows/review.md`
- 비즈니스 로직 변경: `.agents/skills/business-logic/SKILL.md` → `.codex/workflows/business-logic.md`
- UI/디자인 작업: `.agents/skills/design/SKILL.md` → `.codex/workflows/design.md`

## 운영 기준

- Codex는 실제 파일과 실행 결과를 우선한다.
- 모든 workflow와 agent guide는 `AGENTS.md ## 프로젝트 로컬 가이드 우선`을 선행 기준으로 적용한다.
- workflow나 agent guide를 단독으로 읽어도 같은 경로 규칙을 적용한다. 프로젝트에 참조 파일이 없다는 이유로 기준 문서를 생략하지 않는다.
- 긴 답변의 분할, 단계 상태 유지, 최종 통합 기준은 `CLAUDE.md ## 답변 포맷`을 따른다.
- Claude 전용 파일은 참고 가능하지만 Codex 자동화로 가정하지 않는다. Codex 네이티브 Skill은 `.agents/skills/`만 자동 선택 대상으로 삼는다.
- Codex agent guide는 Claude subagent와 같은 책임을 수행한다. 상세 점검 항목은 `.codex/agents/*.md`가 지정한 공통 문서와, 필요한 경우 같은 이름의 `.claude/agents/*.md`를 비교 기준으로 삼는다.
- 파괴적 명령, 원격 배포, 원격 migration, `docker compose down -v`는 `AGENTS.md`의 사용자 확인 규칙을 따른다.
- 문서/설정 변경이 끝나면 `STATE.md`를 갱신하고 커밋한다.
