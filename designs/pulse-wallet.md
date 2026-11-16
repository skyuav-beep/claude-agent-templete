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

### 변형 대응

#### button

| 계약 변형 | 원본 대응 |
|---|---|
| primary | primary (파랑 primary 알약 + on-primary + shadow-pill 글로우, 화면당 하나 — 저장·출금 신청·로그인) |
| secondary | secondary (surface-2 바탕) |
| tertiary | ghost (투명 바탕 + primary-ink 파란 텍스트 링크) |
| ghost | outline (투명 바탕 + 1px line 안쪽 테두리) |
| danger | 원본 없음(파괴 행동 전용 버튼 변형 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | :disabled (불투명도 45%, not-allowed — .pl-btn:disabled) |
| (원본 추가) | violet: 카드 안 보조 CTA(보안 설정·전체 보기), violet + shadow-violet, 화면당 하나 |
| (원본 추가) | 크기 sm 36 / md 48 / lg 56, block은 하단 CTA |
| (원본 추가) | 원본 ghost는 텍스트 링크라 템플릿 tertiary에, 원본 outline은 배경 없는 버튼이라 템플릿 ghost에 대응 |

#### input

| 계약 변형 | 원본 대응 |
|---|---|
| default | TextField (.pl-field-box: 최소 높이 48px, radius-md, surface-2 바탕, 라벨 위 13px 600) |
| focus | :focus-within (안쪽 2px primary 테두리) |
| error | .is-error (안쪽 2px down 테두리) + 아래 .pl-field-error down 12px, role=alert |
| disabled | 원본 없음(입력 비활성 상태 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |

#### badge

| 계약 변형 | 원본 대응 |
|---|---|
| active | up (up-soft + up, 완료·답변완료) |
| pending | warn (warn-soft + warn, 처리중·답변대기) |
| inactive | neutral (surface-2 + ink-muted) |
| danger | down (down-soft + down, 실패·거절) |

### 모바일 컴포넌트 대응

| 템플릿 모바일 컴포넌트 | 원본 대응 |
|---|---|
| bottom-sheet | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| mobile-nav | BottomNav — 아이콘만 있는 평평한 하단 탭(라벨은 스크린리더용), 활성 탭은 작은 파란 점 |
| nav-drawer | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| fab | BottomNav 가운데 fab 항목(.pl-nav-fab) — 52px 파랑 primary 원형 + shadow-pill, QR 스캔 |
| card-row | TokenRow / TxRow / StatTile — surface 바탕 radius-md 행, StatTile은 52px 그라데이션 아이콘 타일 + 라벨·값 |

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

- 두 줄 인사 — greeting 34/40 600, 자간 -0.01em, 화면당 하나(.pl-greet-title)
- 파스텔 하이라이트 카드 — pastel-a→b→c 115deg 그라데이션, radius-lg 24, 뒤에 bar-b 바이올렛 카드가 겹침, 화면당 하나(.pl-gcard, .pl-gcard-face)
- 빛나는 파란 알약 탭 — 선택 탭 primary 바탕 + shadow-pill 글로우, 높이 36px(.pl-seg-item[aria-selected])
- 민트 진행 링 — surface-2 트랙 위 mint 둥근 끝 스트로크, 0.6s 채움(.pl-ring-mint, .pl-ring-bar)
- 캡슐 막대 차트 — 폭 6px radius-pill, bar-a→bar-b(핑크→바이올렛) 세로 그라데이션, 50% 격자선(.pl-bars-bar, .pl-bars-plot)
- 하단 탭 — 높이 84px, surface + 위 1px line, 활성 표시 primary-ink 5px 점, 가운데 52px 파란 FAB(.pl-nav, .pl-nav-fab)

### 원본 컴포넌트 (35종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
| ActionButton | Gradient icon tile with a label below — the quick-action row on Home. | tone default/accent |
| AddressQR | Deposit card: coin + network, the address as a QR code, copy/share, and the wrong-network warning. |  |
| AmountField | Large numeric input for withdraw / transfer, with available balance, MAX, fiat estimate and network fee. |  |
| AuthPanel | Login / signup panel with two methods: 아이디·비밀번호 and Web3 지갑 (sign-in with a wallet signature). | mode login/signup · method id/web3 |
| Badge | Small status label: network names, notice pins, transaction and inquiry status. | tone neutral/brand/up/down/warn |
| BalanceHeader | Hero total-asset figure for Home, centered, in `num-hero` (left-aligned on a card). |  |
| BarChart | Thin pink→violet capsule bars on a light grid with a right-hand axis — 7-day activity (거래 횟수, 입출금 금액, 수익). |  |
| BottomNav | Flat icon-only tab bar with a blue round FAB in the middle (QR scan); the active tab gets a small blue dot. |  |
| Button | Rounded pill buttons with a soft colour glow. | variant primary/violet/secondary/outline/ghost · size sm/md/lg |
| ChangePill | Signed price change in `up` / `down`, as a soft pill or bare text. | kind percent/fiat · variant pill/text |
| CoinAvatar | Round coin logo by ticker: uses `src` if given, else the registered logo for the symbol, else a tinted disc with the ticker (also if the image fails to load). |  |
| GradientCard | Pastel mint→periwinkle→pink card with a violet card stacked behind it — the one hero highlight on a screen (목표, 이벤트, KYC 단계). |  |
| Greeting | Two-line greeting in `greeting` — the visual anchor of Home. |  |
| Icon | Line icon set drawn on a 24px grid, 1.8 stroke, round caps — inherits `currentColor`. |  |
| IconButton | Round 40px icon-only button for headers and inline copy actions. |  |
| InquiryItem | A ticket in 1:1 문의 내역: category, title, date and 답변대기 / 답변완료. | status waiting/answered |
| LanguageList | Radio list for 언어 설정; each option shows its native name and the English name. |  |
| NoticeItem | A row in the 공지사항 list. |  |
| NoticePopup | Launch popup for notices/events, with optional image, CTA, paging dots and “오늘 하루 보지 않기”. |  |
| PriceChart | Smooth blue line with a soft fill and dotted grid, ending in a glowing dot. |  |
| ProgressRing | Round progress ring with a centre slot — 보안 설정 3/5, 일일 출금 한도 사용률, KYC 진행. | tone mint/blue/violet |
| QRScanner | Full-screen scanner overlay: dimmed mask, blue corner frame, scan line, and 앨범 / 플래시 / 내 QR buttons. |  |
| RangeChips | Round period chips under the price chart: 1H · 1D · 1W · 1M · 1Y. |  |
| Screen | Phone shell: status bar, optional app bar (left title, back, `action`), body and a bottom slot — on `bg` with a violet `bg-glow` bloom at the bottom-right. |  |
| SearchField | Pill search input for the token list and coin search. |  |
| SegmentedTabs | Text tabs where the selected one becomes a glowing blue pill — Overview / 자산, 입금 / 출금, 공지 / 문의. |  |
| SelectField | Button that looks like a field and opens a bottom sheet — network, coin and category pickers. |  |
| SettingsRow | Settings / My-page list row: icon disc, label, optional sub line, value or badge, chevron. |  |
| StatPair | Two figures split by a hairline — 보유 수량 / 평가 금액 on coin detail. |  |
| StatTile | Row with a glossy gradient icon tile, label and value — summary stats on Home's Overview tab. |  |
| TextField | Labelled input with optional leading icon, hint and error; `type="password"` adds a show/hide toggle; `multiline` gives a textarea (1:1 문의 본문). |  |
| Toggle | iOS-style switch row for settings — 알림, 생체 인증, 출금 화이트리스트. |  |
| TokenRow | A holding in the token list: coin, name, held amount, fiat value and 24h change. | changeKind percent/fiat |
| TopBar | Home header: avatar, handle + account name (opens account switcher), QR scan and bell. |  |
| TxRow | Transaction history row: kind icon, title, date/network or short hash, signed amount, then fiat or a status badge. | kind deposit/withdraw/swap/transfer · status done/pending/failed |

### 원본 화면 예시

원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).

- `AppScreens` — 390px 화면 14종 그리드 — 로그인·Web3 가입·홈 개요(인사·파스텔 카드·스탯 타일)·홈 자산·코인 상세·활동(보안 링·7일 막대)·입금 QR·출금·거래내역·QR 스캔·팝업 공지·1:1 문의/공지·설정(토글)·언어
- `Cover` — 960×320 표지 — 파스텔 그라데이션 카드가 바이올렛 스택 위에 겹치고, 민트 진행 링과 7개 캡슐 막대가 든 패널, 태그라인 '다크 대시보드형 커스터디 지갑 — 파스텔 카드, 글로우 필, 진행 링'

### 원본 컴포넌트 스타일

원본 `components/bundle.css`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). `var(--x)`는 원본 토큰 `x`다.

| 구역 | 선택자 | 핵심 속성 |
|---|---|---|
|  | `html, body` | background bg · color ink · font-family font-sans |
|  | `body` | padding 16px |
|  | `.pl-num, .pl-num *` | font-family font-sans |
|  | `button` | font inherit · color inherit |
|  | `:where(button, a, input, textarea, select, [tabindex]):focus-visible` | outline 2px solid focus |
|  | `.pl-row` | gap space-3 |
|  | `.pl-stack` | gap space-2 |
|  | `.pl-sr` | width 1px · height 1px |
| Button | `.pl-btn` | gap space-2 · border 0 · border-radius radius-pill · padding 0 space-6 · height 48px · font-size 15px · font-weight 700 |
| Button | `.pl-btn:active` | transform scale(.98) |
| Button | `.pl-btn:disabled` | opacity .45 · transform none |
| Button | `.pl-btn-sm` | height 36px · padding 0 space-4 · font-size 13px |
| Button | `.pl-btn-lg` | height 56px · font-size 16px |
| Button | `.pl-btn-block` | width 100% |
| Button | `.pl-btn-primary` | background primary · color on-primary |
| Button | `.pl-btn-primary:hover:not(:disabled)` | background primary |
| Button | `.pl-btn-secondary` | background surface-2 · color ink |
| Button | `.pl-btn-secondary:hover:not(:disabled)` | background surface-2 |
| Button | `.pl-btn-accent` | background primary · color on-primary |
| Button | `.pl-btn-ghost` | background transparent · color primary-ink · padding 0 space-3 |
| Button | `.pl-btn-outline` | background transparent · color ink · box-shadow inset 0 0 0 1px line |
| Button | `.pl-btn-outline:hover:not(:disabled)` | background surface-2 |
| Icon button (header) | `.pl-iconbtn` | width 40px · height 40px · border-radius radius-pill · border 0 · background surface-2 · color ink |
| Icon button (header) | `.pl-iconbtn:hover` | background surface-2 |
| Icon button (header) | `.pl-iconbtn-dot` | min-width 16px · height 16px · padding 0 4px · border-radius radius-pill · background down · color #fff · font-size 10px · font-weight 800 · box-shadow 0 0 0 2px surface-2 |
| Action button (round disc + label) | `.pl-actions` | gap space-2 |
| Action button (round disc + label) | `.pl-action` | gap space-2 · background none · border 0 · padding 0 · color ink |
| Action button (round disc + label) | `.pl-action-disc` | width 56px · height 56px · border-radius radius-pill · background surface-2 |
| Action button (round disc + label) | `.pl-action:hover .pl-action-disc` | background surface-2 |
| Action button (round disc + label) | `.pl-action-accent .pl-action-disc` | background primary · color on-primary |
| Action button (round disc + label) | `.pl-action-label` | font-size 12px · font-weight 600 |
| Badge & change pill | `.pl-badge` | gap space-1 · height 24px · padding 0 space-2 · border-radius radius-sm · font-size 12px · font-weight 700 |
| Badge & change pill | `.pl-badge-neutral` | background surface-2 · color ink-muted |
| Badge & change pill | `.pl-badge-brand` | background surface-2 · color primary-ink |
| Badge & change pill | `.pl-badge-up` | background up-soft · color up |
| Badge & change pill | `.pl-badge-down` | background down-soft · color down |
| Badge & change pill | `.pl-badge-warn` | background warn-soft · color warn |
| Badge & change pill | `.pl-change` | gap 2px · font-weight 700 · font-size 13px · font-family font-sans |
| Badge & change pill | `.pl-change-up` | color up |
| Badge & change pill | `.pl-change-down` | color down |
| Badge & change pill | `.pl-change-pill` | height 28px · padding 0 space-3 · border-radius radius-pill |
| Badge & change pill | `.pl-change-pill.pl-change-up` | background up-soft |
| Badge & change pill | `.pl-change-pill.pl-change-down` | background down-soft |
| Coin avatar | `.pl-coin` | border-radius radius-pill · font-weight 800 · color #fff · letter-spacing -.02em |
| Coin avatar | `.pl-coin img` | width 100% · height 100% |
| Coin avatar | `.pl-coin-ring` | box-shadow 0 0 0 4px surface-2 |
| Top bar | `.pl-topbar` | gap space-3 |
| Top bar | `.pl-topbar-who` | min-width 0 · background none · border 0 · padding 0 |
| Top bar | `.pl-topbar-handle` | font-size 13px · color ink-muted · font-weight 500 |
| Top bar | `.pl-topbar-name` | gap space-1 · font-size 16px · font-weight 700 · color ink |
| Top bar | `.pl-avatar` | width 44px · height 44px · border-radius radius-pill · background surface-2 · color primary-ink · font-weight 800 |
| Top bar | `.pl-avatar img` | width 100% · height 100% |
| Balance header | `.pl-balance` | gap space-2 |
| Balance header | `.pl-balance-label` | gap space-2 · font-size 13px · font-weight 600 · color ink-muted · background none · border 0 · padding 0 |
| Balance header | `.pl-balance-amount` | font-size 44px · font-weight 800 · letter-spacing -.02em |
| Balance header | `.pl-balance-change` | gap space-2 |
| Fields | `.pl-field` | gap space-2 |
| Fields | `.pl-field-label` | font-size 13px · font-weight 600 · color ink-muted · gap space-2 |
| Fields | `.pl-field-box` | gap space-3 · min-height 48px · padding 0 space-4 · border-radius radius-md · background surface-2 · box-shadow inset 0 0 0 1px transparent · color ink-muted |
| Fields | `.pl-field-box:focus-within` | box-shadow inset 0 0 0 2px primary |
| Fields | `.pl-field-box.is-error` | box-shadow inset 0 0 0 2px down |
| Fields | `.pl-field-box input, .pl-field-box textarea` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font inherit · font-size 15px · font-weight 600 · padding 0 |
| Fields | `.pl-field-box textarea` | padding space-3 0 · min-height 112px |
| Fields | `.pl-field-box input::placeholder, .pl-field-box textarea::placeholder` | color ink-muted · font-weight 500 |
| Fields | `.pl-field-hint` | font-size 12px · color ink-muted |
| Fields | `.pl-field-error` | font-size 12px · color down · font-weight 600 |
| Fields | `.pl-search` | border-radius radius-pill |
| Fields | `.pl-select` | gap space-3 · width 100% · min-height 48px · padding space-2 space-4 · border-radius radius-md · background surface-2 · border 0 |
| Fields | `.pl-select:hover` | background surface-2 |
| Fields | `.pl-select-value` | font-size 15px · font-weight 700 · color ink |
| Fields | `.pl-select-sub` | font-size 12px · color ink-muted · font-weight 500 |
| Amount field | `.pl-amount` | padding space-4 · border-radius radius-lg · background surface · box-shadow inset 0 0 0 1px line · gap space-2 |
| Amount field | `.pl-amount:focus-within` | box-shadow inset 0 0 0 2px primary |
| Amount field | `.pl-amount-top, .pl-amount-bottom` | gap space-2 · font-size 12px · color ink-muted · font-weight 600 |
| Amount field | `.pl-amount-main` | gap space-3 |
| Amount field | `.pl-amount-main input` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font-family font-sans · font-size 28px · font-weight 700 · padding 0 |
| Amount field | `.pl-amount-main input::placeholder` | color ink-muted |
| Amount field | `.pl-amount-sym` | font-weight 700 · font-size 15px · color ink · gap space-2 |
| Amount field | `.pl-max` | height 28px · padding 0 space-3 · border 0 · border-radius radius-pill · background primary · color on-primary · font-size 12px · font-weight 800 |
| Lists & rows | `.pl-list` | gap space-2 |
| Lists & rows | `.pl-section-head` | gap space-3 |
| Lists & rows | `.pl-section-title` | font-size 18px · font-weight 700 |
| Lists & rows | `.pl-tokenrow, .pl-txrow, .pl-noticeitem, .pl-inquiry, .pl-setrow` | gap space-3 · width 100% · padding space-4 · border-radius radius-lg · background surface · border 0 · color ink |
| Lists & rows | `.pl-tokenrow:hover, .pl-txrow:hover, .pl-noticeitem:hover, .pl-inquir…` | background surface-2 |
| Lists & rows | `.pl-rowmain` | min-width 0 · gap 2px |
| Lists & rows | `.pl-rowtitle` | font-size 15px · font-weight 700 · gap space-2 |
| Lists & rows | `.pl-rowsub` | font-size 13px · color ink-muted · font-weight 500 |
| Lists & rows | `.pl-rowend` | gap 2px |
| Lists & rows | `.pl-rowvalue` | font-size 16px · font-weight 700 · font-family font-sans |
| Lists & rows | `.pl-txicon` | width 44px · height 44px · border-radius radius-pill |
| Lists & rows | `.pl-txicon-deposit` | background up-soft · color up |
| Lists & rows | `.pl-txicon-withdraw` | background down-soft · color down |
| Lists & rows | `.pl-txicon-swap, .pl-txicon-transfer` | background surface-2 · color primary-ink |
| Lists & rows | `.pl-setrow-icon` | width 40px · height 40px · border-radius radius-pill · background surface-2 · color ink |
| Lists & rows | `.pl-setrow-value` | font-size 13px · color ink-muted · font-weight 600 |
| Lists & rows | `.pl-chev` | color ink-muted |
| Lists & rows | `.pl-new-dot` | width 6px · height 6px · border-radius radius-pill · background primary-ink |
| Segmented / range | `.pl-seg` | padding 4px · gap 4px · border-radius radius-pill · background surface-2 |
| Segmented / range | `.pl-seg-item` | height 36px · border 0 · border-radius radius-pill · background transparent · color ink-muted · font-size 14px · font-weight 700 |
| Segmented / range | `.pl-seg-item[aria-selected="true"]` | background surface · color ink · box-shadow 0 2px 8px rgba(0,0,0,.18) |
| Segmented / range | `.pl-chips` | gap space-3 |
| Segmented / range | `.pl-chip` | min-width 44px · height 44px · padding 0 space-3 · border-radius radius-pill · border 0 · background surface-2 · color ink-muted · font-size 14px · font-weight 700 |
| Segmented / range | `.pl-chip[aria-selected="true"]` | background primary · color on-primary |
| Chart | `.pl-chart` | width 100% |
| Chart | `.pl-chart-halo` | opacity .25 |
| Stat pair | `.pl-stats` | padding space-4 0 · border-top 1px solid line · border-bottom 1px solid line |
| Stat pair | `.pl-stats-sep` | width 1px · height 48px · background line |
| Stat pair | `.pl-stat` | gap space-2 |
| Stat pair | `.pl-stat-label` | font-size 13px · color ink-muted · font-weight 600 |
| Stat pair | `.pl-stat-value` | gap space-2 · font-size 22px · font-weight 700 · font-family font-sans |
| QR | `.pl-qr` | gap space-4 · padding space-6 space-5 · border-radius radius-lg · background surface |
| QR | `.pl-qr-code` | padding 14px · border-radius radius-lg · background #ffffff |
| QR | `.pl-qr-badge` | transform translate(-50%, -50%) · box-shadow 0 0 0 5px #ffffff |
| QR | `.pl-qr-net` | gap space-2 |
| QR | `.pl-qr-addr` | width 100% · gap space-3 · padding space-3 space-4 · border-radius radius-md · background surface-2 |
| QR | `.pl-qr-addr code` | min-width 0 · font-family font-sans · font-size 13px · font-weight 600 · color ink |
| QR | `.pl-qr-actions` | gap space-2 · width 100% |
| QR | `.pl-warnbox` | gap space-3 · padding space-3 space-4 · border-radius radius-md · background warn-soft · color warn · font-size 13px · font-weight 600 · width 100% |
| Scanner | `.pl-scanner` | width 100% · height 100% · min-height 420px · background #000 · border-radius inherit · color #ffffff |
| Scanner | `.pl-scanner-media > *` | width 100% · height 100% |
| Scanner | `.pl-scanner-win` | width 240px · height 240px · border-radius 28px · box-shadow 0 0 0 2000px scrim |
| Scanner | `.pl-scanner-corner` | width 44px · height 44px · border 4px solid primary |
| Scanner | `.pl-scanner-corner.tl` | border-bottom 0 |
| Scanner | `.pl-scanner-corner.tr` | border-bottom 0 |
| Scanner | `.pl-scanner-corner.bl` | border-top 0 |
| Scanner | `.pl-scanner-corner.br` | border-top 0 |
| Scanner | `.pl-scanner-line` | height 2px · border-radius 2px · background primary · box-shadow 0 0 12px primary |
| Scanner | `.pl-scanner-top, .pl-scanner-bottom` | padding space-5 · gap space-3 |
| Scanner | `.pl-scanner-top` | font-weight 700 · font-size 16px |
| Scanner | `.pl-scanner-hint` | font-size 14px · font-weight 600 · padding 0 space-6 · color #ffffff |
| Scanner | `.pl-scanner-bottom` | gap space-8 |
| Scanner | `.pl-scanner-btn` | gap space-2 · background none · border 0 · color #ffffff · font-size 12px · font-weight 600 |
| Scanner | `.pl-scanner-btn span` | width 52px · height 52px · border-radius radius-pill · background rgba(255,255,255,.16) |
| Scanner | `.pl-scanner-btn[aria-pressed="true"] span` | background primary · color on-primary |
| Notice popup | `.pl-layer` | padding space-5 · background scrim |
| Notice popup | `.pl-layer.is-contained` | border-radius inherit |
| Notice popup | `.pl-popup` | width 100% · max-width 340px · border-radius radius-lg · background surface · box-shadow shadow-card |
| Notice popup | `.pl-popup-media` | background surface-2 |
| Notice popup | `.pl-popup-media img` | width 100% · height 100% |
| Notice popup | `.pl-popup-body` | padding space-5 · gap space-2 |
| Notice popup | `.pl-popup-title` | font-size 18px · font-weight 800 |
| Notice popup | `.pl-popup-text` | font-size 14px · color ink-muted · font-weight 500 |
| Notice popup | `.pl-popup-foot` | border-top 1px solid line |
| Notice popup | `.pl-popup-foot button` | height 52px · border 0 · background none · font-size 14px · font-weight 700 · color ink-muted |
| Notice popup | `.pl-popup-foot button + button` | color ink |
| Notice popup | `.pl-dots` | gap 6px |
| Notice popup | `.pl-dots i` | width 6px · height 6px · border-radius radius-pill · background line |
| Notice popup | `.pl-dots i.on` | width 18px · background primary |
| Language list | `.pl-lang` | gap space-1 |
| Language list | `.pl-lang-item` | gap space-3 · padding space-3 space-4 · border-radius radius-md · background none · border 0 · color ink · width 100% |
| Language list | `.pl-lang-item:hover` | background surface-2 |
| Language list | `.pl-lang-item[aria-checked="true"]` | background surface-2 |
| Language list | `.pl-lang-code` | width 36px · height 36px · border-radius radius-pill · background surface-2 · font-size 12px · font-weight 800 · color ink-muted |
| Language list | `.pl-lang-item[aria-checked="true"] .pl-lang-code` | background primary · color on-primary |
| Language list | `.pl-lang-check` | color primary-ink |
| Auth | `.pl-auth` | gap space-4 |
| Auth | `.pl-auth-title` | font-size 24px · font-weight 800 |
| Auth | `.pl-auth-sub` | font-size 14px · color ink-muted · font-weight 500 |
| Auth | `.pl-divider` | gap space-3 · color ink-muted · font-size 12px · font-weight 600 |
| Auth | `.pl-divider::before, .pl-divider::after` | height 1px · background line |
| Auth | `.pl-connector` | gap space-3 · width 100% · min-height 56px · padding 0 space-4 · border-radius radius-md · background surface · border 0 · box-shadow inset 0 0 0 1px line · color ink |
| Auth | `.pl-connector:hover` | background surface-2 |
| Auth | `.pl-connector-glyph` | width 36px · height 36px · border-radius 12px · background surface-2 · color primary-ink |
| Auth | `.pl-connector-name` | font-size 15px · font-weight 700 |
| Auth | `.pl-auth-links` | gap space-4 · font-size 13px |
| Auth | `.pl-auth-links a` | color ink-muted · font-weight 600 |
| Auth | `.pl-auth-links a:hover` | color ink |
| Bottom nav | `.pl-nav` | height 76px · padding 0 space-3 · background surface-2 · border-radius radius-lg radius-lg 0 0 · box-shadow shadow-card |
| Bottom nav | `.pl-nav-item` | gap 4px · background none · border 0 · color ink-muted · width 56px · padding space-2 0 · font-size 11px · font-weight 600 |
| Bottom nav | `.pl-nav-item[aria-current="page"]` | color ink |
| Bottom nav | `.pl-nav-item[aria-current="page"]::after` | width 4px · height 4px · border-radius radius-pill · background primary |
| Bottom nav | `.pl-nav-fab` | width 56px · height 56px · border-radius radius-pill · border 0 · background primary · color on-primary · box-shadow shadow-pill |
| Screen shell | `.pl-screen` | width 390px · height 820px · border-radius 44px · background radial-gradient(120% 60% at 70% -10%, bg-glow 0%, bg 62%) · color ink · box-shadow 0 0 0 8px surface-2, 0 30px 80px rgba(0,0,0,.35) |
| Screen shell | `.pl-status` | padding 16px 28px 6px · font-size 14px · font-weight 700 · font-family font-sans |
| Screen shell | `.pl-screen-body` | min-height 0 · padding space-3 space-5 space-5 · gap space-5 |
| Screen shell | `.pl-appbar` | gap space-3 · min-height 44px |
| Screen shell | `.pl-appbar-title` | font-size 17px · font-weight 800 |
| Screen shell | `.pl-appbar-spacer` | width 40px |
| ===== Pulse look ===== | `html, body` | font-family font-sans |
| ===== Pulse look ===== | `.pl-num, .pl-num *` | font-family font-sans |
| ===== Pulse look ===== | `.pl-btn` | font-weight 600 |
| ===== Pulse look ===== | `.pl-btn-primary` | box-shadow shadow-pill |
| ===== Pulse look ===== | `.pl-btn-violet` | background violet · color on-primary · box-shadow shadow-violet |
| ===== Pulse look ===== | `.pl-btn-secondary` | background surface-2 |
| ===== Pulse look ===== | `.pl-iconbtn` | background transparent · width 40px · height 40px |
| ===== Pulse look ===== | `.pl-iconbtn:hover` | background surface-2 |
| ===== Pulse look ===== | `.pl-iconbtn-dot` | background notify · box-shadow none |
| Greeting | `.pl-greet` | gap space-2 |
| Greeting | `.pl-greet-eyebrow` | font-size 13px · font-weight 500 · color ink-muted |
| Greeting | `.pl-greet-title` | font-size 34px · font-weight 600 · letter-spacing -0.01em |
| Greeting | `.pl-greet-sub` | font-size 14px · color ink-muted |
| Top bar: title left, chat/bell + avatar right | `.pl-topbar-name` | font-size 20px · font-weight 600 |
| Top bar: title left, chat/bell + avatar right | `.pl-avatar` | width 48px · height 48px · background linear-gradient(160deg, pastel-a, tile-blue-b) · color on-pastel · box-shadow 0 0 0 3px bg, 0 0 0 5px surface-2 |
| Tabs: selected = blue pill, others plain text | `.pl-seg` | background transparent · padding 0 · gap space-2 |
| Tabs: selected = blue pill, others plain text | `.pl-seg-item` | height 36px · padding 0 space-4 · font-weight 500 · font-size 15px · color ink-muted |
| Tabs: selected = blue pill, others plain text | `.pl-seg-item[aria-selected="true"]` | background primary · color on-primary · box-shadow shadow-pill |
| Tabs: selected = blue pill, others plain text | `.pl-chip` | min-width 46px · height 34px · font-weight 500 · background transparent |
| Tabs: selected = blue pill, others plain text | `.pl-chip[aria-selected="true"]` | box-shadow shadow-pill |
| Cards | `.pl-card` | background surface · border-radius radius-lg · padding space-5 · box-shadow shadow-card |
| Cards | `.pl-card-cap` | font-size 13px · color ink-muted |
| Cards | `.pl-tokenrow, .pl-txrow, .pl-noticeitem, .pl-inquiry, .pl-setrow` | border-radius radius-md |
| Cards | `.pl-balance-amount` | font-size 36px · font-weight 600 |
| Cards | `.pl-change-pill` | border-radius radius-sm · height 26px · padding 0 space-2 |
| Gradient tiles | `.pl-g-orange` | background linear-gradient(150deg, tile-orange-a, tile-orange-b) · color on-tile |
| Gradient tiles | `.pl-g-green` | background linear-gradient(150deg, tile-green-a, tile-green-b) · color on-tile |
| Gradient tiles | `.pl-g-pink` | background linear-gradient(150deg, tile-pink-a, tile-pink-b) · color on-tile |
| Gradient tiles | `.pl-g-blue` | background linear-gradient(150deg, tile-blue-a, tile-blue-b) · color on-tile |
| Gradient tiles | `.pl-action .pl-action-disc` | border-radius radius-md |
| Gradient tiles | `.pl-action[class*="pl-g-"]` | background none |
| Gradient tiles | `.pl-action.pl-g-orange .pl-action-disc` | background linear-gradient(150deg, tile-orange-a, tile-orange-b) · color on-tile |
| Gradient tiles | `.pl-action.pl-g-green .pl-action-disc` | background linear-gradient(150deg, tile-green-a, tile-green-b) · color on-tile |
| Gradient tiles | `.pl-action.pl-g-pink .pl-action-disc` | background linear-gradient(150deg, tile-pink-a, tile-pink-b) · color on-tile |
| Gradient tiles | `.pl-action.pl-g-blue .pl-action-disc` | background linear-gradient(150deg, tile-blue-a, tile-blue-b) · color on-tile |
| Gradient tiles | `.pl-stattile` | gap space-4 · width 100% · padding space-3 · border 0 · border-radius radius-md · background surface · color ink |
| Gradient tiles | `.pl-stattile:hover` | background surface-2 |
| Gradient tiles | `.pl-stattile-icon` | width 52px · height 52px · border-radius radius-md · box-shadow inset 0 -6px 12px rgba(0,0,0,.12), inset 0 4px 8px rgba(255,255,255,.35) |
| Gradient card | `.pl-gcard-face` | border-radius radius-lg · padding space-5 · background linear-gradient(115deg, pastel-a 0%, pastel-b 55%, pastel-c 100%) · color on-pastel · gap space-2 |
| Gradient card | `.pl-gcard-stack` | height 40px · border-radius 0 0 radius-lg radius-lg · background bar-b |
| Gradient card | `.pl-gcard-title` | font-size 18px · font-weight 600 |
| Gradient card | `.pl-gcard-sub` | font-size 14px · font-weight 400 |
| Gradient card | `.pl-gcard-track` | height 8px · border-radius radius-pill · background rgba(20, 21, 27, .15) |
| Gradient card | `.pl-gcard-track span` | height 100% · border-radius inherit · background on-pastel |
| Ring | `.pl-ring-center` | font-size 15px |
| Bars | `.pl-bars-plot` | gap space-2 · height 120px |
| Bars | `.pl-bars-col` | height 100% · gap 6px |
| Bars | `.pl-bars-bar` | width 6px · border-radius radius-pill · background linear-gradient(180deg, bar-a, bar-b) |
| Bars | `.pl-bars-bar.is-muted` | opacity .45 |
| Bars | `.pl-bars-x` | font-size 11px · color ink-muted |
| Bars | `.pl-bars-y` | font-size 11px · color ink-muted |
| Toggle | `.pl-toggle-row` | gap space-3 · padding space-3 0 · border-bottom 1px solid line |
| Toggle | `.pl-toggle` | width 50px · height 28px · border 0 · border-radius radius-pill · background toggle-off · padding 0 |
| Toggle | `.pl-toggle[aria-checked="true"]` | background primary · box-shadow shadow-pill |
| Toggle | `.pl-toggle-knob` | width 22px · height 22px · border-radius radius-pill · background #ffffff · box-shadow 0 2px 6px rgba(0,0,0,.3) |
| Toggle | `.pl-toggle[aria-checked="true"] .pl-toggle-knob` | transform translateX(22px) |
| Toggle | `.pl-toggle:disabled` | opacity .45 |
| Bottom nav: flat icons + blue round FAB | `.pl-nav` | background surface · border-radius 0 · height 84px · box-shadow none · border-top 1px solid line |
| Bottom nav: flat icons + blue round FAB | `.pl-nav-item` | color ink-muted |
| Bottom nav: flat icons + blue round FAB | `.pl-nav-item[aria-current="page"]` | color ink |
| Bottom nav: flat icons + blue round FAB | `.pl-nav-item[aria-current="page"]::after` | background primary-ink · width 5px · height 5px |
| Bottom nav: flat icons + blue round FAB | `.pl-nav-fab` | box-shadow shadow-pill · width 52px · height 52px |
| Bottom nav: flat icons + blue round FAB | `.pl-sr` | width 1px · height 1px |
| Screen: bloom bottom-right | `.pl-screen` | background radial-gradient(90% 55% at 100% 100%, bg-glow 0%, bg 70%) · box-shadow 0 0 0 9px #0b0c10, 0 0 0 11px #3a3c46, 0 30px 80px rgba(0,0,0,.4) |
| Screen: bloom bottom-right | `.pl-appbar-title` | font-size 20px · font-weight 600 |
| Screen: bloom bottom-right | `.pl-qr` | background surface |
| Screen: bloom bottom-right | `.pl-popup-media` | background linear-gradient(115deg, pastel-a, pastel-b 55%, pastel-c) |
| Screen: bloom bottom-right | `.pl-popup-media span` | color on-pastel !important |
| Screen: bloom bottom-right | `.pl-popup-title` | font-weight 600 |
| Screen: bloom bottom-right | `.pl-lang-item[aria-checked="true"]` | background surface-2 · box-shadow inset 0 0 0 2px primary |
| Screen: bloom bottom-right | `.pl-ok-chip` | height 26px · padding 0 10px · border-radius radius-sm · background mint · color on-mint · font-weight 600 · font-size 14px |

## Do's and Don'ts

**Do**

- primary 버튼 하나와 violet 버튼 하나까지만 화면에
- 파스텔 카드는 화면당 하나, 글자는 항상 on-pastel
- 숫자는 부호와 함께, 색만으로 방향 전달하지 않기
- 상태 배지는 항상 아이콘 + 단어
- 액션 타일 색은 고정 매핑(입금 orange·출금 pink·교환 blue·내 QR green)
- 토글은 즉시 저장 또는 화면당 Save Changes 하나 — 섞지 않기
- 출금은 OTP 후, 스캔한 주소는 입력만 채우기

**Don't**

- 굵기 600 초과 금지
- 이모지 쓰지 않기(인사도 크기로 분위기)
- 코인 로고를 직접 그리지 않기
- 필드 오류를 토스트로 중복 표시하지 않기
- primary 두 개·violet 두 개 금지

## Responsive Behavior

- 목업 프레임 390×820, radius 44px(.pl-screen)
- 화면 여백 space-6, 카드 안쪽 space-5, 행 사이 space-2
- 컨트롤 높이 36/48/56, 하단 CTA는 lg + block
- prefers-reduced-motion에서 스캔 라인 정지

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

