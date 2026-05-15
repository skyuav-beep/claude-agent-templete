---
name: "[프로젝트/시스템 이름]"
slug: "[kebab-case-slug]"
category: "[etc | finance | productivity | enterprise | content | etc]"
last_updated: "YYYY-MM-DD"
sources: []
related_services: []
lang: ko
logo: "/logos/[slug].png"
policy:
  shadow_on_cards: false        # true | false
  gradient_locations: []         # ["symbol", "avatar", "thumbnail", "hero"] 등
  copy_tone: "ko-friendly"       # ko-friendly | ko-formal | en-sentence
  dark_mode: "supported"         # supported | light-only | dark-only
  non_4_spacing: false           # true | false
---

# [프로젝트 이름] — design.md

> [한 문단 요약 — 시스템의 정체성, 사용 표면, 시각 톤]

본 시안은 `designs/_alias-contract.md` 계약을 준수한다.

## Brand & Style

[브랜드 무드, 시그너처 시각 요소, 색·타이포 무게중심]

## Colors

### Brand

```yaml
brand-primary:   [hex 또는 oklch]
brand-secondary: [...]
```

### Semantic alias — Light

```yaml
# Background
bg-canvas:         [...]
bg-surface:        [...]
bg-subtle:         [...]
bg-muted:          [...]
bg-elevated:       [...]
bg-inverse:        [...]
bg-brand:          [...]
bg-brand-subtle:   [...]
bg-success-subtle: [...]
bg-warning-subtle: [...]
bg-danger-subtle:  [...]

# Foreground
fg-strong:    [...]
fg-default:   [...]
fg-secondary: [...]
fg-tertiary:  [...]
fg-disabled:  [...]
fg-on-brand:  [...]
fg-brand:     [...]
fg-success:   [...]
fg-warning:   [...]
fg-danger:    [...]

# Borders
border-subtle:  [...]
border-default: [...]
border-strong:  [...]
border-brand:   [...]
```

### Semantic alias — Dark

```yaml
# (dark_mode: supported 인 경우만 정의)
# 위와 동일 키 세트, 다크 캔버스 기준 값
```

## Typography

### Type ramp

```yaml
display1:    [size/weight/line-height/letter-spacing]
display2:    [...]
display3:    [...]
title1:      [...]
title2:      [...]
title3:      [...]
label1:      [...]
label2:      [...]
body1:       [...]
body1-read:  [...]
body2:       [...]
caption1:    [...]
```

### 서체 선택

[primary face, fallback chain, weight 범위]

## Spacing

```yaml
space-4: 4    space-8: 8    space-12: 12   space-16: 16
space-20: 20  space-24: 24  space-32: 32   space-40: 40
space-48: 48  space-56: 56  space-64: 64   space-80: 80
space-96: 96  space-128: 128
```

## Rounded

```yaml
radius-2:    2
radius-4:    4
radius-8:    8
radius-12:   12
radius-16:   16
radius-full: 9999
```

## Elevation & Depth

[그림자 정책 — 카드 허용 여부, popover/modal 만 허용 여부]

```yaml
shadow-1: [...]
shadow-2: [...]
shadow-pop: [...]
```

## Components

### button

[sm/md/lg/xl 사이즈, height·radius·font]

### button-primary
### button-secondary
### button-tertiary
### button-ghost
### button-danger
### button-disabled

### input / form field

### badge

### chip

### avatar

### icon-button

### icon

### (선택) sidebar-nav, top-bar, stat-card, data-table, login-layout — admin 표면이 필요하면 정의

## Do's and Don'ts

**Do**

- [본 시안의 권장 패턴]

**Don't**

- [본 시안의 금지 패턴]

## Responsive Behavior

[breakpoint, touch target, collapsing 전략]

## Known Gaps

[정의되지 않은 영역, 합성한 alias, 외부 의존성]

## References

[출처 URL 목록 — frontmatter sources와 일치]
