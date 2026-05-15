# 디자인 운영 가이드

`DESIGN.md`(디자인 시스템 카탈로그)를 이 저장소에서 어떻게 호출하고 갱신하는지 정리한 메타 가이드다. `DESIGN.md`가 자산 자체(토큰·컴포넌트·Do/Don't)라면 이 문서는 자산을 다루는 운영 규칙이다.

## 1차 소스 규칙

- UI/스타일 산출물을 만들거나 검토할 때 1차 소스는 항상 `DESIGN.md`다.
- 토큰값은 `DESIGN.md`에 정의된 형식을 그대로 호출한다. hex/px 직접 표기는 toolchain(CSS/JSX) 빌드 시에만 사용한다.
- `DESIGN.md`의 인용 출처(`[src:1]` 외부 URL)는 reference용이다. 본 카탈로그의 토큰·컴포넌트 정의는 self-contained이며 오프라인에서도 사용 가능하다.

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

위반이 의심되면 `.claude/agents/design-reviewer.md` 서브에이전트를 호출해 일괄 점검한다.

## 카피 톤

- product 카피: 친근한 존댓말(`-요`/`-어요`/`-아요`) 종결을 표준으로 한다.
- 버튼 라벨: 동사 형태(`지원하기`, `저장하기`, `시작하기`, `둘러보기`) 표준.
- UI 라벨·리스트 아이템 끝에 마침표를 찍지 않는다.
- 영어 라벨은 항상 sentence case. ALL-CAPS, Title Case In Buttons 금지.

## 메타 운영

- `DESIGN.md`의 frontmatter(`name`, `slug`, `category`, `last_updated`)는 카탈로그 메타다. 다른 프로젝트로 복제할 때는 해당 프로젝트의 디자인 시스템 정보로 갱신한다.
- `DESIGN.md`를 갱신했으면 `last_updated` 필드를 같은 커밋에서 함께 수정한다.
- `DESIGN.md`와 product 코드(CSS 변수·Tailwind config·Theme 정의)가 어긋나면, `DESIGN.md`를 정본으로 본다. 코드 쪽을 카탈로그에 맞춘다.

## 자동 활성화 흐름

디자인 키워드가 사용자 메시지에 등장하면 `.claude/skills/design/SKILL.md`가 자동 활성화되어 `DESIGN.md`를 강제 로드한다. `feature`/`refactor`/`bugfix` 진행 중 UI 영향이 발견되면 design skill이 추가로 활성화되어 일관성 항목을 보강한다.

상세 흐름은 `CLAUDE.md ## Design System` 섹션과 `.claude/skills/design/SKILL.md`를 참조한다.
