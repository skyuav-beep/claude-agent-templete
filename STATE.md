# STATE.md

## 현재 상태

- 이 저장소는 여러 개발 프로젝트에 재사용하는 `개발용 에이전트 운영 템플릿`이다.
- 공통 운영 규칙과 라우팅은 `AGENTS.md`, 에이전트 헌법과 응답 정책은 `CLAUDE.md`가 정본이다.
- 역할별 지침은 `agents/`, 요청·intake 양식은 `templates/`, 프로젝트·검증 가이드는 `docs/`에 둔다.
- Claude Code 자동화는 `.claude/`, Codex 실행 어댑터는 `.codex/`에 둔다.
- 프로젝트 가이드는 템플릿 배포 원본에서 초기 scaffold를 유지하고 소비 프로젝트가 intake 결과로 교체한다.
- 본 템플릿을 소비하는 런타임 앱은 sibling 저장소 `../riderapp-runtime/`이다.
- 작업 알림은 Claude Code 사용자 전역 설정과 Codex `notify`에 등록되어 두 런타임 모두 동작 중이다. 구성·조정·되돌리기는 `docs/notification-guide.md`.

## 이력 아카이브

- [2026-07-31 전체 스냅샷](docs/archive/STATE-2026-07-31.md) — 압축 전 최신 `STATE.md` 867줄을 바이트 단위 그대로 보존한다.
- 과거 완료 기록과 상세 검증 근거는 아카이브에서 확인하고, 루트 문서는 현재 인계에 필요한 정보만 유지한다.

## 이번 세션에서 완료한 작업

- 아래 최근 요약을 제외한 전체 완료 이력과 상세 검증 근거는 [2026-07-31 전체 스냅샷](docs/archive/STATE-2026-07-31.md)에서 확인한다.

- 여러 창 동시 작업을 위한 작업 알림과 확인(ACK) 추적을 추가했다. (2026-08-01~08-02, PR #14 머지 `501ed79`)
  - `Stop`/`Notification`에서 소리와 데스크톱 알림을 보내고 확인할 때까지 반복하며, `UserPromptSubmit`/`SessionEnd`에서 대기 상태를 해제한다. transcript 갱신도 암묵적 확인으로 인정한다.
  - 상태줄 `.claude/statusline-notify.sh`가 다른 창의 대기 현황을 상시 표시하고 자기 세션은 제외한다.
  - 완료 알림은 기본 60초 이상 걸린 턴만, 재알림은 90초 간격 최대 6회이며 환경변수로 조정한다. 조정·되돌리기는 `docs/notification-guide.md`.
  - 반복 알림 훅은 `"async": true`로 등록해 턴 종료를 지연시키지 않는다. 사용자 전역 설정(`~/.claude/settings.json`)에 등록했고 백업은 `~/.claude/settings.json.bak-20260801`이다.
  - 알림음은 완료 `tada.wav`, 응답 필요 `Alarm03.wav`, 3회째 재알림부터 `Ring06.wav`로 격상한다. 격상 시점은 `CLAUDE_NOTIFY_ESCALATE_AFTER`로 조정하고 macOS는 `Glass`/`Sosumi`/`Basso`로 대응한다. (2026-08-02)
  - 소리를 비동기 재생하고 0.9초만 대기해 2초 이상인 음원이 잘리던 문제를 재생 완료까지 대기하도록 고쳤다. 토스트를 먼저 띄우므로 표시 지연은 없다. (2026-08-02)
  - bash 구문 4종, 완료·응답요청 알림, 짧은 턴 억제, 반복 후 ACK 자동 종료(잔여 프로세스 없음), 확인 훅 stdout 0바이트, 상태줄 출력, 전역·매니페스트 JSON 유효성을 검증했다.
  - 격상 시퀀스는 스텁 발사기로 `attention` 3회 후 `escalate` 2회 전환을 확인했다. (2026-08-02)
  - Codex에도 같은 알림을 연결했다. `~/.codex/config.toml`의 `notify`에 `.codex/hooks/notify-codex.sh`를 등록하고, 어댑터가 페이로드를 Claude 훅 형식으로 변환해 같은 스크립트를 재사용한다. 개인 설정 백업은 `~/.codex/config.toml.bak-20260802`. (2026-08-02)
  - Codex에는 turn 종료·사용자 입력 훅이 없어 확인(ACK)은 rollout 기록 갱신으로 판정하고, 턴 소요 시간은 마지막 `task_started` 시각에서 계산한다. Codex TUI에 커스텀 상태줄이 없으므로 대기 현황은 공유 상태 파일을 읽는 Claude 창 상태줄이 대신 표시한다. (2026-08-02)
  - Codex 검증: 모의 페이로드로 변환 결과(세션 ID·작업 폴더·rollout 경로·시작 시각), 실제 알림 발사, 논블로킹 종료, TOML 파싱을 확인했다. 실제 Codex 세션 1회 실행 확인은 사용자 실행 대기 상태다. (2026-08-02)
  - 전체 CI 대기열: 문서·스크립트 변경으로 lint/test/build 대상 없음.

- STATE 이력을 아카이브하고 루트 인계 문서를 축소했다. (2026-07-31)
  - 최신 원본 867줄을 `docs/archive/STATE-2026-07-31.md`에 바이트 단위로 보존하고 루트에는 현재 상태·최근 완료·다음 작업·TODO만 남겼다.
  - 원본·아카이브 SHA-256 일치, 필수 섹션·후속 작업 보존, 문서 인덱스 106개와 HTML 7개를 검증했다.
  - 전체 CI 대기열: 문서 전용 변경으로 lint/test/build 대상 없음. 별도 배치 항목 없음.

- 환경 호칭 개정과 해당 세션 종료 기록을 반영했다. (2026-07-31, PR #9·#12)
  - 환경 호칭을 `local` / `staging` / `production`으로 통일하고 원격 migration은 사용자 수동으로 유지했다.
  - 템플릿 반영은 완료됐으며 연결 프로젝트의 미완료 작업 2건은 아래 다음 작업에 인계한다.

- STATE 리마인더 훅의 경고 전달 방식을 stdout JSON `additionalContext`로 교체했다. (2026-07-31, PR #11)
  - `exit 0`의 stderr가 모델에 전달되지 않던 문제를 해소하고, 검사 기준을 도구 실행 cwd로 맞췄다.
  - bash 구문, commit 명령 판별 3케이스, 실제 `additionalContext` 수신을 확인했다.

- 에이전트 가이드의 1단계 부트스트랩 규칙과 템플릿 원본 상태를 정합화했다. (2026-07-31, PR #10)
  - 필수 응답 정책 로딩은 허용하되 그 외 저장소 읽기와 작업 분석 명령 금지는 유지했다.
  - 프로젝트 가이드가 `project-owned` 초기 파일이며 소비 프로젝트가 intake로 교체한다는 경계를 명시했다.

## 전체 CI 배치 대기열

- 현재 필수 대기 항목은 없다.
- 최근 변경은 문서와 훅 스크립트 범위이며 각각 문서 인덱스·HTML 검사 또는 bash 구문·동작 프로브로 검증했다.
- 전체 로컬 CI는 3~5개 작업 누적, 하루 종료, 릴리스 전 또는 사용자 명시 요청 시 별도 6단계 작업으로 실행한다.

## 다음 작업

### 작업 알림 후속

- Codex에서 실제 세션 1회로 알림 표시를 확인한다. 짧은 턴은 기본 억제되므로 `CLAUDE_NOTIFY_MIN_SECONDS=0 codex exec --skip-git-repo-check "Reply with exactly: PONG"`처럼 기준을 낮춰 확인한다. 어댑터 호출·rollout 매칭·시작 시각 기록까지는 실측으로 확인됐고 남은 것은 화면 표시 확인이다.
- 며칠 사용 후 완료 알림 기준 60초, 재알림 90초 간격 6회, 격상 3회째가 실사용에 맞는지 조정한다. 조정은 환경변수만 바꾸면 되고 스크립트 수정은 필요 없다.
- Codex `PermissionRequest` 훅 알림은 `approval_policy = "never"` 환경에서 승인 요청 자체가 발생하지 않아 등록하지 않았다. 승인 정책을 바꾸면 등록을 검토한다.
- 연결 프로젝트에 템플릿을 배포할 때 알림 스크립트 4종이 `managed_prefixes` 규칙대로 전달되는지 첫 설치에서 확인한다.

### 환경 호칭 개정 후속

- `signal2`: worktree `~/projects/signal2-wt-common-override`, 브랜치 `docs/common-override-cleanup`, 커밋 `f970539`가 push 없이 대기 중이다.
  - 같은 파일을 수정하는 `~/projects/signal2-wt-rule-docs`의 충돌이 해결된 뒤 변경 필요성을 재확인한다.
- `aiospace`: 브랜치 `codex/chore-u0-production-baseline`에 환경 호칭 관련 문서 2개 변경이 미커밋 상태다.
  - 기존 브랜치에 포함할지 별도 브랜치로 분리할지 결정한 뒤 진행한다.

### L3 가드레일 후속

- `warn-design-tokens.sh`도 `exit 0` + stderr 방식이라 opt-in 등록 시 경고가 모델에 도달하지 않는다. 활성화 전에 stdout JSON `additionalContext` 방식으로 수정한다.
- `block-destructive.sh`는 주석 안의 파괴 명령 문자열에도 반응할 수 있다. URL·포맷 문법의 `#`과 구분되는 안전한 제거 규칙이 필요하다.
- 자동 승인 권한 모드에서는 hook의 `permissionDecision: "ask"`가 사용자 프롬프트 없이 통과할 수 있다. 확실한 차단은 `deny` 또는 `exit 2`를 사용한다.

### 문서 편집·저장 기능

- 가이드 브라우저의 읽기 전용 탐색은 완료했다. 다음은 편집 화면과 저장 기능이다.
- 착수 전 결정: 편집 범위, 저장 방식, 새 문서 생성 허용 여부.
- 권고 기본값: 이 저장소만 · 파일만 저장 · 기존 문서 수정만.

### 디자인 라이브러리 검수

- `docs/admin-fe-preview.html`, `docs/user-fe-preview.html`, `docs/user-fe-mobile-preview.html`의 시안 5종과 light/dark·viewport 조합을 사용자 검수한다.
- 의도와 다른 부분이 확인되면 관련 카탈로그와 `DESIGN.md`, `STATE.md`를 같은 작업에서 갱신한다.

### 낮은 우선순위

- 필요하면 `docs/template-usage.md` 또는 예시 프로젝트 문서를 추가한다.
- `docs/codex-reading-order.md`와 `AGENTS.md`의 빠른 읽기 순서 중복 축소를 검토한다.
- md → HTML 자동 동기화 또는 단일 진입점 도입을 검토한다.

## 현재 기준 파일

- 운영·라우팅: `AGENTS.md`, `CLAUDE.md`, `docs/approval-workflow.md`
- 현재 상태·프로젝트 기준: `STATE.md`, `docs/project-guide.md`
- 역할·요청: `agents/`, `templates/`
- 런타임 어댑터: `.claude/`, `.codex/`
- 디자인 정본: `DESIGN.md`, `designs/`, `docs/design-guidelines.md`
- 문서 UI·검증: `scripts/build-docs-index.mjs`, `scripts/serve-docs.mjs`, `scripts/check-html.mjs`

## 주의 사항

- 이 저장소의 목적은 런타임 앱 구현이 아니라 개발 프로젝트용 에이전트 운영규칙 템플릿 관리다.
- 프로젝트별 기술·업무 기준은 소비 프로젝트의 로컬 문서에 두고 템플릿 공통 규칙과 분리한다.
- 다른 저장소의 상태는 요청 범위이거나 결과에 직접 영향을 줄 때만 보고한다.

## 알려진 TODO

- 프로젝트별 커스텀 항목 체크리스트 추가
- 세션 종료 시 상태 업데이트 예시 추가
- 필요 시 역할별 금지 사항 섹션 강화
