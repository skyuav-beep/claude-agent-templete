# Agent Runtime Matrix

이 문서는 같은 템플릿을 Claude Code와 Codex에서 사용할 때 어떤 파일이 정본이고, 어떤 레이어가 런타임별 어댑터인지 정의한다.

## 기본 원칙

- 공통 정본은 `AGENTS.md`, `CLAUDE.md`의 커뮤니케이션·답변 포맷, `STATE.md`, `docs/project-guide.md`, 프로젝트 로컬 `templates/`, `docs/`, `DESIGN.md`다.
- 두 런타임 모두 `AGENTS.md ## 프로젝트 로컬 가이드 우선`을 적용하며 프로젝트 로컬 기준을 템플릿 기본값보다 우선한다.
- Claude Code 전용 자동화는 `.claude/` 아래에 둔다.
- Codex 전용 실행 절차는 `.codex/` 아래에 둔다.
- 한 런타임을 지원하기 위해 다른 런타임의 전용 파일을 약화하거나 일반화하지 않는다.
- 새 작업 유형을 추가하면 공통 template/doc를 먼저 만들고, 이후 `.claude/skills`와 `.codex/workflows`를 각각 연결한다.

## 지원 수준

| 영역 | Claude Code | Codex | 공통 정본 |
|---|---|---|---|
| 운영 규칙 | `CLAUDE.md` + `AGENTS.md` | `AGENTS.md` 필수 로딩 지시 + `CLAUDE.md` 공통 응답 정책 + `.codex/README.md` | `AGENTS.md`, `CLAUDE.md ## 커뮤니케이션`, `CLAUDE.md ## 답변 포맷` |
| 프로젝트 기준 | `AGENTS.md` 라우팅을 통해 로컬 가이드 선행 로드 | `AGENTS.md` 필수 로딩 + `.codex/README.md` | `docs/project-guide.md`, 하위 `AGENTS.md`, 관련 프로젝트 로컬 문서 |
| 새 프로젝트 QnA | `.claude/skills/start/SKILL.md` 자동 활성화 | `.codex/workflows/start.md` 절차 실행 | `templates/startup-checklist.md` |
| 개발 세션 부트스트랩 | `.claude/skills/dev-start/SKILL.md` 자동 활성화 | `.codex/workflows/dev-start.md` 절차 실행 | `docs/local-dev-ci-guide.md §2.0` |
| 토픽 intake | `.claude/skills/intake/SKILL.md` | `.codex/workflows/intake.md` | `templates/*-intake.md` |
| 모호한 작업 요청 라우팅 | `.claude/skills/request/SKILL.md` 자동 분류 | `.codex/workflows/request.md` 절차 실행 | `agents/main-agent.md`, `templates/*-request.md` |
| 작업 요청 구조화 | `.claude/skills/{feature,bugfix,refactor,review,business-logic}` | `.codex/workflows/{feature,bugfix,refactor,review,business-logic}` | `templates/*-request.md` |
| 디자인 규칙 | `.claude/skills/design/SKILL.md` 자동 로드 | `.codex/workflows/design.md` 강제 참조 | `DESIGN.md`, `docs/design-guidelines.md` |
| 파괴적 명령 차단 | `.claude/hooks/block-destructive.sh` | Codex 승인/샌드박스 + `.codex/checks/safety-checklist.md` | `AGENTS.md` 사용자 확인 규칙 |
| STATE 리마인더 | `.claude/hooks/state-reminder.sh` | `.codex/checks/finish-checklist.md` | `STATE.md` |
| 서브에이전트 | Claude `Agent` 도구 + `.claude/agents/*` | Codex subagent 사용 시 `.codex/agents/*` | `agents/*`, `docs/subagent-guide.md` |
| 설치 | `.claude/plugins/install.sh` | 동일 설치기로 연결·업데이트 | manifest 소유권 + `.claude/.template-install-state.json` 해시 상태 |

## 변경 규칙

1. 공통 질문/양식은 `templates/`에 둔다.
2. 공통 정책/판단 기준은 `docs/`에 둔다.
3. Claude 자동 활성화 설명은 `.claude/skills`에만 둔다.
4. Codex 실행 절차는 `.codex/workflows`에만 둔다.
5. 런타임별 차이가 생기면 이 문서의 매트릭스를 먼저 갱신한다.
