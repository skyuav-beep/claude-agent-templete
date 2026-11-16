---
name: Orbit Wallet
slug: orbit-wallet
category: finance
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/RnTCYCVwS81WFjeqkw1kSj
related_services: []
lang: ko
policy:
  shadow_on_cards: false
  gradient_locations: ["background"]
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/RnTCYCVwS81WFjeqkw1kSj
  version: "1794797836-a44b"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/orbit-wallet.map.json
---

# Orbit Wallet — design.md

> 다크 퍼스트 CEX 커스터디 지갑 — 깊은 보랏빛 바탕에 노란 포인트 하나, 숫자가 주인공인 모바일 지갑 시안.

본 시안은 Claude Design System 「Orbit Wallet」(https://claude.ai/artifact/RnTCYCVwS81WFjeqkw1kSj)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/orbit-wallet.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

다크 퍼스트 CEX 커스터디 지갑 — 깊은 보랏빛 바탕에 노란 포인트 하나, 숫자가 주인공인 모바일 지갑 시안.

- 카드 그림자: 금지(헤어라인 우선) · gradient: background · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#7a2fc7"        # ← brand
accent: "#f3dd3f"               # ← accent
chart-line: "#7a2fc7"           # ← chart-line
```

### Semantic alias — Light

```yaml
bg-canvas: "#f5f3f9"                # ← bg
bg-surface: "#ffffff"               # ← surface-1
bg-subtle: "#efebf5"                # ← surface-2
bg-muted: "#e4deee"                 # ← surface-3
bg-elevated: "#ffffff"              # ← surface-1
bg-inverse: "#15111d"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#7a2fc7"                 # ← brand
bg-brand-subtle: "#efe4fb"          # ← brand-soft
bg-success-subtle: "#ddf3e6"        # ← up-soft
bg-warning-subtle: "#fbefd6"        # ← warn-soft
bg-danger-subtle: "#fbe2e4"         # ← down-soft
fg-strong: "#15111d"                # ← ink
fg-default: "#15111d"               # ← ink
fg-secondary: "#5e5670"             # ← ink-muted
fg-tertiary: "#6a637d"              # ← ink-faint
fg-disabled: "#6a637d"              # ← ink-faint · 합성 — 원본에 비활성 글자색이 없어 ink-faint 재사용
fg-on-brand: "#ffffff"              # ← on-brand
fg-brand: "#6b25b5"                 # ← brand-ink
fg-success: "#0f7643"               # ← up
fg-warning: "#9a5b00"               # ← warn
fg-danger: "#c9303a"                # ← down
border-subtle: "#ddd6e8"            # ← line
border-default: "#ddd6e8"           # ← line
border-strong: "#ddd6e8"            # ← line · 합성 — 원본 선 색은 line 하나
border-brand: "#7a2fc7"             # ← brand
```

### Semantic alias — Dark

```yaml
bg-canvas: "#0c0912"                # ← bg
bg-surface: "#17121f"               # ← surface-1
bg-subtle: "#221b2d"                # ← surface-2
bg-muted: "#2d2539"                 # ← surface-3
bg-elevated: "#17121f"              # ← surface-1
bg-inverse: "#f5f2fa"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#9146e0"                 # ← brand
bg-brand-subtle: "#2a1840"          # ← brand-soft
bg-success-subtle: "#173527"        # ← up-soft
bg-warning-subtle: "#3a2c12"        # ← warn-soft
bg-danger-subtle: "#3a1a20"         # ← down-soft
fg-strong: "#f5f2fa"                # ← ink
fg-default: "#f5f2fa"               # ← ink
fg-secondary: "#a69eb6"             # ← ink-muted
fg-tertiary: "#918aa1"              # ← ink-faint
fg-disabled: "#918aa1"              # ← ink-faint · 합성 — 원본에 비활성 글자색이 없어 ink-faint 재사용
fg-on-brand: "#ffffff"              # ← on-brand
fg-brand: "#c29bff"                 # ← brand-ink
fg-success: "#3ddc84"               # ← up
fg-warning: "#f5b547"               # ← warn
fg-danger: "#ff6b6b"                # ← down
border-subtle: "#2e2640"            # ← line
border-default: "#2e2640"           # ← line
border-strong: "#2e2640"            # ← line · 합성 — 원본 선 색은 line 하나
border-brand: "#9146e0"             # ← brand
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `bg` | #f5f3f9 | #0c0912 | App ground behind every screen; the bottom of the screen glow. |
| `bg-glow` | #e6daf7 | #3b1763 | Top of the screen glow only (radial, fades into `bg`). Never a fill for cards or text grounds. |
| `surface-1` | #ffffff | #17121f | Cards, token rows, sheets, modals. |
| `surface-2` | #efebf5 | #221b2d | Round action discs, inputs, secondary buttons, idle chips. |
| `surface-3` | #e4deee | #2d2539 | Pressed / hover state of surface-2; bottom navigation bar. |
| `line` | #ddd6e8 | #2e2640 | Hairline dividers, chart grid (dashed), input borders at rest. |
| `ink` | #15111d | #f5f2fa | Primary text and icons on bg, surface-1, surface-2, surface-3. |
| `ink-muted` | #5e5670 | #a69eb6 | Secondary text (token amounts, labels, dates) on bg and all surfaces. |
| `ink-faint` | #6a637d | #918aa1 | Placeholders and tertiary meta on bg, surface-1, surface-2. Never for amounts. |
| `brand` | #7a2fc7 | #9146e0 | Primary button fill, selected range chip, active tab, header glow accent. Text on it is `on-brand`. |
| `brand-hover` | #6a25b2 | #a15bec | Hover / pressed state of brand fills. |
| `on-brand` | #ffffff | #ffffff | Text and icons on `brand` and `brand-hover`. |
| `brand-ink` | #6b25b5 | #c29bff | Brand-coloured text and links on bg and surfaces (e.g. “전체 보기”, unread dot). |
| `brand-soft` | #efe4fb | #2a1840 | Selected list row and selected language row background; text on it is `ink`. |
| `accent` | #f3dd3f | #f3dd3f | The one hero action per screen: centre Scan button in the bottom nav, “Max”, highlight dot. Text/icons on it are `on-accent`. |
| `on-accent` | #17120a | #17120a | Text and icons on `accent`. |
| `up` | #0f7643 | #3ddc84 | Price up, deposit amounts, completed status text — always with a + sign or up arrow, never colour alone. On bg, surfaces and up-soft. |
| `up-soft` | #ddf3e6 | #173527 | Ground of the up change pill and completed badge. |
| `down` | #c9303a | #ff6b6b | Price down, failed status, validation errors — always with a − sign, down arrow or word. On bg, surfaces and down-soft. |
| `down-soft` | #fbe2e4 | #3a1a20 | Ground of the down change pill, failed badge and error banners. |
| `warn` | #9a5b00 | #f5b547 | Pending status text, network warnings on deposit/withdraw. On bg, surfaces and warn-soft. |
| `warn-soft` | #fbefd6 | #3a2c12 | Ground of pending badges and the deposit-network warning box. |
| `focus` | #7a2fc7 | #f3dd3f | 2px solid focus ring with 2px offset on every focusable control; ≥3:1 on bg and all surfaces. |
| `chart-line` | #7a2fc7 | #f3dd3f | Price chart line, its end dot and the area fill (fill at 14% → 0% opacity). |
| `scrim` | rgba(21, 17, 29, 0.48) | rgba(5, 3, 9, 0.72) | Behind notice popups, bottom sheets and the QR scanner frame. |

## Typography

### 서체 선택

- **Primary**: `Manrope, "Noto Sans KR", "Apple SD Gothic Neo", system-ui, sans-serif`

### Type ramp

```yaml
display1: 44/800/1.09/-0.02em     # ← num-hero (44px/48px) Total balance on Home, once per screen. Tabular figures.
display2: 28/700/1.21/-0.01em     # ← num-lg (28px/34px) Coin detail holding, amount input value.
display3: 24/700/1.33/0           # ← title-lg (24px/32px) Screen titles on auth and coin detail.
title1: 24/700/1.33/0             # ← title-lg (24px/32px) Screen titles on auth and coin detail.
title2: 18/700/1.33/0             # ← title (18px/24px) Section headers, sheet and popup titles.
title3: 16/700/1.38/0             # ← num-md (16px/22px) Values in token rows and transaction rows.
label1: 15/600/1.47/0             # ← body (15px/22px) Row titles, button labels, inputs.
label2: 12/600/1.33/0             # ← caption (12px/16px) Action labels, badges, dates, nav labels.
body1: 15/600/1.47/0              # ← body (15px/22px) Row titles, button labels, inputs.
body1-read: 15/600/1.47/0         # ← body (15px/22px) Row titles, button labels, inputs.
body2: 13/500/1.38/0              # ← body-sm (13px/18px) Secondary lines in rows, helper text, notice body.
caption1: 12/600/1.33/0           # ← caption (12px/16px) Action labels, badges, dates, nav labels.
```

## Spacing

```yaml
space-4: 4        # ← space-1 Icon-to-text gap inside badges and pills.
space-8: 8        # ← space-2 Gap between rows in a list; label to input.
space-12: 12      # ← space-3 Avatar-to-text gap; chip gaps.
space-16: 16      # ← space-4 Card and row inner padding.
space-20: 20      # ← space-5 Screen side gutter.
space-24: 24      # ← space-6 Between sections of a screen.
space-32: 32      # ← space-8 Above the hero balance; between hero blocks.
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
radius-10: 10       # ← radius-sm 10px · 시안 전용(비-4) — Badges, small chips, QR modules frame.
radius-16: 16       # ← radius-md 16px — Inputs, search field, warning boxes.
radius-22: 22       # ← radius-lg 22px · 시안 전용(비-4) — Token rows, transaction rows, cards.
radius-32: 32       # ← radius-xl 32px — Sheets, popups, the phone screen frame.
radius-full: 9999   # ← radius-pill 999px — Buttons, range chips, change pills, action discs, bottom-nav scan button.
```

## Elevation & Depth

```yaml
shadow-1: "0 24px 64px rgba(40, 20, 70, 0.22)"  # ← shadow-popup · dark 0 24px 64px rgba(0, 0, 0, 0.6)
shadow-pop: "0 -12px 40px rgba(40, 20, 70, 0.14)"  # ← shadow-sheet · dark 0 -12px 40px rgba(0, 0, 0, 0.5)
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | 원본 Button (primary brand · secondary surface-2 · accent 스캔) |
| input | 원본 입력 컴포넌트 (surface-2 바탕, line 테두리) |
| badge | 상태 배지 (up-soft · warn-soft · down-soft) |
| chip | 기간 칩 RangeChips (선택 brand) |
| avatar | 코인 원형 아바타 CoinAvatar |
| icon-button | IconButton (원형 surface-2) |
| icon | Icon (라인 아이콘, currentColor) |

### 원본 컴포넌트 (29종)

| 컴포넌트 | 요약 |
|---|---|
| ActionButton | 56px disc with a label below — the quick-action row under the balance on Home. |
| AddressQR | Deposit card: coin + network, the address as a QR code, copy/share, and the wrong-network warning. |
| AmountField | Large numeric input for withdraw / transfer, with available balance, MAX, fiat estimate and network fee. |
| AuthPanel | Login / signup panel with two methods: 아이디·비밀번호 and Web3 지갑 (sign-in with a wallet signature). |
| Badge | Small status label: network names, notice pins, transaction and inquiry status. |
| BalanceHeader | Hero total-asset figure for Home, centered, in `num-hero`. |
| BottomNav | Five-slot tab bar with the yellow Scan button in the centre: 홈 · 지갑 · [QR 스캔] · 내역 · 설정. |
| Button | Pill-shaped buttons; `primary` (brand fill) is the one committing action per screen — 출금 신청, 로그인, Send. |
| ChangePill | Signed price change in `up` / `down`, as a soft pill or bare text. |
| CoinAvatar | Round coin logo. |
| Icon | Line icon set drawn on a 24px grid, 1.8 stroke, round caps — inherits `currentColor`. |
| IconButton | Round 40px icon-only button for headers and inline copy actions. |
| InquiryItem | A ticket in 1:1 문의 내역: category, title, date and 답변대기 / 답변완료. |
| LanguageList | Radio list for 언어 설정; each option shows its native name and the English name. |
| NoticeItem | A row in the 공지사항 list. |
| NoticePopup | Launch popup for notices/events, with optional image, CTA, paging dots and “오늘 하루 보지 않기”. |
| PriceChart | Smoothed line + soft area price chart with dashed grid and a live end dot, coloured by `chart-line`. |
| QRScanner | Full-screen scanner overlay: dimmed mask, yellow corner frame, scan line, and 앨범 / 플래시 / 내 QR buttons. |
| RangeChips | Round period chips under the price chart: 1H · 1D · 1W · 1M · 1Y. |
| Screen | Phone screen shell: status bar, optional app bar (`title`, back, `action`), padded body and a bottom slot (`nav`). |
| SearchField | Pill search input for the token list and coin search. |
| SegmentedTabs | Pill segmented control for switching views in place: login method, history filter, notice/inquiry tabs. |
| SelectField | Button that looks like a field and opens a bottom sheet — network, coin and category pickers. |
| SettingsRow | Settings / My-page list row: icon disc, label, optional sub line, value or badge, chevron. |
| StatPair | Two figures split by a hairline — 보유 수량 / 평가 금액 on coin detail. |
| TextField | Labelled input with optional leading icon, hint and error; `type="password"` adds a show/hide toggle; `multiline` gives a textarea (1:1 문의 본문). |
| TokenRow | A holding in the token list: coin, name, held amount, fiat value and 24h change. |
| TopBar | Home header: avatar, handle + account name (opens account switcher), QR scan and bell. |
| TxRow | Transaction history row: kind icon, title, date/network or short hash, signed amount, then fiat or a status badge. |

## Known Gaps

- 원본은 다크가 1차 테마다(테마 순서 dark → light). 템플릿 표기는 light/dark 순서를 따른다.
- 바탕 위쪽 보랏빛 글로우(bg-glow)는 방사형 gradient 재료라 별칭에 넣지 않고 원본 색 표에만 둔다.
- 원본 간격 이름은 단계 번호(space-1=4px …)라 템플릿 이름(space-4=4px)으로 값 기준 재매핑했다.
- 라운드 10·22는 4의 배수가 아니라 시안 전용 토큰으로 원래 값을 유지한다(계약 9b). 노란 스캔 버튼 글로우(shadow-accent)는 원본 문서에만 남는다.
- `bg-inverse` ← `ink`: 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
- `fg-disabled` ← `ink-faint`: 합성 — 원본에 비활성 글자색이 없어 ink-faint 재사용
- `border-strong` ← `line`: 합성 — 원본 선 색은 line 하나

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

중앙화(CEX) 커스터디 지갑 앱을 위한 디자인 시스템입니다. 다크 퍼스트, 깊은 보랏빛 바탕에 노란 포인트 하나 — 숫자가 주인공인 모바일 지갑 화면을 만듭니다. 화면 전체 예시는 컴포넌트의 **AppScreens**(로그인 · 홈 · 코인 상세 · 입금 QR · 출금 · 거래내역 · QR 스캔 · 팝업공지 · 공지/1:1 문의 · 언어설정)에 있습니다.

##### 제품 범위

- **계정**: 아이디/비밀번호 가입·로그인, Web3 지갑 서명(SIWE, EIP-4361) 가입·로그인 — `AuthPanel`. 지갑은 신원 증명용이며 자산 보관은 거래소(커스터디)가 합니다.
- **자산**: 총 자산(`BalanceHeader`), 보유 토큰 목록(`TokenRow`), 코인 상세 + 차트(`PriceChart`, `RangeChips`, `StatPair`).
- **입출금**: 입금 주소 QR(`AddressQR`), 출금(`TextField` 주소 + `SelectField` 네트워크 + `AmountField`), QR 스캔(`QRScanner`), 거래내역(`TxRow`).
- **고객 지원**: 팝업 공지(`NoticePopup`), 공지사항(`NoticeItem`), 1:1 문의(`InquiryItem` + 작성 폼).
- **설정**: 언어 설정(`LanguageList`), 설정 목록(`SettingsRow`), 하단 탭(`BottomNav`).

##### 콘텐츠 원칙

- 말투는 **존댓말, 짧은 문장**. 버튼은 동사로 끝냅니다: “출금 신청”, “주소 복사”, “문의 등록”. 마침표 없음.
- 숫자는 항상 **부호를 붙입니다**: `+$2.18`, `−2.78%`(마이너스는 U+2212). 색만으로 방향을 전달하지 않습니다.
- 코인은 `티커 + 이름`(ETH · Ethereum), 네트워크는 항상 표기(TRC-20, ERC-20). 주소는 앞 5자…뒤 3자로 줄이고, 상세에서만 전체를 보여줍니다.
- 날짜는 `2026.11.11 09:41`, 시간대는 공지에서만 `(KST)` 표기.
- 경고 문구는 결과를 말합니다: “다른 자산은 복구되지 않습니다”, “블록체인 전송은 취소할 수 없습니다”.
- 이모지는 쓰지 않습니다.

##### 색

- 바탕은 `bg`, 화면 상단에서 `bg-glow`가 오른쪽 위로부터 퍼지는 방사형 글로우(`Screen`이 처리). 카드와 행은 `surface-1`, 원형 버튼·입력·보조 버튼은 `surface-2`, 눌림과 하단 탭은 `surface-3`.
- 글자는 `ink`, 보조 정보는 `ink-muted`, 플레이스홀더만 `ink-faint`. 금액에는 `ink-faint`를 쓰지 않습니다.
- `brand`(보라)는 화면당 하나의 주 동작(로그인, 출금 신청, 선택된 기간 칩)에만. 그 위의 글자는 `on-brand`. 텍스트 링크는 `brand-ink`.
- `accent`(노랑)는 **화면당 한 번**: 하단 탭 가운데 스캔 버튼, MAX, 스캐너 프레임. 그 위 글자·아이콘은 `on-accent`. 큰 면적이나 텍스트 색으로 쓰지 않습니다(라이트 테마에서 바탕과 대비가 낮음).
- 상승/입금/완료는 `up`(+`up-soft` 바탕), 하락/실패/오류는 `down`(+`down-soft`), 처리중/네트워크 경고는 `warn`(+`warn-soft`). 언제나 부호·화살표·단어와 함께.
- 차트 선과 끝점은 `chart-line`(다크 = 노랑, 라이트 = 보라), 영역은 같은 색 14% → 0%.
- 팝업·시트·스캐너 뒤는 `scrim`.
- 모든 텍스트 쌍은 두 테마 모두 4.5:1 이상입니다. 포커스 링은 `focus` 2px 실선 + 2px 오프셋.

##### 타이포그래피

- 서체는 Manrope(라틴·숫자) + Noto Sans KR(한글), Google Fonts에서 로드합니다(`bundle.css` 첫 줄). 숫자는 `num` 패밀리에 `font-variant-numeric: tabular-nums`(`.ow-num`) — 금액이 세로로 정렬되어야 합니다.
- 총 자산은 `num-hero`(화면당 하나), 코인 보유량·입력 금액은 `num-lg`, 행의 금액은 `num-md`.
- 화면 제목 `title-lg`, 섹션 제목 `title`, 행 제목·버튼 `body`, 보조 줄 `body-sm`, 라벨·뱃지·날짜 `caption`.

##### 간격 · 모서리 · 그림자

- 화면 좌우 여백 `space-5`, 섹션 사이 `space-6`, 카드 안쪽 `space-4`, 목록 행 사이 `space-2`.
- 버튼·칩·변동 필·원형 액션은 `radius-pill`, 행과 카드 `radius-lg`, 입력 `radius-md`, 시트·팝업·화면 프레임 `radius-xl`.
- 그림자는 세 개뿐: 하단 탭/시트 `shadow-sheet`, 팝업 `shadow-popup`, 노란 스캔 버튼 `shadow-accent`. 카드는 그림자 없이 면 색으로 구분합니다.
- 컨트롤 높이: `control-sm` 36 · `control-md` 48 · `control-lg` 56(하단 CTA, 원형 액션, 스캔 버튼).

##### 아이콘

- `Icon` 컴포넌트의 자체 라인 아이콘(24px 그리드, 1.8 스트로크, 둥근 끝, `currentColor`). 목록은 `Icon.names`.
- 코인 로고는 직접 그리지 않습니다. CoinGecko `image` / CoinMarketCap 로고 URL을 `CoinAvatar src`로 넣고, 없으면 티커 원형 배지가 나옵니다.
- 지갑 연결 버튼(MetaMask, WalletConnect, Coinbase Wallet)은 이름 + 범용 아이콘. 공식 로고가 필요하면 각 사의 브랜드 자산을 받아 씁니다.

##### 시세 데이터 (CoinGecko / CoinMarketCap)

- 앱은 거래소 백엔드의 프록시 API만 호출합니다. API 키는 서버에 두고, 서버가 시세를 30–60초 캐시합니다.
- 등록 코인 목록·가격·24h 변동: CoinGecko `GET /coins/markets?vs_currency=usd&ids=…` (`image`, `current_price`, `price_change_percentage_24h`) 또는 CoinMarketCap `GET /v2/cryptocurrency/quotes/latest`.
- 차트: CoinGecko `GET /coins/{id}/market_chart?vs_currency=usd&days=1|7|30|365` → `prices`(`[timestamp, price]`)를 60–120개로 다운샘플해 `PriceChart data`에 그대로 전달.
- 관리자에서 코인별 `coingecko_id` / `cmc_id`를 매핑하고, 화면 하단에 출처(“시세 제공 CoinGecko”)를 표시합니다.

##### 상태와 동작

- 눌림: 버튼 `scale(.98)`, 행은 `surface-2`로. 비활성 버튼은 45% 불투명.
- 출금은 항상 2단계 인증 후 진행, 스캔한 주소는 입력만 채우고 자동 전송하지 않습니다.
- 팝업 공지는 앱 실행당 한 번, “오늘 하루 보지 않기”는 공지 ID별로 자정까지 저장.
- 스캔 라인 애니메이션은 `prefers-reduced-motion`에서 멈춥니다. 그 외 모션은 150ms 색 전환뿐.

##### 쓰는 법

- React 18 + `window.Orbit` 번들. `Orbit.Screen`으로 화면 틀을, 그 안에 컴포넌트를 조립합니다(AppScreens 참고).
- QR 코드는 `qrcode-generator@1.4.4`(`window.qrcode`)를 먼저 로드해야 실제 코드가 그려집니다.

