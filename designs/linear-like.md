---
name: Linear-like
slug: linear-like
category: productivity
last_updated: "2026-05-15"
sources:
  - "(self-contained — productivity/issue tracker UI 일반 관례 합성)"
related_services: []
lang: en
logo: /logos/linear-like.png
policy:
  shadow_on_cards: false
  gradient_locations: ["accent", "hero"]
  copy_tone: "en-sentence"
  dark_mode: "supported"
  non_4_spacing: false
---

# Linear-like — design.md

> 다크 캔버스 우선 productivity 도구의 시각 톤을 합성한 시안. 이슈 트래커·문서 도구·키보드 시그너처 표면에서 통용되는 **dark-first + 그라디언트 accent 적극 + 컴팩트 밀도 + 키보드 단축키 시그너처** 조합. SSOT 없이 self-contained 합성 catalog. 본 시안은 `designs/_alias-contract.md` 계약을 준수하며 dark가 1차, light가 2차다.

## Brand & Style

본 시안의 시각 시그너처는 **다크 캔버스 위에 적극적인 gradient accent**다. 다른 시안과 가장 큰 차이:
- **dark 1차** — 디폴트 dark, light는 옵션 (`policy.dark_mode: "supported"` 이지만 dark 표면 1차 설계).
- **gradient를 accent와 hero에 적극 사용** (`policy.gradient_locations: ["accent", "hero"]`) — Wanted의 4곳 한정 / toss-like의 hero 1곳 / minimal-mono의 전면 금지와 직교.
- **카드 그림자 금지** (`policy.shadow_on_cards: false`) — 1px 헤어라인 + 다크 캔버스의 깊이로 위계 표현.
- **컴팩트 밀도** — 데이터 행 44 우선(comfortable 56 옵션). 키보드 단축키 우선 워크플로.

위계는 (1) 타이트한 라운드(`radius-4`~`radius-8` 디폴트), (2) 1px 헤어라인 보더의 명확한 분리, (3) gradient accent의 시각 강조로 만들어진다.

대상은 **technical user 1차** — 개발자·디자이너·PM의 issue tracker, documentation, internal tool surface. 마케팅 표면은 hero gradient 외에는 본 시안 1차 대상이 아니다.

Voice는 영문 **sentence case** 표준 (`Create issue`, `Assign`, `Mark as done`). Title Case In Buttons (`Create New Issue`) 사용 금지.

## Colors

### Brand (gradient seed pair)

```yaml
brand-start: oklch(0.620 0.180 268)    # 보라
brand-end:   oklch(0.700 0.170 200)    # 청록
```

본 시안의 brand는 **gradient pair**다 — accent에 적극 사용. solid brand color는 두 stop의 중간(`oklch(0.660 0.175 234)` 부근)을 사용하거나 brand-start만 호출.

### Brand gradient (accent + hero)

```yaml
accent-gradient: linear-gradient(135deg, oklch(0.620 0.180 268) 0%, oklch(0.700 0.170 200) 100%)
hero-gradient:   linear-gradient(135deg, oklch(0.500 0.180 268) 0%, oklch(0.620 0.180 245) 50%, oklch(0.700 0.170 200) 100%)
```

`accent`는 (1) primary CTA hover state, (2) 강조 텍스트(타이틀 일부 grad 처리), (3) selection 표시 등에 사용. `hero`는 마케팅 landing 1곳.

### Semantic alias — Light (보조)

```yaml
# Background
bg-canvas:         oklch(0.985 0.005 270)
bg-surface:        oklch(1 0 0)
bg-subtle:         oklch(0.972 0.008 270)
bg-muted:          oklch(0.952 0.012 270)
bg-elevated:       oklch(1 0 0)
bg-inverse:        oklch(0.160 0.020 270)
bg-brand:          oklch(0.620 0.180 268)
bg-brand-subtle:   oklch(0.952 0.025 268)
bg-danger-subtle:  oklch(0.952 0.022 22)
bg-success-subtle: oklch(0.952 0.045 152)
bg-warning-subtle: oklch(0.958 0.032 81)

# Foreground
fg-strong:    oklch(0.160 0.020 270)
fg-default:   oklch(0.200 0.018 270 / 0.90)
fg-secondary: oklch(0.280 0.015 270 / 0.60)
fg-tertiary:  oklch(0.280 0.015 270 / 0.42)
fg-disabled:  oklch(0.280 0.015 270 / 0.28)
fg-on-brand:  oklch(1 0 0)
fg-brand:     oklch(0.500 0.180 268)
fg-success:   oklch(0.520 0.180 144)
fg-warning:   oklch(0.580 0.140 56)
fg-danger:    oklch(0.540 0.200 27)

# Border
border-subtle:  oklch(0.520 0.020 270 / 0.10)
border-default: oklch(0.520 0.020 270 / 0.22)
border-strong:  oklch(0.520 0.020 270 / 0.34)
border-brand:   oklch(0.620 0.180 268)
```

### Semantic alias — Dark (1차)

```yaml
# Background (다크 캔버스 시그너처 — 매우 진한 violet-tinted neutral)
bg-canvas:        oklch(0.140 0.018 270)
bg-surface:       oklch(0.170 0.020 270)
bg-subtle:        oklch(0.120 0.015 270)
bg-muted:         oklch(0.205 0.022 270)
bg-elevated:      oklch(0.240 0.025 270)
bg-inverse:       oklch(1 0 0)
bg-brand:         oklch(0.620 0.180 268)
bg-brand-subtle:  oklch(0.220 0.080 268)
bg-danger-subtle: oklch(0.298 0.10 22 / 0.34)
bg-success-subtle:oklch(0.298 0.10 144 / 0.30)
bg-warning-subtle:oklch(0.298 0.10 56 / 0.34)

# Foreground
fg-strong:    oklch(0.985 0.005 270)
fg-default:   oklch(0.985 0.005 270 / 0.90)
fg-secondary: oklch(0.985 0.005 270 / 0.60)
fg-tertiary:  oklch(0.985 0.005 270 / 0.42)
fg-disabled:  oklch(0.985 0.005 270 / 0.28)
fg-on-brand:  oklch(1 0 0)
fg-brand:     oklch(0.740 0.155 268)
fg-success:   oklch(0.740 0.165 144)
fg-warning:   oklch(0.770 0.150 64)
fg-danger:    oklch(0.720 0.215 27)

# Border (다크 캔버스의 핵심 — 헤어라인이 모든 위계를 짊어진다)
border-subtle:  oklch(0.985 0.005 270 / 0.08)
border-default: oklch(0.985 0.005 270 / 0.18)
border-strong:  oklch(0.985 0.005 270 / 0.30)
border-brand:   oklch(0.740 0.155 268)
```

## Typography

### 서체 선택

primary face는 **Inter Variable**. 영문 1차 시안이므로 라틴 메트릭이 가장 우수한 face. monospace는 **JetBrains Mono** 또는 **SF Mono**(코드 inline, 단축키 표기용). 한국어 surface면 Pretendard JP fallback.

### Type ramp

```yaml
display1:  44/700/1.1/-0.030em
display2:  36/700/1.15/-0.025em
display3:  28/700/1.2/-0.020em
title1:    22/600/1.25/-0.015em
title2:    18/600/1.3/-0.012em
title3:    15/600/1.35/-0.008em
label1:    13/500/1.4/-0.005em       # 컴팩트 (Wanted 14 / toss-like 14 vs)
label2:    12/500/1.4/-0.005em
body1:     14/400/1.5/-0.005em       # 본문도 한 단계 작게 (컴팩트 밀도)
body1-read:14/400/1.65/-0.005em
body2:     13/400/1.45/-0.005em
caption1:  11/600/1.4/0
mono:      13/400/1.5/0 (font-family: monospace)  # 코드 inline + 단축키
```

본 시안의 본문 size는 한 단계 작음(`body1: 14px`) — productivity 표면의 정보 밀도 우선 정책. `mono` variant는 본 시안 시그너처 — 단축키 표기(`⌘K`, `⌘⇧P`)와 코드 inline에 사용.

## Spacing

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

본 시안은 **카드 padding `space-16` 표준** (Wanted/toss-like의 `space-24`보다 작게 — 컴팩트 밀도).

## Rounded

```yaml
radius-2:    2
radius-4:    4    # 입력/버튼 sm 디폴트
radius-6:    6    # input·button md 디폴트 (본 시안 시그너처)
radius-8:    8    # 카드 디폴트
radius-12:   12   # 모달, 큰 카드
radius-full: 9999 # avatar, icon-button
```

본 시안의 라운드는 **타이트하게** — 카드 `radius-8`, 입력 `radius-6`. toss-like(`radius-16` 카드)와 직교.

`radius-6`은 alias 계약 외 추가 항목 — 본 시안 시그너처.

## Elevation & Depth

본 시안은 평면 + 헤어라인 보더 1차. 카드 그림자 금지(`policy.shadow_on_cards: false`).

```yaml
shadow-1:   0 1px 2px oklch(0 0 0 / 0.16)        # dropdown (다크 캔버스에서 진하게)
shadow-2:   0 4px 12px oklch(0 0 0 / 0.24)
shadow-pop: 0 12px 32px oklch(0 0 0 / 0.40)
```

다크 캔버스에서 그림자는 light보다 진하게(elevated surface가 위에 떠 보이도록).

## Shapes

기하학은 **타이트한 라운드 + 평면 다크 표면 + 헤어라인 + accent gradient**. chip·avatar·icon-button만 `radius-full`. 카드는 `radius-8`, 입력은 `radius-6` 시그너처.

배경은 평면. gradient는 accent(CTA hover, 강조 텍스트, selection)와 hero에만 사용.

포커스 링은 다크 캔버스에서 강해야 — 2px `border-brand` + 2px transparent offset + brand color 0.16 alpha glow.

## Components

### button

```yaml
height:
  sm: 28      # 본 시안은 한 단계 작게
  md: 32      # 디폴트 (다른 시안 40 vs)
  lg: 40      # 본 시안의 lg가 다른 시안의 md
  xl: 48
radius:
  sm/md: radius-6     # 시그너처
  lg:    radius-8
  xl:    radius-8
padding-x: space-12 (md) / space-16 (lg+)
label: 13/500 (md) / 14/500 (lg)
```

본 시안의 button height는 **컴팩트** — productivity 표면 시그너처. Wanted lg 48 → linear-like md 32 (한 등급 작음).

### button-primary

`bg-brand` solid 채움 + `fg-on-brand`. Hover 시 accent gradient 전환(시그너처) — `background: linear-gradient(135deg, brand-start, brand-end)`.

### button-secondary

투명 + 1px `border-default` + `fg-default`. Hover `bg-muted`.

### button-tertiary

`bg-muted` + `fg-default`. 보더 없음.

### button-ghost

투명 + `fg-secondary`. Hover `bg-muted` + `fg-strong`.

### button-danger

`fg-danger` 채움 + 흰 텍스트.

### button-disabled

`bg-muted` + `fg-disabled`.

### input / form field

```yaml
height: 32        # 컴팩트
border: 1px border-default
radius: radius-6  # 시그너처
bg:     bg-surface
padding: 0 space-12
font:   13/400
focus:  2px border-brand + 0 0 0 3px brand-alpha-glow
```

### badge

```yaml
height: 20        # 컴팩트
padding: 0 space-8
radius: radius-4  # 본 시안은 badge도 약한 라운드 (toss-like radius-full vs)
font: 11/600
```

다른 시안의 badge가 `radius-full`인데 본 시안은 `radius-4`. productivity 시그너처(이슈 상태 라벨 같은 직사각 badge).

### chip

```yaml
height: 24
padding: 0 space-8
radius: radius-4
bg: bg-muted
font: 12/500
interactive: hover bg-elevated
```

### avatar

`radius-full` 24px (다른 시안 32px vs) — 컴팩트. ring fallback 또는 이니셜.

### icon-button

28×28, `radius-6`. `radius-full` 아님 — 본 시안 시그너처(다른 시안 대부분 radius-full).

### icon

16×16 디폴트 (다른 시안 20-24 디폴트 vs) — 컴팩트 밀도. 1.5px stroke (얇게). monochrome `currentColor`.

### kbd (키보드 단축키, 본 시안 전용)

```yaml
height: 20
padding: 0 6
radius: radius-4
bg: bg-elevated
border: 1px border-subtle
font: mono 11/500
text: ⌘K, ⇧⌘P, Esc
```

본 시안의 시그너처 컴포넌트. command palette 안내, tooltip, help overlay에 사용.

### sidebar-nav / top-bar / stat-card / data-table / login-layout

`DESIGN.md Admin / Dashboard surface 컴포넌트` 명세. 본 시안에서:
- `sidebar-nav` width 220 (다른 시안 240보다 좁음) + 컴팩트 nav-item height 32.
- `top-bar` height 44 (다른 시안 56 vs) — 컴팩트. 우측 search는 `⌘K` kbd hint.
- `data-table` row height 44 (compact density) 디폴트. comfortable 56은 옵션.
- `login-layout`은 다크 캔버스 + accent gradient brand mark.

## Do's and Don'ts

**Do**

- dark 표면을 1차로 설계. light는 옵션 또는 user preference 따름.
- gradient를 accent(CTA hover, 강조 텍스트, selection)와 hero에 적극 사용. 본 시안의 시그너처.
- 카드 그림자 금지 — 헤어라인 보더가 다크 캔버스에서 위계를 짊어진다.
- 컴팩트 밀도 우선. button md 32, input 32, badge 20, avatar 24.
- 카피는 영문 sentence case (`Create issue`, `Mark as done`).
- 키보드 단축키를 모든 주요 액션에 부여 — `kbd` 컴포넌트로 hint 표시.
- monospace를 단축키·코드 inline·issue ID에 사용.

**Don't**

- 카드에 그림자를 적용하지 않는다 (`policy.shadow_on_cards: false`).
- 큰 라운드(`radius-12`+)를 카드/버튼에 사용하지 않는다 — 본 시안은 타이트 시그너처.
- light 표면을 1차 mockup으로 사용하지 않는다 — dark 1차.
- gradient를 accent / hero 외 위치에 사용하지 않는다 (sidebar/top-bar/카드 그라디언트 금지).
- 격식 영문(`Please click here`, ALL-CAPS, Title Case In Buttons) 사용 금지.
- avatar/icon-button을 다른 시안의 `radius-full`로 통일하지 않는다 — 본 시안은 `radius-6`/`radius-full` 혼용 시그너처(avatar는 full, icon-button은 6).
- 너무 작은 hit area (28×28 미만) 사용 금지 — sm size는 적어도 28×28 보장.

## Responsive Behavior

본 시안은 **데스크톱 우선** — productivity 도구는 큰 화면 + 키보드 우선. 모바일 표면이 있으면 별도 mode("mobile-compact")로 분기.

### Breakpoints

| Name | Width | Columns | Gutter |
|---|---|---|---|
| Mobile | ≤ 640 | 4 | 16 |
| Tablet | 641–1023 | 8 | 20 |
| Desktop | 1024–1599 | 12 | 24 |
| Wide | ≥ 1600 | 12 | 24 |

### Touch Targets

데스크톱 우선이라 마우스 hit area 28×28 허용. 모바일 모드에서는 44×44 강제.

## Known Gaps

- **자체 출처 없음** — productivity/issue tracker UI 일반 관례 합성. 특정 회사 디자인 시스템 사양 아님.
- **시안 전용 추가 토큰** — `radius-6`(input·button md), `mono` typography variant, `kbd` 컴포넌트는 alias 계약 외. 다른 시안에서 호출 시 fallback 필요.
- **gradient runtime** — accent gradient는 CSS `linear-gradient`로 surface하지만 CSS 변수 단일 값으로는 표기 불가(gradient는 image 타입). preview HTML은 brand solid로 fallback하고 prose 명시만.
- **다크 우선의 결과** — light 토큰은 정확하지만 본 시안의 1차 사용 표면은 아니다. light에서 mockup 검수 시 dark에서 재검수 필요.

## References

본 시안은 self-contained 합성 catalog. productivity/issue tracker 표면의 시각 패턴(다크 우선, 그라디언트 accent, 컴팩트 밀도, 키보드 시그너처) 일반 관례를 종합.

## CSS Variables

```css
:root[data-design="linear-like"][data-theme="light"] {
  --bg-canvas:        oklch(0.985 0.005 270);
  --bg-surface:       oklch(1 0 0);
  --bg-subtle:        oklch(0.972 0.008 270);
  --bg-muted:         oklch(0.952 0.012 270);
  --bg-elevated:      oklch(1 0 0);
  --bg-inverse:       oklch(0.160 0.020 270);
  --bg-brand:         oklch(0.620 0.180 268);
  --bg-brand-subtle:  oklch(0.952 0.025 268);
  --bg-danger-subtle: oklch(0.952 0.022 22);
  --bg-success-subtle:oklch(0.952 0.045 152);
  --bg-warning-subtle:oklch(0.958 0.032 81);

  --fg-strong:    oklch(0.160 0.020 270);
  --fg-default:   oklch(0.200 0.018 270 / 0.90);
  --fg-secondary: oklch(0.280 0.015 270 / 0.60);
  --fg-tertiary:  oklch(0.280 0.015 270 / 0.42);
  --fg-disabled:  oklch(0.280 0.015 270 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.500 0.180 268);
  --fg-success:   oklch(0.520 0.180 144);
  --fg-warning:   oklch(0.580 0.140 56);
  --fg-danger:    oklch(0.540 0.200 27);

  --border-subtle:  oklch(0.520 0.020 270 / 0.10);
  --border-default: oklch(0.520 0.020 270 / 0.22);
  --border-strong:  oklch(0.520 0.020 270 / 0.34);
  --border-brand:   oklch(0.620 0.180 268);

  /* Spacing (theme-invariant) */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded (표준 + catalog-only radius-6) */
  --radius-2: 2px;   --radius-4: 4px;
  --radius-6: 6px;                                                /* catalog-only: input/button md 시그너처 */
  --radius-8: 8px;   --radius-12: 12px; --radius-16: 16px;
  --radius-full: 9999px;

  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.06);
  --shadow-2:   0 4px 12px oklch(0 0 0 / 0.08);
  --shadow-pop: 0 12px 32px oklch(0 0 0 / 0.14);

  /* mono typography variant (catalog-only) */
  --font-mono: ui-monospace, "JetBrains Mono", "SF Mono", monospace;
  --font-size-mono: 13px;
}

:root[data-design="linear-like"][data-theme="dark"] {
  --bg-canvas:        oklch(0.140 0.018 270);
  --bg-surface:       oklch(0.170 0.020 270);
  --bg-subtle:        oklch(0.120 0.015 270);
  --bg-muted:         oklch(0.205 0.022 270);
  --bg-elevated:      oklch(0.240 0.025 270);
  --bg-inverse:       oklch(1 0 0);
  --bg-brand:         oklch(0.620 0.180 268);
  --bg-brand-subtle:  oklch(0.220 0.080 268);
  --bg-danger-subtle: oklch(0.298 0.10 22 / 0.34);
  --bg-success-subtle:oklch(0.298 0.10 144 / 0.30);
  --bg-warning-subtle:oklch(0.298 0.10 56 / 0.34);

  --fg-strong:    oklch(0.985 0.005 270);
  --fg-default:   oklch(0.985 0.005 270 / 0.90);
  --fg-secondary: oklch(0.985 0.005 270 / 0.60);
  --fg-tertiary:  oklch(0.985 0.005 270 / 0.42);
  --fg-disabled:  oklch(0.985 0.005 270 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.740 0.155 268);                       /* synthesized — dark 1차 시안 */
  --fg-success:   oklch(0.740 0.165 144);                       /* synthesized */
  --fg-warning:   oklch(0.770 0.150 64);                        /* synthesized */
  --fg-danger:    oklch(0.720 0.215 27);                        /* synthesized */

  --border-subtle:  oklch(0.985 0.005 270 / 0.08);
  --border-default: oklch(0.985 0.005 270 / 0.18);
  --border-strong:  oklch(0.985 0.005 270 / 0.30);
  --border-brand:   oklch(0.740 0.155 268);

  /* spacing/radius/font-mono는 light와 동일 — 상속 */

  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.16);
  --shadow-2:   0 4px 12px oklch(0 0 0 / 0.24);
  --shadow-pop: 0 12px 32px oklch(0 0 0 / 0.40);
}
```
