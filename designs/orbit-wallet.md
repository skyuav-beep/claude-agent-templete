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

### 변형 대응

#### button

| 계약 변형 | 원본 대응 |
|---|---|
| primary | primary (brand 보라 알약 + on-brand, 화면당 하나의 확정 동작 — 출금 신청·로그인) |
| secondary | secondary (surface-2 바탕, primary와 짝을 이루는 대안 — 교환 옆 보내기) |
| tertiary | ghost (투명 바탕 + brand-ink 글자, '전체 보기' 같은 인라인 링크형) |
| ghost | outline (투명 바탕 + 1px line 안쪽 테두리, 취소용) |
| danger | 원본 없음(파괴 행동 전용 버튼 변형 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | :disabled (불투명도 45%, not-allowed — .ow-btn:disabled) |
| (원본 추가) | accent: 노랑 accent + on-accent, 히어로 스캔·MAX 순간에만(화면당 한 번) |
| (원본 추가) | 크기 sm 36 / md 48 / lg 56, block(가로 꽉 참), 하단 CTA는 lg + block |
| (원본 추가) | 원본 ghost는 링크형이라 템플릿 tertiary에, 원본 outline은 배경 없는 버튼이라 템플릿 ghost에 대응 |

#### input

| 계약 변형 | 원본 대응 |
|---|---|
| default | TextField (.ow-field-box: 최소 높이 48px, radius-md, surface-2 바탕, 라벨은 위 13px 600) |
| focus | :focus-within (안쪽 2px brand 테두리) |
| error | .is-error (안쪽 2px down 테두리) + 아래 .ow-field-error down 12px 600, role=alert |
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
| mobile-nav | BottomNav — 5슬롯 하단 탭(홈·지갑·[QR 스캔]·내역·설정), 가운데 노란 스캔 버튼 |
| nav-drawer | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| fab | BottomNav 가운데 fab 항목(.ow-nav-fab) — control-lg 56px accent 원형 + shadow-accent |
| card-row | TokenRow / TxRow / SettingsRow — surface-1 바탕 radius-lg 카드형 행, 8px 간격 .ow-list |

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

- 하단 탭 — 높이 76px, surface-3, 위 모서리 radius-xl, 선택 표시 accent 4px 점(.ow-nav, .ow-nav-item[aria-current]::after)
- 가운데 스캔 FAB — 56px accent 노랑 원형 + shadow-accent, 홈의 유일한 accent(.ow-nav-fab)
- 화면 배경 글로우 — 오른쪽 위에서 퍼지는 radial-gradient(120% 60% at 70% -10%, bg-glow → bg 62%)(.ow-screen)
- 총 자산 숫자 — 44px/48px 800, 자간 -.02em, 가운데 정렬(.ow-balance-amount)
- QR 스캐너 프레임 — 240px 창 radius 28px, accent 4px 코너 44px, 글로우 스캔 라인 2.2s(.ow-scanner-win, .ow-scanner-corner, .ow-scanner-line)
- 부호 붙은 변동 필 — 높이 28px 알약, up/down + soft 바탕, tabular-nums(.ow-change-pill)

### 원본 컴포넌트 (29종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
| ActionButton | 56px disc with a label below — the quick-action row under the balance on Home. | tone default/accent |
| AddressQR | Deposit card: coin + network, the address as a QR code, copy/share, and the wrong-network warning. |  |
| AmountField | Large numeric input for withdraw / transfer, with available balance, MAX, fiat estimate and network fee. |  |
| AuthPanel | Login / signup panel with two methods: 아이디·비밀번호 and Web3 지갑 (sign-in with a wallet signature). | mode login/signup · method id/web3 |
| Badge | Small status label: network names, notice pins, transaction and inquiry status. | tone neutral/brand/up/down/warn |
| BalanceHeader | Hero total-asset figure for Home, centered, in `num-hero`. |  |
| BottomNav | Five-slot tab bar with the yellow Scan button in the centre: 홈 · 지갑 · [QR 스캔] · 내역 · 설정. |  |
| Button | Pill-shaped buttons; `primary` (brand fill) is the one committing action per screen — 출금 신청, 로그인, Send. | variant primary/secondary/accent/outline/ghost · size sm/md/lg |
| ChangePill | Signed price change in `up` / `down`, as a soft pill or bare text. | kind percent/fiat · variant pill/text |
| CoinAvatar | Round coin logo. |  |
| Icon | Line icon set drawn on a 24px grid, 1.8 stroke, round caps — inherits `currentColor`. |  |
| IconButton | Round 40px icon-only button for headers and inline copy actions. |  |
| InquiryItem | A ticket in 1:1 문의 내역: category, title, date and 답변대기 / 답변완료. | status waiting/answered |
| LanguageList | Radio list for 언어 설정; each option shows its native name and the English name. |  |
| NoticeItem | A row in the 공지사항 list. |  |
| NoticePopup | Launch popup for notices/events, with optional image, CTA, paging dots and “오늘 하루 보지 않기”. |  |
| PriceChart | Smoothed line + soft area price chart with dashed grid and a live end dot, coloured by `chart-line`. |  |
| QRScanner | Full-screen scanner overlay: dimmed mask, yellow corner frame, scan line, and 앨범 / 플래시 / 내 QR buttons. |  |
| RangeChips | Round period chips under the price chart: 1H · 1D · 1W · 1M · 1Y. |  |
| Screen | Phone screen shell: status bar, optional app bar (`title`, back, `action`), padded body and a bottom slot (`nav`). |  |
| SearchField | Pill search input for the token list and coin search. |  |
| SegmentedTabs | Pill segmented control for switching views in place: login method, history filter, notice/inquiry tabs. |  |
| SelectField | Button that looks like a field and opens a bottom sheet — network, coin and category pickers. |  |
| SettingsRow | Settings / My-page list row: icon disc, label, optional sub line, value or badge, chevron. |  |
| StatPair | Two figures split by a hairline — 보유 수량 / 평가 금액 on coin detail. |  |
| TextField | Labelled input with optional leading icon, hint and error; `type="password"` adds a show/hide toggle; `multiline` gives a textarea (1:1 문의 본문). |  |
| TokenRow | A holding in the token list: coin, name, held amount, fiat value and 24h change. | changeKind percent/fiat |
| TopBar | Home header: avatar, handle + account name (opens account switcher), QR scan and bell. |  |
| TxRow | Transaction history row: kind icon, title, date/network or short hash, signed amount, then fiat or a status badge. | kind deposit/withdraw/swap/transfer · status done/pending/failed |

### 원본 화면 예시

원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).

- `AppScreens` — 390px 화면 13종 그리드 — 로그인·Web3 가입·홈(총 자산·액션 4개·토큰)·코인 상세 차트·입금 QR·출금·거래내역·QR 스캔·팝업 공지·공지/1:1 문의·문의 작성·설정·언어 선택
- `Cover` — 960×320 표지 — brand 슬랩 위 노란 accent 원판과 동심원 궤도 2개, 태그라인 '중앙화 커스터디 지갑 — 숫자가 주인공인 다크 퍼스트 모바일 UI'

### 원본 컴포넌트 스타일

원본 `components/bundle.css`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). `var(--x)`는 원본 토큰 `x`다.

| 구역 | 선택자 | 핵심 속성 |
|---|---|---|
|  | `html, body` | background bg · color ink · font-family font-sans |
|  | `body` | padding 16px |
|  | `.ow-num, .ow-num *` | font-family font-num |
|  | `button` | font inherit · color inherit |
|  | `:where(button, a, input, textarea, select, [tabindex]):focus-visible` | outline 2px solid focus |
|  | `.ow-row` | gap space-3 |
|  | `.ow-stack` | gap space-2 |
|  | `.ow-sr` | width 1px · height 1px |
| Button | `.ow-btn` | gap space-2 · border 0 · border-radius radius-pill · padding 0 space-6 · height control-md · font-size 15px · font-weight 700 |
| Button | `.ow-btn:active` | transform scale(.98) |
| Button | `.ow-btn:disabled` | opacity .45 · transform none |
| Button | `.ow-btn-sm` | height control-sm · padding 0 space-4 · font-size 13px |
| Button | `.ow-btn-lg` | height control-lg · font-size 16px |
| Button | `.ow-btn-block` | width 100% |
| Button | `.ow-btn-primary` | background brand · color on-brand |
| Button | `.ow-btn-primary:hover:not(:disabled)` | background brand-hover |
| Button | `.ow-btn-secondary` | background surface-2 · color ink |
| Button | `.ow-btn-secondary:hover:not(:disabled)` | background surface-3 |
| Button | `.ow-btn-accent` | background accent · color on-accent |
| Button | `.ow-btn-ghost` | background transparent · color brand-ink · padding 0 space-3 |
| Button | `.ow-btn-outline` | background transparent · color ink · box-shadow inset 0 0 0 1px line |
| Button | `.ow-btn-outline:hover:not(:disabled)` | background surface-2 |
| Icon button (header) | `.ow-iconbtn` | width 40px · height 40px · border-radius radius-pill · border 0 · background surface-2 · color ink |
| Icon button (header) | `.ow-iconbtn:hover` | background surface-3 |
| Icon button (header) | `.ow-iconbtn-dot` | min-width 16px · height 16px · padding 0 4px · border-radius radius-pill · background down · color #fff · font-size 10px · font-weight 800 · box-shadow 0 0 0 2px surface-2 |
| Action button (round disc + label) | `.ow-actions` | gap space-2 |
| Action button (round disc + label) | `.ow-action` | gap space-2 · background none · border 0 · padding 0 · color ink |
| Action button (round disc + label) | `.ow-action-disc` | width control-lg · height control-lg · border-radius radius-pill · background surface-2 |
| Action button (round disc + label) | `.ow-action:hover .ow-action-disc` | background surface-3 |
| Action button (round disc + label) | `.ow-action-accent .ow-action-disc` | background accent · color on-accent |
| Action button (round disc + label) | `.ow-action-label` | font-size 12px · font-weight 600 |
| Badge & change pill | `.ow-badge` | gap space-1 · height 24px · padding 0 space-2 · border-radius radius-sm · font-size 12px · font-weight 700 |
| Badge & change pill | `.ow-badge-neutral` | background surface-2 · color ink-muted |
| Badge & change pill | `.ow-badge-brand` | background brand-soft · color brand-ink |
| Badge & change pill | `.ow-badge-up` | background up-soft · color up |
| Badge & change pill | `.ow-badge-down` | background down-soft · color down |
| Badge & change pill | `.ow-badge-warn` | background warn-soft · color warn |
| Badge & change pill | `.ow-change` | gap 2px · font-weight 700 · font-size 13px · font-family font-num |
| Badge & change pill | `.ow-change-up` | color up |
| Badge & change pill | `.ow-change-down` | color down |
| Badge & change pill | `.ow-change-pill` | height 28px · padding 0 space-3 · border-radius radius-pill |
| Badge & change pill | `.ow-change-pill.ow-change-up` | background up-soft |
| Badge & change pill | `.ow-change-pill.ow-change-down` | background down-soft |
| Coin avatar | `.ow-coin` | border-radius radius-pill · font-weight 800 · color #fff · letter-spacing -.02em |
| Coin avatar | `.ow-coin img` | width 100% · height 100% |
| Coin avatar | `.ow-coin-ring` | box-shadow 0 0 0 4px surface-2 |
| Top bar | `.ow-topbar` | gap space-3 |
| Top bar | `.ow-topbar-who` | min-width 0 · background none · border 0 · padding 0 |
| Top bar | `.ow-topbar-handle` | font-size 13px · color ink-muted · font-weight 500 |
| Top bar | `.ow-topbar-name` | gap space-1 · font-size 16px · font-weight 700 · color ink |
| Top bar | `.ow-avatar` | width 44px · height 44px · border-radius radius-pill · background brand-soft · color brand-ink · font-weight 800 |
| Top bar | `.ow-avatar img` | width 100% · height 100% |
| Balance header | `.ow-balance` | gap space-2 |
| Balance header | `.ow-balance-label` | gap space-2 · font-size 13px · font-weight 600 · color ink-muted · background none · border 0 · padding 0 |
| Balance header | `.ow-balance-amount` | font-size 44px · font-weight 800 · letter-spacing -.02em |
| Balance header | `.ow-balance-change` | gap space-2 |
| Fields | `.ow-field` | gap space-2 |
| Fields | `.ow-field-label` | font-size 13px · font-weight 600 · color ink-muted · gap space-2 |
| Fields | `.ow-field-box` | gap space-3 · min-height control-md · padding 0 space-4 · border-radius radius-md · background surface-2 · box-shadow inset 0 0 0 1px transparent · color ink-muted |
| Fields | `.ow-field-box:focus-within` | box-shadow inset 0 0 0 2px brand |
| Fields | `.ow-field-box.is-error` | box-shadow inset 0 0 0 2px down |
| Fields | `.ow-field-box input, .ow-field-box textarea` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font inherit · font-size 15px · font-weight 600 · padding 0 |
| Fields | `.ow-field-box textarea` | padding space-3 0 · min-height 112px |
| Fields | `.ow-field-box input::placeholder, .ow-field-box textarea::placeholder` | color ink-faint · font-weight 500 |
| Fields | `.ow-field-hint` | font-size 12px · color ink-muted |
| Fields | `.ow-field-error` | font-size 12px · color down · font-weight 600 |
| Fields | `.ow-search` | border-radius radius-pill |
| Fields | `.ow-select` | gap space-3 · width 100% · min-height control-md · padding space-2 space-4 · border-radius radius-md · background surface-2 · border 0 |
| Fields | `.ow-select:hover` | background surface-3 |
| Fields | `.ow-select-value` | font-size 15px · font-weight 700 · color ink |
| Fields | `.ow-select-sub` | font-size 12px · color ink-muted · font-weight 500 |
| Amount field | `.ow-amount` | padding space-4 · border-radius radius-lg · background surface-1 · box-shadow inset 0 0 0 1px line · gap space-2 |
| Amount field | `.ow-amount:focus-within` | box-shadow inset 0 0 0 2px brand |
| Amount field | `.ow-amount-top, .ow-amount-bottom` | gap space-2 · font-size 12px · color ink-muted · font-weight 600 |
| Amount field | `.ow-amount-main` | gap space-3 |
| Amount field | `.ow-amount-main input` | min-width 0 · border 0 · outline 0 · background transparent · color ink · font-family font-num · font-size 28px · font-weight 700 · padding 0 |
| Amount field | `.ow-amount-main input::placeholder` | color ink-faint |
| Amount field | `.ow-amount-sym` | font-weight 700 · font-size 15px · color ink · gap space-2 |
| Amount field | `.ow-max` | height 28px · padding 0 space-3 · border 0 · border-radius radius-pill · background accent · color on-accent · font-size 12px · font-weight 800 |
| Lists & rows | `.ow-list` | gap space-2 |
| Lists & rows | `.ow-section-head` | gap space-3 |
| Lists & rows | `.ow-section-title` | font-size 18px · font-weight 700 |
| Lists & rows | `.ow-tokenrow, .ow-txrow, .ow-noticeitem, .ow-inquiry, .ow-setrow` | gap space-3 · width 100% · padding space-4 · border-radius radius-lg · background surface-1 · border 0 · color ink |
| Lists & rows | `.ow-tokenrow:hover, .ow-txrow:hover, .ow-noticeitem:hover, .ow-inquir…` | background surface-2 |
| Lists & rows | `.ow-rowmain` | min-width 0 · gap 2px |
| Lists & rows | `.ow-rowtitle` | font-size 15px · font-weight 700 · gap space-2 |
| Lists & rows | `.ow-rowsub` | font-size 13px · color ink-muted · font-weight 500 |
| Lists & rows | `.ow-rowend` | gap 2px |
| Lists & rows | `.ow-rowvalue` | font-size 16px · font-weight 700 · font-family font-num |
| Lists & rows | `.ow-txicon` | width 44px · height 44px · border-radius radius-pill |
| Lists & rows | `.ow-txicon-deposit` | background up-soft · color up |
| Lists & rows | `.ow-txicon-withdraw` | background down-soft · color down |
| Lists & rows | `.ow-txicon-swap, .ow-txicon-transfer` | background brand-soft · color brand-ink |
| Lists & rows | `.ow-setrow-icon` | width 40px · height 40px · border-radius radius-pill · background surface-2 · color ink |
| Lists & rows | `.ow-setrow-value` | font-size 13px · color ink-muted · font-weight 600 |
| Lists & rows | `.ow-chev` | color ink-faint |
| Lists & rows | `.ow-new-dot` | width 6px · height 6px · border-radius radius-pill · background brand-ink |
| Segmented / range | `.ow-seg` | padding 4px · gap 4px · border-radius radius-pill · background surface-2 |
| Segmented / range | `.ow-seg-item` | height 36px · border 0 · border-radius radius-pill · background transparent · color ink-muted · font-size 14px · font-weight 700 |
| Segmented / range | `.ow-seg-item[aria-selected="true"]` | background surface-1 · color ink · box-shadow 0 2px 8px rgba(0,0,0,.18) |
| Segmented / range | `.ow-chips` | gap space-3 |
| Segmented / range | `.ow-chip` | min-width 44px · height 44px · padding 0 space-3 · border-radius radius-pill · border 0 · background surface-2 · color ink-muted · font-size 14px · font-weight 700 |
| Segmented / range | `.ow-chip[aria-selected="true"]` | background brand · color on-brand |
| Chart | `.ow-chart` | width 100% |
| Chart | `.ow-chart-halo` | opacity .25 |
| Stat pair | `.ow-stats` | padding space-4 0 · border-top 1px solid line · border-bottom 1px solid line |
| Stat pair | `.ow-stats-sep` | width 1px · height 48px · background line |
| Stat pair | `.ow-stat` | gap space-2 |
| Stat pair | `.ow-stat-label` | font-size 13px · color ink-muted · font-weight 600 |
| Stat pair | `.ow-stat-value` | gap space-2 · font-size 22px · font-weight 700 · font-family font-num |
| QR | `.ow-qr` | gap space-4 · padding space-6 space-5 · border-radius radius-xl · background surface-1 |
| QR | `.ow-qr-code` | padding 14px · border-radius radius-lg · background #ffffff |
| QR | `.ow-qr-badge` | transform translate(-50%, -50%) · box-shadow 0 0 0 5px #ffffff |
| QR | `.ow-qr-net` | gap space-2 |
| QR | `.ow-qr-addr` | width 100% · gap space-3 · padding space-3 space-4 · border-radius radius-md · background surface-2 |
| QR | `.ow-qr-addr code` | min-width 0 · font-family font-num · font-size 13px · font-weight 600 · color ink |
| QR | `.ow-qr-actions` | gap space-2 · width 100% |
| QR | `.ow-warnbox` | gap space-3 · padding space-3 space-4 · border-radius radius-md · background warn-soft · color warn · font-size 13px · font-weight 600 · width 100% |
| Scanner | `.ow-scanner` | width 100% · height 100% · min-height 420px · background #000 · border-radius inherit · color #ffffff |
| Scanner | `.ow-scanner-media > *` | width 100% · height 100% |
| Scanner | `.ow-scanner-win` | width 240px · height 240px · border-radius 28px · box-shadow 0 0 0 2000px scrim |
| Scanner | `.ow-scanner-corner` | width 44px · height 44px · border 4px solid accent |
| Scanner | `.ow-scanner-corner.tl` | border-bottom 0 |
| Scanner | `.ow-scanner-corner.tr` | border-bottom 0 |
| Scanner | `.ow-scanner-corner.bl` | border-top 0 |
| Scanner | `.ow-scanner-corner.br` | border-top 0 |
| Scanner | `.ow-scanner-line` | height 2px · border-radius 2px · background accent · box-shadow 0 0 12px accent |
| Scanner | `.ow-scanner-top, .ow-scanner-bottom` | padding space-5 · gap space-3 |
| Scanner | `.ow-scanner-top` | font-weight 700 · font-size 16px |
| Scanner | `.ow-scanner-hint` | font-size 14px · font-weight 600 · padding 0 space-6 · color #ffffff |
| Scanner | `.ow-scanner-bottom` | gap space-8 |
| Scanner | `.ow-scanner-btn` | gap space-2 · background none · border 0 · color #ffffff · font-size 12px · font-weight 600 |
| Scanner | `.ow-scanner-btn span` | width 52px · height 52px · border-radius radius-pill · background rgba(255,255,255,.16) |
| Scanner | `.ow-scanner-btn[aria-pressed="true"] span` | background accent · color on-accent |
| Notice popup | `.ow-layer` | padding space-5 · background scrim |
| Notice popup | `.ow-layer.is-contained` | border-radius inherit |
| Notice popup | `.ow-popup` | width 100% · max-width 340px · border-radius radius-xl · background surface-1 · box-shadow shadow-popup |
| Notice popup | `.ow-popup-media` | background brand-soft |
| Notice popup | `.ow-popup-media img` | width 100% · height 100% |
| Notice popup | `.ow-popup-body` | padding space-5 · gap space-2 |
| Notice popup | `.ow-popup-title` | font-size 18px · font-weight 800 |
| Notice popup | `.ow-popup-text` | font-size 14px · color ink-muted · font-weight 500 |
| Notice popup | `.ow-popup-foot` | border-top 1px solid line |
| Notice popup | `.ow-popup-foot button` | height 52px · border 0 · background none · font-size 14px · font-weight 700 · color ink-muted |
| Notice popup | `.ow-popup-foot button + button` | color ink |
| Notice popup | `.ow-dots` | gap 6px |
| Notice popup | `.ow-dots i` | width 6px · height 6px · border-radius radius-pill · background line |
| Notice popup | `.ow-dots i.on` | width 18px · background brand |
| Language list | `.ow-lang` | gap space-1 |
| Language list | `.ow-lang-item` | gap space-3 · padding space-3 space-4 · border-radius radius-md · background none · border 0 · color ink · width 100% |
| Language list | `.ow-lang-item:hover` | background surface-2 |
| Language list | `.ow-lang-item[aria-checked="true"]` | background brand-soft |
| Language list | `.ow-lang-code` | width 36px · height 36px · border-radius radius-pill · background surface-2 · font-size 12px · font-weight 800 · color ink-muted |
| Language list | `.ow-lang-item[aria-checked="true"] .ow-lang-code` | background brand · color on-brand |
| Language list | `.ow-lang-check` | color brand-ink |
| Auth | `.ow-auth` | gap space-4 |
| Auth | `.ow-auth-title` | font-size 24px · font-weight 800 |
| Auth | `.ow-auth-sub` | font-size 14px · color ink-muted · font-weight 500 |
| Auth | `.ow-divider` | gap space-3 · color ink-faint · font-size 12px · font-weight 600 |
| Auth | `.ow-divider::before, .ow-divider::after` | height 1px · background line |
| Auth | `.ow-connector` | gap space-3 · width 100% · min-height control-lg · padding 0 space-4 · border-radius radius-md · background surface-1 · border 0 · box-shadow inset 0 0 0 1px line · color ink |
| Auth | `.ow-connector:hover` | background surface-2 |
| Auth | `.ow-connector-glyph` | width 36px · height 36px · border-radius 12px · background surface-2 · color brand-ink |
| Auth | `.ow-connector-name` | font-size 15px · font-weight 700 |
| Auth | `.ow-auth-links` | gap space-4 · font-size 13px |
| Auth | `.ow-auth-links a` | color ink-muted · font-weight 600 |
| Auth | `.ow-auth-links a:hover` | color ink |
| Bottom nav | `.ow-nav` | height 76px · padding 0 space-3 · background surface-3 · border-radius radius-xl radius-xl 0 0 · box-shadow shadow-sheet |
| Bottom nav | `.ow-nav-item` | gap 4px · background none · border 0 · color ink-muted · width 56px · padding space-2 0 · font-size 11px · font-weight 600 |
| Bottom nav | `.ow-nav-item[aria-current="page"]` | color ink |
| Bottom nav | `.ow-nav-item[aria-current="page"]::after` | width 4px · height 4px · border-radius radius-pill · background accent |
| Bottom nav | `.ow-nav-fab` | width control-lg · height control-lg · border-radius radius-pill · border 0 · background accent · color on-accent · box-shadow shadow-accent |
| Screen shell | `.ow-screen` | width 390px · height 820px · border-radius 44px · background radial-gradient(120% 60% at 70% -10%, bg-glow 0%, bg 62%) · color ink · box-shadow 0 0 0 8px surface-3, 0 30px 80px rgba(0,0,0,.35) |
| Screen shell | `.ow-status` | padding 16px 28px 6px · font-size 14px · font-weight 700 · font-family font-num |
| Screen shell | `.ow-screen-body` | min-height 0 · padding space-3 space-5 space-5 · gap space-5 |
| Screen shell | `.ow-appbar` | gap space-3 · min-height 44px |
| Screen shell | `.ow-appbar-title` | font-size 17px · font-weight 800 |
| Screen shell | `.ow-appbar-spacer` | width 40px |

## Do's and Don'ts

**Do**

- brand 보라는 화면당 하나의 주 동작에만
- accent 노랑은 화면당 한 번(스캔 버튼·MAX·스캐너 프레임)
- 숫자는 항상 부호를 붙이고 마이너스는 U+2212
- 네트워크(TRC-20, ERC-20)는 항상 표기, 주소는 앞 5자…뒤 3자
- 상태 배지는 항상 아이콘 + 단어
- 출금은 항상 2단계 인증 후, 스캔한 주소는 입력만 채움
- 버튼은 동사로 끝내고 마침표 없음
- 카드는 그림자 없이 면 색으로 구분

**Don't**

- accent를 큰 면적이나 텍스트 색으로 쓰지 않기
- 금액에 ink-faint 쓰지 않기
- primary 버튼 두 개를 나란히 두지 않기
- 색만으로 방향·상태 전달하지 않기
- 이모지 쓰지 않기
- 지갑 브랜드 로고·코인 로고를 직접 그리지 않기
- 스캔한 주소로 자동 전송하지 않기
- 필드 오류를 토스트로 중복 표시하지 않기

## Responsive Behavior

- 목업 프레임 390×820, radius 44px — 실제로는 레이아웃 라우트가 셸 역할(Screen README)
- 화면 좌우 여백 space-5, 섹션 사이 space-6
- 컨트롤 높이 36/48/56, 하단 CTA·원형 액션·스캔 버튼은 56px
- prefers-reduced-motion에서 스캔 라인 정지, 그 외 모션은 150ms 색 전환뿐

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

