# Agent Runtime Matrix

이 문서는 같은 템플릿을 Claude Code와 Codex에서 사용할 때 어떤 파일이 정본이고, 어떤 레이어가 런타임별 어댑터인지 정의한다.

## 기본 원칙

- 공통 정본은 `AGENTS.md`, `CLAUDE.md`의 커뮤니케이션·답변 포맷, `STATE.md`, `docs/project-guide.md`, 프로젝트 로컬 `templates/`, `docs/`, `DESIGN.md`다.
- 두 런타임 모두 `AGENTS.md ## 프로젝트 로컬 가이드 우선`을 적용하며 프로젝트 로컬 기준을 템플릿 기본값보다 우선한다.
- Claude Code 전용 자동화는 `.claude/` 아래에 둔다.
- Codex 네이티브 Skill은 `.agents/skills/`, 승인·검증·호환 실행 절차는 `.codex/` 아래에 둔다.
- 한 런타임을 지원하기 위해 다른 런타임의 전용 파일을 약화하거나 일반화하지 않는다.
- 새 작업 유형을 추가하면 공통 template/doc를 먼저 만들고, 이후 `.claude/skills`와 `.agents/skills`를 각각 연결한다. 명시적 호환 절차가 필요하면 `.codex/workflows`도 연결한다.

## 지원 수준

| 영역 | Claude Code | Codex | 공통 정본 |
|---|---|---|---|
| 운영 규칙 | `CLAUDE.md` + `AGENTS.md` | `AGENTS.md` 필수 로딩 지시 + `CLAUDE.md` 공통 응답 정책 + `.codex/README.md` | `AGENTS.md`, `CLAUDE.md ## 커뮤니케이션`, `CLAUDE.md ## 답변 포맷` |
| 실행 게이트 로딩 | `.claude/CLAUDE.md` 자동 로드 (루트 `CLAUDE.md`와 함께). 읽기 순서·6단계 절차·시작/종료 게이트 | `.agents/skills/*` 자동 선택 + `.codex/README.md` 승인·종료 규칙 | `docs/approval-workflow.md` |
| 종료 전 확인 | `.claude/CLAUDE.md ## 종료 전 확인` | `.codex/checks/finish-checklist.md` | `docs/finish-checklist.md` |
| 작업 절차 연결 | 각 skill·command의 `## 승인 절차 연결` | `.agents/skills/*` + 필요 시 `.codex/workflows/*` | `docs/approval-workflow.md` |
| 프로젝트 기준 | `AGENTS.md` 라우팅을 통해 로컬 가이드 선행 로드 | `AGENTS.md` 필수 로딩 + `.codex/README.md` | `docs/project-guide.md`, 하위 `AGENTS.md`, 관련 프로젝트 로컬 문서 |
| 새 프로젝트 QnA | `.claude/skills/start/SKILL.md` 자동 활성화 | `.agents/skills/start/SKILL.md` 자동 선택 → `.codex/workflows/start.md` | `templates/startup-checklist.md` |
| 개발 세션 부트스트랩 | `.claude/skills/dev-start/SKILL.md` 자동 활성화 | `.agents/skills/dev-start/SKILL.md` 자동 선택 -> `.codex/workflows/dev-start.md` | `docs/local-dev-ci-guide.md §2.0` |
| 기술 스택 업그레이드 | `.claude/skills/stack-upgrade/SKILL.md` 자동 활성화 + `/stack-upgrade` | `.agents/skills/stack-upgrade/SKILL.md` 자동 선택 -> `.codex/workflows/stack-upgrade.md` | `docs/approval-workflow.md`, `docs/local-dev-ci-guide.md` |
| 미완료 Git 작업 정리 | `.claude/skills/git-cleanup/SKILL.md` 자동 활성화 + `/git-cleanup` | `.agents/skills/git-cleanup/SKILL.md` 자동 선택 -> `.codex/workflows/git-cleanup.md` | `docs/approval-workflow.md`, `docs/finish-checklist.md` |
| 세션 종료와 인계 정리 | `.claude/skills/session-end/SKILL.md` 자동 활성화 + `/session-end` | `.agents/skills/session-end/SKILL.md` 자동 선택 -> `.codex/workflows/session-end.md` | `docs/finish-checklist.md`, `docs/approval-workflow.md` |
| 세션 충돌 조정 | `.claude/skills/session-coordination/SKILL.md` + `session-coordination.sh` 파일 점유 hook | `.agents/skills/session-coordination/SKILL.md` 자동 선택 -> `.codex/workflows/session-coordination.md` (동일 스크립트 호출) | `docs/session-coordination-guide.md` |
| 토픽 intake | `.claude/skills/intake/SKILL.md` | `.agents/skills/intake/SKILL.md` 자동 선택 -> `.codex/workflows/intake.md` | `templates/*-intake.md` |
| 모호한 작업 요청 라우팅 | `.claude/skills/request/SKILL.md` 자동 분류 | `.agents/skills/request/SKILL.md` 자동 선택 -> `.codex/workflows/request.md` | `agents/main-agent.md`, `templates/*-request.md` |
| 작업 요청 구조화 | `.claude/skills/{feature,bugfix,refactor,review,business-logic}` | `.agents/skills/{feature,bugfix,refactor,review,business-logic}` 자동 선택 -> 동명 `.codex/workflows/*` | `templates/*-request.md` |
| 디자인 규칙 | `.claude/skills/design/SKILL.md` 자동 로드 | `.agents/skills/design/SKILL.md` 자동 선택 → `.codex/workflows/design.md` | `DESIGN.md`, `docs/design-guidelines.md` |
| 작업 유형 선택 | `.claude/skills/*` description 트리거 | `.agents/skills/*` description 자동 선택 | `AGENTS.md ## 작업 유형 선택 규칙` |
| 파괴적 명령 차단 | `.claude/hooks/block-destructive.sh` PreToolUse 자동 차단 | 같은 스크립트를 실행 전 판정 전용으로 호출 (`.codex/checks/safety-checklist.md ## 실행 전 공용 판정기`) | `AGENTS.md` 사용자 확인 규칙 |
| 배포·릴리스 차단 | `.claude/hooks/block-deploy.sh` PreToolUse 자동 차단 | 같은 스크립트를 실행 전 판정 전용으로 호출 | `CLAUDE.md ## Golden Rules` |
| 비밀 파일 차단 | `.claude/hooks/block-secret-files.sh` PreToolUse 자동 차단 | 같은 스크립트를 쓰기 전 판정 전용으로 호출 | `.codex/checks/safety-checklist.md` |
| 3단계 승인 게이트 | `.claude/hooks/phase-approval.sh` 확인 요청 | `.codex/README.md ## 단계 실행 계약`의 단계 선언 봉투 | `docs/approval-workflow.md` |
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
4. Codex 자동 선택 절차는 `.agents/skills`에 두고, 승인·검증·호환 절차는 `.codex/workflows`에 둔다.
5. 런타임별 차이가 생기면 이 문서의 매트릭스를 먼저 갱신한다.
6. 한쪽 런타임에만 작업 유형을 추가하지 않는다. `node scripts/check-runtime-parity.mjs`가 양방향 누락과 매트릭스 행 누락을 검사한다.
