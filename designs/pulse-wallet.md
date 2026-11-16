---
name: Pulse Wallet
slug: pulse-wallet
category: finance
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/ScsxyrtVoxCFY4J4q265KY
related_services: []
lang: ko
policy:
  shadow_on_cards: true
  gradient_locations: ["card","icon-tile","chart","background"]
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/ScsxyrtVoxCFY4J4q265KY
  version: "1794797837-735c"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/pulse-wallet.map.json
---

# Pulse Wallet — design.md

> 다크 대시보드형 CEX 커스터디 지갑 — 짙은 차콜 바탕, 둥근 카드, 빛나는 파란 알약 탭, 파스텔 그라데이션 하이라이트 카드의 친근한 지갑 시안.

본 시안은 Claude Design System 「Pulse Wallet」(https://claude.ai/artifact/ScsxyrtVoxCFY4J4q265KY)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/pulse-wallet.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

다크 대시보드형 CEX 커스터디 지갑 — 짙은 차콜 바탕, 둥근 카드, 빛나는 파란 알약 탭, 파스텔 그라데이션 하이라이트 카드의 친근한 지갑 시안.

- 카드 그림자: 허용 · gradient: card, icon-tile, chart, background · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#2257e6"        # ← primary
violet: "#9333d6"               # ← violet
mint: "#6ef2c0"                 # ← mint
```

### Semantic alias — Light

```yaml
bg-canvas: "#f3f4f8"                # ← bg
bg-surface: "#ffffff"               # ← surface
bg-subtle: "#eef0f6"                # ← surface-2
bg-muted: "#eef0f6"                 # ← surface-2
bg-elevated: "#ffffff"              # ← surface
bg-inverse: "#14151b"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#2257e6"                 # ← primary
bg-brand-subtle: "#eef0f6"          # ← surface-2 · 합성 — 원본에 primary 옅은 바탕이 없음(선택은 primary 알약 + 글로우)
bg-success-subtle: "#dbf6eb"        # ← up-soft
bg-warning-subtle: "#fcefd8"        # ← warn-soft
bg-danger-subtle: "#fde2e7"         # ← down-soft
fg-strong: "#14151b"                # ← ink
fg-default: "#14151b"               # ← ink
fg-secondary: "#5c5f73"             # ← ink-muted
fg-tertiary: "#5c5f73"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#5c5f73"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#ffffff"              # ← on-primary
fg-brand: "#2257e6"                 # ← primary-ink
fg-success: "#0b7a52"               # ← up
fg-warning: "#9a5b00"               # ← warn
fg-danger: "#cf2f4a"                # ← down
border-subtle: "#dfe2ec"            # ← line
border-default: "#dfe2ec"           # ← line
border-strong: "#b9bccb"            # ← toggle-off · 합성 — 원본 선 색은 line 하나라 꺼진 토글 트랙 색을 진한 선으로 재사용
border-brand: "#2257e6"             # ← primary
```

### Semantic alias — Dark

```yaml
bg-canvas: "#16171d"                # ← bg
bg-surface: "#23252e"               # ← surface
bg-subtle: "#2c2f3a"                # ← surface-2
bg-muted: "#2c2f3a"                 # ← surface-2
bg-elevated: "#23252e"              # ← surface
bg-inverse: "#ffffff"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#2a62f5"                 # ← primary
bg-brand-subtle: "#2c2f3a"          # ← surface-2 · 합성 — 원본에 primary 옅은 바탕이 없음(선택은 primary 알약 + 글로우)
bg-success-subtle: "#173a30"        # ← up-soft
bg-warning-subtle: "#3b2e17"        # ← warn-soft
bg-danger-subtle: "#3d1c26"         # ← down-soft
fg-strong: "#ffffff"                # ← ink
fg-default: "#ffffff"               # ← ink
fg-secondary: "#9a9cb0"             # ← ink-muted
fg-tertiary: "#9a9cb0"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#9a9cb0"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#ffffff"              # ← on-primary
fg-brand: "#7aa2ff"                 # ← primary-ink
fg-success: "#4be3a5"               # ← up
fg-warning: "#ffb84d"               # ← warn
fg-danger: "#ff6b81"                # ← down
border-subtle: "#33364a"            # ← line
border-default: "#33364a"           # ← line
border-strong: "#4a4d5e"            # ← toggle-off · 합성 — 원본 선 색은 line 하나라 꺼진 토글 트랙 색을 진한 선으로 재사용
border-brand: "#2a62f5"             # ← primary
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `bg` | #f3f4f8 | #16171d | App ground. |
| `bg-glow` | #e9e4f8 | #2a1f47 | Soft violet bloom at the bottom-right of every screen (radial, fades into `bg`). Never under text blocks alone. |
| `surface` | #ffffff | #23252e | Cards, rows, sheets, inputs. |
| `surface-2` | #eef0f6 | #2c2f3a | Raised controls on cards: icon buttons, chips, address boxes, pressed rows. |
| `line` | #dfe2ec | #33364a | Hairlines, chart grid, card dividers. |
| `ink` | #14151b | #ffffff | Primary text and icons on bg, surface, surface-2. |
| `ink-muted` | #5c5f73 | #9a9cb0 | Secondary text (labels, dates, held amounts) on bg, surface, surface-2. |
| `primary` | #2257e6 | #2a62f5 | Selected tab pill, toggles on, the + / scan FAB, primary buttons. Text on it is `on-primary`. |
| `on-primary` | #ffffff | #ffffff | Text and icons on `primary` and `violet`. |
| `primary-ink` | #2257e6 | #7aa2ff | Blue text links and the selected nav icon on bg and surfaces. |
| `violet` | #9333d6 | #a63fe0 | Secondary call-to-action pill (e.g. 전체 보기 / All), unread badges' ring. Text `on-primary`. |
| `mint` | #6ef2c0 | #6ef2c0 | Progress rings, success count chips (3/5), positive highlight. Text on it is `on-mint`. |
| `on-mint` | #06281c | #06281c | Text on `mint`. |
| `bar-a` | #e04fb8 | #f472d0 | Top stop of chart bars (pink). Decorative, with value labels. |
| `bar-b` | #9333d6 | #b25cf5 | Bottom stop of chart bars (violet). |
| `up` | #0b7a52 | #4be3a5 | Price up / deposits, always with + or ▲. On bg, surfaces, up-soft. |
| `up-soft` | #dbf6eb | #173a30 | Ground of up pills and completed badges. |
| `down` | #cf2f4a | #ff6b81 | Price down / failed / errors, always with − or ▼. On bg, surfaces, down-soft. |
| `down-soft` | #fde2e7 | #3d1c26 | Ground of down pills and failed badges. |
| `warn` | #9a5b00 | #ffb84d | Pending status, network warnings. On bg, surfaces, warn-soft. |
| `warn-soft` | #fcefd8 | #3b2e17 | Ground of pending badges and warning boxes. |
| `notify` | #e85a36 | #ff7a59 | Notification count dot (white text 11px bold — decorative count, also announced in the label). |
| `toggle-off` | #b9bccb | #4a4d5e | Toggle track when off; the white knob carries the state. |
| `pastel-a` | #8ff0d0 | #8ff0d0 | Gradient card start (mint). |
| `pastel-b` | #b8b5ff | #b8b5ff | Gradient card middle (periwinkle). |
| `pastel-c` | #f6a8e8 | #f6a8e8 | Gradient card end (pink). |
| `on-pastel` | #14151b | #14151b | Text and progress track on the gradient card. |
| `tile-orange-a` | #ffc27a | #ffc27a | Icon tile gradient — orange top (deposits / totals). |
| `tile-orange-b` | #f0743e | #f0743e | Icon tile gradient — orange bottom. |
| `tile-green-a` | #b6ec7a | #b6ec7a | Icon tile gradient — green top (completed / profit). |
| `tile-green-b` | #2fb57a | #2fb57a | Icon tile gradient — green bottom. |
| `tile-pink-a` | #ffa6dc | #ffa6dc | Icon tile gradient — pink top (withdraw / alerts). |
| `tile-pink-b` | #ec4c8c | #ec4c8c | Icon tile gradient — pink bottom. |
| `tile-blue-a` | #8fb4ff | #8fb4ff | Icon tile gradient — blue top (wallet / swap). |
| `tile-blue-b` | #2a62f5 | #2a62f5 | Icon tile gradient — blue bottom. |
| `on-tile` | #ffffff | #ffffff | Icon glyph on tile gradients (icons only, 22px, 2px stroke). |
| `focus` | #2257e6 | #7aa2ff | 2px focus ring, 2px offset. |
| `scrim` | rgba(20, 21, 27, 0.45) | rgba(8, 9, 14, 0.72) | Behind popups, sheets and the scanner window. |

## Typography

### 서체 선택

- **Primary**: `Lexend, "Noto Sans KR", system-ui, sans-serif`

### Type ramp

```yaml
display1: 34/600/1.18/-0.01em     # ← greeting (34px/40px) The two-line greeting on Home; one per screen.
display2: 36/600/1.17/0           # ← num-hero (36px/42px) Total balance, coin price on detail.
display3: 36/600/1.17/0           # ← num-hero (36px/42px) Total balance, coin price on detail.
title1: 20/600/1.3/0              # ← title (20px/26px) App bar titles, section titles.
title2: 17/600/1.41/0             # ← card-title (17px/24px) Card headings, gradient card title, popup title.
title3: 17/600/1.41/0             # ← card-title (17px/24px) Card headings, gradient card title, popup title.
label1: 15/500/1.47/0             # ← body (15px/22px) Row titles, buttons, inputs.
label2: 11/500/1.27/0             # ← caption (11px/14px) Chart axes, badges, tiny meta.
body1: 15/500/1.47/0              # ← body (15px/22px) Row titles, buttons, inputs.
body1-read: 15/500/1.47/0         # ← body (15px/22px) Row titles, buttons, inputs.
body2: 13/400/1.46/0              # ← body-sm (13px/19px) Secondary lines, helper text, card captions.
caption1: 11/500/1.27/0           # ← caption (11px/14px) Chart axes, badges, tiny meta.
```

## Spacing

```yaml
space-4: 4        # ← space-1 Badge padding, icon-text gaps.
space-8: 8        # ← space-2 Gap between rows.
space-12: 12      # ← space-3 Inside compact rows; chip gaps.
space-16: 16      # ← space-4 Row padding; gap inside cards.
space-20: 20      # ← space-5 Card padding.
space-24: 24      # ← space-6 Screen side gutter; between sections.
space-32: 32      # ← space-8 Above the greeting; between hero blocks.
space-40: 40      # 표준 ladder (원본에 없음)
space-48: 48      # 표준 ladder (원본에 없음)
space-56: 56      # 표준 ladder (원본에 없음)
space-64: 64      # 표준 ladder (원본에 없음)
space-80: 80      # 표준 ladder (원본에 없음)
space-96: 96      # 표준 ladder (원본에 없음)
space-128: 128    # 표준 ladder (원본에 없음)
```

원본 간격은 단계 번호 이름(`space-1`=4px …)이라 값 기준으로 템플릿 이름(`space-4`=4px)에 옮겼다.

## Rounded

```yaml
radius-2: 2         # 표준 ladder
radius-4: 4         # 표준 ladder
radius-8: 8         # 표준 ladder
radius-12: 12       # 표준 ladder
radius-10: 10       # ← radius-sm 10px · 시안 전용(비-4) — Badges, small chips, coin squares.
radius-16: 16       # ← radius-md 16px — Rows, inputs, icon tiles.
radius-24: 24       # ← radius-lg 24px — Cards, gradient card, popups.
radius-full: 9999   # ← radius-pill 999px — Tab pills, CTA pills, toggles, FAB.
```

## Elevation & Depth

```yaml
shadow-1: "0 10px 28px rgba(30, 34, 60, 0.08)"  # ← shadow-card · dark 0 12px 32px rgba(0, 0, 0, 0.35)
shadow-2: "0 8px 18px rgba(34, 87, 230, 0.3)"  # ← shadow-pill · dark 0 8px 20px rgba(42, 98, 245, 0.45)
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | 원본 Button (primary 알약 + shadow-pill, violet 보조 CTA) |
| input | 원본 입력 컴포넌트 (surface 바탕) |
| badge | 상태 배지 (up-soft · warn-soft · down-soft) |
| chip | 탭 알약·칩 (surface-2, 선택 primary) |
| avatar | 코인 로고 아바타 (assets/Coins) |
| icon-button | 아이콘 버튼 (surface-2) |
| icon | 라인 아이콘 + 그라데이션 아이콘 타일 |

### 원본 컴포넌트 (35종)

| 컴포넌트 | 요약 |
|---|---|
| ActionButton | Gradient icon tile with a label below — the quick-action row on Home. |
| AddressQR | Deposit card: coin + network, the address as a QR code, copy/share, and the wrong-network warning. |
| AmountField | Large numeric input for withdraw / transfer, with available balance, MAX, fiat estimate and network fee. |
| AuthPanel | Login / signup panel with two methods: 아이디·비밀번호 and Web3 지갑 (sign-in with a wallet signature). |
| Badge | Small status label: network names, notice pins, transaction and inquiry status. |
| BalanceHeader | Hero total-asset figure for Home, centered, in `num-hero` (left-aligned on a card). |
| BarChart | Thin pink→violet capsule bars on a light grid with a right-hand axis — 7-day activity (거래 횟수, 입출금 금액, 수익). |
| BottomNav | Flat icon-only tab bar with a blue round FAB in the middle (QR scan); the active tab gets a small blue dot. |
| Button | Rounded pill buttons with a soft colour glow. |
| ChangePill | Signed price change in `up` / `down`, as a soft pill or bare text. |
| CoinAvatar | Round coin logo by ticker: uses `src` if given, else the registered logo for the symbol, else a tinted disc with the ticker (also if the image fails to load). |
| GradientCard | Pastel mint→periwinkle→pink card with a violet card stacked behind it — the one hero highlight on a screen (목표, 이벤트, KYC 단계). |
| Greeting | Two-line greeting in `greeting` — the visual anchor of Home. |
| Icon | Line icon set drawn on a 24px grid, 1.8 stroke, round caps — inherits `currentColor`. |
| IconButton | Round 40px icon-only button for headers and inline copy actions. |
| InquiryItem | A ticket in 1:1 문의 내역: category, title, date and 답변대기 / 답변완료. |
| LanguageList | Radio list for 언어 설정; each option shows its native name and the English name. |
| NoticeItem | A row in the 공지사항 list. |
| NoticePopup | Launch popup for notices/events, with optional image, CTA, paging dots and “오늘 하루 보지 않기”. |
| PriceChart | Smooth blue line with a soft fill and dotted grid, ending in a glowing dot. |
| ProgressRing | Round progress ring with a centre slot — 보안 설정 3/5, 일일 출금 한도 사용률, KYC 진행. |
| QRScanner | Full-screen scanner overlay: dimmed mask, blue corner frame, scan line, and 앨범 / 플래시 / 내 QR buttons. |
| RangeChips | Round period chips under the price chart: 1H · 1D · 1W · 1M · 1Y. |
| Screen | Phone shell: status bar, optional app bar (left title, back, `action`), body and a bottom slot — on `bg` with a violet `bg-glow` bloom at the bottom-right. |
| SearchField | Pill search input for the token list and coin search. |
| SegmentedTabs | Text tabs where the selected one becomes a glowing blue pill — Overview / 자산, 입금 / 출금, 공지 / 문의. |
| SelectField | Button that looks like a field and opens a bottom sheet — network, coin and category pickers. |
| SettingsRow | Settings / My-page list row: icon disc, label, optional sub line, value or badge, chevron. |
| StatPair | Two figures split by a hairline — 보유 수량 / 평가 금액 on coin detail. |
| StatTile | Row with a glossy gradient icon tile, label and value — summary stats on Home's Overview tab. |
| TextField | Labelled input with optional leading icon, hint and error; `type="password"` adds a show/hide toggle; `multiline` gives a textarea (1:1 문의 본문). |
| Toggle | iOS-style switch row for settings — 알림, 생체 인증, 출금 화이트리스트. |
| TokenRow | A holding in the token list: coin, name, held amount, fiat value and 24h change. |
| TopBar | Home header: avatar, handle + account name (opens account switcher), QR scan and bell. |
| TxRow | Transaction history row: kind icon, title, date/network or short hash, signed amount, then fiat or a status badge. |

## Known Gaps

- 원본 테마 이름은 midnight(다크)·daylight(라이트)다. 템플릿 light ← daylight, dark ← midnight로 옮겼다.
- 파스텔 그라데이션 카드(pastel-a/b/c), 아이콘 타일 그라데이션(tile-*), 차트 막대(bar-a/b), 바탕 블룸(bg-glow)은 별칭에 넣지 않고 원본 색 표에만 둔다.
- 원본 간격 이름은 단계 번호(space-1=4px …)라 템플릿 이름(space-4=4px)으로 값 기준 재매핑했다.
- 라운드 10은 4의 배수가 아니라 시안 전용 토큰으로 원래 값을 유지한다(계약 9b). 보라 글로우(shadow-violet)는 원본 문서에만 남는다.
- `bg-inverse` ← `ink`: 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
- `bg-brand-subtle` ← `surface-2`: 합성 — 원본에 primary 옅은 바탕이 없음(선택은 primary 알약 + 글로우)
- `fg-tertiary` ← `ink-muted`: 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
- `fg-disabled` ← `ink-muted`: 합성 — 원본에 비활성 글자색 없음
- `border-strong` ← `toggle-off`: 합성 — 원본 선 색은 line 하나라 꺼진 토글 트랙 색을 진한 선으로 재사용

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

다크 대시보드형 중앙화(CEX) 커스터디 지갑 디자인 시스템입니다. 짙은 차콜 바탕, 둥근 카드, 크게 쓴 두 줄 인사, 빛나는 파란 알약 탭, 파스텔 그라데이션 하이라이트 카드, 민트 진행 링, 핑크→바이올렛 캡슐 막대 — 생산성 앱처럼 차분하고 친근한 지갑을 만듭니다. 전체 화면은 **AppScreens**(로그인 · Web3 가입 · 홈 개요/자산 · 코인 상세 · 활동 · 입금 QR · 출금 · 거래내역 · QR 스캔 · 팝업 공지 · 1:1 문의/공지 · 설정 · 언어)에 있습니다.

##### 제품 범위

- **계정**: 아이디/비밀번호, Web3 지갑 서명(SIWE, EIP-4361) 가입·로그인 — `AuthPanel`.
- **홈 – 개요 탭**: `Greeting`(“Hello, 스티브 님”), `GradientCard`(이번 달 목표·이벤트·KYC 단계), `StatTile`(총 입금·완료된 거래·보유 코인).
- **홈 – 자산 탭**: 총 자산 카드(`BalanceHeader`), 그라데이션 액션 타일(`ActionButton color`), 보유 토큰(`TokenRow`).
- **활동**: 보안 설정 진행(`ProgressRing` + 바이올렛 CTA), 최근 7일 거래(`BarChart`).
- **시세**: 코인 상세 `PriceChart`(부드러운 파란 선) + `RangeChips` + `StatPair`.
- **입출금**: `AddressQR`, 출금 폼(`TextField` · `SelectField` · `AmountField`), `QRScanner`, `TxRow`.
- **지원·설정**: `NoticePopup`, `NoticeItem`, `InquiryItem`, `SettingsRow`, `Toggle`(알림·생체 인증), `LanguageList`, `BottomNav`.

##### 콘텐츠 원칙

- 친근한 존댓말, “~해요”체. 홈은 이름을 불러 인사합니다: “Hello, 스티브 님” — 언어에 따라 안녕하세요, / Hello, / こんにちは、.
- 카드 캡션은 작고 조용하게(“최근 7일 거래”, “계정 보안”), 핵심 숫자는 칩이나 큰 글자로(“3/5 설정 완료”, “108건”).
- 숫자는 부호와 함께: `+$2.18`, `−2.78%`. 색만으로 방향을 말하지 않습니다.
- 이모지는 쓰지 않습니다(참고 이미지의 손 인사 이모지 대신 두 줄 인사의 크기로 분위기를 냅니다).

##### 색

- 바탕 `bg`, 화면 오른쪽 아래에서 `bg-glow` 바이올렛이 은은하게 번집니다(`Screen`). 카드·행은 `surface`, 카드 안 컨트롤은 `surface-2`, 구분선 `line`.
- 글자 `ink`, 보조 `ink-muted`.
- `primary`(파랑)는 선택 탭 알약, 켜진 토글, 가운데 스캔 FAB, 주 버튼에 — 모두 `shadow-pill` 글로우와 함께. 위의 글자는 `on-primary`. 파란 텍스트 링크는 `primary-ink`.
- `violet`은 카드 안 보조 CTA(보안 설정, 전체 보기)에 `shadow-violet`과 함께. 화면당 하나.
- `mint`는 진행 링과 달성 칩(`on-mint` 글자).
- 차트 막대는 `bar-a`→`bar-b`, 요약 숫자는 `primary-ink`와 `bar-a`로.
- 파스텔 카드: `pastel-a`→`pastel-b`→`pastel-c`, 글자와 진행 막대는 `on-pastel`, 뒤에 `bar-b` 카드가 겹쳐 보입니다. 화면당 하나.
- 아이콘 타일: `tile-{orange,green,pink,blue}-a`→`-b` 그라데이션 + 흰 아이콘(`on-tile`). 입금 orange, 출금 pink, 교환 blue, 내 QR / 완료 green.
- 상승 `up`/`up-soft`, 하락 `down`/`down-soft`, 대기 `warn`/`warn-soft`, 알림 숫자 `notify`.
- 텍스트 쌍은 두 테마 모두 4.5:1 이상. 포커스 링 `focus` 2px. 꺼진 토글 트랙(`toggle-off`)은 바탕과 대비가 낮아 흰 손잡이 위치로 상태를 전달합니다.

##### 타이포그래피

- Lexend(라틴·숫자) + Noto Sans KR(한글), Google Fonts. 숫자는 tabular(`.pl-num`).
- `greeting` 34/40 600(화면당 하나) · `num-hero` 36 600 · `title` 20 600 · `card-title` 17 600 · `body` 15 500 · `body-sm` 13 400 · `caption` 11 500.
- 굵기는 600을 넘기지 않습니다 — 부드러운 인상을 유지합니다.

##### 형태 · 간격 · 그림자

- 카드·팝업 `radius-lg` 24, 행·입력·아이콘 타일 `radius-md` 16, 뱃지 `radius-sm` 10, 탭·버튼·토글·FAB `radius-pill`.
- 화면 여백 `space-6`, 카드 안쪽 `space-5`, 행 사이 `space-2`.
- 카드는 `shadow-card`(아주 은은하게), 파랑·바이올렛 요소만 색 글로우(`shadow-pill`, `shadow-violet`).
- 하단 탭은 아이콘만(라벨은 스크린리더용), 가운데 파란 원형 FAB = QR 스캔, 활성 탭은 작은 파란 점.

##### 아이콘과 이미지

- `Icon` 라인 아이콘(24px, 1.8 스트로크). 그라데이션 타일 안에서는 2px 스트로크 흰색.
- 참고 이미지의 3D 일러스트 아이콘은 그라데이션 + 안쪽 하이라이트(`StatTile`)로 대신했습니다. 실제 3D 일러스트를 쓰려면 이미지 자산으로 추가해 타일 안에 넣습니다.
- 코인 로고는 그리지 않습니다 — CoinGecko `image` / CoinMarketCap 로고를 `CoinAvatar src`로.

##### 시세 데이터 (CoinGecko / CoinMarketCap)

- 앱은 거래소 백엔드 프록시만 호출, API 키는 서버 보관, 30–60초 캐시.
- 목록·시세: CoinGecko `GET /coins/markets?vs_currency=usd&ids=…` 또는 CMC `GET /v2/cryptocurrency/quotes/latest`.
- 차트: `GET /coins/{id}/market_chart?vs_currency=usd&days=1|7|30|365` → `prices` 60–120개로 다운샘플 → `PriceChart data`.
- 7일 활동 막대(`BarChart`)는 거래소 자체 거래 데이터로 그립니다.

##### 동작 규칙

- 출금은 OTP 후 진행, 스캔한 주소는 입력만 채웁니다.
- 팝업 공지는 앱 실행당 한 번, “오늘 하루 보지 않기”는 공지 ID별 자정까지.
- 설정 화면의 토글은 즉시 저장하거나 하단 `Save Changes` 하나로 저장 — 둘을 섞지 않습니다.
- 모션: 토글·링 0.2–0.6s, 스캔 라인. `prefers-reduced-motion`에서 스캔 라인은 멈춥니다.

##### 쓰는 법

- React 18 + `window.Pulse` 번들, `Pulse.Screen`으로 화면 틀을 만들어 조립(AppScreens 참고). 컴포넌트 이름과 props는 Orbit·Brick과 대부분 같고, Pulse에는 `Greeting`, `ProgressRing`, `BarChart`, `Toggle`, `GradientCard`, `StatTile`, `Button variant="violet"`이 추가되어 있습니다.
- QR 코드는 `qrcode-generator@1.4.4`(`window.qrcode`)를 먼저 로드합니다.

