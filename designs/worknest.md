---
name: WorkNest
slug: worknest
category: productivity
last_updated: "2026-07-10"
sources:
  - https://api.anthropic.com/v1/design/h/NR6vHcu1-8PDV2dAGDA3_w?open_file=WorkNest.html
related_services:
  - Notion
  - Linear
lang: ko
logo: /logos/worknest.png
policy:
  shadow_on_cards: false        # 카드 기본은 헤어라인 보더. 그림자는 hover lift·드래그 표면·overlay에 한정
  gradient_locations: []         # 전면 금지 (아바타·심볼 모두 단색)
  copy_tone: "ko-friendly"       # 시스템 카피 -요/-어요, 네비게이션은 영문 + 한글 병기
  dark_mode: "supported"         # light 기본, dark 토글
  non_4_spacing: false           # 레이아웃 spacing은 4 ladder만. 컴포넌트 로컬 관찰값은 본문에 명시
---

# WorkNest — design.md

> 노션형 블록 에디터를 중심으로 프로젝트·할일·일정·고객·견적·재무·아이디어·작업일지를 잇는 **AI Workspace OS**의 디자인 시스템. Notion/Linear 계열의 절제된 정석 톤, 한글 UI 산세리프(Pretendard), **정보 밀도 높은 pro-tool** 레이아웃. 사용자(작업자) 표면 기준으로 정의하며 어드민 환경설정 표면은 포함하지 않는다.

본 시안은 `designs/_alias-contract.md` 계약을 준수한다. 정본 프로토타입(SSOT preview)은 aiospace `mockup/WorkNest.html`이다.

## Brand & Style

- **무드**: 차분한 생산성 도구. 장식 없는 헤어라인 보더, 낮은 채도의 캔버스(`#F7F8FA`) 위 흰 표면, 포인트는 인디고 1색.
- **시그너처**: 좌측 고정 사이드바(영문 메뉴 + 한글 병기), 46px 슬림 탑바(breadcrumb + ⌘K 검색), pill 배지(상태 dot + 라벨), AI 표면은 `bg-brand-subtle` 채움으로 구분.
- **밀도**: 기본 폰트 13.5px, 행간 1.5, 표·리스트 중심. 여백보다 정보량 우선.
- **언어**: 한국어 위주, 메뉴·기술 용어는 영문 병기. `word-break: keep-all` 전역 적용(한국어 음절 단위 줄바꿈 금지).
- **AI 강조(7/10)**: 화면 곳곳의 AI 제안 + 전용 슬라이드 패널. AI 요소는 sparkles 아이콘 + brand-subtle 채움으로 일관 표기.

## Colors

### Brand

```yaml
brand-primary:   "#4F46E5"   # 인디고 — CTA, active, focus, 진행률
brand-secondary: "#4338CA"   # brand-subtle 표면 위 텍스트 강조
```

### Atomic palette (참고)

UI 표면 색은 아래 neutral 패밀리에서만 호출한다. `gray-*` 직접 호출 금지.

```yaml
neutral-0:   "#FFFFFF"   # surface
neutral-50:  "#FBFBFC"   # subtle surface
neutral-100: "#F7F8FA"   # canvas
neutral-150: "#F4F5F7"   # sidebar
neutral-200: "#F3F4F6"   # hover fill
neutral-250: "#ECEEF1"   # active fill
neutral-300: "#E7E9EC"   # hairline
neutral-350: "#DCDEE3"   # strong hairline
neutral-400: "#C9CDD4"   # 합성 — 강조 보더
neutral-500: "#9AA1AC"   # tertiary text
neutral-600: "#6B7280"   # secondary text
neutral-800: "#1F2937"   # default text
neutral-900: "#111827"   # strong text

indigo-500:  "#4F46E5"   # brand
indigo-600:  "#4338CA"
indigo-50:   "#EEF0FE"   # brand subtle fill

green-signal:  "#10B981"  # 진행률·아이콘 시그널
green-text:    "#059669"  # 배지·본문 성공 텍스트
amber-signal:  "#F59E0B"
amber-text:    "#D97706"
red-signal:    "#EF4444"
```

### Semantic alias — Light

```yaml
# Background
bg-canvas:         "#F7F8FA"
bg-surface:        "#FFFFFF"
bg-subtle:         "#FBFBFC"
bg-muted:          "#F3F4F6"
bg-elevated:       "#FFFFFF"
bg-inverse:        "#1F2937"   # 합성 — 프로토타입 미사용, 반전 표면 필요 시
bg-brand:          "#4F46E5"
bg-brand-subtle:   "#EEF0FE"
bg-success-subtle: "#E7F6EF"
bg-warning-subtle: "#FEF6E7"
bg-danger-subtle:  "#FDECEC"   # 합성 — red-signal 기준 약한 채움

# Foreground
fg-strong:    "#111827"
fg-default:   "#1F2937"
fg-secondary: "#6B7280"
fg-tertiary:  "#9AA1AC"
fg-disabled:  "#B6BCC6"   # 합성 — tertiary 한 단계 연함
fg-on-brand:  "#FFFFFF"
fg-brand:     "#4F46E5"
fg-success:   "#059669"
fg-warning:   "#D97706"
fg-danger:    "#EF4444"

# Borders
border-subtle:  "#E7E9EC"
border-default: "#DCDEE3"
border-strong:  "#C9CDD4"   # 합성
border-brand:   "#4F46E5"
```

보조 표면(alias 외 시안 토큰): `sidebar-bg #F4F5F7`, `bg-active #ECEEF1`(pressed/active 채움 — `bg-muted`보다 한 단계 깊음), `scrim rgba(17,24,39,0.32)`.

### Semantic alias — Dark

다크는 네이비 캔버스 + 스카이 블루 액센트로 전환한다(인디고 유지 아님 — 프로토타입 정의).

```yaml
# Background
bg-canvas:         "#0F172A"
bg-surface:        "#131C30"
bg-subtle:         "#18223A"
bg-muted:          "#1E2A45"
bg-elevated:       "#18223A"
bg-inverse:        "#F1F5F9"
bg-brand:          "#38BDF8"
bg-brand-subtle:   "#15293D"
bg-success-subtle: "#123528"   # 합성
bg-warning-subtle: "#3A2E12"   # 합성
bg-danger-subtle:  "#3B1A1E"   # 합성

# Foreground
fg-strong:    "#F8FAFC"
fg-default:   "#F1F5F9"
fg-secondary: "#98A4B8"
fg-tertiary:  "#64748B"
fg-disabled:  "#4B5B73"   # 합성
fg-on-brand:  "#07121F"
fg-brand:     "#38BDF8"
fg-success:   "#34D399"
fg-warning:   "#FBBF24"
fg-danger:    "#F87171"

# Borders
border-subtle:  "#243049"
border-default: "#2E3B57"
border-strong:  "#3A4866"   # 합성
border-brand:   "#38BDF8"
```

보조 표면: `sidebar-bg #0C1424`, `bg-active #243151`, `scrim rgba(0,0,0,0.55)`, brand-subtle 위 텍스트 `#7DD3FC`.

### 상태 팔레트 (badge 전용)

배지는 `(text, bg)` 쌍으로 호출한다. light 기준 관찰값.

```yaml
status-planning: { text: "#8B5CF6", bg: "#F3F0FF" }   # 기획중 / Review
status-active:   { text: "#2563EB", bg: "#EAF1FE" }   # 진행중 / Doing / 상담중
status-hold:     { text: "#D97706", bg: "#FEF6E7" }   # 보류 / Hold
status-done:     { text: "#059669", bg: "#E7F6EF" }   # 완료 / Done / 협업중
status-neutral:  { text: "#6B7280", bg: "#F1F2F4" }   # 신규 / To-do / 잠재고객
status-info:     { text: "#0891B2", bg: "#E6F6FA" }   # 기존고객
priority-urgent: { text: "#EF4444" }
priority-high:   { text: "#F59E0B" }
priority-medium: { text: "#3B82F6" }
priority-low:    { text: "#9CA3AF" }
```

## Typography

### Type ramp

```yaml
display1:    30px / 700 / 1.30 / -0.025em   # 문서(블록 에디터) H1
display2:    28px / 700 / 1.30 / -0.025em   # 페이지 타이틀
display3:    24px / 700 / 1.35 / -0.02em    # 합성 — 대형 지표 숫자
title1:      21px / 700 / 1.40 / -0.02em    # 문서 H2, 모달 타이틀
title2:      17px / 600 / 1.45 / -0.015em   # 합성 — 드로어/패널 헤더
title3:      15px / 600 / 1.50 / -0.01em    # 카드 제목
label1:      13.5px / 600 / 1.40 / -0.01em  # 버튼, 네비 active, 폼 라벨
label2:      12.5px / 500 / 1.40 / -0.005em # sm 버튼, 칸반 컬럼 헤더(600)
body1:       13.5px / 400 / 1.50 / -0.01em  # UI 본문 기본 (html 기본값)
body1-read:  15px / 400 / 1.65 / -0.005em   # 에디터 본문 블록
body2:       13px / 400 / 1.50 / -0.01em    # 테이블 셀, 보조 텍스트
caption1:    11.5px / 600 / 1.35 / 0.03em   # 테이블 헤더·섹션 라벨 (uppercase)
```

### 서체 선택

- **Primary**: `"Pretendard Variable", system-ui, sans-serif` — 한글 UI 산세리프(가변 weight 45–920, 실사용 400–700). 자체 호스팅(`pretendard` 패키지의 동적 서브셋 92조각 + `unicode-range`)이라 화면에 쓰인 글자가 든 조각만 내려온다.
  - 2026-07-10 교체. 이전 `"IBM Plex Sans KR"`는 라틴 본문용 서체에 한글을 얹은 계열이라 본문 13.5px에서 획이 가늘고 자소가 뭉쳐 보였다.
- **Mono**(시안 전용 variant): `"IBM Plex Mono", ui-monospace, monospace` — 코드 블록 12.5px, kbd 10.5px. 다른 시안 전환 시 `_alias-contract.md §9b` mono fallback 적용.
- 전역 `letter-spacing -0.01em`, `-webkit-font-smoothing: antialiased`, `word-break: keep-all`.

## Spacing

4의 배수 ladder만 레이아웃에 사용한다.

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

프로토타입은 pro-tool 밀도를 위해 5/7/9/11px 컴포넌트 내부 패딩을 쓴다 — 이는 **SSOT preview 관찰값**(컴포넌트 로컬)이며 레이아웃 spacing으로 승격하지 않는다. 신규 구현은 가장 가까운 ladder 값(4/8/12)을 우선한다.

## Rounded

```yaml
radius-2:    2
radius-4:    4      # 관찰값 5px(--r-sm) 정규화 — 칩, kbd, 셀 입력
radius-8:    8      # 관찰값 7px(--r-md) 정규화 — 버튼, 인풋, 네비 아이템
radius-12:   12     # 관찰값 10px(--r-lg) 정규화 — 카드, 팝오버, 칸반 컬럼
radius-16:   16     # 관찰값 14px(--r-xl) 정규화 — 모달
radius-full: 9999   # 배지, 아바타, 진행률, 토글
```

## Elevation & Depth

카드의 1차 분리 수단은 **헤어라인 보더**다. 그림자는 (1) hover lift, (2) 드래그 가능한 칸반 카드, (3) popover/dropdown/모달/드로어 overlay 표면에만 허용한다. 정지 상태 일반 카드에 그림자를 두지 않는다.

```yaml
shadow-1:   "0 1px 2px rgba(17,24,39,0.05)"                                # 칸반 카드, active 네비
shadow-2:   "0 2px 8px rgba(17,24,39,0.07), 0 1px 2px rgba(17,24,39,0.04)" # 카드 hover lift
shadow-pop: "0 8px 28px rgba(17,24,39,0.16), 0 1px 3px rgba(17,24,39,0.08)" # 팝오버, 슬래시 메뉴, ⌘K
shadow-3:   "0 12px 32px rgba(17,24,39,0.13), 0 2px 8px rgba(17,24,39,0.06)" # 시안 전용 — 모달, 드로어, AI 패널 (fallback: shadow-pop)
```

다크에서는 `rgba(0,0,0,0.4~0.6)` 계열로 강도만 키운다(키 세트 동일).

## Components

### button

- 높이: `sm 26` / `md 30`(기본) / `lg 36`(합성 — 모달 푸터). 패딩 `0 11px`(sm `0 9px`) — 관찰값. radius `{rounded.radius-8}`, 타이포 `{typography.label1}`(sm은 `{typography.label2}`).

### button-primary
`{colors.bg-brand}` 채움 + `{colors.fg-on-brand}`, 보더 없음. hover `brightness(1.06)`.

### button-secondary
`{colors.bg-surface}` + `{colors.border-default}` 1px + `{colors.fg-default}`. hover `{colors.bg-muted}`.

### button-tertiary
`{colors.bg-brand-subtle}` 채움 + brand-secondary 텍스트, 보더 없음 — AI 진입 버튼이 대표 사용처.

### button-ghost
투명 배경·보더, `{colors.fg-secondary}`. hover `{colors.bg-muted}` + `{colors.fg-default}`.

### button-danger
합성 — `{colors.fg-danger}` 채움 + 흰 텍스트(파괴 확정), 또는 ghost + danger 텍스트(보조). 프로토타입 미정의.

### button-disabled
`{colors.bg-muted}` 채움 + `{colors.fg-disabled}`, cursor not-allowed. 합성.

### input / form field

- 높이 34px(관찰값), radius `{rounded.radius-8}`, `{colors.bg-subtle}` 배경 + `{colors.border-default}` 1px.
- **focus**: `{colors.border-brand}` + 배경 `{colors.bg-surface}` 전환. ring 없음(보더 색 전환만).
- **error**: `{colors.fg-danger}` 보더 + 하단 `{typography.caption1}` 에러 텍스트 (합성).
- **disabled**: `{colors.bg-muted}` + `{colors.fg-disabled}` (합성).
- placeholder `{colors.fg-tertiary}`. select·textarea 동일 토큰.

### badge

높이 21px pill(`{rounded.radius-full}`), `{typography.caption1}` 11.5px/600, 좌측 6px 상태 dot + 라벨. 상태 팔레트의 `(text, bg)` 쌍 사용.
- **active** → `status-active` · **pending** → `status-hold` · **inactive** → `status-neutral` · **danger** → `(#EF4444, #FDECEC)`.

### chip

높이 20px, radius `{rounded.radius-4}`, `{colors.bg-muted}` + `{colors.fg-secondary}`, 11px/500. 태그·메타 표기용. interactive 시 hover에 `bg-active` 채움.

### avatar

원형(`{rounded.radius-full}`), 단색 배경 + 흰 이니셜(font-size = 지름×0.42). 계약 사이즈 32px, 관찰 사용처 22px(리스트)·28px(탑바). 그룹은 `-6px` 겹침 + `1.5px` surface 보더, 초과분 `+N`.

### icon-button

36px 정사각(rail 기준), radius `{rounded.radius-8}`, 투명 배경 + `{colors.fg-secondary}`. hover `bg-active` + `fg-default`. 콤팩트 26px(탑바·사이드바 헤더)은 관찰 로컬값.

### icon

stroke 기반 SVG(1.5~1.75px), `currentColor` 상속, 사이즈 16/20/24(관찰 사용처 13~19). 이모지·픽토그램으로 대체 금지.

### sidebar-nav

- 폭 248px(기본) / 56px(collapsed) / 54px 아이콘 rail + 232px 패널(rail 변형). `sidebar-bg` 배경 + 우측 `{colors.border-subtle}`.
- 아이템: 13.5px/500, radius `{rounded.radius-8}`, hover `bg-active`. **active**: `{colors.bg-surface}` 채움 + 600 + `{elevation.shadow-1}` + 아이콘 `{colors.fg-brand}`.
- 영문 라벨 + 우측 한글 병기(`{colors.fg-tertiary}` 11px), 카운트 배지는 pill. 섹션 라벨은 `{typography.caption1}` uppercase.
- 하단 고정 Settings. 워크스페이스 스위처는 상단(이모지 타일 + 이름).

### top-bar

높이 46px, `{colors.bg-surface}` + 하단 `{colors.border-subtle}`. 구성: breadcrumb(13px, 현재 위치만 600) → 우측 검색 트리거(240px, `bg-muted` 채움, ⌘K kbd 표기) → AI 버튼(tertiary) → 알림 icon-button → 빠른 생성(primary sm) → 아바타 28px.

### modal / dialog

- 커스텀 표면: 폭 520px(`max-width 94vw`), radius `{rounded.radius-16}`, `{colors.bg-elevated}` + `{elevation.shadow-3}` + `{colors.border-subtle}` 1px, 상단 `9vh` 중앙 정렬, `wn-pop` 등장(scale 0.97→1, 0.14s).
- scrim은 시안 `scrim` 토큰(flat 반투명, blur 금지). **닫기는 헤더 X·ESC·푸터 닫기/취소 버튼만 — scrim 클릭·스와이프 닫기 금지** (프로토타입에는 scrim 클릭 닫기가 남아 있으나 production 채택 금지).
- 모달 위 모달 중첩 불허. body scroll lock 적용.

### drawer / panel

우측 슬라이드 표면 — Task 상세 드로어 460px, AI 패널 392px. `{colors.bg-surface}` + 좌측 `{colors.border-subtle}` + `{elevation.shadow-3}`, `translateX` 0.24s 등장. 닫기 정책은 모달과 동일.

### data-table

13px 셀, 패딩 8px 12px, 행 구분 `{colors.border-subtle}` 헤어라인. 헤더 `{typography.caption1}` uppercase `{colors.fg-tertiary}`. 행 hover `{colors.bg-muted}`, 클릭 진입형.

### stat-card

`{colors.bg-surface}` 카드 + 헤어라인. 라벨 `{typography.caption1}`, 값 `{typography.display3}` 또는 title1, 보조 증감 텍스트는 semantic fg 색.

### kanban

컬럼 268px, `{colors.bg-subtle}` + 헤어라인, radius `{rounded.radius-12}`. 카드: `{colors.bg-surface}` + `{elevation.shadow-1}`, radius `{rounded.radius-8}`, `cursor: grab`, 드래그 중 opacity 0.4, 드롭 대상 컬럼은 `{colors.bg-brand}` 2px dashed outline.

### tabs

하단 2px 인디케이터형. 13px/500 `{colors.fg-secondary}` → active 600 `{colors.fg-default}` + `{colors.border-brand}` 인디케이터. 컨테이너 하단 헤어라인.

### toggle

38×22px pill, off `{colors.border-default}` 채움 / on `{colors.bg-brand}`, 18px 흰 노브 + `{elevation.shadow-1}`, 0.15s 전환.

### progress

높이 5px pill, 트랙 `bg-active`, 채움은 brand 또는 상태 색.

### slash-menu / command-palette

280px 팝오버(⌘K는 중앙 대형), `{colors.bg-elevated}` + `{elevation.shadow-pop}`, radius `{rounded.radius-12}`, `position: fixed` + 공간 부족 시 위로 플립. 카테고리 라벨 `{typography.caption1}`, 선택 행 `{colors.bg-brand-subtle}` 채움 + 아이콘 타일(30px, `bg-subtle` + 헤어라인).

### block-editor

본문 `{typography.body1-read}`, H1 `{typography.display1}`, H2 `{typography.title1}`. 코드 블록 mono 12.5px + `{colors.bg-subtle}`. 콜아웃 `{colors.bg-brand-subtle}` + brand 20% 보더. 인용 3px `{colors.border-default}` 좌측 보더 + italic `{colors.fg-secondary}`. 빈 블록 placeholder `{colors.fg-tertiary}`. 임베드 블록(task/project/customer/quote/diagram)은 카드형.

### sticky-memo

포스트잇 5색(데이터 색), radius 8px, 부유 그림자(shadow-pop급), 헤더 드래그 이동·압정 축소·리스트 보기. 우하단 런처 + 개수 배지. 모바일은 리스트 모드만(부유·드래그 비활성).

### bottom-sheet

modal의 모바일(<768) 변형 — 동일 컴포넌트가 미디어쿼리로 전환된다. 하단 고정 풀폭, 상단만 `{rounded.radius-16}`, `{colors.bg-elevated}` + `{elevation.shadow-3}`, 최대 높이 88dvh + 내부 스크롤, 헤더(타이틀+X)·푸터 고정, safe-area 패딩. **닫기 정책은 modal과 동일** — 스와이프·scrim 클릭 닫기 금지.

### mobile-nav

모바일 하단 탭 바 — 높이 56px + safe-area, `{colors.bg-surface}` + 상단 `{colors.border-subtle}` 헤어라인, 5칸 고정(아이콘 20 + `{typography.caption1}` 라벨), active `{colors.fg-brand}`.

### nav-drawer

sidebar-nav의 모바일 오버레이 변형 — 폭 `min(304px, 84vw)`, sidebar-bg 표면 + `{elevation.shadow-3}` + scrim. 닫기는 헤더 X·ESC·메뉴 선택만(scrim 클릭 닫기 없음).

### fab

모바일 빠른 생성 버튼 — 48px 원형(`{rounded.radius-full}`), `{colors.bg-brand}` + `{colors.fg-on-brand}` + `{elevation.shadow-pop}`, 우하단 고정(탭 바 위 safe-area 보정).

### card-row

data-table 행의 모바일 카드 변형 — `{colors.bg-surface}` + `{colors.border-subtle}` 헤어라인, `{rounded.radius-12}`, 구성 3~4행: 제목 `{typography.title3}` + 상태 badge / 메타 `{typography.body2}` / 금액 강조(tabular-nums) / 액션 행(이벤트 버블링 차단). 탭 = 데스크톱 행 클릭과 동일 진입.

## Do's and Don'ts

**Do**

- 표면 분리는 헤어라인 보더 우선, 그림자는 hover·드래그·overlay 한정.
- 상태는 항상 dot + 라벨 pill 배지로, 상태 팔레트의 `(text, bg)` 쌍으로 호출.
- 네비게이션·고유 기능명은 영문 + 한글 병기, 시스템 카피는 `-요/-어요` 종결.
- `word-break: keep-all` 전역 유지, 라벨류는 `white-space: nowrap`.
- AI 기능 표면은 sparkles 아이콘 + `{colors.bg-brand-subtle}` 채움으로 일관 표기.
- 금액·숫자는 `tabular-nums` + 천 단위 구분자.

**Don't**

- 정지 상태 카드에 그림자 금지 (`policy.shadow_on_cards: false`).
- gradient 전면 금지 — 아바타·심볼·배너 모두 단색.
- UI 크롬(버튼·배지·헤더)에 이모지 inline 금지. 화살표·아이콘은 SVG. (사용자 콘텐츠인 노트/워크스페이스 아이콘 픽커의 이모지는 데이터로 허용.)
- scrim 클릭·스와이프로 모달/드로어 닫기 금지. native `alert/confirm/prompt`·pre-styled 라이브러리 모달 금지(headless 동작 위임은 허용).
- 비-4의 배수 spacing 레이아웃 도입 금지(컴포넌트 로컬 관찰값 제외), `gray-*` 표면 직접 호출 금지.
- 다크 모드에서 light 그림자 값 재사용 금지(다크 전용 강도 사용).

## Responsive Behavior

- 브레이크포인트: `bp-sm 640` / `bp-md 768` / `bp-lg 1024` / `bp-xl 1280`. **<768 = Mobile 전용 레이아웃**, 768~1023 = Tablet(데스크톱 레이아웃 + 사이드바 collapsed 기본), **≥1024 = Desktop(기준 UI)**.
- **무회귀 원칙**: 모든 반응형 규칙은 `max-width` 미디어쿼리(또는 mobile 분기)로만 작성한다 — 데스크톱 기본 스타일·DOM 무수정.
- 셸 전환(Mobile): 사이드바 → `nav-drawer`(햄버거), 빠른 생성 → `fab`, 하단 `mobile-nav` 탭 바 5칸(Home·Tasks·Calendar·Finance·더보기), breadcrumb은 현재 단계만 표시.
- 모달·대형 팝오버(알림·빠른 생성) → `bottom-sheet` 전환. 드로어·AI 패널은 풀스크린. 닫기 정책은 모달과 동일.
- 데이터 테이블 → `card-row` 전환(미전환 테이블은 가로 스크롤 폴백). 칸반은 가로 스크롤 + scroll-snap(컬럼 86vw). 탭/필터 행은 가로 스크롤 칩.
- 터치 타깃 최소 40px(`space-40`), hover-reveal UI는 모바일 상시 노출, 모바일 입력 font-size 16px(iOS 자동 줌 방지 — body1의 모바일 보정값).
- safe-area inset(탭 바·fab·시트)·`100dvh` 기준. 다이어그램 캔버스는 모바일 보기 전용(편집은 PC).
- 데스크톱 기준: 콘텐츠 폭 `max-width 1180px` 중앙 정렬(`wide` 변형은 full-bleed), 페이지 패딩 26/36px.

## Known Gaps

- **어드민 표면 미정의** — 본 시안은 사용자 기준. 어드민 환경설정·권한 화면은 추후 별도 정의.
- 합성 토큰: `bg-inverse`(light), `fg-disabled`, `border-strong`, `bg-danger-subtle`, dark의 `*-subtle` 3종, `display3`, `title2`, button `lg/danger/disabled`, input `error/disabled`. (반응형 정책은 2026-06-11 Phase R에서 mock 구현·검증값으로 확정 — 합성 아님.)
- 시안 전용 토큰(계약 §9b 등재): `shadow-3`(드로어·모달), `mono` variant, `sidebar-bg`, `bg-active`, `scrim`, `topbar-h 46px`, 상태 팔레트.
- radius·spacing은 프로토타입 관찰값(5/7/10/14px radii, 5/7/9/11px 패딩)을 ladder로 정규화했다 — mock(`mockup/`)과 1px대 차이가 날 수 있다.
- 프로토타입에 scrim 클릭 닫기·이모지 아이콘 픽커 등 표준 정책과 다른 동작이 남아 있다. mock은 시각 정본이지 인터랙션 정책 정본이 아니다.
- 다크 모드는 액센트가 인디고→스카이로 바뀌는 **별도 무드**다. 색만 반전하는 자동 변환 금지.

## References

- 디자인 핸드오프 번들: https://api.anthropic.com/v1/design/h/NR6vHcu1-8PDV2dAGDA3_w?open_file=WorkNest.html
- SSOT preview: aiospace `mockup/WorkNest.html` (+ `mockup/screenshots/`)
- 참고 톤: Notion, Linear

## CSS Variables

`docs/admin-fe-preview.html`이 시안을 즉시 시각화하기 위한 CSS 변수 블록. 표기 규칙은 `designs/_alias-contract.md ## 10` 참조.

```css
:root[data-design="worknest"][data-theme="light"] {
  /* Background */
  --bg-canvas:         #F7F8FA;
  --bg-surface:        #FFFFFF;
  --bg-subtle:         #FBFBFC;
  --bg-muted:          #F3F4F6;
  --bg-elevated:       #FFFFFF;
  --bg-inverse:        #1F2937;
  --bg-brand:          #4F46E5;
  --bg-brand-subtle:   #EEF0FE;
  --bg-success-subtle: #E7F6EF;
  --bg-warning-subtle: #FEF6E7;
  --bg-danger-subtle:  #FDECEC;

  /* Foreground */
  --fg-strong:    #111827;
  --fg-default:   #1F2937;
  --fg-secondary: #6B7280;
  --fg-tertiary:  #9AA1AC;
  --fg-disabled:  #B6BCC6;
  --fg-on-brand:  #FFFFFF;
  --fg-brand:     #4F46E5;
  --fg-success:   #059669;
  --fg-warning:   #D97706;
  --fg-danger:    #EF4444;

  /* Border */
  --border-subtle:  #E7E9EC;
  --border-default: #DCDEE3;
  --border-strong:  #C9CDD4;
  --border-brand:   #4F46E5;

  /* 시안 전용 */
  --sidebar-bg: #F4F5F7;
  --bg-active:  #ECEEF1;
  --bg-scrim:   rgba(17, 24, 39, 0.32);
  --topbar-h:   46px;
  --font-sans:  "Pretendard Variable", system-ui, sans-serif;
  --font-mono:  "IBM Plex Mono", ui-monospace, monospace;

  /* Spacing */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded */
  --radius-2: 2px;   --radius-4: 4px;   --radius-8: 8px;
  --radius-12: 12px; --radius-16: 16px; --radius-full: 9999px;

  /* Typography */
  --font-size-display1: 30px;   --font-weight-display1: 700; --line-height-display1: 1.30; --letter-spacing-display1: -0.025em;
  --font-size-display2: 28px;   --font-weight-display2: 700; --line-height-display2: 1.30; --letter-spacing-display2: -0.025em;
  --font-size-display3: 24px;   --font-weight-display3: 700; --line-height-display3: 1.35; --letter-spacing-display3: -0.02em;
  --font-size-title1: 21px;     --font-weight-title1: 700;   --line-height-title1: 1.40;   --letter-spacing-title1: -0.02em;
  --font-size-title2: 17px;     --font-weight-title2: 600;   --line-height-title2: 1.45;   --letter-spacing-title2: -0.015em;
  --font-size-title3: 15px;     --font-weight-title3: 600;   --line-height-title3: 1.50;   --letter-spacing-title3: -0.01em;
  --font-size-label1: 13.5px;   --font-weight-label1: 600;   --line-height-label1: 1.40;   --letter-spacing-label1: -0.01em;
  --font-size-label2: 12.5px;   --font-weight-label2: 500;   --line-height-label2: 1.40;   --letter-spacing-label2: -0.005em;
  --font-size-body1: 13.5px;    --font-weight-body1: 400;    --line-height-body1: 1.50;    --letter-spacing-body1: -0.01em;
  --font-size-body1-read: 15px; --font-weight-body1-read: 400; --line-height-body1-read: 1.65; --letter-spacing-body1-read: -0.005em;
  --font-size-body2: 13px;      --font-weight-body2: 400;    --line-height-body2: 1.50;    --letter-spacing-body2: -0.01em;
  --font-size-caption1: 11.5px; --font-weight-caption1: 600; --line-height-caption1: 1.35; --letter-spacing-caption1: 0.03em;

  /* Elevation */
  --shadow-1:   0 1px 2px rgba(17, 24, 39, 0.05);
  --shadow-2:   0 2px 8px rgba(17, 24, 39, 0.07), 0 1px 2px rgba(17, 24, 39, 0.04);
  --shadow-pop: 0 8px 28px rgba(17, 24, 39, 0.16), 0 1px 3px rgba(17, 24, 39, 0.08);
  --shadow-3:   0 12px 32px rgba(17, 24, 39, 0.13), 0 2px 8px rgba(17, 24, 39, 0.06);
}

:root[data-design="worknest"][data-theme="dark"] {
  /* Background */
  --bg-canvas:         #0F172A;
  --bg-surface:        #131C30;
  --bg-subtle:         #18223A;
  --bg-muted:          #1E2A45;
  --bg-elevated:       #18223A;
  --bg-inverse:        #F1F5F9;
  --bg-brand:          #38BDF8;
  --bg-brand-subtle:   #15293D;
  --bg-success-subtle: #123528;
  --bg-warning-subtle: #3A2E12;
  --bg-danger-subtle:  #3B1A1E;

  /* Foreground */
  --fg-strong:    #F8FAFC;
  --fg-default:   #F1F5F9;
  --fg-secondary: #98A4B8;
  --fg-tertiary:  #64748B;
  --fg-disabled:  #4B5B73;
  --fg-on-brand:  #07121F;
  --fg-brand:     #38BDF8;
  --fg-success:   #34D399;
  --fg-warning:   #FBBF24;
  --fg-danger:    #F87171;

  /* Border */
  --border-subtle:  #243049;
  --border-default: #2E3B57;
  --border-strong:  #3A4866;
  --border-brand:   #38BDF8;

  /* 시안 전용 */
  --sidebar-bg: #0C1424;
  --bg-active:  #243151;
  --bg-scrim:   rgba(0, 0, 0, 0.55);

  /* Elevation — 다크 전용 강도 */
  --shadow-1:   0 1px 2px rgba(0, 0, 0, 0.4);
  --shadow-2:   0 2px 10px rgba(0, 0, 0, 0.45);
  --shadow-pop: 0 10px 30px rgba(0, 0, 0, 0.55);
  --shadow-3:   0 14px 36px rgba(0, 0, 0, 0.6);
}
```
