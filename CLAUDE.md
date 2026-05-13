# CLAUDE.md

에이전트의 헌법이다. 항상 로드되며 모든 작업에 적용된다.
운영 프로세스, Context Map, 작업 절차는 `AGENTS.md`를 참조한다.

## Core Philosophy

1. 루트 문서는 가독성과 토큰 효율을 위해 가능한 한 짧게 유지하고, 500라인 미만 유지를 목표로 한다.
2. 컨텍스트 낭비를 막기 위해 이모지와 불필요한 수사는 사용하지 않는다.
3. 루트 문서는 관제탑 역할을 하고, 상세 구현 규칙은 하위 문서에 위임한다.
4. 실행 불가능한 조언보다 `Golden Rules`, `Operational Commands`, `Context Map` 같은 기계가 읽기 쉬운 구체 지침을 우선 제공한다.

## Golden Rules

- 사용자 요청 없이 파괴적 명령을 실행하지 않는다.
- 확인하지 않은 외부 의존성, 비밀값, API 키를 임의로 추가하지 않는다.
- 관련 없는 파일 수정이나 목적과 무관한 구조 확장을 하지 않는다.
- 확인되지 않은 사항을 사실처럼 단정하지 않는다.
- 먼저 현재 문맥과 파일 구조를 읽고 작업 범위를 좁힌다.
- 기존 패턴, 기존 구현, 기존 문서를 우선 활용한다.
- 테스트 가능하면 테스트하고, 못 하면 이유와 위험을 남긴다.
- 작업이 끝나면 `STATE.md`를 갱신한다.
- 불필요한 리팩터링이나 광범위한 포맷 변경을 끼워 넣지 않는다.
- 문서 템플릿 저장소 단계에서 실행 시스템을 과도하게 확장하지 않는다.

## 커뮤니케이션

- 모든 설명, 요약, 진행 보고는 한국어로 작성한다.
- 코드, 명령어, 경로, 식별자는 원문 그대로 유지한다.
- 사용자가 명시적으로 요청하지 않으면 장황한 설명보다 결과와 다음 액션을 우선한다.
- 사용자가 원칙이나 요구사항을 말하면 먼저 의도, 요구사항, 제약사항을 짧게 재정리해 확인한 뒤 반영한다.

## Architecture Rules

<!-- CUSTOMIZE: 프로젝트 아키텍처에 맞게 수정 -->
- 이 저장소는 문서 중심 템플릿이다. 런타임 코드는 없다.
- 루트 문서(`CLAUDE.md`, `AGENTS.md`)는 관제탑 역할. 세부 규칙은 하위 문서에 위임한다.
- 5-Layer 구조: L1(CLAUDE.md) > L2(Skills) > L3(Hooks) > L4(Subagents) > L5(Plugins)
- 공통 규칙과 프로젝트별 규칙은 반드시 분리한다.
- `agents/`는 역할별 행동 규칙, `templates/`는 요청/intake 양식, `docs/`는 가이드/플레이북.

## Naming Conventions

<!-- CUSTOMIZE: 프로젝트 코딩 컨벤션에 맞게 수정 -->
- 파일명: kebab-case (예: `feature-request.md`, `block-destructive.sh`)
- 디렉터리명: kebab-case 단수형 (예: `agents/`, `templates/`, `docs/`)
- Markdown 제목: `##` 레벨부터 시작, `#`은 파일 제목에만 사용
- 커맨드명: kebab-case (예: `/business-logic`, `/feature`)
- 한글 문서 내 영문 용어: backtick으로 감싸기 (예: `Golden Rules`)

## Test Expectations

<!-- CUSTOMIZE: 프로젝트 테스트 정책에 맞게 수정 -->
- 코드나 설정을 바꿨다면 가능한 범위에서 작은 검증 스크립트, 테스트, 정적 확인을 먼저 시도한다.
- 수동 확인보다 시스템적으로 검증 가능한 작은 테스트를 선호한다.
- 환경 문제로 테스트를 못 돌린 경우 그 사유를 마지막 응답에 명확히 남긴다.
- 문서 작업이라면 구조, 역할 구분, 재사용 가능성을 기준으로 검토한다.
- 테스트 명령: (예: `npm test`, `pytest` — 프로젝트에 맞게 기재)
- 테스트 작성 기준: (예: 새 기능에는 단위 테스트 필수 — 프로젝트에 맞게 기재)

## Repo Map

<!-- CUSTOMIZE: 프로젝트 구조에 맞게 수정 -->
- `CLAUDE.md` — 에이전트 헌법 (항상 로드됨)
- `AGENTS.md` — 운영 프로세스, Context Map 라우팅, 작업 절차
- `STATE.md` — 현재 상태, 세션 인계 정보
- `agents/` — 역할별 에이전트 행동 규칙 (main, executor, researcher, reviewer)
- `templates/` — 작업 요청 5종 + intake 양식 13종
- `docs/` — 프로젝트 가이드, 플레이북, 운영 문서
- `.claude/skills/` — L2 Skills (자연어 트리거 기반 자동 활성화 SKILL.md 8종)
- `.claude/commands/` — L2 보조 (명시적 slash command 8종, skills와 병존)
- `.claude/hooks/` — L3 Guardrails (가드레일 스크립트 3종)
- `.claude/agents/` — L4 서브에이전트 프롬프트 템플릿 3종
- `.claude/plugins/` — L5 배포 도구 (manifest, install)

## Skills Layer (자동 활성화 워크플로우)

`.claude/skills/<name>/SKILL.md`에 정의된 skill은 사용자의 자연어 발화에 포함된 트리거 키워드(description 필드)로 자동 활성화된다.
각 skill은 `templates/`의 원본을 읽어서 사용하며, 템플릿 내용을 중복하지 않는다.

- 프로젝트 시작: `start` (startup-checklist QnA)
- 개별 토픽 수집: `intake` (12종 intake 라우터)
- 작업 요청 라우터: `request` (유형 자동 판별, 키워드가 모호할 때만 활성화)
- 개별 요청: `feature`, `bugfix`, `refactor`, `review`, `business-logic`

### 우선순위 규칙

- 사용자 메시지에 명확한 유형 키워드(`기능`, `버그`, `리팩터링`, `리뷰`, `로직 변경`)가 있으면 해당 개별 skill이 우선 활성화된다.
- 유형이 모호하거나 복합적일 때만 `request` skill이 활성화된다.
- 동일 입력에서 두 skill이 동시에 매칭되면 더 구체적인 개별 skill을 선택한다.

### Skill 연계 흐름

- `start` 완료 후 -> 사용자가 토픽명을 말하면 `intake`, 작업 설명이 있으면 `request` 또는 개별 skill이 자연스럽게 이어진다.
- `request`에서 유형이 확정되면 -> 해당 개별 skill 흐름으로 즉시 전환한다.

### 명시적 호출 (slash command)

`.claude/commands/`에 동일 이름의 slash command가 병존한다. 사용자가 `/start`, `/feature` 등을 직접 입력해 명시적으로 호출할 수 있다.
- skills: 자연어 키워드로 자동 활성화 (description 트리거 기반)
- commands: 사용자가 직접 슬래시 입력으로 호출

상세는 `.claude/skills/`와 `.claude/commands/` 디렉터리를 참조한다.

## Hooks Layer (가드레일)

`.claude/hooks/`에 정의된 셸 스크립트가 도구 실행 전에 자동으로 동작한다.
설정은 `.claude/settings.local.json`의 `hooks` 섹션에 등록되어 있다.

- `block-destructive.sh` — `rm -rf`, `git reset --hard`, `git push --force`, `git clean -f` 등 파괴적 명령 차단
- `block-secret-files.sh` — `.env`, `*.pem`, `*.key`, `credentials.json` 등 비밀 파일 쓰기 차단
- `state-reminder.sh` — `git commit` 시 STATE.md 미갱신 경고 (차단하지 않음)

hook을 추가하거나 수정할 때는 `.claude/hooks/`에 스크립트를 작성하고 `settings.local.json`에 등록한다.

## 서브 에이전트 사용 원칙

Claude Code의 `Agent` 도구로 서브 에이전트를 실행할 수 있다.
서브 에이전트 역할과 사용 기준은 `docs/subagent-guide.md`를 참조한다.

- 단순하고 범위가 명확한 작업은 단일 에이전트로 처리한다.
- 역할 분리가 명확히 필요한 경우에만 서브 에이전트를 활용한다.
- 서브 에이전트 결과는 반드시 본 에이전트가 검토 후 사용자에게 전달한다.

## 서브 에이전트 템플릿

`.claude/agents/`에 역할별 프롬프트 템플릿이 있다.
Agent 도구를 호출할 때 해당 템플릿을 읽어 프롬프트에 포함한다.
디스패치 기준은 `docs/subagent-guide.md`를 참조한다.

- 조사/탐색: `.claude/agents/explorer.md` (Explore 타입)
- 리뷰/점검: `.claude/agents/reviewer.md` (general-purpose 타입)
- 설계/계획: `.claude/agents/planner.md` (Plan 타입)

## Plugins Layer (배포)

`.claude/plugins/`에 이 템플릿을 다른 프로젝트에 설치하기 위한 도구가 있다.

- `manifest.json` — 전체 레이어 파일 목록과 메타데이터
- `VERSION` — 현재 템플릿 버전
- `install.sh` — 대상 프로젝트에 파일을 복사하는 설치 스크립트

설치/업데이트 방법은 `docs/plugin-guide.md`를 참조한다.
