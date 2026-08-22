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
| 실행 게이트 로딩 | `.claude/CLAUDE.md` 자동 로드 (루트 `CLAUDE.md`와 함께). 읽기 순서·6단계 절차·시작/종료 게이트 | `.codex/README.md` 읽기 순서와 종료 규칙 | `docs/approval-workflow.md` |
| 종료 전 확인 | `.claude/CLAUDE.md ## 종료 전 확인` | `.codex/checks/finish-checklist.md` | `docs/finish-checklist.md` |
| 작업 절차 연결 | 각 skill·command의 `## 승인 절차 연결` | 각 workflow 절차 + `.codex/README.md` 종료 규칙 | `docs/approval-workflow.md` |
| 프로젝트 기준 | `AGENTS.md` 라우팅을 통해 로컬 가이드 선행 로드 | `AGENTS.md` 필수 로딩 + `.codex/README.md` | `docs/project-guide.md`, 하위 `AGENTS.md`, 관련 프로젝트 로컬 문서 |
| 새 프로젝트 QnA | `.claude/skills/start/SKILL.md` 자동 활성화 | `.codex/workflows/start.md` 절차 실행 | `templates/startup-checklist.md` |
| 개발 세션 부트스트랩 | `.claude/skills/dev-start/SKILL.md` 자동 활성화 | `.codex/workflows/dev-start.md` 절차 실행 | `docs/local-dev-ci-guide.md §2.0` |
| 기술 스택 업그레이드 | `.claude/skills/stack-upgrade/SKILL.md` 자동 활성화 + `/stack-upgrade` | `.codex/workflows/stack-upgrade.md` 절차 실행 | `docs/approval-workflow.md`, `docs/local-dev-ci-guide.md` |
| 미완료 Git 작업 정리 | `.claude/skills/git-cleanup/SKILL.md` 자동 활성화 + `/git-cleanup` | `.codex/workflows/git-cleanup.md` 절차 실행 | `docs/approval-workflow.md`, `docs/finish-checklist.md` |
| 세션 충돌 조정 | Claude lifecycle + `session-coordination.sh` 파일 점유 hook | `.codex/workflows/session-coordination.md`에서 동일 스크립트 호출 | `docs/session-coordination-guide.md` |
| 토픽 intake | `.claude/skills/intake/SKILL.md` | `.codex/workflows/intake.md` | `templates/*-intake.md` |
| 모호한 작업 요청 라우팅 | `.claude/skills/request/SKILL.md` 자동 분류 | `.codex/workflows/request.md` 절차 실행 | `agents/main-agent.md`, `templates/*-request.md` |
| 작업 요청 구조화 | `.claude/skills/{feature,bugfix,refactor,review,business-logic}` | `.codex/workflows/{feature,bugfix,refactor,review,business-logic}` | `templates/*-request.md` |
| 디자인 규칙 | `.claude/skills/design/SKILL.md` 자동 로드 | `.codex/workflows/design.md` 강제 참조 | `DESIGN.md`, `docs/design-guidelines.md` |
| 파괴적 명령 차단 | `.claude/hooks/block-destructive.sh` | Codex 승인/샌드박스 + `.codex/checks/safety-checklist.md` | `AGENTS.md` 사용자 확인 규칙 |
| STATE 리마인더 | `.claude/hooks/state-reminder.sh` | `.codex/checks/finish-checklist.md` | `STATE.md` |
| 작업 완료 알림 | `Stop` 훅 -> `.claude/hooks/notify-pending.sh` | `notify` 설정 -> `.codex/hooks/notify-codex.sh` -> 같은 스크립트 | `docs/notification-guide.md` |
| 확인(ACK) 추적 | `UserPromptSubmit`/`SessionEnd` 훅 | 해당 훅 없음. rollout 기록 파일 갱신 감시로 판정 | 상태 파일 `~/.claude/notify-state/` 공유 |
| 대기 현황 표시 | `statusLine` (다른 창 대기 상시 표시) | Codex TUI에 커스텀 상태줄 없음. Claude 창의 상태줄이 Codex 대기도 함께 표시 | 상태 파일 공유 |
| 서브에이전트 | Claude `Agent` 도구 + `.claude/agents/*` | Codex subagent 사용 시 `.codex/agents/*` | `agents/*`, `docs/subagent-guide.md` |
| 설치 | `.claude/plugins/install.sh` | 동일 설치기로 연결·업데이트 | manifest 소유권 + `.claude/.template-install-state.json` 해시 상태 |

## 변경 규칙

1. 공통 질문/양식은 `templates/`에 둔다.
2. 공통 정책/판단 기준은 `docs/`에 둔다.
3. Claude 자동 활성화 설명은 `.claude/skills`에만 둔다.
4. Codex 실행 절차는 `.codex/workflows`에만 둔다.
5. 런타임별 차이가 생기면 이 문서의 매트릭스를 먼저 갱신한다.
