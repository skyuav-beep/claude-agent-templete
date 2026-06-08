---
name: Minimal Mono
slug: minimal-mono
category: starter
last_updated: "2026-05-16"
sources:
  - "(self-contained — 합성 catalog, 외부 SSOT 없음)"
related_services: []
lang: ko
logo: /logos/minimal-mono.png
policy:
  shadow_on_cards: false
  gradient_locations: []
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
---

# Minimal Mono — design.md

> 흑백 단색 + 평면 표면 + 헤어라인 보더로 정의되는 미니멀 스타터 시안. 브랜드 컬러가 없거나, 도메인 중립적인 admin/도구 UI, 콘텐츠 위계가 타이포로만 만들어지는 프로젝트의 기본 시안. 본 시안은 SSOT 외부 출처 없이 self-contained로 합성되었으며, `designs/_alias-contract.md` 계약을 준수한다.

## Brand & Style

브랜드 시각의 무게중심은 **타이포 위계 100%** — 채도가 0인 neutral 표면 위에 글자 굵기와 크기로만 위계를 만든다. accent 컬러는 없으며 시그너처 시각 요소도 없다. light는 흰 캔버스 + 검은 텍스트, dark는 거의 검은 캔버스 + 거의 흰 텍스트의 단순 반전 구조다.

표면은 100% 평면. gradient는 어떤 위치에서도 사용하지 않는다(`policy.gradient_locations: []`). 카드 그림자도 사용하지 않으며 1px 헤어라인 보더가 모든 카드/패널의 구조를 짊어진다. 그림자는 popover/dropdown/modal/toast 같은 elevated surface에만 등장한다.

대상 사용자는 도메인 중립적이며, 도구·관리·에디터 surface처럼 콘텐츠가 주인공인 UI가 핵심이다. 마케팅 표면은 본 시안의 1차 대상이 아니다 — 마케팅이 필요하면 별도 시안을 검토한다.

Voice는 **친근한 존댓말**(`-요`/`-어요`/`-아요`)을 표준으로 한다. 격식체와 챗봇 톤은 회피한다.

## Colors

### Brand

없음. `bg-brand`/`fg-brand`/`border-brand` alias는 neutral 가장 진한 톤을 그대로 호출한다(light에서 거의 검정, dark에서 거의 흰색). 화면당 단일 강조색 정책을 유지하되 그 강조색이 brand hue가 아니라 가장 진한 neutral이다.

### Semantic alias — Light

```yaml
# Background (모두 채도 0)
bg-canvas:         oklch(1 0 0)             # 흰
bg-surface:        oklch(1 0 0)
bg-subtle:         oklch(0.975 0 0)         # 페이지 배경
bg-muted:          oklch(0.955 0 0)         # hover 채움
bg-elevated:       oklch(1 0 0)
bg-inverse:        oklch(0.145 0 0)         # 거의 검정
bg-brand:          oklch(0.145 0 0)         # = bg-inverse, primary CTA
bg-brand-subtle:   oklch(0.940 0 0)
bg-danger-subtle:  oklch(0.965 0.020 18)
bg-success-subtle: oklch(0.965 0.025 152)
bg-warning-subtle: oklch(0.965 0.025 81)

# Foreground (neutral-900 위에 alpha 적용)
fg-strong:    oklch(0.145 0 0)               # 거의 검정 @ alpha 1
fg-default:   oklch(0.145 0 0 / 0.88)
fg-secondary: oklch(0.145 0 0 / 0.60)
fg-tertiary:  oklch(0.145 0 0 / 0.42)
fg-disabled:  oklch(0.145 0 0 / 0.28)
fg-on-brand:  oklch(1 0 0)                   # 흰 텍스트 on 검정 brand
fg-brand:     oklch(0.145 0 0)
fg-success:   oklch(0.520 0.180 144)
fg-warning:   oklch(0.580 0.140 56)
fg-danger:    oklch(0.540 0.200 27)

# Border
border-subtle:  oklch(0.145 0 0 / 0.08)
border-default: oklch(0.145 0 0 / 0.20)
border-strong:  oklch(0.145 0 0 / 0.32)
border-brand:   oklch(0.145 0 0)
```

### Semantic alias — Dark

```yaml
# Background (모두 채도 0)
bg-canvas:        oklch(0.145 0 0)           # 거의 검정
bg-surface:       oklch(0.175 0 0)
bg-subtle:        oklch(0.125 0 0)
bg-muted:        oklch(0.205 0 0)
bg-elevated:     oklch(0.235 0 0)
bg-inverse:      oklch(1 0 0)
bg-brand:        oklch(0.940 0 0)           # 거의 흰 = primary CTA on dark
bg-brand-subtle: oklch(0.235 0 0)
bg-danger-subtle: oklch(0.298 0.10 22 / 0.32)
bg-success-subtle:oklch(0.298 0.10 144 / 0.28)
bg-warning-subtle:oklch(0.298 0.10 56 / 0.32)

# Foreground
fg-strong:    oklch(1 0 0)
fg-default:   oklch(1 0 0 / 0.88)
fg-secondary: oklch(1 0 0 / 0.60)
fg-tertiary:  oklch(1 0 0 / 0.42)
fg-disabled:  oklch(1 0 0 / 0.28)
fg-on-brand:  oklch(0.145 0 0)              # 검정 텍스트 on 흰 brand
fg-brand:     oklch(1 0 0)
fg-success:   oklch(0.740 0.165 144)
fg-warning:   oklch(0.770 0.150 64)
fg-danger:    oklch(0.720 0.215 27)

# Border
border-subtle:  oklch(1 0 0 / 0.08)
border-default: oklch(1 0 0 / 0.20)
border-strong:  oklch(1 0 0 / 0.32)
border-brand:   oklch(1 0 0)
```

채도가 0인 brand는 시각적 강조에 한계가 있다. 강조가 필요한 위치는 (1) 단일 primary 액션의 black/white 채움, (2) underline·heavier weight로 위계 보강을 권장한다.

## Typography

### 서체 선택

primary face는 **Pretendard JP** 또는 **Inter**. 한국어 위주면 Pretendard, 영문 위주면 Inter. CJK 지원 없는 표면이면 Inter Variable 단일 fallback.

### Type ramp

```yaml
display1: 48/700/1.1/-0.030em
display2: 40/700/1.15/-0.025em
display3: 32/700/1.2/-0.020em
title1:   28/700/1.25/-0.018em
title2:   22/700/1.3/-0.015em
title3:   18/700/1.35/-0.010em
label1:   14/600/1.4/-0.005em
label2:   13/600/1.4/-0.005em
body1:    16/500/1.5/-0.005em
body1-read:16/500/1.625/-0.005em
body2:    14/500/1.45/-0.005em
caption1: 12/600/1.4/0
```

위계는 **size + weight 조합으로 명확히 분리**한다. 색으로 위계를 만들지 않는다(시안 정체성). 단일 색상 표면 + 다단계 weight가 시그너처다.

## Spacing

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

4의 배수만. 컴포넌트 로컬값도 4의 배수만 허용. button sm radius 6, lg 10 같은 비-4 로컬값은 본 시안에서 사용하지 않는다(예: button sm radius 4, lg 8로 정규화).

## Rounded

```yaml
radius-2:    2
radius-4:    4    # 입력/버튼 sm
radius-8:    8    # 카드, 버튼 md/lg 디폴트
radius-12:   12   # 큰 카드, 모달
radius-16:   16
radius-full: 9999 # chip, avatar, icon-button
```

라운드는 **보수적으로**. radius-12 이상은 모달/대형 카드에만. radius-full은 chip/avatar/icon-button에만.

## Elevation & Depth

평면이 기본. 카드는 1px `border-subtle`로 구조를 만든다(`policy.shadow_on_cards: false`). 그림자는 elevated surface 전용.

```yaml
shadow-1:   0 1px 2px oklch(0 0 0 / 0.04)    # dropdown
shadow-2:   0 4px 8px oklch(0 0 0 / 0.06)    # popover
shadow-pop: 0 8px 24px oklch(0 0 0 / 0.10)   # modal, toast
```

다크 모드에서 그림자는 더 진하게(alpha 0.20/0.32/0.48).

## Shapes

기하학은 **discrete radii + 평면 표면 + 헤어라인 보더**. 평면 흰 캔버스(또는 거의 검은 다크 캔버스) 위에 4~12px 라운드 카드/버튼을 얹는다. chip·avatar·icon-button·toggle에만 `radius-full`을 적용한다.

기본 보더는 1px `border-subtle` 헤어라인. 폼 입력·secondary 버튼은 1px `border-default`로 한 단계 강해진다. 포커스 상태는 1px `border-brand`(가장 진한 neutral) + 2px outline offset.

배경은 평면 단색. gradient는 본 시안의 어떤 surface에도 사용하지 않는다.

## Components

본 시안은 필수 7종 시그너처(button-*, input, badge, chip, avatar, icon-button, icon) + admin 5종(login-layout, sidebar-nav, top-bar, stat-card, data-table)을 정의한다. 마케팅 표면 컴포넌트(header/footer/hero-banner/job-card)는 본 시안 범위 외다.

### button

sm/md/lg/xl 4단. 4의 배수 정규화 (Wanted의 비-4 로컬값 6/10 사용 안 함).

| 사이즈 | height | radius | label |
|---|---|---|---|
| sm | 32 | `radius-4` | 13/600 |
| md | 40 | `radius-8` | 14/600 |
| lg | 48 | `radius-8` | 16/600 |
| xl | 56 | `radius-12` | 17/700 |

### button-primary

`bg-brand`(거의 검정 light / 거의 흰 dark) + `fg-on-brand`. Hover 시 1단계 brighten/darken (light: oklch(0.220 0 0), dark: oklch(0.880 0 0)).

### button-secondary

투명 배경 + 1px `border-default` + `fg-strong`. Hover 시 `bg-muted` 채움.

### button-tertiary

`bg-muted` + `fg-strong`. 보더 없음. inline 보조 액션.

### button-ghost

투명 배경 + `fg-default` 또는 `fg-brand`. Hover 시 `bg-muted` 채움. 텍스트 링크 대용.

### button-danger

`fg-danger` 색 채움 + 흰 텍스트.

### button-disabled

`bg-muted` + `fg-disabled`(alpha 0.28).

### input / form field

```yaml
height: 44
border: 1px border-default
radius: radius-4              # 본 시안은 입력 라운드를 한 단계 작게(Wanted는 8)
bg:     bg-surface
fg:     fg-default
placeholder: fg-tertiary
focus:  1px border-brand + 2px outline offset
error:  1px fg-danger + helper-text fg-danger
disabled: bg-muted + fg-disabled
padding: 0 space-12
```

### badge

```yaml
height: 22
padding: 0 space-8
radius: radius-full
font: 12/600
variants:
  active:   bg-success-subtle + fg-success
  pending:  bg-warning-subtle + fg-warning
  inactive: bg-muted + fg-secondary
  danger:   bg-danger-subtle + fg-danger
```

### chip

```yaml
height: 28
padding: 0 space-12
radius: radius-full
bg: bg-muted
fg: fg-default
border: 0
font: 12/500
interactive: hover bg-subtle
```

### avatar

`radius-full` 32px 원. gradient 없음. 기본 fallback은 이니셜 텍스트 + `bg-inverse` 배경 + `fg-on-brand` 텍스트.

### icon-button

36×36, `radius-full`, 투명 배경, `fg-secondary`. Hover 시 `bg-muted` + `fg-strong`.

### icon

24×24 그리드, 2px stroke, rounded line caps + joins, monochrome, `currentColor` 상속. outline-first. 16/20/24/32 사이즈.

### login-layout / sidebar-nav / top-bar (admin) / stat-card / data-table

`DESIGN.md ## Components > Admin / Dashboard surface 컴포넌트 (synthesized)` 명세를 그대로 따른다. 시안의 색·radius 토큰만 본 시안 값으로 치환된다.

## Do's and Don'ts

**Do**

- 위계는 **size + weight 조합**으로 만든다. 색으로 위계를 만들지 않는다.
- product-facing 색은 시맨틱 alias로 호출하고, atomic neutral ramp 직접 호출은 새 alias 정의 시에만.
- 단일 primary 액션은 가장 진한 neutral(`bg-brand` = light 거의 검정 / dark 거의 흰)로 강조한다.
- 카드는 1px `border-subtle` 헤어라인. 그림자는 popover/dropdown/modal/toast 전용.
- 라운드는 `radius-4` ~ `radius-12` 위주, chip·avatar·icon-button만 `radius-full`.
- 본문은 `body1` 기본, 산문 단락은 `body1-read`.
- 카피는 **친근한 존댓말**(`-요`/`-어요`/`-아요`) + 동사형 버튼 라벨.
- 다크 모드는 light의 alpha 구조를 그대로 반전한다 — neutral 채도 0 정책 유지.
- 강조가 약하다고 느껴지면 **weight 또는 underline**으로 보강한다. 색 강조는 본 시안에서 사용하지 않는다.

**Don't**

- **gradient를 어떤 surface에도 사용하지 않는다** — symbol, avatar, hero, CTA, 모든 곳에서 금지(`policy.gradient_locations: []`).
- 카드에 그림자를 적용하지 않는다 — 헤어라인 보더가 표준.
- 카피에 격식체(`-습니다`/`-십시오`), 챗봇 톤(`~해보세요!`, `여기를 눌러주세요`), 마케팅 과장을 사용하지 않는다.
- 6/10/14/18/22 같은 비-4의 배수 spacing·radius를 도입하지 않는다(Wanted의 button sm 6, lg 10 같은 로컬 예외도 본 시안에서 정규화).
- 채도가 0이 아닌 brand hue를 새로 도입하지 않는다 — 시그널 색(success/warning/danger)만 채도를 가진다.
- ALL-CAPS, Title Case In Buttons를 사용하지 않는다.
- UI 라벨/리스트 아이템 끝에 마침표를 찍지 않는다.
- 텍스처·노이즈·glassy 효과(backdrop-blur)를 표면에 사용하지 않는다.
- 2px 장식 보더, 컬러 left-rail accent, color-shifted variant rim을 사용하지 않는다.

## Responsive Behavior

표준 mobile-first 패턴. 본 시안은 admin/도구 surface가 1차 대상이므로 데스크톱 max-content-width 1280를 권장한다.

### Breakpoints

| Name | Width | Columns | Gutter |
|---|---|---|---|
| Mobile | ≤ 640 | 4 | 16 |
| Tablet | 641–1023 | 8 | 24 |
| Desktop | ≥ 1024 | 12 | 24 |

### Touch Targets

모든 인터랙티브 표면은 최소 44×44px hit area를 보장한다. `input`은 44px height, button md(40)/sm(32)는 padding으로 hit area를 보장한다.

## Known Gaps

- **wide data-table fade-edge 정책** — 본 시안은 `policy.gradient_locations: []` 전면 금지로, fade-edge gradient mask는 도입하지 않는다. `DESIGN.md ### data-table > #### Wide Table Cases`의 Case C/D 채택 시 스크롤 가능 시각 단서는 **sticky 컬럼 경계 1px `{colors.border-strong}` + 우측 inset shadow-1**(우측 가장자리 4px inset)로 대체한다. 둘 다 평면 표면 정책에 정합.
- **brand 표현 한계** — 채도 0 정책 때문에 카테고리 색 코딩(예: 매장별 컬러 태그)이 어렵다. 그런 요구가 있으면 시그널 색 4종(success/warning/danger + 1)을 카테고리로 전용하거나, fork해서 brand hue를 도입한다.
- **마케팅 표면 미지원** — header/footer/hero-banner/job-card는 정의하지 않았다. 본 시안은 admin/도구 surface 1차. 마케팅이 필요한 프로젝트는 다른 시안을 선택한다.
- **OKLCH 변환** — 본 시안의 OKLCH는 sRGB → OKLab 표준 변환이며 ±0.002 lightness/chroma 오차가 있을 수 있다.

## References

본 시안은 self-contained 합성 catalog로 외부 SSOT 없음. neutral-anchored minimal admin UI의 일반적인 관례(시스템 폰트 사용, alpha multiplier 텍스트 위계, 평면 표면, 헤어라인 보더)를 종합했다.

## CSS Variables

`docs/admin-fe-preview.html` 및 다운스트림 프로젝트가 호출할 CSS 변수.

```css
:root[data-design="minimal-mono"][data-theme="light"] {
  --bg-canvas:        oklch(1 0 0);
  --bg-surface:       oklch(1 0 0);
  --bg-subtle:        oklch(0.975 0 0);
  --bg-muted:         oklch(0.955 0 0);
  --bg-elevated:      oklch(1 0 0);
  --bg-inverse:       oklch(0.145 0 0);
  --bg-brand:         oklch(0.145 0 0);
  --bg-brand-subtle:  oklch(0.940 0 0);
  --bg-danger-subtle: oklch(0.965 0.020 18);
  --bg-success-subtle:oklch(0.965 0.025 152);
  --bg-warning-subtle:oklch(0.965 0.025 81);

  --fg-strong:    oklch(0.145 0 0);
  --fg-default:   oklch(0.145 0 0 / 0.88);
  --fg-secondary: oklch(0.145 0 0 / 0.60);
  --fg-tertiary:  oklch(0.145 0 0 / 0.42);
  --fg-disabled:  oklch(0.145 0 0 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.145 0 0);
  --fg-success:   oklch(0.520 0.180 144);
  --fg-warning:   oklch(0.580 0.140 56);
  --fg-danger:    oklch(0.540 0.200 27);

  --border-subtle:  oklch(0.145 0 0 / 0.08);
  --border-default: oklch(0.145 0 0 / 0.20);
  --border-strong:  oklch(0.145 0 0 / 0.32);
  --border-brand:   oklch(0.145 0 0);

  /* Spacing (theme-invariant) */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded (theme-invariant — 표준 ladder만, catalog-only 추가 없음) */
  --radius-2: 2px;   --radius-4: 4px;   --radius-8: 8px;
  --radius-12: 12px; --radius-16: 16px; --radius-full: 9999px;

  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.04);
  --shadow-2:   0 4px 8px oklch(0 0 0 / 0.06);
  --shadow-pop: 0 8px 24px oklch(0 0 0 / 0.10);
}

:root[data-design="minimal-mono"][data-theme="dark"] {
  --bg-canvas:        oklch(0.145 0 0);
  --bg-surface:       oklch(0.175 0 0);
  --bg-subtle:        oklch(0.125 0 0);
  --bg-muted:         oklch(0.205 0 0);
  --bg-elevated:      oklch(0.235 0 0);
  --bg-inverse:       oklch(1 0 0);
  --bg-brand:         oklch(0.940 0 0);
  --bg-brand-subtle:  oklch(0.235 0 0);
  --bg-danger-subtle: oklch(0.298 0.10 22 / 0.32);
  --bg-success-subtle:oklch(0.298 0.10 144 / 0.28);
  --bg-warning-subtle:oklch(0.298 0.10 56 / 0.32);

  --fg-strong:    oklch(1 0 0);
  --fg-default:   oklch(1 0 0 / 0.88);
  --fg-secondary: oklch(1 0 0 / 0.60);
  --fg-tertiary:  oklch(1 0 0 / 0.42);
  --fg-disabled:  oklch(1 0 0 / 0.28);
  --fg-on-brand:  oklch(0.145 0 0);
  --fg-brand:     oklch(1 0 0);
  --fg-success:   oklch(0.740 0.165 144);                       /* synthesized */
  --fg-warning:   oklch(0.770 0.150 64);                        /* synthesized */
  --fg-danger:    oklch(0.720 0.215 27);                        /* synthesized */

  --border-subtle:  oklch(1 0 0 / 0.08);
  --border-default: oklch(1 0 0 / 0.20);
  --border-strong:  oklch(1 0 0 / 0.32);
  --border-brand:   oklch(1 0 0);

  /* spacing/radius는 light와 동일 — 상속 */

  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.20);
  --shadow-2:   0 4px 8px oklch(0 0 0 / 0.32);
  --shadow-pop: 0 8px 24px oklch(0 0 0 / 0.48);
}
```
