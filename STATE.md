# STATE.md

## 현재 상태

- 이 저장소는 `개발용 에이전트 운영 템플릿`이다.
- 어떤 프로젝트에서도 재사용할 수 있는 공통 운영 규칙, 역할별 지침, 요청 템플릿, intake/guide 문서를 제공한다.
- 공통 규칙은 `AGENTS.md`에 정의한다.
- 역할별 규칙은 `agents/` 아래에 둔다.
- 작업 요청 템플릿과 intake 양식은 `templates/` 아래에 둔다.
- 가이드 문서는 `docs/` 아래에 둔다.
- 본 템플릿을 소비하는 런타임 앱은 sibling 저장소 `../riderapp-runtime/`이다.
- 본 템플릿을 사용하는 첫 비즈니스 프로젝트의 설계 문서는 sibling 저장소 `../rider-platform-docs/`에 분리되어 있다.

## 이전 세션까지 완료한 작업

- `AGENTS.md`를 개발용 에이전트 운영 템플릿 기준으로 재구성했다.
- 역할별 에이전트 문서(`agents/main-agent.md`, `agents/executor-agent.md`, `agents/researcher-agent.md`, `agents/reviewer-agent.md`)를 정리했다.
- 기능 개발, 버그 수정, 리뷰, 리팩터링, 비즈니스 로직 요청 템플릿을 추가했다.
- 템플릿 저장소용 `README.md`를 추가하고, 실제 프로젝트 `README.md`와의 역할 구분 규칙을 `AGENTS.md`에 반영했다.
- `AGENTS.md`의 `세부 규칙 위임` 섹션에 코딩 입력 분류 기준을, `작업 시작 전 프로토콜` 섹션에 intake -> guide -> development 흐름을 반영했다.
- `agents/executor-agent.md`, `agents/reviewer-agent.md`에 코딩 체크리스트를 추가했다.
- 루트 `AGENTS.md`에 `Core Philosophy`, `Execution Protocol`, `Project Context & Operations`, `Golden Rules`, `Context Map (Action-Based Routing)` 섹션을 반영했다.
- 프로젝트 시작 전 설문형 정보 수집을 위한 intake 템플릿(`templates/project-intake.md`, `templates/ui-intake.md`, `templates/responsive-intake.md`, `templates/tech-intake.md`)을 추가했다.
- intake 답변을 실제 개발 기준으로 바꾸기 위한 `docs/project-guide-template.md`를 추가했다.
- 다국어 프로젝트용 `templates/i18n-intake.md`, `docs/i18n-guidelines.md`를 추가하고 `AGENTS.md`, executor/reviewer agent 문서에 i18n 규칙을 반영했다.
- Codex가 어떤 규칙과 파일을 어떤 우선순위로 참조하는지 정리한 `docs/codex-reading-order.md`를 추가했다.
- 비즈니스 로직 개발 프로세스용 `docs/business-logic-playbook.md`와 `templates/business-logic-request.md`를 추가했다.
- 초기 프레임워크/디렉터리/파일 분리 기준용 `docs/framework-structure-guide.md`와 `templates/framework-structure-intake.md`를 추가했다.
- 에이전트 초기 시작 QnA 체크리스트 `templates/startup-checklist.md`(7개 섹션)를 추가했다.
- `AGENTS.md` 작업 시작 전 프로토콜에 새 프로젝트 / 기존 프로젝트 분기 기준을 추가했다.
- 런타임 에이전트 앱 `riderapp-runtime`을 sibling 저장소로 신규 생성했다. (`/home/skyua/projects/riderapp-runtime`, pnpm workspace, Claude Agent SDK 래퍼/비용 통제/SQLite/Next.js 대시보드)

## 이번 세션에서 완료한 작업

- v2-3 + v2-4: 시안별 시그너처 시각화 + 화면 조립 비교 가이드. (2026-05-15)
  - `docs/admin-fe-preview.html`에 `## 시안 시그너처` 섹션 신설(`#signature`). 시안별 차별화를 활성 시안 dropdown에 연동된 specimen으로 시각화.
    - wanted: 채용보상금 잡카드(우측 하단 fg-brand 강조)
    - minimal-mono: 색 없는 size+weight+underline 타이포 위계
    - toss-like: hero gradient banner + amount input(tabular-nums, 32/700)
    - material-3: 5종 button variant(filled/tonal/elevated/outlined/text, radius-full + +0.10em letter-spacing) + elevated card(shadow-2)
    - linear-like: kbd 단축키(⌘K/⇧⌘P/Esc) + gradient accent(CTA + 강조 텍스트 background-clip)
  - CSS `[data-design]` 속성 분기로 활성 시안 시그너처만 표시. HTML 74KB.
  - `docs/admin-fe-design-guide.md`에 `## 시안별 화면 조립 차이` 섹션 신설. login/dashboard/list/상세/폼 5개 화면 패턴별 5개 시안 비교 매트릭스 + 시안 선택 가이드(프로젝트 유형 5종 매핑) + 시안 변경 안전 범위 4종 점검 항목.

- v2-5/v2-6/v2-7/v2-8 + 검수 후속: preview/가이드/fallback/카탈로그 정합 보강. (2026-05-15)
  - **v2-5**: `admin-fe-preview.html`에 `## atomic 7종` 섹션 신설. button(5 variant × 4 size) / input(4 state) / badge / chip / avatar / icon-button / icon 시안별 차이 한 페이지 비교.
  - **v2-6**: `admin-fe-design-guide.md` 본문 prose 일반화. 1차 원칙을 "시안 무관" + "시안 정책에 따라 분기" 2 그룹으로 재구성. 카피 톤 체크리스트를 ko-friendly / ko-formal / en-sentence 3종 매트릭스로 확장.
  - **v2-7**: `_alias-contract.md ## 9b` 섹션 신설(시안 전용 토큰 fallback 매핑 표 + ladder 변수 정책). `admin-fe-preview.html` `:root` 공통 블록에 catalog-only fallback 변수(`--radius-6/20/28`, `--shadow-3/4/cta`, `--font-mono`) 추가.
  - **v2-8**: `design-reviewer` 서브에이전트(general-purpose) 호출하여 5개 카탈로그 self-review 실행. 핵심 결함 6종 검출(catalog-only 토큰 CSS Variables surface 누락, alias 카운트 표기 오류 32→25, dark synthesized 마커 누락, wanted catalog-only ladder Known Gaps 누락).
  - **v2-8 후속**: 검출된 critical 이슈 일괄 수정.
    - alias 카운트 32→25 정정 (`_alias-contract.md`, `STATE.md`, `startup-checklist.md`, `design-reviewer.md`, `design-guidelines.md` 5개 파일).
    - `_alias-contract.md ## 9b` fallback 표에 wanted catalog-only 토큰(`--radius-6/10/20/24/32`, `--shadow-3/4`, `--border-inverse`, `--fg-link`) 추가, ladder 변수 ship 방식(a) 시안별 자체 정의 vs (b) 공통 root 의존 정책 명시.
    - `wanted.md` Known Gaps에 catalog-only ladder + color/border + shadow-3/4 명시 + CSS Variables 블록에 누락 토큰 8종 surface.
    - 4개 카탈로그(`minimal-mono`, `toss-like`, `material-3`, `linear-like`) CSS Variables 블록에 spacing 14종 + radius ladder + 각 시안의 catalog-only 토큰 일괄 surface. dark 블록의 `fg-success/warning/danger` 등 합성 alias에 `/* synthesized */` 마커 명시.
    - 재검수 자동화: 5개 카탈로그 모두 `--space-16`, `--radius-8`, 각 catalog-only 토큰 surface 검증 통과. select-design.sh 활성화/복귀 정상.
  - 라이브러리 v2 인프라 + 시각화 + 정합 보강 완료. preview HTML 86KB, 카탈로그 평균 1100줄.

- v2-2.4: linear-like 시안 라이브러리 추가. (2026-05-15)
  - `designs/linear-like.md` 신규 — productivity/issue tracker 톤. **dark 1차** + gradient accent 적극(`policy.gradient_locations: ["accent", "hero"]`) + 카드 그림자 금지(`policy.shadow_on_cards: false`) + 컴팩트 밀도(button md 32, input 32, body1 14, sidebar 220) + en-sentence 영문 카피.
  - brand는 gradient pair(violet→teal). accent gradient는 CTA hover/강조 텍스트/selection에 적극 사용, hero gradient는 마케팅 1곳.
  - 시안 전용 추가 토큰: `radius-6`(input/button md 디폴트), `mono` typography variant(JetBrains Mono/SF Mono), `kbd` 컴포넌트(키보드 단축키 표기). alias 계약 외 항목으로 Known Gaps에 명시.
  - CSS 변수 단일 값으로는 gradient 표기 불가 → preview HTML은 solid brand로 fallback, accent gradient는 prose 명시.
  - 라이브러리 v1 시드 5종 완성(wanted, minimal-mono, toss-like, material-3, linear-like). 5개 시안 모두 select-design.sh로 활성화·복귀 검증 통과.

- v2-2.3: material-3 시안 라이브러리 추가. (2026-05-15)
  - `designs/material-3.md` 신규 — Google Material Design 3 공식 사양 매핑. tonal palette seed(`#6750A4` ≈ oklch(0.460 0.155 295)) 기반 light/dark 시맨틱 alias. elevation 5단(shadow-1~shadow-pop + level 3/4 추가) + button `radius-full` 시그너처 + positive letter-spacing(`+0.03em` ~ `+0.10em`).
  - 영문 sentence case copy tone(`policy.copy_tone: "en-sentence"`) — 본 라이브러리에서 첫 en-sentence 시안.
  - 시안 전용 추가 토큰: `radius-28`(extra-large modal/FAB), `shadow-3`/`shadow-4`(M3 elevation level 3/4), Roboto/Material Symbols 서체. alias 계약 외 항목으로 Known Gaps에 명시.
  - dynamic color seed 변환·ripple motion·state layer는 prose로만 surface(host 앱 구현 영역).
  - `admin-fe-preview.html` 변수 두 블록 inline + DESIGNS 항목 추가. `manifest.json` 등록. select-design 활성화/복귀 검증.

- v2-2.2: toss-like 시안 라이브러리 추가. (2026-05-15)
  - `designs/toss-like.md` 신규 — 한국 핀테크 톤. 단일 강조 파랑(`bg-brand: oklch(0.620 0.180 245)`) + 큰 라운드(`radius-12`~`radius-16`) + 카드 그림자 허용(`policy.shadow_on_cards: true`) + 마케팅 hero gradient(`policy.gradient_locations: ["hero"]`).
  - 시안 전용 추가 토큰: `radius-20`(modal/xl 카드), `shadow-cta`(brand color glow), `amount` typography variant(tabular-nums + 32/700/1.0). alias 계약 외 항목으로 Known Gaps에 명시.
  - 모바일 우선 — 컴포넌트 height 한 단계 큼 (button md 44, input 52, avatar 40, icon-button 40). touch target 48 권장.
  - `admin-fe-preview.html`에 toss-like 변수 두 블록 + DESIGNS 객체 항목 추가. dropdown에서 wanted/minimal-mono/toss-like 토글 동작.
  - `manifest.json designs.files` 등록.

- v2-2.1: minimal-mono 시안 라이브러리 추가. (2026-05-15)
  - `designs/minimal-mono.md` 신규 — self-contained 합성 catalog. 흑백 단색 + 평면 표면 + 헤어라인 보더 + 단색 brand(가장 진한 neutral). gradient 전면 금지(`policy.gradient_locations: []`). 4의 배수 정규화(button sm radius 4, lg 8 — Wanted의 6/10 로컬값 제거).
  - 필수 7종 컴포넌트 + admin 5종 시그너처 + Do/Don't + light/dark CSS Variables 32+14+6+elevation 정의.
  - alias 계약 검수 체크리스트 8종 통과(색 32종, ladder 누락 없음, 컴포넌트 7종, policy 5종 frontmatter, last_updated, STATE 기록 포함).
  - `admin-fe-preview.html`에 minimal-mono CSS 변수 두 블록 inline + DESIGNS 객체에 항목 추가. dropdown에서 wanted ↔ minimal-mono 토글 동작. policy chip이 "gradient: 전면 금지"로 정상 표시.
  - `manifest.json designs.files`에 minimal-mono 등록. install dry-run에 포함.
  - 검증: `select-design.sh minimal-mono` 활성화 → DESIGN.md == designs/minimal-mono.md 일치, `--list`에서 wanted/minimal-mono 모두 노출, 다시 wanted로 복귀 정상.

- v2-1: admin-fe-preview.html 일반화 + 시안별 CSS Variables 섹션 도입. (2026-05-15)
  - `designs/_alias-contract.md`에 `## 10 CSS Variables 표기 규칙` 섹션 신설. alias→CSS 변수 명명 규칙, `data-design`+`data-theme` 2축 cascade 셀렉터, md fenced css 블록 형식, preview 정합 검증 정책.
  - `designs/wanted.md` 와 `designs/_template.md`에 `## CSS Variables` 섹션 추가. wanted.md frontmatter에 `policy:` 블록 5종(shadow_on_cards/gradient_locations/copy_tone/dark_mode/non_4_spacing) 명시.
  - `docs/admin-fe-preview.html` 리팩터:
    - 기존 `:root[data-theme]` 하드코딩 블록을 `:root[data-design="wanted"][data-theme="light|dark"]` 분기로 교체.
    - 상단 preview-bar에 시안 dropdown(`<select id="design-select">`) 추가. localStorage `admin-fe-preview-design` 키로 선택 유지.
    - preview-bar 아래 `policy-strip` 신설. 활성 시안의 frontmatter policy 5종을 chip으로 자동 렌더링(success/danger/info variant).
    - JS `DESIGNS` 객체에서 dropdown 자동 populate, 시안 변경 시 `data-design` 속성 + policy strip 동기 갱신.
    - JS 구문 `node --check` 통과. HTML 50KB.
  - `docs/admin-fe-design-guide.md`에 preview 시각 확인 섹션 + 시안 추가 절차(3단계) 명시.
  - `docs/design-guidelines.md`에 preview 시각 검증 섹션 추가.

- 디자인 시안 라이브러리 도입(`designs/` 폴더 + select-design.sh + install.sh --design 플래그). (2026-05-15)
  - 신규: `designs/README.md`, `designs/_alias-contract.md`(alias 25종 + 컴포넌트 7종 + policy 5종 계약), `designs/_template.md`(빈 골격), `designs/wanted.md`(기존 DESIGN.md 이전).
  - 신규 스크립트: `.claude/plugins/select-design.sh` — `--list`/`--current`/`<slug>` 모드. DESIGN.md가 라이브러리와 다른 직접 편집 상태면 `DESIGN.md.bak` 자동 백업 후 덮어쓰기.
  - `install.sh` 확장: `--design <slug>` 플래그 (기본 wanted). 설치 마지막에 designs/<slug>.md → DESIGN.md 활성화 + `.claude/.active-design` 마커 생성.
  - manifest.json에 신규 `designs` 섹션(default+files+selector) 추가. 라이브러리 4종 파일 + selector가 install dry-run 73개 대상에 포함됨.
  - `docs/design-guidelines.md`에 라이브러리 사용 흐름 섹션 + install 정책 갱신.
  - `templates/startup-checklist.md` 섹션 3 Q6~Q8을 라이브러리 기반 흐름으로 단순화(목록 확인/활성화 검증/STATE 기록).
  - `templates/ui-intake.md` 사용 디자인 시스템 섹션을 (a) 라이브러리 기본/(b) fork/(c) `_template`에서 신규/(d) override 4분기로 갱신.
  - `CLAUDE.md` Repo Map + Design System 섹션, `AGENTS.md` Context Map에 라이브러리/active 정본 구분 명시.
  - `.claude/agents/design-reviewer.md` 일반화: 점검 항목을 A(시안 무관 일반 — alias 계약/ladder/다크 누락)와 B(시안별 정책 — frontmatter `policy:` 블록과 `## Do's and Don'ts` 자동 적용)로 분리. Wanted 고유 규칙(잡카드 채용보상금, blue-800 focus ring, gray-* 패밀리 차단)은 B 섹션의 시안별 예시로 격하.
  - 로컬 검증: `select-design.sh --list/--current/wanted/_template/nonexistent` 5개 모드 동작 확인. `install.sh --dry-run --design wanted /tmp` 73개 대상 + 활성화 단계 출력 확인. 실설치(`/tmp/test-install-real`) 후 `DESIGN.md == designs/wanted.md` 일치 검증.

- DESIGN.md에 admin/dashboard 표면 컴포넌트 5종(synthesized) 추가 + admin FE 디자인 가이드 작성. (2026-05-15)
  - DESIGN.md `## Components` 섹션 끝에 `### Admin / Dashboard surface 컴포넌트 (synthesized)` 블록 추가.
  - 신규 컴포넌트 5종: `login-layout`, `sidebar-nav`, `top-bar (admin)`, `stat-card (KPI)`, `data-table` — 모두 토큰 호출 형식 + 평면 표면/1px 헤어라인/단일 강조색 정책 준수.
  - DESIGN.md frontmatter `last_updated`를 2026-05-15로 갱신.
  - `docs/admin-fe-design-guide.md` 신규 작성 — 화면 단위 조립 패턴(login, dashboard, 리스트, 상세, 폼, 알림) + 카피 톤 체크리스트 + 데이터 밀도 + 다크 모드 + design skill 연계.
  - `docs/admin-fe-preview.html` 신규 작성 — DESIGN.md 토큰(oklch CSS 변수)을 직접 매핑한 단일 파일 시각화. 색 토큰 swatch + admin 5종 컴포넌트 + 대시보드/리스트 페이지 조립뷰. 라이트/다크 토글, 사이드바 collapse 토글, checkbox 토글 동작. 외부 CDN 의존성 없음. JS 블록 `node --check` 통과.

- todo.md 미완료 12종 일괄 처리. (2026-05-15)
  - install.sh `--dry-run` 검증 — HTML 2종(development-process.html, intake.html) 정상 복사 확인.
  - plugin-guide 디렉터리명 정본을 `claude-agent-templete`(GitHub 저장소명)로 결정. plugin-guide.md 3개 경로 + manifest.json `name` 필드 통일.
  - `docs/development-process.md` Phase 3 단계 6에 `docs/ui-decisions.md` 동기화 운영 메모 추가, STATE.md 다음 작업 항목에도 inline 메모.
  - `templates/ui-intake.md`에 `## 사용 디자인 시스템` + `## 토큰 정책` 섹션 추가 (DESIGN.md 그대로/fork/override 분기, 토큰 기본값 호출).
  - `.claude/skills/{feature,refactor,bugfix}/SKILL.md`에 `## 다른 skill과의 연계` 섹션 추가 (UI 영향 발견 시 design skill로 연계).
  - `templates/qa-intake.md` CI/CD 섹션에 디자인 토큰 외 값 PR 경고 정책 항목 추가.
  - `DESIGN.md` 상단에 외부 인용 의존성 정책 boxed note 추가, `docs/design-guidelines.md` 1차 소스 규칙 보강(외부 URL 재방문 조건 4종 + `[src:N (archived)]` 보존).
  - DESIGN.md frontmatter install 정책: 옵션 B(그대로 복사 + 첫 단계 재작성) 결정. `templates/startup-checklist.md` 섹션 3에 Q6~Q8(디자인 시스템 선택, frontmatter 재작성, STATE.md 기록) 추가.
  - `.claude/hooks/warn-design-tokens.sh` opt-in 가드레일 신규 작성 (hex/비-4 px 검출, 항상 exit 0). `settings.local.json` 기본 미등록, 활성화 방법 `docs/design-guidelines.md`에 명시.
  - `AGENTS.md ## 문서화 원칙`과 `docs/design-guidelines.md ## STATE.md 변경 이력 운영 규칙`에 DESIGN.md 갱신 시 운영 규칙 명시 (last_updated + STATE 변경 이력).

- 문서 자기일관성 정리 + 디자인 시스템 통합을 진행했다. (2026-05-14)
  - 자기일관성 정리:
    - `CLAUDE.md` Repo Map의 서브에이전트 3종 표기를 5종(explorer, code-reviewer, planner, test-runner, feature-dev)으로 정정.
    - `docs/plugin-guide.md` 설치 내용 섹션을 manifest 기준으로 동기화 — L2를 skills/commands로 분리, L4를 5종으로 갱신, supporting 영역 명시.
    - `.claude/plugins/manifest.json` supporting.docs에 누락 자산 3종 추가(`docs/development-process.html`, `docs/intake.html`, `docs/global-claude-md-template.md`).
    - `AGENTS.md` Context Map의 `Constraint 1: 표 금지` 적용 범위를 Context Map 섹션 한정으로 명시 (다른 문서의 표 사용 허용).
    - `docs/development-process.md` Phase 3의 `docs/ui-decisions.md` 빈 참조를 "필요 시 작성"으로 약화.
  - 디자인 시스템 통합:
    - `CLAUDE.md`에 `## Design System` 섹션 신설 (토큰 호출 규칙, Do/Don't 핵심, 카피 톤, 자동 활성화 흐름) + Repo Map에 `DESIGN.md` 추가.
    - `AGENTS.md` Context Map에 `DESIGN.md`, `docs/design-guidelines.md` 라우팅 추가 + Skills Layer를 9종으로 갱신.
    - `.claude/skills/design/SKILL.md` 신규 작성 — UI/디자인 키워드 자동 활성화, DESIGN.md 강제 로드, 토큰 호출 형식 강제.
    - `docs/design-guidelines.md` 신규 작성 — 1차 소스 규칙, alias/atomic 선택 기준, 다크 alias 정책, 새 컴포넌트 추가 절차, Do/Don't 운영, 카피 톤.
    - `agents/executor-agent.md`에 디자인 공통 체크리스트 4종 + `### Design` 작업 유형 체크리스트 추가.
    - `agents/reviewer-agent.md`에 `### Design 리뷰 포커스` 섹션 추가.
    - `agents/researcher-agent.md`의 Feature/Refactor 조사에 DESIGN.md 확인 항목 추가.
    - `.claude/agents/design-reviewer.md` 신규 서브에이전트 — code-reviewer와 직교(병렬 실행 가능)한 디자인 일관성 전용 리뷰어.
    - `docs/subagent-guide.md` 디스패치 기준에 design-reviewer 추가.
    - `templates/feature-request.md`에 `## 디자인 토큰 참조` 섹션 추가.
    - `.claude/plugins/manifest.json`에 디자인 자산 4종 등록(L1 DESIGN.md, L2 design SKILL, L4 design-reviewer, supporting design-guidelines.md). JSON 유효성 검증 통과.

- Layer 4 서브에이전트를 이미지 비전 기준 5종 체제로 확장했다. (2026-05-13)
  - `test-runner.md` 신규: 테스트 실행/실패 분석 위임 (general-purpose 타입)
  - `feature-dev.md` 신규: end-to-end 기능 구현 위임 (general-purpose 타입)
  - `reviewer.md` → `code-reviewer.md` 이름 변경: 역할 명확화 (repo conventions 검토)
  - 참조 문서 갱신: `CLAUDE.md`, `AGENTS.md`, `manifest.json`, `docs/subagent-guide.md`
  - 최종 구성: explorer, code-reviewer, planner, test-runner, feature-dev (5종)

- Skills Layer를 `.claude/commands/`(slash command)에서 `.claude/skills/<name>/SKILL.md`(자연어 자동 활성화) 구조로 전환했다. (2026-05-13)
  - 8개 skill 디렉터리에 SKILL.md 작성: `start`, `request`, `feature`, `bugfix`, `refactor`, `review`, `business-logic`, `intake`.
  - 각 SKILL.md의 description 필드에 한국어+영문 트리거 키워드 병기.
  - 우선순위 규칙: 명확한 유형 키워드는 개별 skill, 모호하면 `request` skill 활성화.
  - skill 연계 흐름: `start` → `intake` 또는 개별 작업 skill로 자연스러운 전환.
  - `$ARGUMENTS` 참조 제거 → "사용자 메시지에 ~ 있으면" 자연어 파싱 방식으로 재설계.
  - SKILL.md 내 slash command 참조(`/feature`, `/intake` 등)를 "해당 skill이 활성화된다" 표현으로 대체.
  - `.claude/commands/` 8종은 명시적 호출용으로 병존 유지 (역할 분리).
  - 루트 문서 4종(`CLAUDE.md`, `AGENTS.md`, `README.md`, `STATE.md`)과 `manifest.json`, `docs/subagent-guide.md`에 변경 반영.
  - intake 토픽 매핑 12종이 실제 `templates/*-intake.md` 파일 존재와 1:1 일치함을 검증.
  - `settings.local.json`은 skills 관련 별도 설정 불필요(SKILL.md 파일 존재만으로 자동 활성화)임을 확인.
  - `docs/subagent-guide.md`에 Skills vs 서브에이전트 역할 구분 섹션 추가.

- Skills Layer (L2) 구현: `.claude/commands/`에 커스텀 slash command 8개를 추가했다. (2026-05-12)
  - 오케스트레이터 3종: `start.md` (프로젝트 QnA), `intake.md` (12종 intake 라우터), `request.md` (작업 유형 라우터)
  - 개별 요청 5종: `feature.md`, `bugfix.md`, `refactor.md`, `review.md`, `business-logic.md`
  - 각 커맨드는 `templates/`의 원본을 읽어서 대화형으로 진행. 템플릿 내용을 중복하지 않음.
  - `CLAUDE.md`에 Skills Layer 섹션 추가, `AGENTS.md` Context Map에 커맨드 라우팅 추가.
  - `README.md` 사용 방법을 커맨드 중심으로 업데이트하고 커스텀 커맨드 섹션 추가.

- Hooks Layer (L3) 구현: `.claude/hooks/`에 가드레일 스크립트 3개를 추가했다. (2026-05-12)
  - `block-destructive.sh`: `rm -rf`, `git reset --hard`, `git push --force`, `git clean -f`, `git checkout .` 차단
  - `block-secret-files.sh`: `.env`, `*.pem`, `*.key`, `credentials.json` 등 비밀 파일 쓰기 차단
  - `state-reminder.sh`: `git commit` 시 STATE.md 미갱신 경고 (차단하지 않음)
  - `.claude/settings.local.json`에 PreToolUse hooks 등록 완료.
  - `CLAUDE.md`에 Hooks Layer 섹션 추가, `AGENTS.md` Context Map에 hooks 라우팅 추가.

- L1 CLAUDE.md 재구조화: "에이전트 헌법" 패턴으로 개편했다. (2026-05-13)
  - AGENTS.md에서 Core Philosophy, Golden Rules, 커뮤니케이션, 검증 원칙을 CLAUDE.md로 이동.
  - CLAUDE.md에 Architecture Rules, Naming Conventions, Test Expectations, Repo Map 신규 섹션 추가.
  - AGENTS.md에 헌법 역참조 추가, Context Map 설명 업데이트.
  - `docs/global-claude-md-template.md` 생성 (글로벌 `~/.claude/CLAUDE.md` 템플릿).

- Plugins Layer (L5) 구현: `.claude/plugins/`에 배포 도구를 추가했다. (2026-05-13)
  - `manifest.json`: 전체 레이어 파일 목록과 메타데이터 (name, version, layers, supporting)
  - `VERSION`: 1.0.0
  - `install.sh`: 대상 프로젝트에 파일 복사 스크립트 (--force, --dry-run 지원)
  - `docs/plugin-guide.md`: 설치/업데이트/커스텀/버전 관리 가이드
  - `CLAUDE.md`에 Plugins Layer 섹션 추가, `AGENTS.md` Context Map에 라우팅 추가.
  - `README.md`에 "다른 프로젝트에 설치" 섹션 추가.

- Subagents Layer (L4) 구현: `.claude/agents/`에 서브에이전트 프롬프트 템플릿 3개를 추가했다. (2026-05-13)
  - `explorer.md`: 조사/탐색 위임용 (Explore 타입, researcher-agent.md 참조)
  - `reviewer.md`: 리스크 점검 위임용 (general-purpose 타입, reviewer-agent.md 참조)
  - `planner.md`: 구현 계획 위임용 (Plan 타입, main-agent + executor-agent 참조)
  - `docs/subagent-guide.md`에 디스패치 테이블 섹션 추가.
  - `CLAUDE.md`에 서브에이전트 템플릿 섹션 추가, `AGENTS.md` Context Map에 라우팅 추가.

- `templates/` 18개 파일에 작성 예시 섹션을 일괄 추가했다. (2026-05-06)
  - request 5종(`feature`, `bugfix`, `refactor`, `review`, `business-logic`): 각 파일 말미에 시나리오형 작성 예시 추가.
  - 짧은 intake 6종(`api`, `error`, `form`, `qa`, `routing`, `format`): 답변 예시 추가.
  - 중간 intake 5종(`ui`, `responsive`, `project`, `tech`, `i18n`): 답변 예시 추가.
  - `framework-structure-intake.md`: feature-first hybrid 구조 예시 추가.
  - `startup-checklist.md`: "결과 요약 작성 예시" 섹션을 11개 섹션 답변이 채워진 형태로 추가.
  - 결정: 프로젝트 유형(rider 운영 대시보드)을 기본 시나리오로 통일해 templates 간 일관성 유지.

- `docs/project-guide-template.md`에 작성 예시(Worked Example)와 변환 절차 요약을 추가했다. (2026-05-06)
  - "rider 운영 대시보드 MVP" 시나리오로 1~12 섹션 전체를 채운 산출물 형태 예시.
  - intake 템플릿(`project-intake`, `startup-checklist`, `ui-intake`, `responsive-intake`, `tech-intake`, `i18n-intake`, `framework-structure-intake`)과 본 가이드 섹션 간 매핑 표.
  - 비어 있는 입력은 "미정"으로 두지 말고 `## 3. Open Questions`로 옮기는 규칙 명시.

- `agents/*.md`를 작업 유형 축으로 구체화했다. (2026-05-06)
  - `main-agent.md`: `## 작업 유형 식별 가이드` 섹션 추가. feature/bugfix/refactor/business-logic/review 5종 templates와 1:1 매핑 표 + 복합 요청 처리 규칙.
  - `executor-agent.md`: `## 작업 유형별 체크리스트` 섹션 추가 (feature, bugfix, refactor, business-logic 4종).
  - `reviewer-agent.md`: `## 작업 유형별 리뷰 포커스` 섹션 추가 (feature, bugfix, refactor, business-logic + review 요청 자체 처리).
  - `researcher-agent.md`: `## 작업 유형별 조사 포커스` 섹션 추가 (feature, bugfix, refactor, business-logic, review).
  - 결정: 프로젝트 유형 축(A/B안) 대신 작업 유형 축(C안)으로 분기. `templates/*-request.md` 5종과 1:1 매칭되어 신규 개념 도입 없이 진행 가능.

- 브라우저 보조 UI를 3단계로 확장했다. (2026-05-04)
  - A: `README.md`에 "브라우저 UI" 섹션과 1차 소스 규칙을 추가했다. `AGENTS.md`에 `HTML UI 운영 규칙` 섹션을 신설하고 Context Map에 `docs/intake.html` 라우팅을 추가했다.
  - B: `docs/development-process.html`에 진행률 카드(`localStorage` 저장, 초기화/모두 펼치기 버튼), 운영 규칙 안내 배너, intake CTA, STATE 미니 대시보드(STATE.md fetch 또는 텍스트 붙여넣기로 H2 섹션 파싱)를 추가했다. Phase 펼침 상태도 `localStorage`에 저장한다.
  - C: `docs/intake.html`을 신규 작성했다. Startup QnA 11섹션 위저드와 feature/bugfix/refactor/review/business-logic 5종 요청 템플릿을 폼으로 채우고 Markdown으로 다운로드/복사한다. 입력값은 폼별 `localStorage` 키에 저장된다.
  - 외부 의존성 없이 단일 HTML 파일로 동작한다. `node --check`로 두 페이지의 JS 블록 구문 검증을 통과했다.
- 기존 `~/projects/riderapp` 폴더를 두 개로 분리했다.
  - `~/projects/claude-agent-template/` (현재 저장소): 범용 에이전트 운영 템플릿
  - `~/projects/rider-platform-docs/`: rider platform 비즈니스 설계 문서
- `riderapp-runtime/rules` 심볼릭 링크를 신규 템플릿 저장소로 갱신했다.
- 메모리(`project_riderapp_runtime.md`)를 새 경로 기준으로 갱신했다.
- 루트 `AGENTS.md`를 관제탑 중심 구조로 슬림화했다.
- 루트 `AGENTS.md`에 빠른 읽기 순서 섹션을 추가했다.
- 루트 `AGENTS.md`의 `Context Map`에 `CLAUDE.md`, `docs/codex-reading-order.md`, `docs/subagent-guide.md`, `docs/development-process.md`, `docs/development-process.html` 라우팅을 추가했다.
- 분리본과 원본 파일 무결성 검증 후 원본 `~/projects/riderapp/`을 삭제했다. (2026-05-04)
- 운영 문서 자기일관성 정리 (2026-05-04):
  - `CLAUDE.md`를 65줄에서 22줄로 축소했다. AGENTS.md와 중복되던 Golden Rules/커뮤니케이션/Operational Commands/Context Map을 제거하고, Claude Code 고유 내용(서브 에이전트 사용 원칙, 공통 규칙 참조 라우팅)만 남겼다.
  - `AGENTS.md` 커뮤니케이션 섹션의 "확인되지 않은 사항은 사실처럼 단정하지 않는다" 항목을 제거했다. 동일 의미 문장이 Golden Rules에 이미 존재한다.
  - `STATE.md`의 과거 기록 중 실제 AGENTS.md 섹션명과 어긋나던 표현을 정정했다. (`Standards & References` 삭제, `공통 코딩 원칙` -> `세부 규칙 위임`으로 보정)
- 워크스페이스 3개 폴더 기준 실행 셋팅을 재확인했다. (2026-05-04)
  - 현재 워크스페이스 폴더는 `claude-agent-template`, `rider-platform-docs`, `riderapp-runtime`이다.
  - `claude-agent-template`은 에이전트 운영 규칙/템플릿 저장소이며 실행 앱이 아니다.
  - `rider-platform-docs`는 라이더 플랫폼 비즈니스/시스템 설계 문서 저장소이며 실행 앱이 아니다.
  - 실제 실행 대상은 `riderapp-runtime`이다.
  - `riderapp-runtime/rules` 심볼릭 링크가 `/home/skyua/projects/claude-agent-template`을 가리키는 것을 확인했다.
  - `riderapp-runtime`에서 `pnpm typecheck`와 `pnpm build`가 통과했다.
  - 웹 대시보드 실행 명령은 `cd /home/skyua/projects/riderapp-runtime && pnpm dev:web`이며 기본 주소는 `http://localhost:3030`이다.
  - CLI 시뮬레이션 명령은 `pnpm dev:cli simulate simple`이다.
  - 실제 Claude Agent SDK 작업 실행에는 `riderapp-runtime/.env`의 `ANTHROPIC_API_KEY`가 필요하다.

## 다음 작업

### 디자인 라이브러리 후속 (사용자 검수 대기)
- **사용자가 `docs/admin-fe-preview.html` 브라우저 시각 검수 진행 중**. 활성 시안 = `wanted`. dropdown으로 5개 시안 토글하며 의도와 다른 부분 발견 시 토큰값/fallback/시그너처 spec 조정 예정. 검수 결과 받으면 해당 카탈로그 갱신 + STATE 변경 이력 기록.
- preview HTML fetch 모델 마이그레이션은 시안 5종 단계에서 보류. 시안 10+ 시점에 재검토(현재 inline 모델 86KB는 충분히 가벼움).
- 라이브러리 v1 시드 5종 완성: `wanted`, `minimal-mono`, `toss-like`, `material-3`, `linear-like`. 추가 시안 요청 시 `designs/_template.md`에서 시작.

### 기존 보류 항목

- i18n locale별 구현 예시(키 구조, 디렉터리 배치, fallback 코드 샘플)를 추가한다.
- 비즈니스 로직 요청 예시에서 build/docker/git 작업이 실제로 어떻게 흘러가는지 단계별 시나리오를 추가한다.
- 프레임워크 구조 intake 답변을 받아 만든 실제 디렉터리 트리 예시를 추가한다.
- startup-checklist 답변을 저장하는 `docs/ui-decisions.md` 템플릿을 추가한다. (동기화 메모: 신설 시 `docs/development-process.md:89` 단계 6도 함께 갱신. 한쪽이 변경되면 다른 쪽도 동기화한다.)
- 필요하면 `docs/template-usage.md` 또는 예시 프로젝트 문서를 추가한다.
- 필요하면 `docs/codex-reading-order.md`와 루트 `AGENTS.md`의 빠른 읽기 순서 중복을 더 줄인다.
- `riderapp-runtime/README.md`의 예전 `riderapp` 경로 설명을 현재 워크스페이스 구조(`claude-agent-template`, `rider-platform-docs`, `riderapp-runtime`)에 맞게 갱신한다.
- intake.html에 나머지 intake 템플릿(project/ui/responsive/tech/i18n/format/api/error/routing/form/qa/framework-structure)도 폼으로 추가한다.
- md → HTML 자동 동기화 스크립트 또는 단일 진입점(`docs/index.html`) 도입을 검토한다.

## 현재 기준 파일

- 공통 규칙: `AGENTS.md`
- 템플릿 사용 안내: `README.md`
- 상태 인계: `STATE.md`
- Claude Code 운영 설정: `CLAUDE.md`
- 역할별 지침: `agents/main-agent.md`, `agents/executor-agent.md`, `agents/reviewer-agent.md`, `agents/researcher-agent.md`
- Skills (자동 활성화): `.claude/skills/start/SKILL.md`, `.claude/skills/intake/SKILL.md`, `.claude/skills/request/SKILL.md`, `.claude/skills/feature/SKILL.md`, `.claude/skills/bugfix/SKILL.md`, `.claude/skills/refactor/SKILL.md`, `.claude/skills/review/SKILL.md`, `.claude/skills/business-logic/SKILL.md`, `.claude/skills/design/SKILL.md`
- Slash Commands (명시적 호출): `.claude/commands/start.md`, `.claude/commands/intake.md`, `.claude/commands/request.md`, `.claude/commands/feature.md`, `.claude/commands/bugfix.md`, `.claude/commands/refactor.md`, `.claude/commands/review.md`, `.claude/commands/business-logic.md`
- 가드레일 hooks: `.claude/hooks/block-destructive.sh`, `.claude/hooks/block-secret-files.sh`, `.claude/hooks/state-reminder.sh`, `.claude/hooks/warn-design-tokens.sh` (opt-in)
- hooks 설정: `.claude/settings.local.json`
- 서브에이전트 템플릿: `.claude/agents/explorer.md`, `.claude/agents/code-reviewer.md`, `.claude/agents/planner.md`, `.claude/agents/test-runner.md`, `.claude/agents/feature-dev.md`, `.claude/agents/design-reviewer.md`
- 플러그인: `.claude/plugins/manifest.json`, `.claude/plugins/VERSION`, `.claude/plugins/install.sh`
- 플러그인 가이드: `docs/plugin-guide.md`
- 요청 템플릿: `templates/feature-request.md`, `templates/bugfix-request.md`, `templates/review-request.md`, `templates/refactor-request.md`, `templates/business-logic-request.md`
- intake 템플릿: `templates/project-intake.md`, `templates/ui-intake.md`, `templates/responsive-intake.md`, `templates/tech-intake.md`, `templates/i18n-intake.md`, `templates/framework-structure-intake.md`, `templates/startup-checklist.md`, `templates/api-intake.md`, `templates/error-intake.md`, `templates/form-intake.md`, `templates/format-intake.md`, `templates/qa-intake.md`, `templates/routing-intake.md`
- guide 템플릿: `docs/project-guide-template.md`, `docs/i18n-guidelines.md`, `docs/business-logic-playbook.md`, `docs/framework-structure-guide.md`, `docs/design-guidelines.md`, `docs/admin-fe-design-guide.md`
- 디자인 시스템 카탈로그(active): `DESIGN.md`
- 디자인 시안 라이브러리: `designs/README.md`, `designs/_alias-contract.md`, `designs/_template.md`, `designs/wanted.md`, `designs/minimal-mono.md`, `designs/toss-like.md`, `designs/material-3.md`, `designs/linear-like.md`
- 디자인 시안 selector: `.claude/plugins/select-design.sh`
- 운영 아티팩트: `docs/codex-reading-order.md`, `docs/subagent-guide.md`, `docs/development-process.md`, `docs/development-process.html`, `docs/intake.html`, `docs/admin-fe-preview.html`
- 런타임 앱: `../riderapp-runtime/` (sibling 저장소)
- 비즈니스 설계 문서: `../rider-platform-docs/` (sibling 저장소, rider platform 전용)

## 주의 사항

- 이 저장소의 목적은 `런타임 멀티 에이전트 앱` 구현이 아니라 `개발 프로젝트용 에이전트 운영규칙 템플릿` 정리다.
- rider platform 비즈니스 도메인 설계 문서는 이 저장소에 두지 않는다. (`../rider-platform-docs/`로 이동)
- 이후 코드 파일을 추가하더라도 공통 규칙과 템플릿 문서의 목적을 흐리지 않도록 유지한다.

## 알려진 TODO

- 프로젝트별 커스텀 항목 체크리스트 추가
- 세션 종료 시 상태 업데이트 예시 추가
- 필요 시 역할별 금지 사항 섹션 강화
