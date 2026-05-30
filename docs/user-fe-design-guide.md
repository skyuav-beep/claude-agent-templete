# User FE 디자인 가이드 (반응형판)

consumer-facing user FE 표면을 만들 때 `DESIGN.md`의 토큰·컴포넌트를 어떻게 조립하는지 정리한 가이드다. `DESIGN.md`가 atomic spec이라면 이 문서는 화면 단위 patterns다. 본 가이드는 반응형(mobile/tablet/desktop 단일 코드베이스) 운영을 가정하며, 모바일 전용(viewport 360~430 고정) 변형은 별도 `docs/user-fe-mobile-design-guide.md`로 분리한다.

본 가이드는 `DESIGN.md`를 1차 소스로 호출하며, 토큰값을 직접 적지 않고 `{group.name}` 형식으로만 호출한다.

## 1차 원칙 (반응형 user FE 공통)

본 섹션은 모든 시안에 공통 적용되는 시안 무관 원칙이다. 시안별 정책(카드 그림자, gradient 위치, 카피 톤)은 활성 시안의 frontmatter `policy:` 블록과 `## Do's and Don'ts` 섹션을 따른다.

**시안 무관 (alias 계약 기반)**
- 색상은 시맨틱 alias 우선(`bg-*`, `fg-*`, `border-*`), atomic ramp는 새 alias 정의 시에만.
- spacing/radius는 `{spacing.*}` / `{rounded.*}` 사다리만 사용. 6/10/14/18/22 도입 금지(시안의 `policy.non_4_spacing`이 false인 한).
- 텍스트 위계는 alpha multiplier(`fg-strong/default/secondary/tertiary/disabled`)로 표현.
- 이모지를 product UI에 inline 사용 금지. 화살표·아이콘은 monochrome SVG `currentColor` 상속.
- 1px 헤어라인 보더(`{colors.border-subtle}`)가 카드 구조의 기본. 그림자 사용 여부는 시안 정책.

**반응형 user FE 특화 원칙**
- **mobile-first** — 모바일(<640) 레이아웃을 1차로 설계하고 tablet·desktop으로 확장한다(반대 방향 금지).
- **touch target 44×44** 보장 — desktop 마우스 환경에서도 모바일 hit area 정책을 그대로 유지한다(`{component.input}` 44, `{component.button}` sm 32은 padding으로 hit area 보장).
- **nav 컴포넌트 분기** — mobile: `### bottom-nav`, tablet: top-tab 또는 collapsed sidebar, desktop: `### sidebar-nav` 또는 top-nav.
- **safe-area-inset** — `### app-bar (mobile)`의 top padding과 `### bottom-nav`의 bottom padding에 `env(safe-area-inset-*)`를 합산(iOS notch / home indicator 회피).
- **breakpoint별 컴포넌트 교체** 시 동일 alias 호출 유지 — `bg-surface`/`fg-default`/`border-subtle`는 모든 breakpoint에서 동일하게 호출하고, 레이아웃 토큰(`spacing`/`grid-columns`)만 분기.

**시안 정책에 따라 분기**
- 카드 그림자: `policy.shadow_on_cards` (true: toss-like/material-3, false: wanted/minimal-mono/linear-like)
- gradient 위치: `policy.gradient_locations` 배열에 명시된 위치 외 사용 금지
- 카피 톤: `policy.copy_tone` (ko-friendly: `-요`/`-어요`/`-아요` + 동사형 / ko-formal: `-습니다` / en-sentence: sentence case)
- 단일 강조색: `{colors.bg-brand}` 1개만 primary CTA에 (시안의 brand 정의 따름)

## Breakpoints

`DESIGN.md ## Responsive Behavior`의 4단계 breakpoint를 user FE에 동일하게 적용한다.

| Name | Width | Columns | Gutter | nav 컴포넌트 | feed 카드 |
|---|---|---|---|---|---|
| Mobile | ≤ 640 | 4 | `{spacing.space-16}` | `### bottom-nav` (3~5탭) | vertical, 1열 또는 carousel |
| Tablet | 641–1023 | 8 | `{spacing.space-24}` | top-tab 또는 collapsed `### sidebar-nav` | vertical, 2~3열 grid |
| Desktop | 1024–1279 | 12 | `{spacing.space-24}` | `### sidebar-nav` (admin) 또는 top-nav | vertical, 3~4열 grid |
| Large desktop | ≥ 1280 | 12 | `{spacing.space-24}` | 동일 | vertical, 4열 grid, max-content-width 1280 |

## 화면 골격

### Mobile (≤ 640) — 1차 설계

```
+------------------------------+
| app-bar (52h, sticky top)    |  ← {component.app-bar (mobile)}
+------------------------------+
|                              |
|  content (scroll)            |
|  padding {spacing.space-16}  |
|                              |
|                              |
+------------------------------+
| bottom-nav (56h, sticky)     |  ← {component.bottom-nav}
+------------------------------+
```

### Tablet (641–1023) — 변환 단계

```
+------+------------------------+
| side | top-bar                |
| nav  +------------------------+
| 200  | content                |
| (col |   padding              |
|  laps|     {spacing.space-24} |
|  ed) |                        |
+------+------------------------+
```

bottom-nav는 사라지고 좌측 collapsed sidebar 또는 top-tab으로 전환.

### Desktop (≥ 1024) — admin 골격 재사용

`docs/admin-fe-design-guide.md ## 화면 골격`의 3영역 구조와 동일하지만 max-content-width를 마케팅 1080 또는 user-facing 1200으로 운영(admin은 1280).

## 1. Splash / Onboarding

신규 사용자 첫 진입 화면. 앱 시작 splash → 3-step walkthrough → CTA 흐름.

```
+------------------------------+
|                              |
|     [brand 48~64px]          |
|     앱 한 줄 가치 제안          |  ← {typography.title1}
|     sub 설명 1줄              |  ← {typography.body1} fg-secondary
|                              |
|     [page-indicator ● ○ ○]   |  ← carousel dot
|                              |
|     [ 시작하기 ] lg full       |  ← {component.button-primary}
|     이미 계정이 있어요          |  ← {component.button-ghost} 텍스트 링크
|                              |
+------------------------------+
```

- 카드 없이 캔버스 직접 사용. background `{colors.bg-canvas}` + 상하 큰 여백 `{spacing.space-32}`.
- walkthrough 3-step은 swipe carousel. 좌우 dot indicator (`{colors.fg-brand}` active, `{colors.fg-disabled}` inactive). 자동 진행 금지.
- 브랜드 일러스트는 평면, 기하학적 — 시안의 `policy.gradient_locations`에 `"hero"` 또는 `"thumbnail"`이 있으면 gradient 일러스트 허용, 아니면 monochrome SVG.
- 카피 패턴 (ko-friendly): `처음이신가요?`, `지금 시작해 보세요`, `다음 단계로` / (en-sentence): `Get started`, `Continue`, `Skip for now`.

## 2. Signup / Login

`### login-layout` 컴포넌트를 user FE에 그대로 사용하되 mobile에서는 카드 없이 풀스크린, desktop에서는 admin과 동일한 중앙 카드.

### Mobile

```
+------------------------------+
| app-bar (back-button 좌측)    |
+------------------------------+
|                              |
|     [brand 32px]             |
|     로그인                     |  ← {typography.title1}
|     사용 중인 계정으로          |  ← {typography.body2} fg-secondary
|                              |
|     [email input  48h ]      |  ← mobile은 48~52 height
|     [password input  48h ]   |
|                              |
|     [ 로그인하기 ] lg full      |  ← {component.button-primary}
|                              |
|     비밀번호 찾기  ·  회원가입   |  ← {component.button-ghost} 중앙
|                              |
|     ──── 또는 ────             |  ← divider
|     [ Apple로 시작하기 ] outline lg
|     [ Google로 시작하기 ] outline lg
|                              |
+------------------------------+
```

- 카드 없음, content padding `{spacing.space-24}` `{spacing.space-32}`.
- 소셜 로그인 버튼은 `{component.button-secondary}` outline 변형. 브랜드 컬러 직접 호출 금지(monochrome currentColor + 좌측 18px icon).
- 에러 inline: 입력 하단 `{component.alert}` inline. 카피 (ko-friendly): `이메일 또는 비밀번호가 일치하지 않아요`.

### Desktop

admin login-layout과 동일. 카드 width 400, padding `{spacing.space-32}`, radius `{rounded.radius-12}`.

## 3. 홈 / 피드

user FE의 가장 빈번한 진입 화면. hero/banner → 카테고리 chip → feed-card list 구성.

```
app-bar (logo 좌측, search/notification 우측)
+------------------------------+
| [hero banner 또는 promo card] |  ← 옵션, full-bleed 또는 카드
+------------------------------+
| [chip] [chip] [chip] ...     |  ← horizontal scroll chip-row
+------------------------------+
| [feed-card vertical]         |  ← mobile 1열
| [feed-card vertical]         |
| [feed-card vertical]         |
+------------------------------+
bottom-nav
```

- hero banner는 시안 `policy.gradient_locations`에 `"hero"` 있을 때만 gradient. 없으면 평면 색 + 1px 헤어라인 또는 이미지.
- 카테고리 chip-row는 horizontal scroll. 모바일은 좌우 peek 16px. desktop은 wrap.
- feed-card list는 mobile 1열, tablet 2열, desktop 3~4열 grid. 카드 간 gap은 `{spacing.space-16}`.
- pull-to-refresh는 mobile 표준. desktop은 새로고침 버튼 또는 자동 polling.

### 시안별 hero 패턴

| 시안 | hero 표면 | gradient | CTA |
|---|---|---|---|
| `wanted` | 1px border + 평면 색, padding 24 | 미사용(`gradient_locations`에 hero 있음 — 마케팅 surface 한정, 본 user FE 홈에는 미적용) | `{component.button-primary}` md |
| `minimal-mono` | 1px border + 평면 흑백 | 전면 금지 | 검정 채움 md |
| `toss-like` | full-bleed gradient banner + 큰 카피 | 허용 (`hero` 위치) | bg-brand 파랑 lg |
| `material-3` | elevated card shadow-2 + 큰 라운드 | 미사용 | filled button radius-full |
| `linear-like` | dark canvas + gradient accent text | 허용 (`accent`/`hero` 위치) | gradient CTA + kbd hint (옵션) |

## 4. 탐색 / 리스트

검색 + 필터 + 정렬이 함께 있는 카탈로그 화면.

```
app-bar (back-button 좌측, page-title 중앙 또는 search-bar)
+------------------------------+
| [search-bar (full-width)]    |  ← {component.search-bar}
+------------------------------+
| [chip 정렬] [chip 필터] ...   |  ← filter chip-row + 우측 grid/list 토글
+------------------------------+
| [feed-card] [feed-card]      |  ← grid 2열 (mobile)
| [feed-card] [feed-card]      |
+------------------------------+
bottom-nav (홈 탭 활성)
```

- 필터 chip 클릭 → `### bottom-sheet` 진입(다중 선택). 적용된 필터는 chip에 카운트 badge (`필터(3)` 텍스트 금지 → badge sm).
- 정렬은 단일 선택 bottom-sheet 또는 inline dropdown. 디폴트 정렬(인기/최신)은 chip에 underline 또는 active 상태로 표시.
- 빈 상태: `{component.empty-state}`. 카피 (ko-friendly): `조건에 맞는 결과가 없어요. 필터를 조정해 보세요` / (en-sentence): `No results. Try adjusting filters`.
- 무한 스크롤 표준. 페이지네이션은 desktop에서만 옵션.

## 5. 상세

feed-card에서 진입. 이미지/미디어 갤러리 + 제목 + 메타 + body + CTA 구성.

```
app-bar (back-button 좌측, 우측 share/bookmark icon-button)
+------------------------------+
| [media gallery]              |  ← full-bleed, swipe carousel
| ● ○ ○ (dot indicator)        |
+------------------------------+
| [title  {typography.title1}] |
| [meta row caption1 fg-tert] |
+------------------------------+
| [description body1-read]    |
|                              |
| [section card · 1px border]  |
| [section card · 1px border]  |
+------------------------------+
|                              |
+------------------------------+
| [ CTA button-primary lg ]    |  ← sticky bottom, padding + safe-area
+------------------------------+
```

- 미디어 gallery는 swipe carousel. desktop에서는 좌측 큰 이미지 + 우측 thumbnail 그리드로 변환.
- sticky bottom CTA는 mobile 표준. desktop은 상세 우측 사이드 패널 또는 페이지 우측 CTA 고정.
- 위험 액션(취소/삭제)은 sticky CTA가 아니라 본문 끝 또는 `### bottom-sheet` 확인 단계 거침.
- 리뷰/댓글 같은 보조 컨텐츠는 본문 아래 별도 카드 섹션. 무한 스크롤 또는 페이지네이션.

## 6. 폼 / 신청

회원가입·신청·결제 같은 다단계 입력 화면. 모바일은 step-by-step, desktop은 단일 페이지 또는 wizard.

```
app-bar (back-button + page-title)
+------------------------------+
| ● ─ ○ ─ ○                    |  ← step indicator (옵션)
+------------------------------+
| [section title3]             |
| [label2 + input  48h]        |  ← mobile 48~52, desktop 44
| [label2 + input  48h]        |
| [helper caption1 fg-sec]    |
|                              |
| [checkbox 약관 동의]          |
+------------------------------+
|                              |
+------------------------------+
| [ 다음 단계 ] lg full          |  ← sticky bottom CTA
+------------------------------+
```

- 폼 필드 간 vertical gap `{spacing.space-16}`. 라벨은 필드 위 `{typography.label2}`.
- 도움말은 필드 아래 `{typography.caption1} {colors.fg-secondary}`. 에러는 같은 위치를 `{colors.fg-danger}`로 교체.
- step indicator는 3 step 이상일 때만. 2 step은 생략 가능.
- 자동완성/추천 입력은 풀스크린 검색 패턴(`### search-bar` Case B) 또는 bottom-sheet picker.
- 최종 확인 단계는 요약 카드(`{colors.bg-subtle}` 또는 1px border)로 입력 내용 재노출 + primary CTA "신청 완료" / "결제하기".

## 7. 마이 / 설정

프로필 + 메뉴 리스트 + 설정 토글 구성. 모바일 가장 자주 쓰는 화면 중 하나.

```
app-bar (page-title: "마이")
+------------------------------+
| [profile-row]                |
|  avatar 56px + 이름/이메일      |
|  우측 chevron-right (편집)     |
+------------------------------+
| [menu-list]                  |
|  · 주문 내역           >       |  ← list-row, divider 1px border-subtle
|  · 즐겨찾기            >       |
|  · 알림 설정           >       |
|  · 고객 지원           >       |
+------------------------------+
| [toggle-list]                |
|  · 다크 모드           [toggle]|
|  · 푸시 알림           [toggle]|
+------------------------------+
| [ 로그아웃 ] ghost danger lg  |
+------------------------------+
bottom-nav (마이 탭 활성)
```

- list-row height 56 (mobile) / 48 (desktop compact). cursor: pointer + active state.
- 위험 액션(계정 삭제, 로그아웃)은 별도 섹션 + `{component.button-ghost}` 또는 `{component.button-danger}` ghost 변형으로 분리. 클릭 시 `### bottom-sheet` 확인 단계.
- 다크 모드 토글이 시스템 토글이 아닌 앱 토글이면 `{component.toggle}` 사용. 시스템 따름 옵션도 함께 제공 권장.

## 시안별 화면 조립 차이

본 가이드의 7종 화면 패턴은 alias 호출을 사용하므로 라이브러리 5개 시안 모두 자동 호환된다. 다만 시안 정책 차이로 시각 결과는 달라진다.

### 홈 / 피드

| 시안 | hero | feed-card | bottom-nav |
|---|---|---|---|
| `wanted` | 1px border 평면 카드 hero | 1px border, padding 16, 그림자 없음 | A 5탭 균등 |
| `minimal-mono` | 1px border 흑백 hero | 1px border 흑백 | A 또는 C 텍스트 only |
| `toss-like` | full-bleed gradient hero, 큰 라운드 | shadow-1 카드, radius-16 | A 5탭 + 활성 아이콘 큰 weight |
| `material-3` | elevated hero shadow-2 | elevated card shadow-1 또는 outlined | A 5탭, M3 navigation bar 스타일(라벨 + indicator pill) |
| `linear-like` | dark canvas + gradient accent text hero | 1px border 컴팩트, padding 12 | **C 텍스트 only** (시그너처) |

### 상세

| 시안 | media gallery | sticky CTA | 위험 액션 |
|---|---|---|---|
| `wanted` | full-bleed swipe + dot | bg-brand 채움 lg | bottom-sheet 확인 |
| `minimal-mono` | 동일 | 검정 채움 lg | 동일 |
| `toss-like` | full-bleed + 큰 라운드 thumbnail | bg-brand lg + shadow-cta | bottom-sheet (큰 라운드) |
| `material-3` | swipe + page indicator (M3) | filled button radius-full | filled tonal danger |
| `linear-like` | 우측 panel slide (desktop) | gradient CTA + ⌘ Enter kbd | inline confirm |

### 폼 / 신청

| 시안 | input height | 라벨 위치 | sticky CTA |
|---|---|---|---|
| `wanted` | mobile 48 / desktop 44 | 필드 위 label2 | bg-brand lg full |
| `minimal-mono` | 동일 | 동일 | 검정 lg full |
| `toss-like` | mobile 52 / desktop 48 | 필드 위 또는 placeholder만 | bg-brand lg + shadow-cta |
| `material-3` | mobile 56 / desktop 52 | floating label (focus 시 위로) | snackbar + bottom action |
| `linear-like` | mobile 44 / desktop 36 | inline label 좌측 또는 위 | inline save + ⌘S kbd |

## 카피 톤 체크리스트

user FE도 product 카피 톤은 활성 시안의 `policy.copy_tone`을 따른다. admin 가이드와 동일한 3종 매트릭스를 적용한다.

| copy_tone | OK 본문 | OK 버튼 | X 금지 |
|---|---|---|---|
| **ko-friendly** (wanted, minimal-mono, toss-like) | `저장되었어요`, `결제가 완료되었어요`, `다시 시도해 보세요` | `시작하기`, `결제하기`, `다음`, `취소` | `저장되었습니다` (격식), `완료!` (이모지/느낌표), `여기를 눌러주세요` (챗봇 톤) |
| **ko-formal** | `저장되었습니다` | `저장`, `취소` | `저장되었어요` (친근체) |
| **en-sentence** (material-3, linear-like) | `Saved`, `Payment complete`, `Try again` | `Get started`, `Pay`, `Continue`, `Cancel` | `SAVE` (ALL-CAPS), `Save All Items` (Title Case), `Please click here` (챗봇 톤) |

### user FE 공통

- 광고/마케팅 톤(`!!!`, `지금 바로!`, `Limited time!`)을 product 카피에 사용 금지.
- 가격/숫자는 `tabular-nums` + 천 단위 separator(한글: `1,234,567원`, 영문: `$1,234.56`).
- placeholder 텍스트와 라벨을 함께 노출 — placeholder만으로 라벨 대체 금지(접근성).
- 이모지를 product UI inline 사용 금지(축하/성공도 monochrome SVG로).

## 다크 모드 대응

- alias 토큰만 호출하면 light/dark 자동 분기.
- 모바일은 시스템 다크 모드 따름이 표준(`prefers-color-scheme: dark`). 앱 내 토글도 함께 제공 권장(마이/설정).
- splash/onboarding 일러스트는 다크 변형 별도 ship — 단순 색 invert는 일러스트 의도를 깨뜨릴 수 있음.
- 다크 모드 hero banner gradient는 alpha 강도 한 단계 낮춤(light 0.20 → dark 0.12).

## preview 시각 확인

`docs/user-fe-preview.html`을 브라우저에서 열면 user FE 5종 컴포넌트 + 7종 화면 조립 패턴 + 토큰 swatch를 한 페이지에서 확인할 수 있다.

- 상단 셀렉터에서 **시안(designs/<slug>)**과 **테마(light/dark)**, **viewport(mobile 360 / tablet 768 / desktop 1280)** 3축을 독립적으로 토글한다.
- 셀렉터 아래 POLICY strip은 활성 시안의 frontmatter `policy:` 블록을 chip으로 시각화한다.
- 선택 상태는 localStorage에 저장되어 새로고침 후에도 유지된다.

### 시안 추가 후 preview 등록

라이브러리에 새 시안(`designs/<slug>.md`)을 추가했다면 다음 2가지를 user-fe-preview.html에 반영한다(admin-fe-preview.html과 별개로 갱신).

1. 시안 md의 `## CSS Variables` 섹션 두 블록(`:root[data-design="<slug>"][data-theme="light/dark"] { ... }`)을 `user-fe-preview.html` `<style>` 블록 안의 시안 변수 영역에 inline.
2. `<script>` 안의 `DESIGNS` 객체에 한 항목 추가(label + policy frontmatter 복사).

## design skill 자동 연계

user FE 작업 키워드(피드, 카드, 상세, 모바일, 폼, bottom-sheet, app-bar, bottom-nav)는 `.claude/skills/design/SKILL.md`를 자동 활성화해 `DESIGN.md`를 강제 로드한다. 본 가이드는 그 연장선으로 호출된다. 새로운 user FE 컴포넌트가 필요하면 `docs/design-guidelines.md ## 새 컴포넌트 추가 절차`를 따른다.

## 모바일 전용판과의 차이

본 가이드는 반응형(mobile/tablet/desktop 단일 코드베이스) 운영을 가정한다. 모바일 전용 앱(viewport 360~430 고정, 데스크탑 미지원, 네이티브-like 인터랙션)은 `docs/user-fe-mobile-design-guide.md`로 분리되며 차이점은 다음과 같다.

| 항목 | 반응형 (본 가이드) | 모바일 전용 (별도 가이드) |
|---|---|---|
| viewport | 360~1280+ 모두 지원 | 360~430 고정 |
| nav | mobile bottom-nav → tablet sidebar → desktop sidebar | bottom-nav 고정, sidebar 없음 |
| 그리드 | 4 cols (mobile) → 8 → 12 | 4 cols 고정 |
| sticky CTA | mobile only | 모든 화면 표준 |
| swipe/gesture | 옵션 (mobile only) | 표준 (carousel, sheet drag, swipe-action) |
| modal | desktop `{component.modal}` 중심 | `### bottom-sheet` 중심, 풀스크린 modal 가능 |
| max-content-width | 1200~1280 (desktop) | 폭 100% |

같은 5개 시안과 alias 계약을 공유하지만, 컴포넌트 로컬값(height·padding)이 모바일 전용에서 한 단계 큼(touch target 강화).

## 운영 메모

- 본 가이드를 갱신하면 `STATE.md ## 이번 세션에서 완료한 작업`에 변경 이력을 한 줄 남긴다(운영 규칙).
- 본 가이드의 패턴은 `DESIGN.md`의 토큰/컴포넌트와 어긋날 수 없다. 어긋나면 `DESIGN.md`를 정본으로 보고 본 가이드를 갱신한다.
- 화면 mockup이 필요하면 `.claude/agents/design-reviewer.md`로 토큰/Do-Don't 점검을 분리 위임할 수 있다.
- 모바일 전용판이 추가되면 두 가이드의 공통 원칙은 본 가이드를 정본으로 두고 모바일 전용 가이드는 차이점만 명세한다.
