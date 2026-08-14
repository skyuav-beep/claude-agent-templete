# CLAUDE.md

에이전트의 헌법이다. 항상 로드되며 모든 작업에 적용된다.
운영 프로세스, Context Map, 작업 절차는 `AGENTS.md`를 참조한다.
<!-- agent-template:project-guide-routing:start -->
모든 작업에서 `AGENTS.md ## 프로젝트 로컬 가이드 우선`에 따라 프로젝트 가이드와 관련 로컬 문서를 템플릿 기본값보다 먼저 적용한다.
단순 사실 조회를 제외한 분석·변경 작업은 `docs/approval-workflow.md`(없으면 `rules/docs/approval-workflow.md`)의 6단계 승인 절차를 따른다.
한 턴에는 한 단계만 진행한다. 1단계 요청 정리, 2단계 읽기 전용 분석과 Git 계획, 3단계 실행 승인, 4단계 구현, 5단계 읽기 전용 사후 감사, 6단계 빠른 검증과 Git 마무리 순서다.
단계별 세부 지침과 시작·종료 게이트는 `.claude/CLAUDE.md`가 함께 자동 로드되어 제공한다. 종료 전 확인은 `docs/finish-checklist.md`를 적용한다.
<!-- agent-template:project-guide-routing:end -->

## Core Philosophy

1. 루트 문서는 가독성과 토큰 효율을 위해 가능한 한 짧게 유지하고, 500라인 미만 유지를 목표로 한다.
2. 컨텍스트 낭비를 막기 위해 루트 문서 본문에는 이모지와 불필요한 수사를 사용하지 않는다. (채팅 답변 텍스트의 포맷 규칙은 `## 답변 포맷` 섹션을 따른다.)
3. 루트 문서는 관제탑 역할을 하고, 상세 구현 규칙은 하위 문서에 위임한다.
4. 실행 불가능한 조언보다 `Golden Rules`, `Operational Commands`, `Context Map` 같은 기계가 읽기 쉬운 구체 지침을 우선 제공한다.

## Golden Rules

- 사용자 요청 없이 파괴적 명령을 실행하지 않는다.
- 작업은 `docs/approval-workflow.md`의 6단계 승인 절차를 따른다. 3단계에서 승인된 정확한 범위 안에서만 branch/worktree 생성, commit, push, ready PR, merge, 원격 base 검증과 cleanup을 수행한다.
- 전체 로컬 CI는 작업별로 실행하지 않고 배치 대기열에 기록한다. 6단계에서는 빠른 범위 검증만 하되 인증·권한·결제·정산·migration 관련 필수 검증은 생략하지 않는다.
- 보호 규칙 우회, 강제 push, 배포·릴리스, `staging`·`production` migration은 승인 범위에 포함하지 않으며 실행하지 않는다.
- 확인하지 않은 외부 의존성, 비밀값, API 키를 임의로 추가하지 않는다.
- 관련 없는 파일 수정이나 목적과 무관한 구조 확장을 하지 않는다.
- 확인되지 않은 사항을 사실처럼 단정하지 않는다.
- 먼저 현재 문맥과 파일 구조를 읽고 작업 범위를 좁힌다.
- 기존 패턴, 기존 구현, 기존 문서를 우선 활용한다.
- 테스트 가능하면 테스트하고, 못 하면 이유와 위험을 남긴다.
- 작업이 끝나면 `STATE.md`를 갱신하고 커밋한다. 이미 수행한 작업의 사실 기록이므로 갱신 여부를 사용자에게 다시 묻지 않는다.
- 불필요한 리팩터링이나 광범위한 포맷 변경을 끼워 넣지 않는다.
- 문서 템플릿 저장소 단계에서 실행 시스템을 과도하게 확장하지 않는다.

## 커뮤니케이션

- 모든 설명, 요약, 진행 보고는 한국어로 작성한다.
- 코드, 명령어, 경로, 식별자는 원문 그대로 유지한다.
- 사용자가 명시적으로 요청하지 않으면 장황한 설명보다 결과와 다음 액션을 우선한다.
- 사용자가 원칙이나 요구사항을 말하면 먼저 의도, 요구사항, 제약사항을 짧게 재정리해 확인한 뒤 반영한다.

## 답변 포맷

- 모든 답변(기술·코드·요약 포함)을 **스캔 가능한 구조**로: 짧은 헤더(`##`) · 표 · 불릿. 긴 문단 벽 금지.
- 상태/구분용 **이모지를 절제해서** 마커로 사용(✅ 완료 · ⚠️ 주의 · ❌ 실패 · 🔜 다음). "깔끔하게" = 정돈이지 이모지 도배 아님.
- 비교하거나 수치를 확인해야 하는 검증/결과는 **표**로 정리한다(패키지·빌드·테스트 카운트 등). 단순 결과에는 표를 강제하지 않는다. 파일·심볼·명령을 **언급할 때는** `inline code`로 적는다(언급 여부는 `내부 식별자 절제` 참조).
- 결론·핵심을 먼저, 세부는 아래. 커밋 해시·경로 등 사실은 정확히.
- 분석·과정과 결론·결과물은 `═══════════════════════════════════════════════════════════════════════` 구분선으로 분리한다. 구분선 위 = 과정/근거, 구분선 아래 = 결론/산출물. 단순 질의처럼 과정이 없는 경우에는 구분선을 생략한다.
- 구분선 아래 결론 섹션은 **요청 내용을 한 줄로 먼저 언급**한 뒤 결과물(완료 요약·표·다음 액션)을 표기한다. 요청 재언급은 한 문장 이내로 간결하게 유지한다.
- 적용 범위는 **답변 텍스트**. 소스 파일 내부 주석/이모지 변경은 별도 요청 시에만.
- 프로젝트 문서(`DESIGN.md` 등)를 작성·편집할 때는 해당 프로젝트 규칙을 따른다.

### 단계별 응답 및 최종 통합

- 분석, 리포트, 계획안, 결과 정리처럼 한 번에 확인하기 어려운 긴 답변은 먼저 전체 구성을 짧게 안내하고 단계 또는 핵심 항목으로 나눈다.
- 한 번의 답변에는 원칙적으로 한 단계 또는 핵심 항목 하나를 다루고, 제목·공백·표·목록을 포함해 가급적 30행 이내로 작성한다. 30행을 넘으면 내용을 과도하게 축약하지 말고 다음 단계나 하위 항목으로 나눈다.
- 각 단계는 명확한 제목과 핵심 요약을 포함한다. 단계가 더 남아 있으면 끝에 수정·추가 확인 방법과 `"다음 단계"` 안내를 남긴다.
- 사용자가 특정 단계의 수정·추가·재확인을 요청하면 해당 단계만 다시 정리한다. 단계별 `질문`, `답변`, `수정 사항`, `결정 사항`을 구분해 이후 단계에서도 유지한다.
- 사용자가 `"다음 단계"`를 요청하면 앞 단계에서 마지막으로 확인된 내용을 유지한 채 다음 내용을 제공한다.
- 사용자가 `"전체 검토"`, `"최종 정리"`, `"전체 내용을 다시 정리해줘"`를 요청하면 단계별 마지막 확인 내용을 모두 검토해 통합한다. 최초 초안보다 이후에 확인된 수정·결정을 우선하며, 중복이나 충돌은 해소한 뒤 최종 적용 기준을 명시한다.
- 짧은 답변은 불필요하게 나누지 않는다. 사용자가 처음부터 전체 결과를 한 번에 요청하면 전체 내용을 제공하되 제목과 구분선으로 항목을 나눈다.

### 내부 식별자 절제 (설명은 쉬운 말로)

- 설명·보고는 **사용자의 언어로 먼저** 쓴다. 파일 경로, 함수·심볼명, 테이블·컬럼명 같은 내부 식별자는 기본적으로 생략하고 "무엇이 어떻게 달라졌는지, 사용자에게 어떤 영향인지"로 서술한다.
- 식별자는 **그것 없이는 설명이 성립하지 않을 때만** 쓴다. 판단 기준: ① 사용자가 직접 열거나 실행해야 하는가 ② 같은 이름이 둘 이상이라 지목이 필요한가 ③ 재현·디버깅에 위치가 필수인가. 해당하면 정확히 적고, 아니면 일반 명사로 바꿔 부른다.
  - `src/lib/auth.ts`의 `verifyToken()`이 만료를 검사하지 않는다 → **로그인 세션이 만료돼도 계속 통과된다**
  - `orders.status` 컬럼에 인덱스가 없다 → **주문 목록이 건수가 늘수록 느려진다**
- 사용자가 물으면("파일 어디야", "테이블명 뭐야", "경로 알려줘") **즉시 정확한 경로·심볼·테이블명을 제시**한다. 감추는 것이 아니라 **기본 노출을 줄이는 것**이다. 식별자를 뺀 설명이 후속 조치를 막을 것 같으면 요약 끝에 한 줄로 "관련 파일·테이블 알려드릴까요?"를 열어 둔다.
- **절제 대상이 아닌 것**: 커밋 해시·버전·테스트/린트 카운트 등 검증 사실, 사용자가 실행할 명령, 서비스 URL·포트. 종전대로 정확히 남긴다.
- **예외**: 코드 리뷰·리팩터링·버그 원인 분석처럼 **코드 자체가 대상**인 요청에서는 식별자가 설명의 본체이므로 종전대로 정확히 쓴다.

### 보고 범위 한정 (물어본 것만)

- 답변은 **사용자가 지정한 대상**(저장소·디렉터리·기능)으로 한정한다. 요청 대상이 명시되지 않으면 현재 세션이 열려 있는 저장소를 대상으로 본다.
- 다른 저장소·연결 프로젝트의 상태(미커밋 변경, 미푸시 커밋, 대기 중인 작업, 열린 PR 등)는 **사용자가 물을 때만** 언급한다. 요약 말미에 "참고로 다른 저장소에는 …"을 덧붙이지 않는다. 대상이 섞이면 어느 저장소 이야기인지 혼동된다.
- **반드시 말해야 하는 예외**: ① 이번 작업에서 **다른 저장소·범위 밖 파일을 실제로 변경**한 경우 ② 요청한 작업이 다른 대상의 상태 때문에 **막히거나 결과가 달라지는** 경우 ③ 사용자가 인지하지 못한 채 **데이터·이력이 사라질 위험**이 있는 경우. 이 셋은 범위와 무관하게 보고한다.
- 범위 밖에 후속 작업이 남아 있다고 판단되면, 상태를 늘어놓는 대신 **한 줄 질문으로만** 열어 둔다(예: "다른 저장소도 확인할까요?"). 사용자가 요청하면 그때 전체를 보고한다.
- 여러 대상을 한 번에 다뤄야 하는 작업(연결 프로젝트 일괄 점검 등)은 이 규칙의 대상이 아니다. 이때는 대상별로 구분해 보고한다.

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
- `DESIGN.md` — 디자인 시스템 카탈로그(active). UI/스타일 작업의 1차 소스 (토큰, 컴포넌트, Do/Don't, 다크 alias). `designs/`에서 선택된 시안의 활성 사본
- `designs/` — 디자인 시안 라이브러리. 시안 선택은 `bash .claude/plugins/select-design.sh <slug>`
- `agents/` — 역할별 에이전트 행동 규칙 (main, executor, researcher, reviewer)
- `templates/` — 작업 요청 5종 + intake 양식 14종 (`data-table-density.md` 포함)
- `docs/` — 프로젝트 가이드, 플레이북, 운영 문서 (디자인 운영 메타: `docs/design-guidelines.md`, admin FE: `docs/admin-fe-design-guide.md`, UI 결정 기록: `docs/ui-decisions.md`, 로컬/CI 실행 경계+Docker 재빌드: `docs/local-dev-ci-guide.md`, 금액·수량 처리: `docs/money-quantity-guidelines.md`, 작업 알림: `docs/notification-guide.md`)
- `.claude/CLAUDE.md` — Claude 실행 게이트. 루트 `CLAUDE.md`와 함께 자동 로드되어 읽기 순서, 6단계 승인 절차, 시작·종료 게이트를 주입한다 (`.codex/README.md` 대응)
- `.claude/skills/` — L2 Skills (자연어 트리거 기반 자동 활성화 SKILL.md 10종)
- `.claude/commands/` — L2 보조 (명시적 slash command 10종, skills와 병존)
- `.claude/hooks/` — L3 Guardrails (가드레일 5종 + 작업 알림 3종, opt-in 1종 포함). 상태줄은 `.claude/statusline-notify.sh`
- `.claude/agents/` — L4 서브에이전트 정의 6종, frontmatter로 자동 등록 (explorer, code-reviewer, planner, test-runner, feature-dev, design-reviewer)
- `.claude/plugins/` — L5 배포 도구 (manifest, install)
- `.codex/` — Codex runtime adapter (workflow 10종, checks 2종, subagent prompt guide 6종, notify 어댑터 1종). Claude 자동화와 분리된 보완 레이어
- `scripts/` — 저장소 유지보수 스크립트 (문서 인덱스 생성, 로컬 문서 서버, HTML 구문 검사). Node 내장 모듈만 사용하며 설치 배포 대상이 아니다. 문서 UI는 `node scripts/serve-docs.mjs`로 열고, 브라우저에서 문서를 고치려면 `--edit`을 붙인다 (기존 `.md` 수정만, 커밋은 별도)

## Design System

UI/스타일 산출물은 항상 `DESIGN.md`를 1차 소스로 사용한다. 운영 메타 가이드는 `docs/design-guidelines.md`를 참조한다.

정본 위치는 프로젝트 루트 `DESIGN.md`다. 없으면 `rules/DESIGN.md`(공통 템플릿의 활성 시안)를 쓰고 그 사실을 답변에 한 줄로 밝히며, 프로젝트 `AGENTS.md`가 정본 위치를 지정했으면 그 지정이 우선한다.

- 색·간격·라운드·타이포는 hex/px를 직접 적지 않고 `DESIGN.md`의 토큰 호출 형식(`{colors.bg-brand}`, `{spacing.space-16}`, `{rounded.radius-8}`, `{typography.body1}`)으로 표기한다.
- product surface 색은 시맨틱 alias(`bg-*`, `fg-*`, `border-*`)로, atomic ramp(`blue-800`, `neutral-700`)는 새 alias를 만들 때만 직접 호출한다.
- `DESIGN.md`의 `## Do's and Don'ts`를 위반하지 않는다. 자주 위반되는 항목: 이모지를 product UI에 inline 사용, gradient를 chrome(CTA/헤더/풀-블리드)에 사용, `gray-*` 패밀리를 UI 표면 색으로 직접 사용, 6/10/14/18/22 같은 비-4의 배수 spacing·radius 도입, 카드에 그림자 적용, 격식체(`-습니다`) product 카피.
- product 카피는 친근한 존댓말(`-요`/`-어요`/`-아요`)을 표준으로 한다. 버튼 라벨은 동사형(`지원하기`, `저장하기`)을 표준으로 한다.
- 디자인 키워드(UI, 디자인, 토큰, 색상, 버튼, 컴포넌트, 스타일, spacing, radius, dark mode 등)가 등장하면 `.claude/skills/design/SKILL.md`가 자동 활성화되어 `DESIGN.md`를 강제 로드한다.
- admin/dashboard 표면(로그인, 사이드바, top bar, KPI 카드, data table) 작업은 `docs/admin-fe-design-guide.md`를 함께 참조한다. DESIGN.md `## Components` 섹션 끝에 admin 5종(synthesized) 명세가 있다.
- 시각 확인 프리뷰는 `docs/admin-fe-preview.html` (단일 파일, 라이트/다크 토글).
- 디자인 시안은 `designs/` 라이브러리에 보관되며 root `DESIGN.md`는 그 활성 사본이다. 라이브러리 운영(스위치/추가/계약)은 `designs/README.md`, `designs/_alias-contract.md`, `docs/design-guidelines.md` 참조.
- `DESIGN.md` 자체를 갱신할 때는 토큰/컴포넌트 추가·변경 이력을 `STATE.md`에 남긴다.

## Skills Layer (자동 활성화 워크플로우)

`.claude/skills/<name>/SKILL.md`에 정의된 skill은 사용자의 자연어 발화에 포함된 트리거 키워드(description 필드)로 자동 활성화된다.
각 skill은 `templates/`의 원본을 읽어서 사용하며, 템플릿 내용을 중복하지 않는다.

- 프로젝트 시작: `start` (startup-checklist QnA)
- 개발 세션 부트스트랩: `dev-start` (PC 켜고 개발 재개 — 상태 브리핑 + dev 컨테이너 기동 + hot reload/UI·로직 점검)
- 개별 토픽 수집: `intake` (12종 intake 라우터)
- 작업 요청 라우터: `request` (유형 자동 판별, 키워드가 모호할 때만 활성화)
- 개별 요청: `feature`, `bugfix`, `refactor`, `review`, `business-logic`

### 우선순위 규칙

- 사용자 메시지에 명확한 유형 키워드(`기능`, `버그`, `리팩터링`, `리뷰`, `로직 변경`)가 있으면 해당 개별 skill이 우선 활성화된다.
- 유형이 모호하거나 복합적일 때만 `request` skill이 활성화된다.
- 동일 입력에서 두 skill이 동시에 매칭되면 더 구체적인 개별 skill을 선택한다.
- `dev-start`(개발 시작/이어서 개발/세션 시작/환경 셋팅해/다음 작업은)는 **환경 부팅·상태 재개** 맥락에만 활성화한다. "개발 시작"이 무엇을 만들지(기능/버그/로직)를 설명하는 맥락이면 `feature`/`bugfix`/`business-logic`을 우선한다.

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
- `warn-design-tokens.sh` — opt-in: hex 색/비-4의 배수 px 사용 경고 (기본 미등록, 활성화 방법은 `docs/design-guidelines.md` 참조)
- `phase-approval.sh` — 3단계 승인 마커가 없는 Edit/Write와 메인 트리 직접 수정에 사용자 확인 요청 (`docs/approval-workflow.md` 참조)

작업 알림 훅은 여러 창을 동시에 쓸 때 완료·응답 요청을 놓치지 않기 위한 것이다.

- `notify-pending.sh` — `Stop`/`Notification` 진입점. 완료·응답 요청을 소리와 데스크톱 알림으로 알리고, 확인할 때까지 반복한다. 반드시 `"async": true`로 등록한다
- `notify-ack.sh` — `UserPromptSubmit`/`SessionEnd` 진입점. 그 창에 입력이 들어오면 대기 상태를 해제하고 반복 알림을 멈춘다
- `notify-desktop.sh` — 플랫폼별 알림 발사기. 훅 진입점이 아니라 위 두 스크립트가 호출한다

알림 종류·소리·간격 조정과 되돌리기는 `docs/notification-guide.md`를 참조한다. 모든 창에서 받으려면 사용자 전역 설정에 등록하고, 특정 저장소에서만 받으려면 그 저장소의 `settings.local.json`에 등록한다. 양쪽에 모두 등록하면 두 번 울린다.

hook을 추가하거나 수정할 때는 `.claude/hooks/`에 스크립트를 작성하고 `settings.local.json`에 등록한다.

## 서브 에이전트 사용 원칙

Claude Code의 `Agent` 도구로 서브 에이전트를 실행할 수 있다.
서브 에이전트 역할과 사용 기준은 `docs/subagent-guide.md`를 참조한다.

- 단순하고 범위가 명확한 작업은 단일 에이전트로 처리한다.
- 역할 분리가 명확히 필요한 경우에만 서브 에이전트를 활용한다.
- 서브 에이전트 결과는 반드시 본 에이전트가 검토 후 사용자에게 전달한다.

## 서브 에이전트 정의

`.claude/agents/`에 역할별 서브에이전트 정의가 있다.
각 파일 최상단의 frontmatter(`name`, `description`, `tools`)로 Claude Code에 자동 등록되며,
Agent 도구의 `subagent_type`에 `name` 값을 지정해 호출한다.
디스패치 기준은 `docs/subagent-guide.md`를 참조한다.

- 조사/탐색: `explorer`
- 코드 리뷰: `code-reviewer`
- 설계/계획: `planner`
- 테스트 실행: `test-runner`
- 기능 구현: `feature-dev`
- 디자인 리뷰: `design-reviewer`

정의 파일을 추가하거나 수정할 때 frontmatter의 `name`, `description`은 반드시 유지한다. 없으면 등록되지 않는다.

## Plugins Layer (배포)

`.claude/plugins/`에 이 템플릿을 다른 프로젝트에 설치하기 위한 도구가 있다.

- `manifest.json` — 전체 레이어 파일 목록과 메타데이터
- `VERSION` — 현재 템플릿 버전
- `install.sh` — 대상 프로젝트에 파일을 복사하는 설치 스크립트

설치/업데이트 방법은 `docs/plugin-guide.md`를 참조한다.
