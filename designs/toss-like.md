---
name: Toss-like
slug: toss-like
category: finance
last_updated: "2026-05-16"
sources:
  - "(self-contained — 한국 금융 fintech UI 패턴 일반 관례 합성)"
related_services: []
lang: ko
logo: /logos/toss-like.png
policy:
  shadow_on_cards: true
  gradient_locations: ["hero", "table-fade-edge"]
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
---

# Toss-like — design.md

> 한국 금융/핀테크 surface에서 통용되는 친근한 fintech 톤을 합성한 시안. 단일 강조 파랑(`bg-brand`)을 1차 시그너처로, **큰 라운드 + 카드 부드러운 그림자 + 친근한 카피**가 모드의 무게중심이다. SSOT 없이 self-contained 합성 catalog. 본 시안은 `designs/_alias-contract.md` 계약을 준수한다.

## Brand & Style

핀테크 표면의 시각 시그너처는 **밝은 캔버스 + 단일 강조 파랑 + 부드러운 라운드 그림자 카드** 조합이다. 위계는 (1) 큰 라운드(`radius-12` ~ `radius-16` 카드 표준), (2) `shadow-1`/`shadow-2` 부드러운 elevation, (3) 단일 강조 파랑 CTA로 만들어진다 (`policy.shadow_on_cards: true`).

표면은 평면이지만 카드에 옅은 그림자를 허용한다 — 카드 그룹 사이에 공간감을 만드는 게 본 시안의 핵심 차별화다(Wanted/minimal-mono는 그림자 금지, 본 시안은 허용). gradient는 마케팅 hero와 wide data-table fade-edge(가로 스크롤 affordance)에 허용된다(`policy.gradient_locations: ["hero", "table-fade-edge"]`).

대상 사용자는 **일반 소비자(non-technical)** 가 1차다. 금융/결제/송금/투자 surface처럼 *신뢰감 + 친근감*이 모두 필요한 도메인. 마케팅 landing → 본인인증 → core flow → 알림 4개 surface를 단일 시스템으로 운영한다.

Voice는 **친근한 존댓말**(`-요`/`-어요`/`-아요`) + 동사형 버튼(`송금하기`, `결제하기`, `확인하기`). 금융 전문 용어는 1줄 sub-label로 풀어 설명한다(예: "이체" → "송금하기 · 다른 사람에게 보내요"). 격식체와 영문 단독 사용은 회피한다.

## Colors

### Brand

```yaml
brand-primary: oklch(0.620 0.180 245)    # 파랑
brand-hover:   oklch(0.540 0.180 245)    # 더 진한 파랑
```

### Brand gradient (마케팅 hero 전용)

```yaml
hero-gradient: linear-gradient(135deg, oklch(0.620 0.180 245) 0%, oklch(0.680 0.160 268) 100%)
```

마케팅 hero banner 1곳에만 사용. CTA·헤더·풀-블리드 본문에는 적용하지 않는다.

### Semantic alias — Light

```yaml
# Background
bg-canvas:         oklch(0.985 0.002 245)    # 매우 옅은 파랑 tint
bg-surface:        oklch(1 0 0)              # 흰 카드
bg-subtle:         oklch(0.975 0.005 245)    # 페이지 배경
bg-muted:          oklch(0.955 0.008 245)    # hover 채움
bg-elevated:       oklch(1 0 0)
bg-inverse:        oklch(0.180 0.020 245)
bg-brand:          oklch(0.620 0.180 245)
bg-brand-subtle:   oklch(0.955 0.020 245)
bg-danger-subtle:  oklch(0.962 0.020 22)
bg-success-subtle: oklch(0.965 0.045 152)
bg-warning-subtle: oklch(0.968 0.030 81)

# Foreground
fg-strong:    oklch(0.180 0.020 245)
fg-default:   oklch(0.220 0.018 245 / 0.92)
fg-secondary: oklch(0.280 0.015 245 / 0.62)
fg-tertiary:  oklch(0.280 0.015 245 / 0.44)
fg-disabled:  oklch(0.280 0.015 245 / 0.28)
fg-on-brand:  oklch(1 0 0)
fg-brand:     oklch(0.540 0.180 245)
fg-success:   oklch(0.520 0.180 144)
fg-warning:   oklch(0.580 0.140 56)
fg-danger:    oklch(0.540 0.200 27)

# Border
border-subtle:  oklch(0.520 0.020 245 / 0.10)
border-default: oklch(0.520 0.020 245 / 0.22)
border-strong:  oklch(0.520 0.020 245 / 0.34)
border-brand:   oklch(0.620 0.180 245)
```

### Semantic alias — Dark

```yaml
# Background
bg-canvas:        oklch(0.145 0.020 245)    # 진한 navy
bg-surface:       oklch(0.180 0.025 245)
bg-subtle:        oklch(0.125 0.020 245)
bg-muted:         oklch(0.215 0.025 245)
bg-elevated:      oklch(0.250 0.025 245)
bg-inverse:       oklch(1 0 0)
bg-brand:         oklch(0.620 0.180 245)
bg-brand-subtle:  oklch(0.180 0.085 245)
bg-danger-subtle: oklch(0.298 0.10 22 / 0.34)
bg-success-subtle:oklch(0.298 0.10 144 / 0.30)
bg-warning-subtle:oklch(0.298 0.10 56 / 0.34)

# Foreground
fg-strong:    oklch(1 0 0)
fg-default:   oklch(1 0 0 / 0.92)
fg-secondary: oklch(1 0 0 / 0.62)
fg-tertiary:  oklch(1 0 0 / 0.44)
fg-disabled:  oklch(1 0 0 / 0.28)
fg-on-brand:  oklch(1 0 0)
fg-brand:     oklch(0.730 0.155 245)
fg-success:   oklch(0.740 0.165 144)
fg-warning:   oklch(0.770 0.150 64)
fg-danger:    oklch(0.720 0.215 27)

# Border
border-subtle:  oklch(1 0 0 / 0.10)
border-default: oklch(1 0 0 / 0.22)
border-strong:  oklch(1 0 0 / 0.34)
border-brand:   oklch(0.730 0.155 245)
```

## Typography

### 서체 선택

primary face는 **Pretendard JP**(또는 Pretendard, Inter fallback). 핀테크는 숫자(금액 표시) 비중이 높으므로 tabular-nums 활용을 강하게 권장한다.

### Type ramp

```yaml
display1:  44/700/1.1/-0.028em      # 금액 강조 display (큰 송금/잔액 화면)
display2:  36/700/1.15/-0.022em
display3:  28/700/1.2/-0.018em
title1:    24/700/1.25/-0.015em
title2:    20/700/1.3/-0.012em
title3:    17/700/1.35/-0.008em
label1:    14/600/1.4/-0.005em
label2:    13/600/1.4/-0.005em
body1:     16/500/1.55/-0.005em
body1-read:16/500/1.65/-0.005em
body2:     14/500/1.5/-0.005em
caption1:  12/600/1.4/0
amount:    32/700/1.0/-0.020em tabular-nums  # 금액 전용 variant
```

`amount` variant는 본 시안의 특이 ramp — 금액·잔액 셀에 사용. tabular-nums + 더 타이트한 line-height.

## Spacing

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

본 시안은 **카드 padding `space-20` 또는 `space-24` 표준** (Wanted/minimal-mono의 `space-24`보다 한 단계 작게 가져갈 수 있다 — 모바일 카드 밀도가 높은 핀테크 표면 특성).

## Rounded

```yaml
radius-2:    2
radius-4:    4
radius-8:    8     # 작은 chip, sm input
radius-12:   12    # md 카드, 버튼 디폴트
radius-16:   16    # lg 카드 (시그너처)
radius-20:   20    # xl 카드, modal
radius-full: 9999  # chip, avatar, icon-button, toggle
```

본 시안은 라운드를 **크게 가져간다** — 카드 디폴트 `radius-16`, 버튼 디폴트 `radius-12`. minimal-mono(`radius-4` 입력, `radius-8` 카드)와 직교한다.

`radius-20`은 본 시안에서 신설한 alias contract 외 추가 항목. 모달과 xl 카드 전용. 다른 시안에는 없을 수 있다.

## Elevation & Depth

본 시안은 카드에 **부드러운 그림자 elevation을 허용**한다(`policy.shadow_on_cards: true`).

```yaml
shadow-1:   0 1px 3px oklch(0 0 0 / 0.06)     # 카드 기본
shadow-2:   0 4px 12px oklch(0 0 0 / 0.08)    # 강조 카드, dropdown
shadow-pop: 0 12px 32px oklch(0 0 0 / 0.12)   # modal, toast, bottom sheet
shadow-cta: 0 8px 24px oklch(0.620 0.180 245 / 0.30)  # primary CTA hover (선택)
```

다크 모드는 그림자가 진하게(alpha 0.24/0.36/0.50). `shadow-cta`는 brand color glow — 다크에서도 brand hue 유지.

## Shapes

기하학은 **큰 라운드 + 부드러운 그림자 + 평면 색 표면**. chip·avatar·icon-button·toggle은 `radius-full`. 카드는 1px `border-subtle` + `shadow-1` 조합 또는 보더 생략하고 `shadow-2`만 사용도 허용.

마케팅 hero는 `gradient_locations: ["hero"]`에 따라 brand gradient 사용. 다른 surface는 평면 단색.

## Components

### button

| 사이즈 | height | radius | label |
|---|---|---|---|
| sm | 36 | `radius-8` | 14/600 |
| md | 44 | `radius-12` | 15/600 |
| lg | 52 | `radius-12` | 16/700 |
| xl | 60 | `radius-16` | 17/700 |

본 시안의 button height는 다른 시안보다 한 단계 큼 (Wanted lg 48 → toss-like lg 52). 핀테크 표면이 모바일 우선이라 hit area를 넉넉히.

### button-primary

`bg-brand` 채움 + `fg-on-brand` 텍스트. Hover 시 `oklch(0.540 0.180 245)`로 darken. 선택적으로 `shadow-cta` glow.

### button-secondary

투명 배경 + 1px `border-default` + `fg-strong`. Hover `bg-muted`.

### button-tertiary

`bg-brand-subtle` + `fg-brand`. 본 시안의 secondary 위계가 다른 시안의 ghost와 가까움.

### button-ghost

투명 + `fg-brand`. Hover `bg-brand-subtle`.

### button-danger

`fg-danger` 채움 + 흰 텍스트.

### button-disabled

`bg-muted` + `fg-disabled`.

### input / form field

```yaml
height: 52              # 큰 height (모바일 표면)
border: 1px border-default
radius: radius-12       # 큰 라운드 (시그너처)
bg:     bg-surface
padding: 0 space-16
focus:  border-brand + 3px brand glow
```

`amount` input variant는 height 64, `font: amount` ramp, 우측 정렬 + 통화 단위 suffix.

### badge

```yaml
height: 24
padding: 0 space-8
radius: radius-full
font: 12/700           # 한 단계 굵게
```

### chip

```yaml
height: 32             # 한 단계 큼 (모바일 친화)
padding: 0 space-12
radius: radius-full
bg: bg-muted
```

### avatar

`radius-full` 40px 기본(다른 시안 32px보다 큼). 이니셜 + `bg-brand-subtle` + `fg-brand`.

### icon-button

40×40 (한 단계 큼), `radius-full`.

### icon

24×24, 2px stroke, monochrome, `currentColor`. 16/20/24/32 사이즈.

### sidebar-nav / top-bar / stat-card / data-table / login-layout

`DESIGN.md Admin / Dashboard surface 컴포넌트` 명세에서 색·radius 토큰만 본 시안 값으로 치환. 추가로 본 시안에서:
- `stat-card`는 그림자 `shadow-1` 적용(`shadow_on_cards: true`).
- `data-table` row hover에 `shadow-1` 추가 가능(선택).
- `top-bar`의 우측 액션 묶음에 큰 라운드 `radius-12` 카드 wrapper 가능.

## Do's and Don'ts

**Do**

- 큰 라운드(`radius-12` ~ `radius-16`)를 카드·버튼·입력 디폴트로 사용.
- 카드에 부드러운 `shadow-1` 그림자 허용 — 카드 그룹 사이 공간감이 본 시안 시그너처.
- 단일 강조 파랑(`bg-brand`)을 primary CTA에 사용. 화면당 strong 파랑은 1개.
- 금액·잔액·숫자는 `tabular-nums` + `amount` ramp.
- 버튼 size를 한 단계 큼(`md 44`, `lg 52`). 모바일 hit area 우선.
- 친근한 존댓말 + 동사형 버튼. 금융 전문 용어는 sub-label로 풀어 설명.
- 마케팅 hero에 brand gradient 사용 가능 (1곳 한정).

**Don't**

- gradient를 hero 외 surface(CTA, 카드, top-bar, 사이드바)에 사용하지 않는다.
- 카드 그림자를 너무 진하게 쓰지 않는다 — `shadow-1` 정도가 표준, `shadow-2`는 강조 카드만.
- 격식체 `-습니다`/`-십시오`를 product 카피에 사용하지 않는다.
- 빨강을 brand color로 사용하지 않는다 — 빨강은 위험/에러 시그널 전용.
- 작은 라운드(`radius-2`, `radius-4`)를 카드/버튼 디폴트로 사용하지 않는다 — 본 시안은 큰 라운드 시그너처.
- 영문 단독 카피(en-sentence)를 1차로 사용하지 않는다 — 한국어 우선, 영문은 보조 표기.
- ALL-CAPS · 마침표(UI 라벨/버튼) · 마케팅 과장 어휘 금지.

## Responsive Behavior

본 시안은 **mobile-first** — 핀테크 표면의 1차 surface가 모바일이다. 모바일 max-content-width 정책은 가지지 않고 viewport 전폭 + 좌우 `space-20` padding.

### Breakpoints

| Name | Width | Columns | Gutter |
|---|---|---|---|
| Mobile | ≤ 640 | 4 | 20 |
| Tablet | 641–1023 | 8 | 24 |
| Desktop | ≥ 1024 | 12 | 32 |

### Touch Targets

최소 48×48 권장(다른 시안 44보다 큼). 핀테크 표면에서 오탭 방지가 핵심.

## Known Gaps

- **자체 출처 없음** — 본 시안은 한국 핀테크 UI 일반 관례의 합성이며 특정 회사의 디자인 시스템 사양이 아니다. 토큰값은 핀테크 표면에서 흔히 관찰되는 범위에서 합성.
- **`radius-20` alias** — alias 계약 외 추가 토큰. 본 시안 전용. 다른 시안에서 호출 시 fallback이 필요할 수 있다.
- **`shadow-cta` alias** — brand color glow 그림자. preview HTML은 `shadow-1`로 fallback.
- **`amount` typography variant** — alias 계약 외 추가. tabular-nums 강제는 본 시안 정책.

## References

본 시안은 self-contained 합성 catalog. 외부 SSOT 없음. 한국 핀테크 표면(송금/결제/투자)의 시각 패턴 일반 관례를 종합.

## CSS Variables

```css
:root[data-design="toss-like"][data-theme="light"] {
  --bg-canvas:        oklch(0.985 0.002 245);
  --bg-surface:       oklch(1 0 0);
  --bg-subtle:        oklch(0.975 0.005 245);
  --bg-muted:         oklch(0.955 0.008 245);
  --bg-elevated:      oklch(1 0 0);
  --bg-inverse:       oklch(0.180 0.020 245);
  --bg-brand:         oklch(0.620 0.180 245);
  --bg-brand-subtle:  oklch(0.955 0.020 245);
  --bg-danger-subtle: oklch(0.962 0.020 22);
  --bg-success-subtle:oklch(0.965 0.045 152);
  --bg-warning-subtle:oklch(0.968 0.030 81);

  --fg-strong:    oklch(0.180 0.020 245);
  --fg-default:   oklch(0.220 0.018 245 / 0.92);
  --fg-secondary: oklch(0.280 0.015 245 / 0.62);
  --fg-tertiary:  oklch(0.280 0.015 245 / 0.44);
  --fg-disabled:  oklch(0.280 0.015 245 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.540 0.180 245);
  --fg-success:   oklch(0.520 0.180 144);
  --fg-warning:   oklch(0.580 0.140 56);
  --fg-danger:    oklch(0.540 0.200 27);

  --border-subtle:  oklch(0.520 0.020 245 / 0.10);
  --border-default: oklch(0.520 0.020 245 / 0.22);
  --border-strong:  oklch(0.520 0.020 245 / 0.34);
  --border-brand:   oklch(0.620 0.180 245);

  /* Spacing (theme-invariant) */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded (표준 + catalog-only) */
  --radius-2: 2px;   --radius-4: 4px;   --radius-8: 8px;
  --radius-12: 12px; --radius-16: 16px;
  --radius-20: 20px;                                              /* catalog-only: xl 카드/modal */
  --radius-full: 9999px;

  --shadow-1:   0 1px 3px oklch(0 0 0 / 0.06);
  --shadow-2:   0 4px 12px oklch(0 0 0 / 0.08);
  --shadow-cta: 0 8px 24px oklch(0.620 0.180 245 / 0.30);        /* catalog-only: brand color glow */
  --shadow-pop: 0 12px 32px oklch(0 0 0 / 0.12);

  /* Typography */
  --font-size-display1: 44px;   --font-weight-display1: 700;    --line-height-display1: 1.1;    --letter-spacing-display1: -0.028em;
  --font-size-display2: 36px;   --font-weight-display2: 700;    --line-height-display2: 1.15;   --letter-spacing-display2: -0.022em;
  --font-size-display3: 28px;   --font-weight-display3: 700;    --line-height-display3: 1.2;    --letter-spacing-display3: -0.018em;
  --font-size-title1: 24px;     --font-weight-title1: 700;      --line-height-title1: 1.25;     --letter-spacing-title1: -0.015em;
  --font-size-title2: 20px;     --font-weight-title2: 700;      --line-height-title2: 1.3;      --letter-spacing-title2: -0.012em;
  --font-size-title3: 17px;     --font-weight-title3: 700;      --line-height-title3: 1.35;     --letter-spacing-title3: -0.008em;
  --font-size-label1: 14px;     --font-weight-label1: 600;      --line-height-label1: 1.4;      --letter-spacing-label1: -0.005em;
  --font-size-label2: 13px;     --font-weight-label2: 600;      --line-height-label2: 1.4;      --letter-spacing-label2: -0.005em;
  --font-size-body1: 16px;      --font-weight-body1: 500;       --line-height-body1: 1.55;      --letter-spacing-body1: -0.005em;
  --font-size-body1-read: 16px; --font-weight-body1-read: 500;  --line-height-body1-read: 1.65; --letter-spacing-body1-read: -0.005em;
  --font-size-body2: 14px;      --font-weight-body2: 500;       --line-height-body2: 1.5;       --letter-spacing-body2: -0.005em;
  --font-size-caption1: 12px;   --font-weight-caption1: 600;    --line-height-caption1: 1.4;    --letter-spacing-caption1: 0;
}

:root[data-design="toss-like"][data-theme="dark"] {
  --bg-canvas:        oklch(0.145 0.020 245);
  --bg-surface:       oklch(0.180 0.025 245);
  --bg-subtle:        oklch(0.125 0.020 245);
  --bg-muted:         oklch(0.215 0.025 245);
  --bg-elevated:      oklch(0.250 0.025 245);
  --bg-inverse:       oklch(1 0 0);
  --bg-brand:         oklch(0.620 0.180 245);
  --bg-brand-subtle:  oklch(0.180 0.085 245);
  --bg-danger-subtle: oklch(0.298 0.10 22 / 0.34);
  --bg-success-subtle:oklch(0.298 0.10 144 / 0.30);
  --bg-warning-subtle:oklch(0.298 0.10 56 / 0.34);

  --fg-strong:    oklch(1 0 0);
  --fg-default:   oklch(1 0 0 / 0.92);
  --fg-secondary: oklch(1 0 0 / 0.62);
  --fg-tertiary:  oklch(1 0 0 / 0.44);
  --fg-disabled:  oklch(1 0 0 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.730 0.155 245);                       /* synthesized */
  --fg-success:   oklch(0.740 0.165 144);                       /* synthesized */
  --fg-warning:   oklch(0.770 0.150 64);                        /* synthesized */
  --fg-danger:    oklch(0.720 0.215 27);                        /* synthesized */

  --border-subtle:  oklch(1 0 0 / 0.10);
  --border-default: oklch(1 0 0 / 0.22);
  --border-strong:  oklch(1 0 0 / 0.34);
  --border-brand:   oklch(0.730 0.155 245);

  /* spacing/radius는 light와 동일 — 상속 */

  --shadow-1:   0 1px 3px oklch(0 0 0 / 0.24);
  --shadow-2:   0 4px 12px oklch(0 0 0 / 0.36);
  --shadow-cta: 0 8px 24px oklch(0.620 0.180 245 / 0.50);        /* catalog-only: brand glow dark */
  --shadow-pop: 0 12px 32px oklch(0 0 0 / 0.50);
}
```
