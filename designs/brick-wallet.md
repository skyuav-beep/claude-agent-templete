---
name: Brick Wallet
slug: brick-wallet
category: finance
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/GBDRB53TjJPVyeWEJjfBDT
related_services: []
lang: ko
policy:
  shadow_on_cards: true
  gradient_locations: []
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/GBDRB53TjJPVyeWEJjfBDT
  version: "1794797833-2694"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/brick-wallet.map.json
---

# Brick Wallet — design.md

> 네오 브루탈리즘 CEX 커스터디 지갑 — 크림색 종이 위 검은 굵은 선, 4–6px 딱딱한 그림자, 라임·핑크·블루·오렌지 원색 블록이 벽돌처럼 쌓이는 시안.

본 시안은 Claude Design System 「Brick Wallet」(https://claude.ai/artifact/GBDRB53TjJPVyeWEJjfBDT)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/brick-wallet.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

네오 브루탈리즘 CEX 커스터디 지갑 — 크림색 종이 위 검은 굵은 선, 4–6px 딱딱한 그림자, 라임·핑크·블루·오렌지 원색 블록이 벽돌처럼 쌓이는 시안.

- 카드 그림자: 허용 · gradient: 전면 금지 · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#c6f432"        # ← lime
pink: "#ff8ad8"                 # ← pink
blue: "#6fa8ff"                 # ← blue
orange: "#ffb547"               # ← orange
```

### Semantic alias — Light

```yaml
bg-canvas: "#fff4d6"                # ← bg
bg-surface: "#ffffff"               # ← surface
bg-subtle: "#ffe9a8"                # ← surface-alt
bg-muted: "#ffe9a8"                 # ← surface-alt
bg-elevated: "#ffffff"              # ← surface
bg-inverse: "#000000"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#c6f432"                 # ← lime
bg-brand-subtle: "#ffe9a8"          # ← surface-alt · 합성 — 원본에 브랜드 옅은 바탕이 없음(원색 블록만)
bg-success-subtle: "#ffe9a8"        # ← surface-alt · 합성 — 원본 상태 표시는 진한 원색 블록(up-block)+on-block 글자라, 템플릿의 '옅은 바탕+상태색 글자' 조합에서 읽히도록 중립 면 재사용
bg-warning-subtle: "#ffe9a8"        # ← surface-alt · 합성 — 원본 대기·경고는 orange 블록+on-block 글자(위와 같은 이유로 중립 면)
bg-danger-subtle: "#ffe9a8"         # ← surface-alt · 합성 — 원본 실패는 down-block 블록+on-block 글자(위와 같은 이유로 중립 면)
fg-strong: "#000000"                # ← ink
fg-default: "#000000"               # ← ink
fg-secondary: "#4a4436"             # ← ink-muted
fg-tertiary: "#4a4436"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#4a4436"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#000000"              # ← on-block
fg-brand: "#000000"                 # ← ink · 합성 — 라임은 글자로 쓰지 않는다(브랜드 강조 글자는 ink)
fg-success: "#0a6b2a"               # ← up
fg-warning: "#000000"               # ← ink · 합성 — 원본에 경고 글자색이 없음(주황 블록 위 on-block 글자)
fg-danger: "#c21a1a"                # ← down
border-subtle: "#000000"            # ← line
border-default: "#000000"           # ← line
border-strong: "#000000"            # ← line
border-brand: "#000000"             # ← line · 합성 — 원본의 모든 테두리는 line(Paper 검정 / Night 크림)
```

### Semantic alias — Dark

```yaml
bg-canvas: "#151412"                # ← bg
bg-surface: "#22201c"               # ← surface
bg-subtle: "#2f2c26"                # ← surface-alt
bg-muted: "#2f2c26"                 # ← surface-alt
bg-elevated: "#22201c"              # ← surface
bg-inverse: "#fff4d6"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#c6f432"                 # ← lime
bg-brand-subtle: "#2f2c26"          # ← surface-alt · 합성 — 원본에 브랜드 옅은 바탕이 없음(원색 블록만)
bg-success-subtle: "#2f2c26"        # ← surface-alt · 합성 — 원본 상태 표시는 진한 원색 블록(up-block)+on-block 글자라, 템플릿의 '옅은 바탕+상태색 글자' 조합에서 읽히도록 중립 면 재사용
bg-warning-subtle: "#2f2c26"        # ← surface-alt · 합성 — 원본 대기·경고는 orange 블록+on-block 글자(위와 같은 이유로 중립 면)
bg-danger-subtle: "#2f2c26"         # ← surface-alt · 합성 — 원본 실패는 down-block 블록+on-block 글자(위와 같은 이유로 중립 면)
fg-strong: "#fff4d6"                # ← ink
fg-default: "#fff4d6"               # ← ink
fg-secondary: "#c9bfa6"             # ← ink-muted
fg-tertiary: "#c9bfa6"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#c9bfa6"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#000000"              # ← on-block
fg-brand: "#fff4d6"                 # ← ink · 합성 — 라임은 글자로 쓰지 않는다(브랜드 강조 글자는 ink)
fg-success: "#8dff6a"               # ← up
fg-warning: "#fff4d6"               # ← ink · 합성 — 원본에 경고 글자색이 없음(주황 블록 위 on-block 글자)
fg-danger: "#ff8f8f"                # ← down
border-subtle: "#fff4d6"            # ← line
border-default: "#fff4d6"           # ← line
border-strong: "#fff4d6"            # ← line
border-brand: "#fff4d6"             # ← line · 합성 — 원본의 모든 테두리는 line(Paper 검정 / Night 크림)
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `bg` | #fff4d6 | #151412 | App ground: warm paper in Paper, near-black in Night. |
| `bg-dots` | #e9d9ad | #2b2924 | The 16px dot grid printed on `bg` and inside chart boxes. Decoration only, never text. |
| `surface` | #ffffff | #22201c | Cards, rows, inputs, sheets — always with a `line` border and `shadow-hard`. |
| `surface-alt` | #ffe9a8 | #2f2c26 | Table headers, pressed rows, idle chips, segmented-control track. |
| `ink` | #000000 | #fff4d6 | All text and icons on bg, surface and surface-alt. |
| `ink-muted` | #4a4436 | #c9bfa6 | Secondary text (amounts held, dates, labels) on bg, surface, surface-alt. |
| `line` | #000000 | #fff4d6 | Every border (2px, 3px on hero blocks) and the hard shadow colour. Borders are the main way surfaces are separated. |
| `lime` | #c6f432 | #c6f432 | Primary action fill, active nav tab, hero balance block, price-up block. Text on it is `on-block`. |
| `pink` | #ff8ad8 | #ff8ad8 | Scan button, stickers, 출금 tile, notice popup header. Text on it is `on-block`. |
| `blue` | #6fa8ff | #6fa8ff | 입금 tile, info stickers, selected language. Text on it is `on-block`. |
| `orange` | #ffb547 | #ffb547 | 교환 tile, pending badges, warning boxes. Text on it is `on-block`. |
| `on-block` | #000000 | #000000 | Text and icons on lime, pink, blue, orange, up-block and down-block — black in both themes. |
| `up` | #0a6b2a | #8dff6a | Price up / deposit amount text on bg and surface, always with ▲ or +. |
| `down` | #c21a1a | #ff8f8f | Price down / failed / error text on bg and surface, always with ▼ or −. |
| `up-block` | #c6f432 | #c6f432 | Fill of the up change chip and 완료 badge (same as lime); text `on-block`. |
| `down-block` | #ff7a7a | #ff7a7a | Fill of the down change chip and 실패 badge; text `on-block`. |
| `focus` | #2340e8 | #6fa8ff | 3px solid focus ring with 3px offset; ≥3:1 on bg and surface. |
| `scrim` | rgba(0, 0, 0, 0.55) | rgba(0, 0, 0, 0.7) | Behind popups, sheets and the scanner window. |

## Typography

### 서체 선택

- **Primary**: `Archivo, "Noto Sans KR", system-ui, sans-serif`
- **Mono**: `"IBM Plex Mono", "Noto Sans KR", ui-monospace, monospace`

### Type ramp

```yaml
display1: 40/400/1/-0.02em        # ← display (40px/40px) Auth headline and empty states; one per screen.
display2: 40/700/1.1/-0.03em      # ← num-hero (40px/44px) Total balance inside the lime hero block.
display3: 26/700/1.23/0           # ← num-lg (26px/32px) Coin price on detail, amount input.
title1: 22/400/1.18/0             # ← headline (22px/26px) Screen titles and section headers, sentence case.
title2: 22/400/1.18/0             # ← headline (22px/26px) Screen titles and section headers, sentence case.
title3: 15/700/1.47/0             # ← body (15px/22px) Row titles, button labels, inputs.
label1: 15/700/1.47/0             # ← body (15px/22px) Row titles, button labels, inputs.
label2: 11/800/1.27/0.08em        # ← label (11px/14px) Uppercase labels on blocks, table headers, stickers.
body1: 15/700/1.47/0              # ← body (15px/22px) Row titles, button labels, inputs.
body1-read: 15/700/1.47/0         # ← body (15px/22px) Row titles, button labels, inputs.
body2: 13/500/1.38/0              # ← body-sm (13px/18px) Secondary lines, helper text.
caption1: 11/800/1.27/0.08em      # ← label (11px/14px) Uppercase labels on blocks, table headers, stickers.
```

### 시안 전용 글꼴 스타일

| 원본 스타일 | 크기/굵기/줄높이/자간 | 용도 |
|---|---|---|
| `num-md` | 15/600/1.33/0 | Values in rows and tables, ticker prices. |

## Spacing

```yaml
space-4: 4        # ← space-1 Inside stickers and badges.
space-8: 8        # ← space-2 Icon-to-text gap; gap between grid tiles.
space-12: 12      # ← space-3 Gap between rows; padding of compact rows.
space-16: 16      # ← space-4 Card padding; screen gutter.
space-20: 20      # 표준 ladder (원본에 없음)
space-24: 24      # ← space-6 Between sections.
space-32: 32      # 표준 ladder (원본에 없음)
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
radius-16: 16       # 표준 ladder
radius-0: 0         # ← radius-none 0px — Tables, ticker, nav bar, chart box.
radius-6: 6         # ← radius-sm 6px · 시안 전용(비-4) — Buttons, inputs, chips, badges, tiles.
radius-12: 12       # ← radius-md 12px — Cards, hero block, popups, the screen frame inner blocks.
```

## Elevation & Depth

```yaml
shadow-1: "4px 4px 0 #000000"             # ← shadow-hard · dark 4px 4px 0 #fff4d6
shadow-pop: "6px 6px 0 #000000"           # ← shadow-hard-lg · dark 6px 6px 0 #fff4d6
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | 원본 Button (라임 블록 + 검은 선 + shadow-hard, 누르면 4px 이동) |
| input | 원본 입력 컴포넌트 (surface + 2px line) |
| badge | 상태 배지 (up-block · orange · down-block 원색 블록) |
| chip | 칩 (surface-alt, 선택은 눌린 상태) |
| avatar | 코인 아바타 (사각 블록) |
| icon-button | 아이콘 버튼 (사각 블록 + 선) |
| icon | 굵은 라인 아이콘, currentColor |

### 변형 대응

#### button

| 계약 변형 | 원본 대응 |
|---|---|
| primary | primary (lime 블록 + on-block 검정 글자, 2px line 테두리 + 4px 딱딱한 그림자, 화면당 하나의 확정 동작) |
| secondary | secondary (surface 바탕, primary와 짝을 이루는 대안) |
| tertiary | ghost (배경·테두리·그림자 없음, 2px 밑줄 텍스트 링크) |
| ghost | outline (투명 바탕 + 2px 테두리, 그림자 없음 — 부담 적은 취소) |
| danger | 원본 없음(파괴 행동 전용 버튼 변형 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | :disabled (불투명도 45%, 그림자 제거 — .bk-btn:disabled) |
| (원본 추가) | accent: pink 블록, 스캔·카메라 순간에만 |
| (원본 추가) | 크기 sm 36 / md 48 / lg 58, 하단 CTA는 lg + block |
| (원본 추가) | 누르면 블록이 그림자 위로 4px 이동(shadow-pressed) |
| (원본 추가) | 원본 ghost는 밑줄 링크라 템플릿 tertiary에, 원본 outline은 그림자 없는 투명 버튼이라 템플릿 ghost에 대응 |

#### input

| 계약 변형 | 원본 대응 |
|---|---|
| default | TextField (.bk-field-box: 최소 높이 50px, 2px line 테두리, radius-sm 6, surface 바탕, 라벨은 대문자 11px 800 자간 .08em) |
| focus | :focus-within (shadow-hard 4px 딱딱한 그림자가 나타남), 전역 포커스 링은 focus 3px + 3px 오프셋 |
| error | .is-error (테두리 down + 4px 4px 0 down 그림자) + 아래 .bk-field-error down 12px 800, role=alert |
| disabled | 원본 없음(입력 비활성 상태 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |

#### badge

| 계약 변형 | 원본 대응 |
|---|---|
| active | up (up-block 라임 + on-block, 완료·답변완료) |
| pending | warn (orange + on-block, 처리중·답변대기) |
| inactive | neutral (surface-alt + ink) |
| danger | down (down-block 코랄 + on-block, 실패·거절) |

### 모바일 컴포넌트 대응

| 템플릿 모바일 컴포넌트 | 원본 대응 |
|---|---|
| bottom-sheet | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| mobile-nav | BottomNav — 테두리로 나뉜 평평한 탭 바, 활성 탭은 lime으로 채움 |
| nav-drawer | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| fab | BottomNav의 fab 항목(.bk-nav-fab) — 64px pink 사각 스캔 버튼이 바 위로 22px 튀어나옴 |
| card-row | TokenRow / TxRow / SettingsRow — surface 바탕 radius-sm 행, 2px 테두리 + 4px 딱딱한 그림자 |

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

- 벽돌 블록 — 2px line 테두리 + shadow-hard 4px(히어로·팝업 6px) 흐림 없는 그림자, 누르면 translate(4px,4px)(.bk-btn 외 공통 규칙)
- 점 종이 바탕 — bg 위 bg-dots 1.2px 원형 도트 16px 격자(.bk-screen)
- 라임 총 자산 블록 — lime 바탕 + 3px 테두리 + radius-md, 금액 40px 700 자간 -.03em(.bk-balance, .bk-balance-amount)
- 하단 탭 — 높이 70px, 위 3px 테두리, 탭 사이 2px 세로선, 활성 탭 lime 채움, 64px pink 사각 FAB가 -22px 위로(.bk-nav, .bk-nav-fab)
- 시세 띠 — lime 마퀴, 위아래 2px 테두리, 항목 사이 세로선, 24s 무한 흐름(.bk-ticker)
- 기울어진 스티커 — 2px 테두리 + 2px 그림자, 대문자 11px 800, −6~6도 기울임, 블록당 하나(.bk-sticker)

### 원본 컴포넌트 (31종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
| ActionButton | Square colour tile with an outlined icon and a display-face label — Home's 2×2 quick-action grid. | tone default/accent |
| AddressQR | Deposit card (thick border, big shadow): coin + network, the address as a QR code, copy/share, and the wrong-network warning. |  |
| AmountField | Large numeric input for withdraw / transfer, with available balance, MAX, fiat estimate and network fee. |  |
| AuthPanel | Login / signup panel with two methods: 아이디·비밀번호 and Web3 지갑 (sign-in with a wallet signature). | mode login/signup · method id/web3 |
| Badge | Small status label: network names, notice pins, transaction and inquiry status. | tone neutral/brand/up/down/warn |
| BalanceHeader | The lime hero block on Home: uppercase label with the hide toggle, the total in `num-hero`, and the 24h change. |  |
| BottomNav | Flat tab bar split by borders; the active tab fills lime, and a pink square Scan button breaks out above the bar. |  |
| Button | Chunky bordered button with a hard shadow; pressing it slides 4px onto its shadow. | variant primary/secondary/accent/outline/ghost · size sm/md/lg |
| ChangePill | Signed price change: a bordered chip (lime up / coral down, black text) or bare text in `up` / `down`. | kind percent/fiat · variant pill/text |
| CoinAvatar | Square bordered coin logo. |  |
| Icon | Line icon set (same glyphs as the app's other kits) drawn on a 24px grid, 1.8 stroke, round caps — inherits `currentColor`. |  |
| IconButton | Square 42px bordered icon-only button for headers and inline copy actions. |  |
| InquiryItem | A ticket in 1:1 문의 내역: category, title, date and 답변대기 / 답변완료. | status waiting/answered |
| LanguageList | Radio list for 언어 설정; each option shows its native name and the English name. |  |
| NoticeItem | A row in the 공지사항 list. |  |
| NoticePopup | Launch popup with a striped pink header block, with optional image, CTA, paging dots and “오늘 하루 보지 않기”. |  |
| PriceChart | Hard-edged price chart: straight segments in `line`, a solid lime area, a graph-paper grid and a pink square marking the latest price — inside a bordered box wi |  |
| QRScanner | Scanner overlay: a square lime window with pink corner blocks and a stepped scan line, a lime hint strip, and 앨범 / 플래시 / 내 QR tiles. |  |
| RangeChips | Equal-width square chips under the chart: 1H · 1D · 1W · 1M · 1Y. |  |
| Screen | Phone screen shell on dotted paper: status bar, optional app bar (left-aligned display title, back, `action`), body and a bottom slot (`nav`). |  |
| SearchField | Bordered search input for the token list and coin search. |  |
| SegmentedTabs | Bordered segmented control (selected segment inverts to `ink`) for switching views in place: login method, history filter, notice/inquiry tabs. |  |
| SelectField | Button that looks like a field and opens a bottom sheet — network, coin and category pickers. |  |
| SettingsRow | Settings / My-page list row: icon disc, label, optional sub line, value or badge, chevron. |  |
| StatPair | Two figures in one bordered box split by a 2px rule — 보유 수량 / 평가 금액 on coin detail. |  |
| Sticker | Small tilted label slapped on a block — network on the deposit card, “NEW” on a listing, event tags. |  |
| TextField | Labelled input with optional leading icon, hint and error; `type="password"` adds a show/hide toggle; `multiline` gives a textarea (1:1 문의 본문). |  |
| Ticker | Lime marquee strip of listed coins with price and ▲/▼ change — sits under the Home header. |  |
| TokenRow | A holding in the token list: coin, name, held amount, fiat value and 24h change. | changeKind percent/fiat |
| TopBar | Home header: avatar, handle + account name (opens account switcher), QR scan and bell. |  |
| TxRow | Transaction history row: kind icon, title, date/network or short hash, signed amount, then fiat or a status badge. | kind deposit/withdraw/swap/transfer · status done/pending/failed |

### 원본 화면 예시

원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).

- `AppScreens` — 390px 화면 13종 그리드 — 로그인(대형 디스플레이 문구 + 스티커)·Web3 가입·홈(시세 띠·라임 총 자산·2×2 액션 타일)·코인 상세·입금 QR(TRC-20 ONLY 스티커)·출금·거래내역·QR 스캔·팝업 공지·공지/문의·문의 작성·설정·언어
- `Cover` — 960×320 표지 — lime·pink·blue·orange·surface 벽돌을 3px 테두리와 6px 딱딱한 그림자로 엇갈려 쌓은 패턴, 태그라인 '네오 브루탈리즘 커스터디 지갑 — 굵은 선, 단단한 그림자, 원색 블록'

### 원본 컴포넌트 스타일

원본 `components/bundle.css`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). `var(--x)`는 원본 토큰 `x`다.

| 구역 | 선택자 | 핵심 속성 |
|---|---|---|
|  | `html, body` | background-color bg · color ink · font-family font-sans |
|  | `body` | padding 16px |
|  | `.bk-num, .bk-num *` | font-family font-mono |
|  | `button` | font inherit · color inherit |
|  | `:where(button, a, input, textarea, [tabindex]):focus-visible` | outline 3px solid focus |
|  | `.bk-row` | gap space-3 |
|  | `.bk-stack` | gap space-3 |
| block colours (tiles, stickers) | `.bk-c-lime` | background lime · color on-block |
| block colours (tiles, stickers) | `.bk-c-pink` | background pink · color on-block |
| block colours (tiles, stickers) | `.bk-c-blue` | background blue · color on-block |
| block colours (tiles, stickers) | `.bk-c-orange` | background orange · color on-block |
| block colours (tiles, stickers) | `.bk-c-surface` | background surface · color ink |
| the brick: border + hard shadow + press | `.bk-btn, .bk-iconbtn, .bk-action, .bk-tokenrow, .bk-txrow, .bk-notice…` | border border-w solid line · box-shadow shadow-hard |
| the brick: border + hard shadow + press | `:is(.bk-btn, .bk-iconbtn, .bk-action, .bk-tokenrow, .bk-txrow, .bk-no…` | transform translate(4px, 4px) · box-shadow shadow-pressed |
| the brick: border + hard shadow + press | `:is(.bk-tokenrow, .bk-txrow, .bk-noticeitem, .bk-inquiry, .bk-setrow,…` | background surface-alt |
| Button | `.bk-btn` | gap space-2 · border-radius radius-sm · padding 0 space-6 · height 48px · font-size 15px · font-weight 800 |
| Button | `.bk-btn:disabled` | opacity .45 · box-shadow none |
| Button | `.bk-btn-sm` | height 36px · padding 0 space-3 · font-size 13px |
| Button | `.bk-btn-lg` | height 58px · font-size 17px |
| Button | `.bk-btn-block` | width 100% |
| Button | `.bk-btn-primary` | background lime · color on-block |
| Button | `.bk-btn-secondary` | background surface · color ink |
| Button | `.bk-btn-accent` | background pink · color on-block |
| Button | `.bk-btn-outline` | background transparent · color ink · box-shadow none |
| Button | `.bk-btn-ghost` | background none · border 0 · box-shadow none · color ink · padding 0 space-2 |
| Icon button | `.bk-iconbtn` | width 42px · height 42px · border-radius radius-sm · background surface · color ink |
| Icon button | `.bk-iconbtn-dot` | min-width 20px · height 20px · padding 0 4px · border border-w solid line · border-radius radius-sm · background pink · color on-block · font-size 11px · font-weight 800 · font-family font-mono |
| Action tile | `.bk-actions` | gap space-3 |
| Action tile | `.bk-action` | gap space-4 · min-height 84px · padding space-3 · border-radius radius-sm |
| Action tile | `.bk-action-disc` | width 34px · height 34px · border border-w solid currentColor · border-radius radius-sm |
| Action tile | `.bk-action-label` | font-family font-display · font-size 17px |
| Badge, change, sticker | `.bk-badge` | gap space-1 · height 24px · padding 0 space-2 · border border-w solid line · border-radius radius-sm · font-size 11px · font-weight 800 · letter-spacing .04em |
| Badge, change, sticker | `.bk-badge-neutral` | background surface-alt · color ink |
| Badge, change, sticker | `.bk-badge-brand` | background blue · color on-block |
| Badge, change, sticker | `.bk-badge-up` | background up-block · color on-block |
| Badge, change, sticker | `.bk-badge-down` | background down-block · color on-block |
| Badge, change, sticker | `.bk-badge-warn` | background orange · color on-block |
| Badge, change, sticker | `.bk-change` | gap 2px · font-weight 700 · font-size 13px · font-family font-mono |
| Badge, change, sticker | `.bk-change-up` | color up |
| Badge, change, sticker | `.bk-change-down` | color down |
| Badge, change, sticker | `.bk-change-pill` | height 28px · padding 0 space-2 · border border-w solid line · border-radius radius-sm · color on-block |
| Badge, change, sticker | `.bk-change-pill.bk-change-up` | background up-block · color on-block |
| Badge, change, sticker | `.bk-change-pill.bk-change-down` | background down-block · color on-block |
| Badge, change, sticker | `.bk-sticker` | padding space-1 space-2 · border border-w solid line · border-radius radius-sm · box-shadow 2px 2px 0 line · font-size 11px · font-weight 800 · letter-spacing .08em |
| Coin | `.bk-coin` | border-radius radius-sm · border border-w solid line · font-weight 800 · color #000000 · font-family font-mono · letter-spacing -.04em |
| Coin | `.bk-coin img` | width 100% · height 100% |
| Coin | `.bk-coin-ring` | box-shadow shadow-hard |
| Top bar | `.bk-topbar` | gap space-3 |
| Top bar | `.bk-topbar-who` | min-width 0 · background none · border 0 · padding 0 |
| Top bar | `.bk-topbar-handle` | font-size 11px · font-weight 800 · letter-spacing .08em · color ink-muted |
| Top bar | `.bk-topbar-name` | gap space-1 · font-family font-display · font-size 20px · color ink |
| Top bar | `.bk-avatar` | width 42px · height 42px · border border-w solid line · border-radius radius-sm · background orange · color on-block · font-family font-display · font-size 18px |
| Balance hero block | `.bk-balance` | gap space-2 · padding space-4 · background lime · color on-block · border border-w-lg solid line · border-radius radius-md · box-shadow shadow-hard-lg |
| Balance hero block | `.bk-balance-label` | gap space-2 · font-size 11px · font-weight 800 · letter-spacing .08em · background none · border 0 · padding 0 · color on-block |
| Balance hero block | `.bk-balance-amount` | font-size 40px · font-weight 700 · letter-spacing -.03em |
| Balance hero block | `.bk-balance-change` | gap space-2 |
| Balance hero block | `.bk-balance .bk-change-up, .bk-balance .bk-change-down` | color on-block |
| Balance hero block | `.bk-balance .bk-change-pill` | background surface · color ink |
| Fields | `.bk-field` | gap space-2 |
| Fields | `.bk-field-label` | font-size 11px · font-weight 800 · letter-spacing .08em · color ink · gap space-2 |
| Fields | `.bk-field-label a` | letter-spacing 0 · font-size 12px · color ink !important |
| Fields | `.bk-field-box` | gap space-3 · min-height 50px · padding 0 space-3 · border border-w solid line · border-radius radius-sm · background surface · color ink |
| Fields | `.bk-field-box:focus-within` | box-shadow shadow-hard |
| Fields | `.bk-field-box.is-error` | background surface · box-shadow 4px 4px 0 down |
| Fields | `.bk-field-box input, .bk-field-box textarea` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font inherit · font-size 15px · font-weight 700 · padding 0 |
| Fields | `.bk-field-box textarea` | padding space-3 0 · min-height 112px · font-weight 500 |
| Fields | `.bk-field-box input::placeholder, .bk-field-box textarea::placeholder` | color ink-muted · font-weight 500 |
| Fields | `.bk-field-hint` | font-size 12px · color ink-muted · font-weight 600 |
| Fields | `.bk-field-error` | font-size 12px · color down · font-weight 800 |
| Fields | `.bk-field-box .bk-iconbtn` | width 34px · height 34px · box-shadow none |
| Fields | `.bk-select` | gap space-3 · width 100% · min-height 54px · padding space-2 space-3 · border-radius radius-sm · background surface · color ink |
| Fields | `.bk-select-value` | font-size 15px · font-weight 800 |
| Fields | `.bk-select-sub` | font-size 12px · color ink-muted · font-weight 600 |
| Amount | `.bk-amount` | padding space-4 · border border-w solid line · border-radius radius-md · background surface · box-shadow shadow-hard · gap space-2 |
| Amount | `.bk-amount-top, .bk-amount-bottom` | gap space-2 · font-size 12px · color ink-muted · font-weight 700 |
| Amount | `.bk-amount-top > span:first-child` | font-size 11px · letter-spacing .08em · color ink · font-weight 800 |
| Amount | `.bk-amount-main` | gap space-3 · border-top border-w dashed line · border-bottom border-w dashed line · padding space-3 0 |
| Amount | `.bk-amount-main input` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font-family font-mono · font-size 28px · font-weight 700 · padding 0 |
| Amount | `.bk-amount-main input::placeholder` | color ink-muted |
| Amount | `.bk-amount-sym` | font-weight 800 · font-size 15px · gap space-2 |
| Amount | `.bk-max` | height 30px · padding 0 space-3 · border-radius radius-sm · background pink · color on-block · font-size 12px · font-weight 800 · box-shadow 2px 2px 0 line |
| Lists & rows | `.bk-list` | gap space-3 |
| Lists & rows | `.bk-section-head` | gap space-3 |
| Lists & rows | `.bk-section-title` | font-family font-display · font-size 22px · font-weight 400 |
| Lists & rows | `.bk-tokenrow, .bk-txrow, .bk-noticeitem, .bk-inquiry, .bk-setrow` | gap space-3 · width 100% · padding space-3 · border-radius radius-sm · background surface · color ink |
| Lists & rows | `.bk-rowmain` | min-width 0 · gap 2px |
| Lists & rows | `.bk-rowtitle` | font-size 15px · font-weight 800 · gap space-2 |
| Lists & rows | `.bk-rowsub` | font-size 12px · color ink-muted · font-weight 600 |
| Lists & rows | `.bk-rowend` | gap 4px |
| Lists & rows | `.bk-rowvalue` | font-size 15px · font-weight 700 · font-family font-mono |
| Lists & rows | `.bk-txicon` | width 40px · height 40px · border border-w solid line · border-radius radius-sm · color on-block |
| Lists & rows | `.bk-txicon-deposit` | background blue |
| Lists & rows | `.bk-txicon-withdraw` | background pink |
| Lists & rows | `.bk-txicon-swap, .bk-txicon-transfer` | background orange |
| Lists & rows | `.bk-setrow-icon` | width 38px · height 38px · border border-w solid line · border-radius radius-sm · background surface-alt · color ink |
| Lists & rows | `.bk-setrow-value` | font-size 13px · font-weight 800 |
| Lists & rows | `.bk-chev` | color ink |
| Lists & rows | `.bk-new-dot` | width 10px · height 10px · border border-w solid line · background pink |
| Segmented, chips | `.bk-seg` | border border-w solid line · border-radius radius-sm · background surface · box-shadow shadow-hard |
| Segmented, chips | `.bk-seg-item` | height 42px · border 0 · background transparent · color ink · font-size 14px · font-weight 800 |
| Segmented, chips | `.bk-seg-item[aria-selected="true"]` | background ink · color bg |
| Segmented, chips | `.bk-chips` | gap space-2 |
| Segmented, chips | `.bk-chip` | height 38px · border-radius radius-sm · background surface · color ink · font-size 13px · font-weight 800 · font-family font-mono · box-shadow 2px 2px 0 line |
| Segmented, chips | `.bk-chip[aria-selected="true"]` | background lime · color on-block · transform translate(2px, 2px) · box-shadow none |
| Chart | `.bk-chart` | width 100% · border border-w solid line · border-radius radius-sm · background surface · box-shadow shadow-hard |
| Stat pair | `.bk-stats` | border border-w solid line · border-radius radius-sm · background surface · box-shadow shadow-hard |
| Stat pair | `.bk-stats-sep` | background line |
| Stat pair | `.bk-stat` | gap space-1 · padding space-3 |
| Stat pair | `.bk-stat-label` | font-size 11px · font-weight 800 · letter-spacing .08em · color ink-muted |
| Stat pair | `.bk-stat-value` | gap space-2 · font-size 20px · font-weight 700 · font-family font-mono |
| QR | `.bk-qr` | gap space-3 · padding space-4 · border border-w-lg solid line · border-radius radius-md · background surface · box-shadow shadow-hard-lg |
| QR | `.bk-qr-net` | gap space-2 · font-weight 800 |
| QR | `.bk-qr-code` | padding 12px · border border-w solid #000000 · background #ffffff |
| QR | `.bk-qr-badge` | transform translate(-50%, -50%) |
| QR | `.bk-qr-addr` | gap space-3 · padding space-2 space-2 space-2 space-3 · border border-w dashed line · border-radius radius-sm · background surface-alt |
| QR | `.bk-qr-addr code` | min-width 0 · font-family font-mono · font-size 12px · font-weight 600 · color ink |
| QR | `.bk-qr-addr .bk-iconbtn` | width 34px · height 34px · box-shadow 2px 2px 0 line |
| QR | `.bk-qr-actions` | gap space-3 |
| QR | `.bk-warnbox` | gap space-2 · padding space-3 · border border-w solid line · border-radius radius-sm · background orange · color on-block · font-size 13px · font-weight 700 |
| Scanner | `.bk-scanner` | width 100% · height 100% · min-height 420px · background #000000 · color #fff4d6 |
| Scanner | `.bk-scanner-media > *` | width 100% · height 100% |
| Scanner | `.bk-scanner-win` | width 248px · height 248px · border 4px solid lime · box-shadow 0 0 0 2000px scrim, 8px 8px 0 pink |
| Scanner | `.bk-scanner-corner` | width 22px · height 22px · background pink · border 3px solid #000000 |
| Scanner | `.bk-scanner-line` | height 4px · background lime |
| Scanner | `.bk-scanner-top, .bk-scanner-bottom` | padding space-4 · gap space-3 |
| Scanner | `.bk-scanner-top` | font-family font-display · font-size 20px |
| Scanner | `.bk-scanner-top .bk-iconbtn` | background surface !important · color ink !important |
| Scanner | `.bk-scanner-hint` | padding space-2 space-3 · font-size 13px · font-weight 800 · background lime · color on-block · border border-w solid #000000 |
| Scanner | `.bk-scanner-bottom` | gap space-6 |
| Scanner | `.bk-scanner-btn` | gap space-2 · background none · border 0 · color #fff4d6 · font-size 12px · font-weight 800 |
| Scanner | `.bk-scanner-btn span` | width 54px · height 54px · background surface · color ink · border border-w solid #000000 · border-radius radius-sm · box-shadow 3px 3px 0 pink |
| Scanner | `.bk-scanner-btn[aria-pressed="true"] span` | background lime · color on-block |
| Popup | `.bk-layer` | padding space-6 · background scrim |
| Popup | `.bk-popup` | width 100% · max-width 330px · border border-w-lg solid line · border-radius radius-md · background surface · box-shadow shadow-hard-lg |
| Popup | `.bk-popup-media` | background pink · color on-block · border-bottom border-w-lg solid line |
| Popup | `.bk-popup-media img` | width 100% · height 100% |
| Popup | `.bk-popup-media span` | color on-block !important |
| Popup | `.bk-popup-body` | padding space-4 · gap space-2 |
| Popup | `.bk-popup-title` | font-family font-display · font-size 22px · font-weight 400 |
| Popup | `.bk-popup-text` | font-size 14px · color ink-muted · font-weight 600 |
| Popup | `.bk-popup-foot` | border-top border-w solid line |
| Popup | `.bk-popup-foot button` | height 50px · border 0 · background surface-alt · font-size 13px · font-weight 800 · color ink |
| Popup | `.bk-popup-foot button + button` | background surface |
| Popup | `.bk-dots` | gap 6px |
| Popup | `.bk-dots i` | width 10px · height 10px · border border-w solid line · background surface |
| Popup | `.bk-dots i.on` | width 24px · background ink |
| Language | `.bk-lang` | gap space-3 |
| Language | `.bk-lang-item` | gap space-3 · padding space-3 · border-radius radius-sm · background surface · color ink · width 100% |
| Language | `.bk-lang-item[aria-checked="true"]` | background blue · color on-block |
| Language | `.bk-lang-item[aria-checked="true"] .bk-rowsub` | color on-block |
| Language | `.bk-lang-code` | width 38px · height 38px · border border-w solid line · border-radius radius-sm · background surface-alt · font-size 12px · font-weight 800 · font-family font-mono · color ink |
| Language | `.bk-lang-item[aria-checked="true"] .bk-lang-code` | background surface |
| Language | `.bk-lang-check` | color on-block |
| Auth | `.bk-auth` | gap space-4 |
| Auth | `.bk-auth-title` | font-family font-display · font-size 34px · font-weight 400 · letter-spacing -.02em |
| Auth | `.bk-auth-sub` | font-size 14px · color ink-muted · font-weight 600 |
| Auth | `.bk-connector` | gap space-3 · width 100% · min-height 60px · padding 0 space-3 · border-radius radius-sm · background surface · color ink |
| Auth | `.bk-connector:nth-child(1) .bk-connector-glyph` | background orange |
| Auth | `.bk-connector:nth-child(2) .bk-connector-glyph` | background blue |
| Auth | `.bk-connector:nth-child(3) .bk-connector-glyph` | background pink |
| Auth | `.bk-connector-glyph` | width 38px · height 38px · border border-w solid line · border-radius radius-sm · color on-block |
| Auth | `.bk-connector-name` | font-size 15px · font-weight 800 |
| Auth | `.bk-auth-links` | font-size 13px |
| Auth | `.bk-auth-links a` | color ink · font-weight 800 |
| Bottom nav | `.bk-nav` | height 70px · background surface · border-top border-w-lg solid line |
| Bottom nav | `.bk-nav-item` | gap 3px · background none · border 0 · color ink · font-size 11px · font-weight 800 |
| Bottom nav | `.bk-nav-item[aria-current="page"]` | background lime · color on-block |
| Bottom nav | `.bk-nav-fab` | width 64px · height 64px · border-width border-w-lg · border-radius radius-sm · background pink · color on-block |
| Ticker | `.bk-ticker` | border-top border-w solid line · border-bottom border-w solid line · background lime · color on-block |
| Ticker | `.bk-ticker-track` | width max-content |
| Ticker | `.bk-ticker-item` | gap space-2 · padding 7px space-3 · font-size 12px · font-weight 700 |
| Ticker | `.bk-ticker-item b` | font-weight 800 |
| Ticker | `.bk-ticker-chg` | font-family font-mono |
| Screen shell | `.bk-screen` | width 390px · height 820px · background-color bg · color ink · border border-w-lg solid line · border-radius 36px · box-shadow 10px 10px 0 line |
| Screen shell | `.bk-status` | padding 16px 26px 6px · font-size 14px · font-weight 700 · font-family font-mono |
| Screen shell | `.bk-screen-body` | min-height 0 · padding space-3 space-4 space-4 · gap space-4 |
| Screen shell | `.bk-appbar` | gap space-3 · min-height 46px |
| Screen shell | `.bk-appbar-title` | font-family font-display · font-size 22px · font-weight 400 |
| Screen shell | `.bk-appbar-spacer` | width 42px |

## Do's and Don'ts

**Do**

- 블록 색 의미 고정 — lime 주 동작·활성·총 자산·상승, pink 스캔·출금·스티커·공지, blue 입금·정보, orange 교환·처리중·경고
- 블록 위 글자는 언제나 on-block(검정)
- 면 구분은 선으로, 테두리·그림자 색은 line
- 숫자는 항상 부호(U+2212)나 ▲▼와 함께
- 라벨·스티커·표 머리는 대문자 영문 또는 짧은 한글, 자간 넓게
- 액션 타일 색은 앱 전체에서 고정(입금 blue·출금 pink·교환 orange·내 QR surface)
- 출금은 OTP 후, 스캔한 주소는 입력만 채우기

**Don't**

- 흐림 그림자 쓰지 않기
- 이모지 쓰지 않기(장식은 스티커와 블록으로)
- 스티커는 블록당 하나, 목록 행에는 붙이지 않기
- 코인 로고를 직접 그리지 않기
- 색만으로 방향·상태 전달하지 않기
- 텍스트 라벨이 있는 동작에 IconButton 쓰지 않기
- 필드 오류를 토스트로 중복 표시하지 않기

## Responsive Behavior

- 목업 프레임 390×820(.bk-screen)
- 화면 여백 space-4, 섹션 사이 space-6, 행 사이 space-3
- 컨트롤 높이 36/48/58, 하단 CTA는 lg + block
- prefers-reduced-motion에서 시세 띠와 스캔 라인 정지

## Known Gaps

- 원본 테마 이름은 paper(라이트)·night(다크)다. 템플릿 light ← paper, dark ← night로 옮겼다.
- 원본 선 색은 line 하나(2–3px, Paper 검정 / Night 크림)라 테두리 별칭 4종이 모두 같다. 상태 '옅은 바탕' 별칭은 중립 면(surface-alt)이다 — 원본 배지처럼 원색 블록(up-block·orange·down-block)+on-block 글자를 쓰려면 원본 색 표의 토큰을 직접 쓴다.
- 원본에는 둥근 모서리가 거의 없다(0·6·12). radius-full은 정의하지 않으며, 원형이 필요하면 템플릿 표준 fallback을 쓴다. 라운드 6은 시안 전용 토큰.
- 원본 간격은 4·8·12·16·24만 있다(space-5·space-8 없음). 바탕 점 격자(bg-dots)는 원본 색 표에만 둔다. 제목 서체(display)는 Archivo Black 계열.
- `bg-inverse` ← `ink`: 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
- `bg-brand-subtle` ← `surface-alt`: 합성 — 원본에 브랜드 옅은 바탕이 없음(원색 블록만)
- `bg-success-subtle` ← `surface-alt`: 합성 — 원본 상태 표시는 진한 원색 블록(up-block)+on-block 글자라, 템플릿의 '옅은 바탕+상태색 글자' 조합에서 읽히도록 중립 면 재사용
- `bg-warning-subtle` ← `surface-alt`: 합성 — 원본 대기·경고는 orange 블록+on-block 글자(위와 같은 이유로 중립 면)
- `bg-danger-subtle` ← `surface-alt`: 합성 — 원본 실패는 down-block 블록+on-block 글자(위와 같은 이유로 중립 면)
- `fg-tertiary` ← `ink-muted`: 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
- `fg-disabled` ← `ink-muted`: 합성 — 원본에 비활성 글자색 없음
- `fg-brand` ← `ink`: 합성 — 라임은 글자로 쓰지 않는다(브랜드 강조 글자는 ink)
- `fg-warning` ← `ink`: 합성 — 원본에 경고 글자색이 없음(주황 블록 위 on-block 글자)
- `border-brand` ← `line`: 합성 — 원본의 모든 테두리는 line(Paper 검정 / Night 크림)

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

네오 브루탈리즘 스타일의 중앙화(CEX) 커스터디 지갑 디자인 시스템입니다. 크림색 종이 위에 검은 굵은 선, 4–6px 딱딱한 그림자, 라임·핑크·블루·오렌지 원색 블록 — 모든 것이 “벽돌”처럼 쌓입니다. 화면 전체 예시는 **AppScreens**(로그인 · Web3 가입 · 홈 · 코인 상세 · 입금 QR · 출금 · 거래내역 · QR 스캔 · 팝업 공지 · 공지/1:1 문의 · 문의 작성 · 설정 · 언어 설정)에 있습니다.

##### 제품 범위

- **계정**: 아이디/비밀번호 가입·로그인, Web3 지갑 서명(SIWE, EIP-4361) 가입·로그인 — `AuthPanel`. 지갑은 신원 증명용, 자산 보관은 거래소가 합니다.
- **자산**: 시세 띠(`Ticker`), 총 자산 라임 블록(`BalanceHeader`), 2×2 액션 타일(`ActionButton`), 보유 자산(`TokenRow`), 코인 상세(`PriceChart`, `RangeChips`, `StatPair`).
- **입출금**: 입금 QR(`AddressQR` + `Sticker`), 출금(`TextField` + `SelectField` + `AmountField`), QR 스캔(`QRScanner`), 거래내역(`TxRow`).
- **지원**: 팝업 공지(`NoticePopup`), 공지사항(`NoticeItem`), 1:1 문의(`InquiryItem` + 작성 폼).
- **설정**: `SettingsRow`, `LanguageList`, 하단 탭 `BottomNav`.

##### 콘텐츠 원칙

- 짧고 직설적인 존댓말. “~해요”체 허용: “서명 한 번이면 계정이 만들어져요.” 버튼은 동사: “출금 신청 →”, “복사”.
- 라벨·스티커·표 머리글은 **대문자 영문 또는 짧은 한글**, 자간 넓게(`label` 스타일): TOTAL BALANCE, TRC-20 ONLY, EVENT.
- 숫자는 항상 부호(+ / −, U+2212)나 ▲▼와 함께. 색만으로 방향을 말하지 않습니다.
- 날짜는 목록 구분선에서 `11.11`, 상세에서 `2026.11.11 09:41`.
- 이모지 없음. 장식은 스티커와 블록으로 합니다.

##### 색

- 바탕 `bg`(종이) 위에 `bg-dots` 16px 도트 그리드. 카드·행·입력은 `surface`, 표 머리·눌림·트랙은 `surface-alt`.
- 모든 테두리와 그림자 색은 `line`(Paper = 검정, Night = 크림). 면 구분은 그림자 색 차이가 아니라 **선**으로 합니다.
- 글자는 `ink`, 보조는 `ink-muted`.
- 블록 색은 의미를 고정합니다: `lime` = 주 동작·활성 탭·총 자산·상승, `pink` = 스캔·출금·스티커·공지, `blue` = 입금·정보, `orange` = 교환·처리중·경고. 블록 위 글자는 언제나 `on-block`(검정, 두 테마 공통).
- 텍스트로 쓰는 등락은 `up` / `down`, 칩·뱃지 면은 `up-block` / `down-block` + `on-block`.
- 포커스는 `focus` 3px 실선 + 3px 오프셋. 팝업·시트 뒤는 `scrim`.
- 텍스트 쌍은 두 테마 모두 4.5:1 이상(블록 위 검정 글자 포함).

##### 타이포그래피

- 디스플레이: Archivo Black(라틴) + Black Han Sans(한글) — `display`(화면당 하나), `headline`(화면·섹션 제목).
- 숫자: IBM Plex Mono, tabular — `num-hero`(라임 블록 안 총 자산), `num-lg`(코인 가격·입력), `num-md`(행·시세 띠).
- 본문: Archivo + Noto Sans KR — `body`(행 제목·버튼, 700), `body-sm`, `label`(대문자 라벨 11px 800).
- 모두 Google Fonts(`bundle.css` 첫 줄)에서 불러옵니다.

##### 선 · 그림자 · 모서리 · 간격

- 테두리 `border-w` 2px가 기본, 총 자산·팝업·입금 카드·스캔 버튼은 `border-w-lg` 3px.
- 올라온 블록은 `shadow-hard`(4px), 히어로·팝업은 `shadow-hard-lg`(6px). 흐림 그림자는 쓰지 않습니다.
- 누르면 블록이 그림자 위로 4px 이동(`shadow-pressed`). 선택된 칩도 눌린 상태로 둡니다.
- 모서리는 작게: 버튼·입력·타일 `radius-sm` 6px, 카드·팝업 `radius-md` 12px, 시세 띠·탭 바·차트 격자 `radius-none`.
- 화면 여백 `space-4`, 섹션 사이 `space-6`, 행 사이 `space-3`.

##### 아이콘과 이미지

- `Icon` 라인 아이콘(24px, 1.8 스트로크, `currentColor`). 블록 안에서는 2px 테두리 박스에 넣습니다(액션 타일).
- 코인 로고는 그리지 않습니다 — CoinGecko `image` / CoinMarketCap 로고를 `CoinAvatar src`로. 없으면 밝은 원색 사각 배지에 티커.
- 지갑 연결은 이름 + 범용 아이콘. 공식 로고가 필요하면 각 사 브랜드 자산을 사용합니다.

##### 시세 데이터 (CoinGecko / CoinMarketCap)

- 앱은 거래소 백엔드 프록시만 호출, API 키는 서버 보관, 30–60초 캐시.
- 목록·시세 띠: CoinGecko `GET /coins/markets?vs_currency=usd&ids=…` 또는 CMC `GET /v2/cryptocurrency/quotes/latest`.
- 차트: `GET /coins/{id}/market_chart?vs_currency=usd&days=1|7|30|365` → `prices` 40–80개로 다운샘플 → `PriceChart data`.
- 관리자에서 코인별 `coingecko_id` / `cmc_id` 매핑, 화면에 출처 표기.

##### 동작 규칙

- 출금은 OTP 후 진행, 스캔한 주소는 입력만 채웁니다.
- 팝업 공지는 앱 실행당 한 번, “오늘 하루 보지 않기”는 공지 ID별 자정까지.
- 움직임은 세 가지뿐: 누름 이동(80ms), 시세 띠 흐름, 스캔 라인(계단식). `prefers-reduced-motion`에서 띠와 스캔 라인은 멈춥니다.

##### 쓰는 법

- React 18 + `window.Brick` 번들. `Brick.Screen`으로 화면 틀을 만들고 조립합니다(AppScreens 참고). 컴포넌트 이름과 props는 Orbit Wallet 시스템과 거의 같아, 같은 화면 코드를 두 스타일로 바꿔 끼울 수 있습니다(추가: `Ticker`, `Sticker`, `ActionButton color`).
- QR 코드는 `qrcode-generator@1.4.4`(`window.qrcode`)를 먼저 로드합니다.

