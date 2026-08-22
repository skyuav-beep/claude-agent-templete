# AGENTS.md

## 목적

이 저장소는 개발 프로젝트를 진행할 때 에이전트가 따라야 할 공통 운영 규칙과 작업 방식을 정의하는 템플릿이다.

이 저장소의 에이전트는 다음 목표를 우선한다.

- 사용자의 요청을 빠르게 구현 가능한 형태로 구체화한다.
- 불필요한 추측보다 현재 저장소 상태와 실행 가능한 근거를 우선한다.
- 작은 변경으로 시작하되, 실행과 검증까지 가능한 단위로 마무리한다.
- 작업이 끝난 뒤 다음 작업자가 이어받을 수 있도록 상태를 명확히 남긴다.

에이전트 헌법(Core Philosophy, Golden Rules, 커뮤니케이션, 검증 원칙, Architecture Rules, Naming Conventions, Repo Map)은 `CLAUDE.md`에 정의되어 있다. 이 파일은 운영 프로세스, 라우팅, 작업 절차를 다룬다.

## 공통 응답 정책 로딩

- Claude Code와 Codex를 포함한 모든 런타임은 작업 시작 시 `CLAUDE.md ## 커뮤니케이션`과 `## 답변 포맷`을 반드시 읽고 답변에 적용한다.
- 긴 답변의 단계 분할, 30행 권고, 단계별 확인 내용 유지, 최종 통합 기준의 정본은 `CLAUDE.md ### 단계별 응답 및 최종 통합`이다.
- 런타임별 skill, workflow, agent 문서는 이 정책을 중복 정의하지 않고 정본을 참조한다.

<!-- agent-template:project-guide-routing:start -->
## 프로젝트 로컬 가이드 우선

- 모든 작업은 `docs/project-guide.md`가 있으면 반드시 읽고, 현재 작업 영역의 하위 `AGENTS.md`와 관련 `docs/*.md`도 확인한다.
- 적용 우선순위는 상위 런타임 규칙과 사용자의 최신 요청을 먼저 따르고, 그 범위 안에서 `프로젝트 로컬 가이드 및 더 구체적인 하위 문서 > 템플릿 기본값`으로 한다.
- 프로젝트 로컬 가이드가 템플릿 기본값과 충돌하면 프로젝트 기준을 적용하고, 어떤 기준을 선택했는지 작업 보고에 남긴다.
- `docs/project-guide.md`가 없거나 초기 템플릿 상태이면 관련 프로젝트 문서와 실제 구현을 우선 확인하고, 템플릿 기본값을 fallback으로 사용하며 가이드 작성 또는 갱신 필요를 알린다.
- `.claude/*`와 `.codex/*`는 실행 어댑터다. 프로젝트 기술·업무 기준을 자체적으로 재정의하지 않고 이 섹션의 우선순위를 따른다.
- **경로 해석(rules/ fallback)**: skill·command·workflow·agent guide가 지시하는 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다(공통 템플릿을 `rules/` symlink로 연결한 프로젝트). 프로젝트에 같은 파일이 있으면 항상 프로젝트 쪽이 우선이며, 공통본을 대신 읽었으면 그 사실을 작업 보고에 한 줄로 남긴다.

## 6단계 승인 절차

- 단순 사실 조회를 제외한 분석·변경 작업은 `docs/approval-workflow.md`를 정본으로 적용한다. 프로젝트 루트에 없으면 `rules/docs/approval-workflow.md`를 읽는다.
- 1단계 요청 정리 → 2단계 읽기 전용 분석과 작업 브랜치·worktree·Git 수명주기 계획 → 3단계 명시 승인 → 4단계 구현 → 5단계 읽기 전용 사후 감사 → 6단계 빠른 검증·STATE·commit·push·ready PR·merge·원격 base 검증·브랜치/worktree 정리 순서를 지킨다.
- 한 턴에는 한 단계만 진행한다. 3단계에서 2단계에 명시한 전체 Git 수명주기를 승인받은 경우 4~6단계의 `STATE.md` 기록과 Git 작업을 다시 묻지 않지만, 범위 확대·보호 규칙 우회·배포·원격 migration은 별도 승인 대상이거나 실행 금지다.
- 전체 로컬 CI는 매 작업에서 제외하고 3~5개 작업 누적, 하루 종료, 릴리스 전 또는 사용자 요청 시 배치 실행한다. 6단계에서는 5분 이내의 변경 범위 검증만 수행하고 미실행 전체 CI를 `STATE.md`에 기록한다. 인증·권한·결제·정산·migration 관련 필수 검증은 미루지 않는다.
<!-- agent-template:project-guide-routing:end -->

## Execution Protocol

프로젝트를 분석한 뒤에는 다음 순서로 문서를 만들고 갱신한다.

1. 프로젝트 시작 전에는 intake 템플릿으로 목표, 범위, UI, 반응형, 기술 스택 정보를 먼저 수집한다.
2. 수집된 답변은 확정 사항, 미정 사항, 제약 사항, 우선순위로 정리한다.
3. 정리된 내용을 바탕으로 `docs/project-guide.md`를 프로젝트 전용 가이드 정본으로 작성한다.
4. 루트 `AGENTS.md`에는 공통 원칙, 운영 명령, 라우팅 규칙만 유지하고 세부 규칙은 하위 문서에 위임한다.
5. 역할별 세부 규칙은 `agents/` 아래 문서로 분리한다.
6. 작업 요청 형식은 `templates/` 아래 문서로 분리한다.
7. 현재 상태와 다음 작업은 `STATE.md`에 기록한다.
8. 사용자 입력·개념·백서·요구사항·설계·개발계획은 `docs/knowledge-management-guide.md`의 분류와 명명 규칙으로 보관한다.
9. 규칙이 실제 작업 방식과 어긋나면 루트 문서 또는 하위 문서 업데이트를 제안한다.

## Project Context & Operations

### 비즈니스 목표 및 Tech Stack 요약

- 이 저장소의 목적은 `개발용 에이전트 운영규칙 템플릿`을 제공하는 것이다.
- 현재 단계의 핵심 산출물은 실행 애플리케이션이 아니라 `AGENTS.md`, `STATE.md`, 역할별 지침, 요청 템플릿이다.
- 기본 Tech Stack은 문서 중심 저장소이며, 필요 시 이후 실제 프로젝트 스택에 맞게 커스텀한다.

### Operational Commands

- 현재 저장소는 문서 템플릿 저장소이므로 필수 빌드 명령은 없다.
- 새 프로젝트로 복제된 뒤에는 루트 `AGENTS.md`에 반드시 실제 실행 명령을 명시한다.
- 예시: `npm run dev`, `npm test`, `pnpm lint`, `python -m pytest`, `uv run pytest`
- 로컬 검증은 Docker Desktop으로 진행한다. 개발 컨테이너와 Docker 재빌드 기준은 `docs/local-dev-ci-guide.md §2`를 따르고, Git 작업 경계는 `docs/approval-workflow.md`를 따른다.
- 환경 호칭은 `local`(현재 PC의 Docker 개발환경) / `staging`(원격 검증 서버) / `production`(원격 운영 서버) 3-tier로 통일한다(정의: `docs/local-dev-ci-guide.md §0`). migration은 `local`에만 자동 적용(명령명이 아니라 `DATABASE_URL` 연결 대상으로 판단)하고, "dev" 단독 표기와 원격 환경의 `develop` 호칭은 쓰지 않는다.
- 개발 세션 시작(PC 켜고 재개) 시 `docs/local-dev-ci-guide.md §2.0` 부트스트랩을 따른다 — 상태 브리핑 → `docker compose up -d`(항상, 멱등) → hot reload·UI/로직 점검. `dev-start` skill 또는 `/dev-start`로 호출.

## 요청 해석 규칙

- 먼저 사용자의 요청에서 `목표`, `산출물`, `제약`, `우선순위`를 분리해서 이해한다.
- 요청이 모호하면 1단계에서 범위를 정리하고, 2단계 읽기 전용 분석 뒤 3단계에서 실행 범위를 승인받는다.
- 파괴적 변경, 구조 변경, 범위가 큰 리팩터링은 수행 전에 반드시 재확인한다.
- 요청이 문서 수정인지 코드 수정인지, 또는 둘 다인지 먼저 구분한다.

## 빠른 읽기 순서

### 공통 시작

1. `AGENTS.md`
2. `CLAUDE.md`의 `## 커뮤니케이션`, `## 답변 포맷`
3. `STATE.md`
4. `docs/project-guide.md`가 있으면 해당 문서
5. 현재 작업 영역의 하위 `AGENTS.md`와 관련 `docs/*.md`
6. `README.md`

### 작업 유형별 추가 문서

- 구현/문서 수정: `agents/executor-agent.md`
- 조사/근거 수집: `agents/researcher-agent.md`
- 리뷰/리스크 점검: `agents/reviewer-agent.md`
- 신규 프로젝트 시작: `templates/startup-checklist.md`
- 요청 구조화: 관련 `templates/*.md`
- 개발 기준 작성: 관련 `docs/*.md`

## 작업 시작 전 프로토콜

### 새 프로젝트 시작 시

새 프로젝트 작업을 시작할 때는 `templates/startup-checklist.md`를 따라 사용자에게 QnA를 진행한다.

1. startup-checklist의 섹션을 순서대로 사용자에게 질문한다.
2. 각 섹션이 끝나면 확정 / 미정 / 제외로 분류해서 요약한다.
3. 전체 QnA가 끝나면 결과 요약을 작성하고 다음 액션을 제안한다.
4. 확정된 기술 스택은 이 파일의 `Operational Commands` 섹션에 반영한다.
5. 수집된 내용 전체는 `docs/project-guide-template.md` 구조를 참고해 `docs/project-guide.md`에 작성한다.

### 개발 세션 재개 시 (PC 켜고 시작)

사용자가 "개발 시작 / 이어서 개발 / 세션 시작 / 환경 셋팅해 / 다음 작업은" 류로 개발을 재개하면 `dev-start` skill이 활성화된다. `docs/local-dev-ci-guide.md §2.0` 부트스트랩 절차(상태 브리핑 → dev 컨테이너 `up -d` 기동 → hot reload·UI/로직 점검)를 수행한 뒤, `STATE.md ## 다음 작업`부터 이어간다.

### 기존 프로젝트 작업 시

1. 현재 파일 구조와 핵심 문서를 확인한다.
2. `AGENTS.md`, `STATE.md`, 관련 문서 또는 구현체를 먼저 읽는다.
3. `rg`, `rg --files` 같은 도구로 기존 구현 또는 중복 파일 존재 여부를 검색한다.
4. 수정 대상과 비수정 대상을 구분한다.
5. 수행 결과로 어떤 파일이 바뀌어야 하는지 예상한다.

## 세부 규칙 위임

- 역할별 행동 규칙은 `agents/*.md`를 우선 참조한다.
- 요청 형식과 수집 질문은 `templates/*.md`를 우선 참조한다.
- 프로젝트별 기술 기준과 플레이북은 `docs/*.md`를 우선 참조한다.
- 코딩 관련 사용자의 입력은 `공통 코딩 원칙`, `역할별 행동 규칙`, `작업 유형별 절차`, `프로젝트별 기술 규칙`, `보류 아이디어` 중 무엇인지 먼저 분류한다.
- 여러 성격이 섞여 있으면 하나의 문서에 몰아넣지 말고 목적에 따라 분리 저장한다.
- 프로젝트에 종속적인 기술 선택은 템플릿 공통 규칙이 아니라 프로젝트 문서로 분리한다.
- 공통 규칙과 실제 작업 방식의 괴리가 생기면 루트 문서 또는 하위 문서 업데이트를 제안한다.

## HTML UI 운영 규칙

- 에이전트가 참조하는 1차 소스는 항상 `*.md` 문서다. `docs/*.html`은 사람이 보는 보조 화면이다.
- md 내용이 바뀌면 HTML UI도 함께 갱신하거나, 어긋난 사실을 STATE.md `알려진 TODO`에 남긴다.
- HTML UI에서 사용자가 입력한 값은 사용자의 브라우저 `localStorage`에만 저장된다. 저장소(repo)에는 반영되지 않으므로 결과는 사용자가 별도로 Markdown으로 내보내 커밋한다.
- 예외는 가이드 브라우저의 편집 모드다. `node scripts/serve-docs.mjs --edit`으로 띄웠을 때만 열리며, 이 저장소 안의 기존 `.md` 파일을 직접 수정한다. 신규 생성·삭제는 하지 않고 commit도 하지 않으므로 저장 후 승인 절차에 따라 별도로 커밋한다. 플래그 없이 실행하면 종전대로 읽기 전용이다.
- HTML UI는 외부 의존성 없는 단일 파일을 유지한다. 빌드 시스템, 번들러, 외부 CDN 의존성을 추가하지 않는다.

## 문서화 원칙

- 새로운 기능, 스크립트, 설정을 추가하면 필요한 최소 문서를 함께 갱신한다.
- 하나의 논리적 작업이 끝나면 6단계에서 `STATE.md`를 갱신한 뒤 승인된 파일만 stage하고 commit한다. 이 기록은 3단계 승인에 포함되므로 매 작업마다 갱신 여부를 다시 확인하지 않는다(`docs/approval-workflow.md ## 재확인하지 않는 작업`).
- commit·push·PR·머지·브랜치/worktree 정리는 3단계에서 승인된 Git 수명주기 범위 안에서만 수행한다. 상세 게이트와 전체 CI 배치 정책은 `docs/approval-workflow.md`와 `docs/local-dev-ci-guide.md §6`을 따른다.
- 초안 단계 문서는 이후 확장 가능하도록 짧고 명확하게 유지한다.
- TODO는 실행 가능한 문장으로 남긴다.
- 역할별 규칙은 공통 규칙과 중복하지 말고 차이점만 적는다.
- 코딩 관련 지침은 성격에 따라 `AGENTS.md`, `agents/*.md`, `templates/*.md`, 별도 노트 문서 중 맞는 위치에 저장한다.
- 프로젝트 시작 전 질문지는 `templates/*-intake.md`에 두고, 실제 개발 기준 문서는 `docs/*.md`에 둔다.
- 템플릿 저장소의 `README.md`는 이 저장소의 사용법을 설명하는 문서로 유지한다.
- 실제 프로젝트로 복제된 뒤에는 해당 프로젝트의 `README.md`를 프로젝트 소개, 실행 방법, 설치, 환경 설정 중심으로 다시 작성한다.
- 템플릿용 설명과 프로젝트용 설명이 충돌할 경우, 템플릿 사용법은 별도 문서로 이동시키는 방식을 우선 검토한다.
- `DESIGN.md`(디자인 시스템 카탈로그) 갱신 시 운영 규칙: 토큰·컴포넌트·Do/Don't·dark alias 변경이 발생하면 같은 커밋에서 `DESIGN.md` frontmatter `last_updated`를 갱신하고, `STATE.md` `이번 세션에서 완료한 작업` 섹션에 변경 이력(추가/변경된 토큰명·컴포넌트명·사유)을 한 줄 이상 기록한다. 운영 메타 가이드는 `docs/design-guidelines.md`.

## Context Map (Action-Based Routing)

- Constraint 1: 본 Context Map 섹션 내부에서는 표(Table) 형식 대신 아래 Format의 불릿 라인을 사용한다. (이 제약은 Context Map 한정이며, `agents/main-agent.md`, `docs/development-process.md` 등 다른 문서의 표 사용을 금지하지 않는다.)
- Constraint 2: 이모지는 사용하지 않는다.
- Format: `- **[트리거/작업 영역](상대 경로)** - 한 줄 설명`
- 프로젝트가 커지면 작업 영역별 하위 `AGENTS.md` 또는 역할 문서를 만들고 이 섹션에 라우팅 규칙을 추가한다.

- **[공통 운영 규칙](./AGENTS.md)** - 저장소 전체에 적용되는 공통 원칙, 작업 방식, 문서 규칙 확인 시.
- **[현재 상태 및 인계](./STATE.md)** - 최근 변경 사항, 다음 작업, 현재 저장소 목적을 확인할 때.
- **[템플릿 사용 안내](./README.md)** - 이 저장소를 새 프로젝트에 어떻게 복제하고 커스텀할지 확인할 때.
- **[에이전트 헌법](./CLAUDE.md)** - Core Philosophy, Golden Rules, 커뮤니케이션, Architecture Rules, Naming, Test, Repo Map, Design System, Claude Code 레이어 설정.
- **[디자인 시스템 카탈로그 (active)](./DESIGN.md)** - UI/스타일/컴포넌트 작업 시 토큰, 컴포넌트, Do/Don't, 다크 alias의 1차 소스. `designs/`에서 선택된 시안의 활성 사본.
- **[디자인 시안 라이브러리](./designs/)** - 사용 가능한 시안 카탈로그 모음. 시안 스위치는 `bash .claude/plugins/select-design.sh <slug>`. 시안 작성 계약은 `designs/_alias-contract.md`.
- **[총괄 진행 규칙](./agents/main-agent.md)** - 요청 해석, 범위 통제, 우선순위 판단이 필요할 때.
- **[구현 작업](./agents/executor-agent.md)** - 문서 작성, 코드 수정, 설정 변경 같은 실제 산출물 작업 시.
- **[조사 작업](./agents/researcher-agent.md)** - 기존 구조 조사, 중복 확인, 근거 수집이 필요할 때.
- **[리뷰 작업](./agents/reviewer-agent.md)** - 리스크 점검, 회귀 확인, 테스트 누락 검토 시.
- **[기능 요청 템플릿](./templates/feature-request.md)** - 신규 기능 작업 요청을 구조화할 때.
- **[버그 수정 템플릿](./templates/bugfix-request.md)** - 재현 경로와 기대 동작을 기준으로 버그 요청을 정리할 때.
- **[리뷰 요청 템플릿](./templates/review-request.md)** - 코드 리뷰 범위와 중점 항목을 지정할 때.
- **[리팩터링 요청 템플릿](./templates/refactor-request.md)** - 구조 개선 범위와 유지 조건을 명시할 때.
- **[비즈니스 로직 요청 템플릿](./templates/business-logic-request.md)** - 로직 변경의 요구사항, 시나리오, 영향 범위, Git 작업 계획을 정리할 때.
- **[초기 시작 체크리스트](./templates/startup-checklist.md)** - 새 프로젝트 시작 시 에이전트가 사용자에게 QnA로 진행하는 전체 설정 체크리스트.
- **[프로젝트 시작 설문](./templates/project-intake.md)** - 프로젝트 목표, 사용자, 범위, 성공 기준을 수집할 때.
- **[UI 설문](./templates/ui-intake.md)** - 화면 톤, 주요 사용자 흐름, 참고 서비스, 상태 정의를 수집할 때.
- **[반응형 설문](./templates/responsive-intake.md)** - PC/모바일 우선순위와 breakpoint별 요구사항을 정리할 때.
- **[기술 스택 설문](./templates/tech-intake.md)** - framework, 테스트, 배포, 개발 명령을 수집할 때.
- **[프레임워크 구조 설문](./templates/framework-structure-intake.md)** - 레포 형태, 디렉터리 분리 기준, 파일 크기 기준을 수집할 때.
- **[다국어 설문](./templates/i18n-intake.md)** - 지원 언어, 기본 locale, 번역 범위, 포맷 정책을 수집할 때.
- **[포맷/타임존 설문](./templates/format-intake.md)** - 세계시(UTC), 화폐 기호, 천 단위 구분자 등 포맷 설정 기준을 수집할 때.
- **[API 설문](./templates/api-intake.md)** - API 데이터 페칭 방식, 명세서 이용, Mocking 전략을 수집할 때.
- **[에러 처리 설문](./templates/error-intake.md)** - 글로벌 Error Boundary, 화면 노출 방식, 로깅 서비스 연동 정책을 수집할 때.
- **[라우팅 정책 설문](./templates/routing-intake.md)** - 파라미터 기반 상태 동기화 및 권한에 따른 라우팅 제어 기준을 수집할 때.
- **[폼 유효성 설문](./templates/form-intake.md)** - 입력 폼 상태 관리 및 Zod 등 검증 스키마 사용 여부를 수집할 때.
- **[QA/워크플로우 설문](./templates/qa-intake.md)** - 에이전트 테스트 강제 유무, Git 커밋 컨벤션, CI/CD 연동 정책을 수집할 때.
- **[프로젝트 가이드 정본](./docs/project-guide.md)** - 현재 프로젝트의 목표, 기술·업무·검증 기준을 확인할 때.
- **[프로젝트 가이드 템플릿](./docs/project-guide-template.md)** - intake 답변을 프로젝트 가이드 구조로 옮길 때.
- **[프로젝트 지식 관리 가이드](./docs/knowledge-management-guide.md)** - 사용자 입력부터 개념·백서·요구사항·설계·개발계획까지의 분류, 시간순 명명, 문서 생명주기를 확인할 때.
- **[지식 입력 템플릿](./templates/knowledge-entry.md)** - 분류 전 원문과 사용자 정보를 `docs/00-inbox/`에 기록할 때.
- **[개념·백서 템플릿](./templates/whitepaper-note.md)** - 개념과 백서 정보를 근거 중심으로 정리할 때.
- **[개발계획 템플릿](./templates/development-plan.md)** - 근거 문서, 마일스톤, 완료 조건, 검증 계획을 정리할 때.
- **[의사결정 기록 템플릿](./templates/decision-record.md)** - 중요한 기술·제품·운영 결정을 ADR 형태로 남길 때.
- **[다국어 가이드](./docs/i18n-guidelines.md)** - i18n 구조, key 규칙, formatting, fallback 기준을 정리할 때.
- **[비즈니스 로직 플레이북](./docs/business-logic-playbook.md)** - 요구사항, 시나리오, 구현, 검증, 빌드, Git 작업 기준을 확인할 때.
- **[금액·수량 처리 기준](./docs/money-quantity-guidelines.md)** - 금액/수량의 계산·확정·표시·저장 계층 규칙, 잔차 배분, 통화 최소 단위, 실수 타입 금지 기준을 확인할 때.
- **[로컬/CI 실행 가이드](./docs/local-dev-ci-guide.md)** - 환경 호칭 3-tier, 승인 후 Docker 개발 루프, 빠른 범위 검증, 전체 CI 배치, 머지·정리 게이트를 확인할 때.
- **[6단계 승인 워크플로](./docs/approval-workflow.md)** - 요청 정리부터 작업 브랜치 점검, 실행 승인, 구현, 사후 감사, 빠른 검증과 Git 수명주기 마무리까지의 정본.
- **[종료 체크리스트](./docs/finish-checklist.md)** - 작업 종료 전 절차, 검증, 기록, 응답 형식 확인 항목의 공통 정본. Claude는 `.claude/CLAUDE.md`, Codex는 `.codex/checks/finish-checklist.md`가 이 문서를 참조한다.
- **[Claude 실행 게이트](./.claude/CLAUDE.md)** - 루트 `CLAUDE.md`와 함께 자동 로드되어 읽기 순서, 6단계 절차, 시작·종료 게이트를 Claude 런타임에 주입.
- **[프레임워크 구조 가이드](./docs/framework-structure-guide.md)** - 디렉터리 분리, 파일 크기, 레포 구조 기준을 확인할 때.
- **[Codex 읽기 순서](./docs/codex-reading-order.md)** - Codex가 어떤 순서로 문맥을 읽는지 참고할 때.
- **[에이전트 런타임 매트릭스](./docs/agent-runtime-matrix.md)** - Claude Code와 Codex의 기능 대응 관계, 공통 정본, 런타임별 어댑터 경계를 확인할 때.
- **[Claude 실행 가이드](./docs/claude-guide.md)** - Claude Code의 `.claude/*` 자동화 레이어 사용 기준을 확인할 때.
- **[Codex 실행 가이드](./docs/codex-guide.md)** - Codex에서 `.codex/*` workflow/check로 동일 운영 절차를 수행할 때.
- **[서브에이전트 가이드](./docs/subagent-guide.md)** - 역할 분리나 협업 흐름 예시를 확인할 때.
- **[개발 프로세스 문서](./docs/development-process.md)** - 문서형 개발 프로세스 초안을 확인할 때.
- **[개발 전략 가이드](./docs/development-strategy.md)** - UI Mock First와 Logic/DB First 중 개발 진행 방식을 선택할 때.
- **[개발 프로세스 시각화](./docs/development-process.html)** - 브라우저에서 시각 가이드, 단계별 체크리스트, STATE 미니 대시보드 확인 시.
- **[개발 전략 매뉴얼](./docs/development-strategy.html)** - 브라우저에서 UI-first 기본 경로와 DB/로직 우선 예외 경로를 비교할 때.
- **[Intake 폼 UI](./docs/intake.html)** - 브라우저에서 Startup QnA 위저드 또는 요청 템플릿(feature/bugfix/refactor/review/business-logic/knowledge) 입력 후 Markdown으로 내보낼 때.
- **[Skills Layer](./.claude/skills/)** - 자연어 트리거 기반 자동 활성화 SKILL.md 12종. `start`, `dev-start`, `intake`, `request`, `feature`, `bugfix`, `refactor`, `review`, `business-logic`, `design`, `stack-upgrade`, `git-cleanup`. 우선순위와 연계 흐름은 `CLAUDE.md`의 Skills Layer 섹션 참조.
- **[Slash Commands](./.claude/commands/)** - skills와 동일 이름의 명시적 slash command 12종. `/start`, `/dev-start`, `/intake`, `/request`, `/feature`, `/bugfix`, `/refactor`, `/review`, `/business-logic`, `/design`, `/stack-upgrade`, `/git-cleanup`. 사용자가 직접 호출할 때만 동작.
- **[Hooks Layer](./.claude/hooks/)** - 파괴적 명령 차단, 배포·릴리스 명령 차단, 비밀 파일 쓰기 차단, STATE.md 갱신 리마인더, 3단계 승인 전 파일 수정 확인, 세션 파일 겹침 조정. 설정은 `.claude/settings.local.json`.
- **[서브에이전트 정의](./.claude/agents/)** - frontmatter로 자동 등록되는 역할별 서브에이전트 6종 (explorer, code-reviewer, planner, test-runner, feature-dev, design-reviewer). Agent 도구의 `subagent_type`에 이름을 지정해 호출한다. 디스패치 기준은 `docs/subagent-guide.md`.
- **[Plugins Layer](./.claude/plugins/)** - manifest.json, VERSION, install.sh. 다른 프로젝트에 설치 시 `docs/plugin-guide.md` 참조.
- **[Codex Layer](./.codex/)** - Codex용 workflow 13종(`start`, `dev-start`, `intake`, `request`, `feature`, `bugfix`, `refactor`, `review`, `business-logic`, `design`, `stack-upgrade`, `session-coordination`, `git-cleanup`), safety/finish checklist, subagent prompt guide. Claude 전용 자동화와 분리된 보완 레이어.
- **[미완료 Git 작업 정리](./.claude/skills/git-cleanup/SKILL.md)** - 커밋·push·PR·머지·브랜치·worktree 중 덜 끝난 것을 점검하고 마무리할 때. 배포·릴리스는 실행하지 않고 사용자에게 인계한다.
- **[세션 충돌 조정](./docs/session-coordination-guide.md)** - Claude/Codex 세션 등록, 파일 점유 확인, 겹침 시 대기·사용자 확인 기준.
- **[Plugin 가이드](./docs/plugin-guide.md)** - 설치, 업데이트, 커스텀, 버전 관리 방법.
- **[디자인 운영 가이드](./docs/design-guidelines.md)** - `DESIGN.md` 토큰 호출 규칙, alias/atomic 선택, 컴포넌트 추가 절차, dark alias 합성 표기.
- **[Admin FE 디자인 가이드](./docs/admin-fe-design-guide.md)** - admin/dashboard 화면(로그인, 사이드바, top bar, KPI 카드, data table, 폼) 조립 패턴. DESIGN.md 토큰/컴포넌트 호출 기준.
- **[UI Decisions 템플릿](./docs/ui-decisions.md)** - startup-checklist 섹션 3~5 + `data-table-density.md` 등 UI 결정 사항을 통합 기록. 프로젝트별로 필요 섹션만 채워 사용.

## 사용자 확인이 필요한 상황

- 파일 삭제, 구조 대이동, 의존성 대규모 추가가 필요한 경우
- 기존 구현을 뒤집는 리팩터링이 필요한 경우
- 요구사항 해석에 따라 결과가 크게 달라질 수 있는 경우
- 테스트 실패 원인이 코드인지 환경인지 불분명한 경우
- GitHub Actions 배포/릴리스 실행, 원격(`staging`/`production`) migration 적용 등 "GitHub 이상"의 원격 작업이 필요한 경우 — agent는 실행하지 않고 사용자에게 인계한다 (`docs/local-dev-ci-guide.md §0`)
- `docker compose down -v` 등 로컬 DB 데이터를 삭제하는 재빌드가 필요한 경우

## 초기 프로젝트 기본 가정

이 저장소가 비어 있거나 초기 단계라면 다음 순서로 진행한다.

1. 사용자 요청에 맞는 최소 구조를 만든다.
2. 실행 진입점 또는 문서 중 하나는 반드시 남긴다.
3. 이후 확장 포인트는 파일명과 디렉터리 구조로 드러나게 한다.
