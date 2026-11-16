# 디자인 운영 가이드

`DESIGN.md`(디자인 시스템 카탈로그)를 이 저장소에서 어떻게 호출하고 갱신하는지 정리한 메타 가이드다. `DESIGN.md`가 자산 자체(토큰·컴포넌트·Do/Don't)라면 이 문서는 자산을 다루는 운영 규칙이다.

## 1차 소스 규칙

- UI/스타일 산출물을 만들거나 검토할 때 1차 소스는 항상 `DESIGN.md`다.
- 토큰값은 `DESIGN.md`에 정의된 형식을 그대로 호출한다. hex/px 직접 표기는 toolchain(CSS/JSX) 빌드 시에만 사용한다.
- `DESIGN.md`의 인용 출처(`[src:N]`)는 frontmatter `sources` 항목(예: `https://api.anthropic.com/v1/design/...`)을 가리키는 reference 표기다. 본 카탈로그의 토큰·컴포넌트·Do/Don't 정의는 self-contained로 작성되어 있어 인용 출처가 오프라인이거나 만료되어도 본 문서만으로 디자인 시스템을 운영할 수 있다.
- 외부 URL 재방문은 다음 경우에만 수행한다.
  - SSOT 번들(`wanted-design-system/` 등) 갱신
  - 신규 컴포넌트/토큰 추가 시 출처 검증
  - 인용 출처 만료/이전(rotation) 추적
- 외부 URL이 만료되어도 본 카탈로그의 운영은 계속 가능해야 하며, 추후 보강이 필요하면 인용 마크만 `[src:N (archived)]` 표기로 보존한다.

## 토큰 호출 형식

답변 본문이나 문서에서 토큰을 호출할 때는 `{group.name}` 형식을 사용한다.

- 색: `{colors.bg-brand}`, `{colors.fg-default}`, `{colors.fg-secondary}`, `{colors.border-subtle}`
- 간격: `{spacing.space-4}` ~ `{spacing.space-128}` (4의 배수 사다리, 6/10/14/18/22 도입 금지)
- 라운드: `{rounded.radius-2}` ~ `{rounded.radius-32}`, `{rounded.radius-full}`
- 타이포: `{typography.display1}`, `{typography.title1}`, `{typography.body1}`, `{typography.body1-read}`, `{typography.caption1}` 외 18종
- elevation: `{elevation.shadow-1}` ~ `{elevation.shadow-4}`, `{elevation.shadow-pop}`

## alias vs atomic 선택 기준

- product surface에서는 시맨틱 alias(`bg-*`, `fg-*`, `border-*`)를 호출한다. 의미가 코드에 드러나고 light/dark 자동 대응된다.
- atomic ramp(`blue-800`, `neutral-700`, `red-100` 등)는 다음 경우에만 직접 호출한다.
  - 새 시맨틱 alias를 정의하는 시점
  - DESIGN.md에 alias로 surface되지 않은 색이 필요한 시점
  - 그라디언트 stop 정의
- `gray-*` 패밀리는 utility용이다. UI 표면 색에는 `neutral-*` 패밀리를 호출한다.

## 다크 모드 alias 정책

- `DESIGN.md`의 `### Semantic alias — Dark` 섹션이 surface한 토큰을 우선 사용한다.
- SSOT가 dark에서 surface하지 않은 alias(`bg-danger-subtle`, `fg-brand` 등)는 **합성(synthesized)** 표기로 적정 대비값을 명시한다. 패턴은 `DESIGN.md ## Known Gaps`의 다크 alias 합성 규칙(blue-400 brightened, semantic hue @ ↑ lightness)을 따른다.
- 합성값을 새로 추가하면 `DESIGN.md`에 synthesized 주석과 함께 기록한다.

## 새 컴포넌트 추가 절차

1. 기존 14개 컴포넌트(button, input, checkbox, toggle, chip, filter-pill, badge, header, nav-link, search, icon-button, avatar, job-card, job-detail-hero, hero-banner, filter-bar, toast, alert, empty-state, icon, logo)로 충족 가능한지 먼저 확인한다.
2. 충족 불가하면 `DESIGN.md`의 `## Components` 섹션에 새 컴포넌트 정의를 추가한다. 양식은 기존 컴포넌트와 동일(상태·variant·토큰 호출·코드 예시).
3. 컴포넌트별 로컬값(예: job-card body padding `14 16 16`, button sm radius `6`)은 글로벌 토큰이 아님을 명시한다.
4. 추가/변경 사항을 `STATE.md` `이번 세션에서 완료한 작업` 섹션에 토큰/컴포넌트 변경 이력으로 기록한다.

## Do/Don't 운영

`DESIGN.md`의 `## Do's and Don'ts`는 위반 빈도가 높은 항목을 모아둔 곳이다. 다음은 특히 자주 검출되는 위반 패턴이다.

- 이모지를 product UI에 inline으로 사용 → monochrome SVG 또는 평면 일러스트로 대체
- gradient를 CTA·헤더·풀-블리드 본문에 적용 → 4개 허용 위치(심볼/아바타/잡카드 thumb/마케팅 hero)로만 한정
- `gray-*` 패밀리를 UI 표면 색으로 직접 사용 → `neutral-*` 패밀리에서 호출
- 6/10/14/18/22 같은 비-4의 배수 spacing·radius 도입 → `{spacing.*}` / `{rounded.*}` 사다리 값 사용
- 카드에 그림자 적용 → 1px `{colors.border-subtle}` 헤어라인이 표준, 그림자는 popover/dropdown/modal/toast에만
- 격식체(`-습니다`, `-십시오`) product 카피 → `-요`/`-어요`/`-아요` 종결
- 챗봇 톤(`~해보세요!`, `여기를 눌러주세요`), 마케팅 과장(`혁신적`, `최고의`) → 절제된 동사형 라벨

위반이 의심되면 Claude에서는 `.claude/agents/design-reviewer.md`, Codex에서는 `.codex/agents/design-reviewer.md` 기준으로 일괄 점검한다.

## 카피 톤

- product 카피: 친근한 존댓말(`-요`/`-어요`/`-아요`) 종결을 표준으로 한다.
- 버튼 라벨: 동사 형태(`지원하기`, `저장하기`, `시작하기`, `둘러보기`) 표준.
- UI 라벨·리스트 아이템 끝에 마침표를 찍지 않는다.
- 영어 라벨은 항상 sentence case. ALL-CAPS, Title Case In Buttons 금지.

## STATE.md 변경 이력 운영 규칙

- `DESIGN.md`의 토큰·컴포넌트·Do/Don't·dark alias가 추가/변경/삭제되면 같은 커밋에서 다음을 수행한다.
  1. `DESIGN.md` frontmatter `last_updated`를 오늘 날짜로 갱신.
  2. `STATE.md` `이번 세션에서 완료한 작업` 섹션에 변경 이력을 한 줄 이상 기록한다. 형식 예: `- DESIGN.md 갱신: {colors.bg-accent} alias 신규 추가 (사유: 프로젝트 브랜드 컬러 도입). last_updated 2026-05-15. (YYYY-MM-DD)`
  3. 신규 컴포넌트가 추가된 경우 `STATE.md` `현재 기준 파일` 섹션은 `DESIGN.md` 단일 항목 그대로 유지(컴포넌트별로 나누지 않는다).
- 위 규칙은 `AGENTS.md ## 문서화 원칙`에도 동일하게 명시되어 있다. 두 문서가 어긋나면 design-guidelines.md를 정본으로 본다.

## 라이브러리 (designs/) 사용 흐름

- `designs/` 폴더는 사용 가능한 디자인 시안 라이브러리다. root `DESIGN.md`는 라이브러리에서 선택된 시안의 활성 사본이다.
- 라이브러리 목록 확인: `bash .claude/plugins/select-design.sh --list`
- 시안 활성화(스위치): `bash .claude/plugins/select-design.sh <slug>` — `designs/<slug>.md` → `DESIGN.md` 복사 + `.claude/.active-design` 갱신.
- **라이브러리 소스 결정 순서**: 프로젝트 `designs/` > `rules/designs/`(공통 템플릿 symlink) > 스크립트 위치 기준 추론. 산출물(`DESIGN.md`, `.claude/.active-design`)은 소스와 무관하게 **항상 프로젝트 루트**에 쓴다. 따라서 `designs/`를 복사하지 않고 `rules/` symlink만 연결한 프로젝트에서도 스위치가 동작하며, 공통 템플릿의 `DESIGN.md`는 덮어쓰지 않는다.
- install 시 기본 시안 지정: `bash .claude/plugins/install.sh --design <slug> /target` (기본값 `wanted`).
- 신규 시안 작성: `cp designs/_template.md designs/<slug>.md` 후 frontmatter + 본문 채움. `designs/_alias-contract.md`의 alias 25종 + 컴포넌트 7종 시그너처는 반드시 정의.
- DESIGN.md를 직접 편집한 상태에서 select-design.sh를 실행하면 자동으로 `DESIGN.md.bak`을 만든 뒤 덮어쓴다.
- **시안 전용 토큰 fallback**: 특정 시안만 정의하는 추가 토큰(`radius-6`, `radius-20`, `radius-28`, `shadow-3/4`, `font-mono` 등)은 다른 시안 전환 시 미정의가 된다. 호출 코드는 가능하면 표준 alias만 사용하고, 전용 토큰을 호출해야 하면 `var(--token, fallback)` 패턴 또는 컴포넌트 단위 분리(예: linear-like 비활성 시 `kbd` 컴포넌트를 `chip`으로 대체)를 사용한다. 매핑 표는 `designs/_alias-contract.md ## 9b` 참조.

## Claude Design System 동기화

2026-11-16부터 시안의 **원본은 Claude 안의 Design System**(Artifact)이고, `designs/<slug>.md`는 그 스냅샷이다. 단독 Claude Design(claude.ai/design)은 2026-12-14에 닫히고, 디자인 기능은 Claude 안의 Design System·Design 캔버스로 옮겨졌다.

- **연결 정보**: 각 시안 frontmatter의 `claude_design_system:`(`url`, `version`, `synced`). `node scripts/design-sync.mjs status`로 한 번에 본다.
- **고치는 곳**: 디자인은 Claude의 Design System 페이지·Design 캔버스·채팅에서만 고친다. `designs/*.md`와 `DESIGN.md`를 손으로 고치지 않는다(다음 동기화 때 덮어써진다).
- **Claude 쪽 파일**: `project/README.md`(시안 본문 전체 그대로), `project/frontmatter.txt`(시안 frontmatter, 연결 정보 제외), `project/tokens.json`(README의 yaml 블록에서 뽑은 색·글꼴·간격·라운드·그림자 — 목업이 쓰는 값), `project/components/Cover/preview.html`(표지). README가 기준이고 토큰은 README에서 다시 만든다.

### 세션 시작 점검 (Claude Code)

1. `node scripts/design-sync.mjs status`로 연결된 시안과 기록된 버전을 본다(최소 활성 시안 `.claude/.active-design`).
2. Artifact 도구로 각 Design System의 `project/README.md`를 읽어 현재 버전을 확인한다. 기록된 `version`과 같으면 끝.
3. 다르면 `project/README.md`·`project/frontmatter.txt`·`project/tokens.json`을 scratchpad 한 폴더로 내려받아 들여온다:
   `node scripts/design-sync.mjs import <slug> --from <폴더> --url <url> --version <버전>`
   - 페이지 토큰 편집기로 바꾼 색은 README의 해당 yaml 줄에 되돌려 반영된다.
   - 되돌릴 수 없는 차이(간격·라운드 등 색 외 값, README에 없는 토큰)가 있으면 파일을 쓰지 않고 종료 코드 2로 멈춘다. 이때는 Claude 쪽 README를 고쳐 맞춘 뒤 다시 들여온다.
4. `node scripts/design-sync.mjs preview`로 프리뷰 3화면의 별칭 색이 맞는지 보고, 어긋나면 `--fix`로 값만 고친다.
5. 활성 시안이 바뀌었으면 `cp designs/<slug>.md DESIGN.md`로 활성 사본을 맞춘다(`select-design.sh`는 직접 편집으로 보고 백업을 남기므로 이 경우엔 쓰지 않는다).
6. 바뀐 파일은 평소처럼 6단계 절차로 커밋·PR한다. Codex와 연결 프로젝트는 이 커밋된 스냅샷을 쓴다.

### 새 시안 추가

`designs/_template.md`로 `designs/<slug>.md`를 만든 뒤 한 번만 반대로 올린다: `node scripts/design-sync.mjs export <slug> --out <폴더> --suffix " (claude-agent-template)"` → Artifact 도구로 Design System 유형에서 새 시스템 생성 → `<폴더>/<slug>`를 `root`로 게시 → 다시 내려받아 `import`(연결 정보 기록). 이후로는 Claude 쪽에서만 고친다.

### 디자인 작업과의 연결

- 화면 목업이 필요하면 Claude의 Design 캔버스에서 활성 시안의 Design System을 골라 만든다. 승인된 목업 → 구현 → `design-reviewer` 순서.
- 목업 중 토큰을 바꿔야 하면 Design System에서 바꾸고 위 세션 시작 점검 3~6으로 저장소에 내린다.
- Design System은 기본 비공개다. 함께 작업할 사람에게는 페이지의 공유 메뉴로 공유한다.
- Codex는 Claude Artifact를 읽을 수 없다. Codex 세션은 `status`로 마지막 동기화 날짜만 알리고, 최신 확인과 들여오기는 Claude Code 세션에서 한다.
- 검사: `node scripts/design-sync.mjs check`(토큰 변환·프리뷰 일치, 네트워크 없음).

## 메타 운영

- `DESIGN.md`의 frontmatter(`name`, `slug`, `category`, `last_updated`)는 카탈로그 메타다. 다른 프로젝트로 복제할 때는 해당 프로젝트의 디자인 시스템 정보로 갱신한다.
- **install 정책(라이브러리 도입 후 갱신)**: `install.sh --design <slug>`로 라이브러리에서 시안을 골라 활성화한다. 옵션:
  - (a) 라이브러리 시안 그대로 사용 (기본): `--design wanted` 등 기존 시안 슬러그.
  - (b) 라이브러리에서 fork: `cp designs/wanted.md designs/<custom>.md` 후 편집, `select-design.sh <custom>`.
  - (c) 활성 DESIGN.md 직접 편집: `select-design.sh` 미사용, root만 수정. 다음 select-design.sh 실행 시 백업됨.
- 신규 프로젝트는 `templates/startup-checklist.md` 섹션 3 Q6~Q8에서 라이브러리 선택과 frontmatter 재작성을 진행한다.
- `DESIGN.md`를 갱신했으면 `last_updated` 필드를 같은 커밋에서 함께 수정한다.
- `DESIGN.md`와 product 코드(CSS 변수·Tailwind config·Theme 정의)가 어긋나면, `DESIGN.md`를 정본으로 본다. 코드 쪽을 카탈로그에 맞춘다.

## 토큰 외 값 정적 경고 hook (opt-in)

`.claude/hooks/warn-design-tokens.sh`는 PreToolUse Write/Edit hook으로 등록 가능한 opt-in 가드레일이다.

- 검출 대상: (1) hex 색상 직접 사용(`colors_and_type.css` 외 파일에서), (2) 비-4의 배수 px 값(6/10/14/18/22).
- 적용 파일: `*.css`, `*.scss`, `*.less`, `*.tsx`, `*.jsx`, `*.ts`, `*.js`, `*.vue`, `*.svelte`. 그 외는 즉시 통과.
- 검사 본문: Write는 `content`, Edit는 `new_string`, MultiEdit는 `edits[].new_string` 전체를 대상으로 한다.
- 운영 정책: 경고만 출력하고 차단하지 않는다(항상 `exit 0`). false-positive 우려와 정적 검출의 한계로 인해 `settings.local.json`에는 기본 등록하지 않는다.
- 경고 전달 방식: stdout JSON의 `hookSpecificOutput.additionalContext`로 모델에게 전달한다. `exit 0`의 stderr는 Claude Code가 버려서 경고가 아무에게도 도달하지 않으므로 쓰지 않는다(`state-reminder.sh`와 같은 규약).
- 활성화 방법: 디자인 토큰 강제가 필요한 프로젝트에서 `settings.local.json`의 `hooks.PreToolUse`에 다음 항목을 추가한다.

```json
{
  "matcher": "Write|Edit|MultiEdit",
  "hooks": [{ "type": "command", "command": "bash .claude/hooks/warn-design-tokens.sh" }]
}
```

## preview 시각 검증

라이브러리 시안의 토큰·컴포넌트가 의도대로 렌더링되는지 `docs/admin-fe-preview.html`에서 확인한다.

- 신규 시안 추가 시 `admin-fe-preview.html`의 `<style>` 블록에 시안의 `## CSS Variables` 두 블록(`:root[data-design][data-theme]`)을 inline 하고, `<script>` 의 `DESIGNS` 객체에 한 항목 추가한다.
- preview 상단 dropdown으로 시안 토글 후 다음을 시각 검수한다.
  - 색 swatch 9종(background) + 텍스트 위계 9종(foreground) — 알 수 없는 색/누락 없음
  - admin 5종 컴포넌트가 헤어라인/그림자/gradient 정책 차이를 정확히 반영
  - frontmatter `policy:` 블록과 POLICY strip의 chip이 일치
- 위반 시 시안 md의 `## CSS Variables`와 `## Do's and Don'ts`를 우선 갱신한다.

## 런타임 연계 흐름

디자인 키워드가 사용자 메시지에 등장하면 Claude에서는 `.claude/skills/design/SKILL.md`가 자동 활성화되고, Codex에서는 `.agents/skills/design/SKILL.md`가 자동 선택되어 `DESIGN.md`를 강제 로드한다. 상세 호환 절차는 `.codex/workflows/design.md`를 따른다. `feature`/`refactor`/`bugfix` 진행 중 UI 영향이 발견되면 같은 디자인 절차를 추가 적용해 일관성 항목을 보강한다.

상세 흐름은 `CLAUDE.md ## Design System`, `.claude/skills/design/SKILL.md`, `.agents/skills/design/SKILL.md`, `.codex/workflows/design.md`를 참조한다.
