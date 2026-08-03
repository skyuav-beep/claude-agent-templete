---
name: Material 3
slug: material-3
category: enterprise
last_updated: "2026-05-16"
sources:
  - https://m3.material.io
  - https://m3.material.io/styles/color/system/overview
  - https://m3.material.io/foundations/elevation/overview
  - https://m3.material.io/styles/typography/type-scale-tokens
related_services: []
lang: en
logo: /logos/material-3.png
policy:
  shadow_on_cards: true
  gradient_locations: []
  copy_tone: "en-sentence"
  dark_mode: "supported"
  non_4_spacing: false
---

# Material 3 — design.md

> Google Material Design 3 (Material You) 공개 사양의 alias 매핑. tonal palette + dynamic color seed + elevation 5단 + ripple 모션이 시그너처다. 본 카탈로그는 M3 공식 사양(m3.material.io)을 1차 출처로 합성하되 본 라이브러리의 `_alias-contract.md` alias 네이밍으로 정규화했다. dynamic color seed 기능은 prose로만 명시(런타임 색 변환은 host 앱이 구현).

## Brand & Style

Material 3의 시그너처는 **tonal palette + dynamic color**다. brand seed 1개(예: oklch(0.620 0.165 268))에서 tonal value 0-100 13단을 생성하고, 이 tonal에서 light/dark 시맨틱 alias가 파생된다. 본 alias 매핑은 M3 default theme(brand seed = `#6750A4` ≈ oklch(0.460 0.155 295))의 변환값을 사용한다.

표면은 **elevation 5단(0/1/2/3/4/5)** 으로 z-depth를 적극 표현한다. 카드 그림자를 표준 허용(`policy.shadow_on_cards: true`)하며, elevated card / filled card / outlined card 3종 variant를 둔다.

모션은 **ripple**(터치/클릭 위치에서 퍼지는 원형 ink)이 시그너처지만 본 catalog는 정적 spec이므로 ripple은 prose로만 명시한다. M3의 motion duration·easing 토큰(`emphasized`/`standard`)도 spec으로 ship.

Voice는 영문 **sentence case** 표준 (`Save`, `Cancel`, `Get started`). Title Case In Buttons (`Save All Items`)와 ALL-CAPS는 회피. 한국어 surface면 친근한 존댓말도 허용하되 본 시안의 1차 lang은 영문.

대상은 글로벌 **enterprise / consumer cross-platform** — Android·Web·iOS 동시 운영 표면.

## Colors

### Brand (tonal seed)

```yaml
seed: oklch(0.460 0.155 295)              # M3 default primary seed (#6750A4 approx)
```

본 시안에서는 seed에서 파생된 tonal palette 13단(0/10/20/30/40/50/60/70/80/90/95/99/100)을 시맨틱 alias로 매핑한다. host 앱이 dynamic color를 구현하면 seed만 교체하면 모든 alias가 일괄 갱신된다.

### Semantic alias — Light

```yaml
# Background (M3 surface tonal value 99/100/95/87 등)
bg-canvas:         oklch(0.992 0.005 295)     # surface
bg-surface:        oklch(0.992 0.005 295)
bg-subtle:         oklch(0.965 0.012 295)     # surface-container-low
bg-muted:          oklch(0.945 0.018 295)     # surface-container
bg-elevated:       oklch(0.925 0.025 295)     # surface-container-high
bg-inverse:        oklch(0.250 0.018 295)     # inverse-surface
bg-brand:          oklch(0.460 0.155 295)     # primary (tonal 40)
bg-brand-subtle:   oklch(0.920 0.045 295)     # primary-container (tonal 90)
bg-danger-subtle:  oklch(0.935 0.040 22)      # error-container
bg-success-subtle: oklch(0.935 0.060 152)
bg-warning-subtle: oklch(0.940 0.060 81)

# Foreground
fg-strong:    oklch(0.180 0.015 295)          # on-surface
fg-default:   oklch(0.220 0.012 295 / 0.95)
fg-secondary: oklch(0.300 0.010 295 / 0.70)   # on-surface-variant
fg-tertiary:  oklch(0.300 0.010 295 / 0.48)
fg-disabled:  oklch(0.300 0.010 295 / 0.32)   # M3 disabled 38% alpha
fg-on-brand:  oklch(0.998 0 0)                # on-primary
fg-brand:     oklch(0.460 0.155 295)
fg-success:   oklch(0.500 0.175 144)
fg-warning:   oklch(0.560 0.140 56)
fg-danger:    oklch(0.495 0.205 27)           # error

# Border (M3 outline alias)
border-subtle:  oklch(0.520 0.020 295 / 0.12)    # outline-variant
border-default: oklch(0.520 0.020 295 / 0.25)    # outline
border-strong:  oklch(0.520 0.020 295 / 0.40)
border-brand:   oklch(0.460 0.155 295)
```

### Semantic alias — Dark

```yaml
# Background (M3 dark surface tonal value 10/20/12 등)
bg-canvas:        oklch(0.155 0.015 295)
bg-surface:       oklch(0.155 0.015 295)
bg-subtle:        oklch(0.135 0.013 295)
bg-muted:         oklch(0.195 0.020 295)
bg-elevated:      oklch(0.235 0.025 295)
bg-inverse:       oklch(0.920 0.010 295)
bg-brand:         oklch(0.795 0.130 295)      # primary on dark (tonal 80)
bg-brand-subtle:  oklch(0.330 0.080 295)      # primary-container dark
bg-danger-subtle: oklch(0.298 0.10 22 / 0.40)
bg-success-subtle:oklch(0.298 0.10 144 / 0.34)
bg-warning-subtle:oklch(0.298 0.10 56 / 0.40)

# Foreground
fg-strong:    oklch(0.965 0.005 295)
fg-default:   oklch(0.965 0.005 295 / 0.95)
fg-secondary: oklch(0.965 0.005 295 / 0.70)
fg-tertiary:  oklch(0.965 0.005 295 / 0.48)
fg-disabled:  oklch(0.965 0.005 295 / 0.32)
fg-on-brand:  oklch(0.220 0.020 295)          # on-primary dark
fg-brand:     oklch(0.795 0.130 295)
fg-success:   oklch(0.760 0.165 144)
fg-warning:   oklch(0.785 0.150 64)
fg-danger:    oklch(0.720 0.215 27)

# Border
border-subtle:  oklch(0.965 0.005 295 / 0.12)
border-default: oklch(0.965 0.005 295 / 0.25)
border-strong:  oklch(0.965 0.005 295 / 0.40)
border-brand:   oklch(0.795 0.130 295)
```

## Typography

### 서체 선택

primary face는 **Roboto** 또는 **Roboto Flex**(variable). 한국어 cross-platform 표면이면 Noto Sans KR fallback. Material 3 type scale은 size를 sp 단위로 명시하지만 본 카탈로그는 px로 환산.

### Type ramp (M3 type scale 매핑)

```yaml
display1:  57/400/1.12/-0.025em      # Display Large
display2:  45/400/1.16/0
display3:  36/400/1.22/0
title1:    32/400/1.25/0             # Headline Large
title2:    28/400/1.28/0
title3:    22/400/1.27/0             # Title Large (M3는 weight 400)
label1:    14/500/1.43/0.10em        # Label Large (positive tracking)
label2:    12/500/1.33/0.05em
body1:     16/400/1.50/0.03em        # Body Large
body1-read:16/400/1.65/0.03em
body2:     14/400/1.43/0.03em
caption1:  11/500/1.45/0.05em        # Label Small
```

Material 3의 특이점: **positive letter-spacing** (`+0.03em` ~ `+0.10em`)을 small text와 label에 사용. negative tracking은 display 1만. font weight 400 표준(Wanted의 500-700 표준과 차이).

## Spacing

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

M3는 **4dp grid** 기준. 본 시안의 spacing ladder는 alias 계약 그대로(`policy.non_4_spacing: false`). M3 자체에는 `8dp grid` 변형도 있지만 본 시안은 4dp 단일.

## Rounded

```yaml
radius-2:    2
radius-4:    4    # extra-small
radius-8:    8    # small (M3 button)
radius-12:   12   # medium (M3 card)
radius-16:   16   # large
radius-28:   28   # extra-large (Material You FAB, modal sheet)
radius-full: 9999 # full (chip, search bar)
```

M3 shape scale은 `none/extra-small(4)/small(8)/medium(12)/large(16)/extra-large(28)/full`. `radius-28`은 본 시안 전용 alias contract 외 항목(Material You의 FAB·bottom sheet 시그너처).

## Elevation & Depth

본 시안은 **M3 elevation 5단**(level 0/1/2/3/4/5)을 정의한다. 카드 그림자 허용(`policy.shadow_on_cards: true`).

```yaml
shadow-0:   none                              # level 0 (flat)
shadow-1:   0 1px 2px oklch(0 0 0 / 0.30),
            0 1px 3px 1px oklch(0 0 0 / 0.15)   # level 1 (raised card)
shadow-2:   0 1px 2px oklch(0 0 0 / 0.30),
            0 2px 6px 2px oklch(0 0 0 / 0.15)   # level 2 (button hover)
shadow-3:   0 4px 8px 3px oklch(0 0 0 / 0.15),
            0 1px 3px oklch(0 0 0 / 0.30)       # level 3 (FAB, dialog)
shadow-4:   0 6px 10px 4px oklch(0 0 0 / 0.15),
            0 2px 3px oklch(0 0 0 / 0.30)       # level 4 (nav drawer)
shadow-pop: 0 8px 12px 6px oklch(0 0 0 / 0.15),
            0 4px 4px oklch(0 0 0 / 0.30)       # level 5 (modal)
```

M3는 다크 모드에서 elevation을 **surface tint overlay**(brand color tint)로도 표현한다. 본 catalog는 정적 그림자 표기만 ship.

## Shapes

기하학은 **multi-tier rounded + elevation tier** 조합. button은 `radius-full`(M3 default — fully rounded), 카드는 `radius-12`, 모달은 `radius-28`. chip은 `radius-8` (M3의 input chip).

배경은 평면 색. gradient는 본 시안에 없다(`policy.gradient_locations: []`). M3는 surface tint(brand color tonal overlay)로 elevation을 표현하지만 본 시안은 정적 그림자로 정규화.

## Components

### button

M3의 5종 button variant — filled / tonal / elevated / outlined / text.

```yaml
height:
  sm: 32      # small
  md: 40      # default (M3 standard)
  lg: 48      # large
radius: radius-full   # M3 button은 default fully rounded (시그너처)
padding-x: space-24   # M3 button은 좌우 padding 24dp 표준 (label 양옆 여백)
label: 14/500/+0.10em letter-spacing
```

본 시안의 button radius는 **`radius-full`이 디폴트** — Wanted/toss-like/minimal-mono의 `radius-8`~`radius-12`와 직교한다. M3 시그너처.

### button-primary (M3 filled)

`bg-brand` 채움 + `fg-on-brand`. Hover 시 `state-layer` (8% brand alpha) overlay.

### button-secondary (M3 tonal)

`bg-brand-subtle` 채움 + `fg-brand`. M3의 *tonal button*에 해당.

### button-tertiary (M3 elevated)

`bg-surface` + `fg-brand` + `shadow-1` 그림자. M3 *elevated button*.

### button-ghost (M3 outlined)

투명 + 1px `border-default` + `fg-brand`. M3 *outlined button*.

### button-danger

`fg-danger` 채움 + 흰 텍스트.

### button-disabled

`fg-disabled` 위 12% alpha 채움 — M3는 disabled state를 ink alpha로 표현.

### input / form field

```yaml
height: 56            # M3 text field height (큰 표면)
border: 1px border-default       # outlined variant
radius: radius-4 (top) + radius-0 (bottom)    # M3 filled variant
       또는 radius-4 (full)                   # M3 outlined variant
bg:     bg-surface
label:  floating (focus 시 위로 이동)
helper: 12/400 caption1 fg-secondary
focus:  border-brand 2px
```

M3 input은 **floating label** + filled/outlined 2종 variant. 본 시안은 outlined variant 표준.

### badge

```yaml
height: 16          # M3는 작은 dot/numeric badge 시그너처
padding: 0 4
radius: radius-full
font: 11/600
variants:
  numeric: 16 height + 1-3 digit
  small:   6 dot
```

### chip

```yaml
height: 32          # M3 chip height
padding: 0 space-16
radius: radius-8    # M3 input chip
bg: bg-muted
border: 1px border-default (outlined variant)
icon: 18px leading
```

### avatar

`radius-full` 40px. fallback 이니셜 + `bg-brand-subtle` + `fg-brand`.

### icon-button

40×40, `radius-full`, M3 *icon button* 시그너처.

### icon

24×24, **Material Symbols** (variable axes: weight/grade/fill/optical size). monochrome `currentColor`. M3는 outlined/filled/rounded/sharp 4 family — 본 시안은 outlined 기본.

### sidebar-nav / top-bar / stat-card / data-table / login-layout

`DESIGN.md Admin / Dashboard surface 컴포넌트` 그대로. 본 시안에서 차이:
- `sidebar-nav`는 M3 *navigation drawer* 시그너처 — width 360 가능(다른 시안 240 vs).
- `stat-card`는 그림자 `shadow-1` 적용.
- `top-bar`는 M3 *top app bar* — center-aligned / small / medium / large 4 variant. 본 시안은 small (height 64).
- `data-table`은 M3 spec 부재(M3에 명시 컴포넌트 아님) — 본 catalog의 admin 5종 명세 그대로 사용.

## Do's and Don'ts

**Do**

- button radius를 `radius-full`로 사용 (M3 시그너처).
- elevation 5단을 surface 위계에 일관되게 적용. flat / raised / elevated / FAB / modal.
- positive letter-spacing을 small text(`body2`, `label1`, `caption1`)에 적용.
- input은 outlined variant 표준, floating label 사용.
- 카피는 영문 sentence case. button 라벨은 짧은 동사구.
- icon은 Material Symbols outlined 기본, active 상태에서 filled.
- 다크 모드에서 brand color tonal 80(밝게)을 사용 — light tonal 40과 대비.

**Don't**

- gradient를 어떤 surface에도 사용하지 않는다(`policy.gradient_locations: []`). surface tint는 정적 그림자로 정규화.
- ALL-CAPS 또는 Title Case In Buttons 사용 금지(영문은 sentence case).
- 한국어 격식체(`-습니다`/`-십시오`)와 영문 마케팅 과장 어휘를 동시 사용 금지.
- 작은 라운드(`radius-2`/`radius-4`)를 button에 사용 금지 — M3 button은 fully rounded.
- 비-4의 배수 spacing/radius 도입 금지.
- M3 outside의 자체 elevation 단계를 임의 추가 금지(5단 + flat이 표준).

## Responsive Behavior

M3는 **5 window size class** — compact(<600) / medium(600-839) / expanded(840-1199) / large(1200-1599) / extra-large(≥1600).

### Breakpoints (M3 window size class)

| Class | Width | Columns | Gutter |
|---|---|---|---|
| Compact | < 600 | 4 | 16 |
| Medium | 600-839 | 8 | 24 |
| Expanded | 840-1199 | 12 | 24 |
| Large | 1200-1599 | 12 | 32 |
| Extra Large | ≥ 1600 | 12 | 32 |

### Touch Targets

최소 48×48 (M3 표준). 본 시안의 button md 40 + padding 8 합산으로 48 충족.

## Known Gaps

- **OKLCH 변환** — M3 공식 사양은 sRGB hex로 ship. 본 카탈로그의 OKLCH 값은 sRGB → OKLab 표준 변환이며 ±0.002 lightness/chroma 오차.
- **dynamic color seed 변환** — 본 catalog는 seed `#6750A4` 정적 매핑만 ship. 다른 brand로 dynamic color를 구현하려면 host 앱이 M3 spec의 tonal palette 알고리즘(HCT color space)을 직접 구현해야 한다.
- **ripple/motion 토큰** — duration 50ms~500ms 11종, easing 6종(emphasized/standard 등)은 본 catalog 범위 외. prose 명시만.
- **state layer** — M3는 hover/pressed/dragged/focused 4 state를 brand color 8/12/16% alpha overlay로 표현. 본 catalog는 alias로 명시하지 않고 prose로만 surface.
- **wide data-table fade-edge 정책** — 본 시안은 `policy.gradient_locations: []` 전면 금지로, fade-edge gradient mask는 도입하지 않는다. `DESIGN.md ### data-table > #### Wide Table Cases`의 Case C/D 채택 시 스크롤 가능 시각 단서는 **state-layer 8% brand alpha overlay**(좌/우 가장자리 4px 정적 overlay)로 대체한다. M3 state layer 정합.
- **surface tint elevation** — 다크 모드에서 elevation을 brand tonal overlay로 표현하는 M3 정책은 본 catalog의 정적 그림자로 대체.
- **추가 alias** — `radius-28`(extra-large), `shadow-3`/`shadow-4`(M3 level 3-4)는 alias 계약 외 추가 토큰. 다른 시안에서 호출 시 fallback 필요.

## References

1. https://m3.material.io — Material Design 3 공식 사이트
2. https://m3.material.io/styles/color/system/overview — Color system + tonal palette
3. https://m3.material.io/foundations/elevation/overview — Elevation 5단
4. https://m3.material.io/styles/typography/type-scale-tokens — Type scale
5. https://m3.material.io/foundations/layout/applying-layout/window-size-classes — Window size class

## CSS Variables

```css
:root[data-design="material-3"][data-theme="light"] {
  --bg-canvas:        oklch(0.992 0.005 295);
  --bg-surface:       oklch(0.992 0.005 295);
  --bg-subtle:        oklch(0.965 0.012 295);
  --bg-muted:         oklch(0.945 0.018 295);
  --bg-elevated:      oklch(0.925 0.025 295);
  --bg-inverse:       oklch(0.250 0.018 295);
  --bg-brand:         oklch(0.460 0.155 295);
  --bg-brand-subtle:  oklch(0.920 0.045 295);
  --bg-danger-subtle: oklch(0.935 0.040 22);
  --bg-success-subtle:oklch(0.935 0.060 152);
  --bg-warning-subtle:oklch(0.940 0.060 81);

  --fg-strong:    oklch(0.180 0.015 295);
  --fg-default:   oklch(0.220 0.012 295 / 0.95);
  --fg-secondary: oklch(0.300 0.010 295 / 0.70);
  --fg-tertiary:  oklch(0.300 0.010 295 / 0.48);
  --fg-disabled:  oklch(0.300 0.010 295 / 0.32);
  --fg-on-brand:  oklch(0.998 0 0);
  --fg-brand:     oklch(0.460 0.155 295);
  --fg-success:   oklch(0.500 0.175 144);
  --fg-warning:   oklch(0.560 0.140 56);
  --fg-danger:    oklch(0.495 0.205 27);

  --border-subtle:  oklch(0.520 0.020 295 / 0.12);
  --border-default: oklch(0.520 0.020 295 / 0.25);
  --border-strong:  oklch(0.520 0.020 295 / 0.40);
  --border-brand:   oklch(0.460 0.155 295);

  /* Spacing (theme-invariant, 4dp grid) */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded (M3 shape scale: extra-small/small/medium/large/extra-large/full) */
  --radius-2: 2px;   --radius-4: 4px;   --radius-8: 8px;
  --radius-12: 12px; --radius-16: 16px;
  --radius-28: 28px;                                              /* catalog-only: M3 extra-large (FAB, modal sheet) */
  --radius-full: 9999px;

  /* M3 elevation 5단 (level 0/1/2/3/4/5) */
  --shadow-1: 0 1px 2px oklch(0 0 0 / 0.30), 0 1px 3px 1px oklch(0 0 0 / 0.15);
  --shadow-2: 0 1px 2px oklch(0 0 0 / 0.30), 0 2px 6px 2px oklch(0 0 0 / 0.15);
  --shadow-3: 0 4px 8px 3px oklch(0 0 0 / 0.15), 0 1px 3px oklch(0 0 0 / 0.30);   /* catalog-only: M3 level 3 (FAB, dialog) */
  --shadow-4: 0 6px 10px 4px oklch(0 0 0 / 0.15), 0 2px 3px oklch(0 0 0 / 0.30);  /* catalog-only: M3 level 4 (nav drawer) */
  --shadow-pop: 0 8px 12px 6px oklch(0 0 0 / 0.15), 0 4px 4px oklch(0 0 0 / 0.30);

  /* Typography */
  --font-size-display1: 57px;   --font-weight-display1: 400;    --line-height-display1: 1.12;   --letter-spacing-display1: -0.025em;
  --font-size-display2: 45px;   --font-weight-display2: 400;    --line-height-display2: 1.16;   --letter-spacing-display2: 0;
  --font-size-display3: 36px;   --font-weight-display3: 400;    --line-height-display3: 1.22;   --letter-spacing-display3: 0;
  --font-size-title1: 32px;     --font-weight-title1: 400;      --line-height-title1: 1.25;     --letter-spacing-title1: 0;
  --font-size-title2: 28px;     --font-weight-title2: 400;      --line-height-title2: 1.28;     --letter-spacing-title2: 0;
  --font-size-title3: 22px;     --font-weight-title3: 400;      --line-height-title3: 1.27;     --letter-spacing-title3: 0;
  --font-size-label1: 14px;     --font-weight-label1: 500;      --line-height-label1: 1.43;     --letter-spacing-label1: 0.10em;
  --font-size-label2: 12px;     --font-weight-label2: 500;      --line-height-label2: 1.33;     --letter-spacing-label2: 0.05em;
  --font-size-body1: 16px;      --font-weight-body1: 400;       --line-height-body1: 1.50;      --letter-spacing-body1: 0.03em;
  --font-size-body1-read: 16px; --font-weight-body1-read: 400;  --line-height-body1-read: 1.65; --letter-spacing-body1-read: 0.03em;
  --font-size-body2: 14px;      --font-weight-body2: 400;       --line-height-body2: 1.43;      --letter-spacing-body2: 0.03em;
  --font-size-caption1: 11px;   --font-weight-caption1: 500;    --line-height-caption1: 1.45;   --letter-spacing-caption1: 0.05em;
}

:root[data-design="material-3"][data-theme="dark"] {
  --bg-canvas:        oklch(0.155 0.015 295);
  --bg-surface:       oklch(0.155 0.015 295);
  --bg-subtle:        oklch(0.135 0.013 295);
  --bg-muted:         oklch(0.195 0.020 295);
  --bg-elevated:      oklch(0.235 0.025 295);
  --bg-inverse:       oklch(0.920 0.010 295);
  --bg-brand:         oklch(0.795 0.130 295);
  --bg-brand-subtle:  oklch(0.330 0.080 295);
  --bg-danger-subtle: oklch(0.298 0.10 22 / 0.40);
  --bg-success-subtle:oklch(0.298 0.10 144 / 0.34);
  --bg-warning-subtle:oklch(0.298 0.10 56 / 0.40);

  --fg-strong:    oklch(0.965 0.005 295);
  --fg-default:   oklch(0.965 0.005 295 / 0.95);
  --fg-secondary: oklch(0.965 0.005 295 / 0.70);
  --fg-tertiary:  oklch(0.965 0.005 295 / 0.48);
  --fg-disabled:  oklch(0.965 0.005 295 / 0.32);
  --fg-on-brand:  oklch(0.220 0.020 295);
  --fg-brand:     oklch(0.795 0.130 295);                       /* M3 tonal 80 */
  --fg-success:   oklch(0.760 0.165 144);                       /* synthesized */
  --fg-warning:   oklch(0.785 0.150 64);                        /* synthesized */
  --fg-danger:    oklch(0.720 0.215 27);                        /* synthesized */

  --border-subtle:  oklch(0.965 0.005 295 / 0.12);
  --border-default: oklch(0.965 0.005 295 / 0.25);
  --border-strong:  oklch(0.965 0.005 295 / 0.40);
  --border-brand:   oklch(0.795 0.130 295);

  /* spacing/radius는 light와 동일 — 상속 */

  --shadow-1: 0 1px 2px oklch(0 0 0 / 0.50), 0 1px 3px 1px oklch(0 0 0 / 0.30);
  --shadow-2: 0 1px 2px oklch(0 0 0 / 0.50), 0 2px 6px 2px oklch(0 0 0 / 0.30);
  --shadow-3: 0 4px 8px 3px oklch(0 0 0 / 0.30), 0 1px 3px oklch(0 0 0 / 0.50);   /* catalog-only dark */
  --shadow-4: 0 6px 10px 4px oklch(0 0 0 / 0.30), 0 2px 3px oklch(0 0 0 / 0.50);  /* catalog-only dark */
  --shadow-pop: 0 8px 12px 6px oklch(0 0 0 / 0.30), 0 4px 4px oklch(0 0 0 / 0.50);
}
```
