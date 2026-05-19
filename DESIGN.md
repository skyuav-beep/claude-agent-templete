---
name: 원티드
slug: wanted
category: etc
last_updated: "2026-05-19"
sources:
  - https://api.anthropic.com/v1/design/h/j7_orggLzbQ43g24R8OfYA
  - https://www.wanted.co.kr
  - https://wanted-sans.github.io
  - https://github.com/wanteddev/wanted-sans
  - https://github.com/wanteddev/wanted-icons
  - https://github.com/orioncactus/pretendard
related_services: []
lang: ko
logo: /logos/wanted.png
policy:
  shadow_on_cards: false
  gradient_locations: ["symbol", "avatar", "thumbnail", "hero"]
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
---

# 원티드 (Wanted) — design.md

> **외부 인용 의존성 정책**: 본 문서의 `[src:N]` 인용은 frontmatter `sources` 항목(예: `https://api.anthropic.com/v1/design/...`)을 가리키는 reference 표기다. 본 카탈로그의 토큰·컴포넌트·Do-Don't 정의는 self-contained로 작성되어 있어 인용 출처가 오프라인이거나 만료되어도 본 문서만으로 디자인 시스템을 운영할 수 있다. 외부 URL 재방문은 SSOT 번들 갱신·신규 컴포넌트 추가·인용 출처 검증이 필요한 경우에만 수행한다. 운영 메타 가이드는 `docs/design-guidelines.md` 참조.

> 원티드랩이 운영하는 한국 1위 채용·커리어 플랫폼. `wanted.co.kr` 잡 마켓플레이스, 채용담당자용 Wanted Talent 대시보드, 프리미엄 커리어 코칭 구독 Wanted Plus, 후보자/리크루터용 iOS/Android 앱을 단일 디자인 시스템 위에 얹는다 [src:1]. 본 문서는 Wanted Design System 핸드오프 번들(`wanted-design-system/` 익스포트 — `README.md`, `colors_and_type.css`, 14개 preview 카드, `ui_kits/wanted-web/` 마켓플레이스 재구성)을 1차 출처로 합성한 결과이며, 공개된 wanted.co.kr 마케팅 surface, Wanted Sans 오픈소스 레포(wanteddev/wanted-sans), Pretendard JP, wanted-icons 패키지를 보조 출처로 사용했다.

## Brand & Style

원티드는 한국 디자인-엔지니어링 씬에서 **정밀 스케일 토큰 시스템 + 자체 브랜드 서체 + 시그너처 그라디언트 로고**의 조합으로 알려진다 [src:1]. Figma 공개 미러("Wanted Design System (Community)")는 14-step gray + 19-step cool-neutral + 11-step hue ramp의 dual-neutral 구조를 ship하며, `Wanted Sans` (Wanted + 산돌 공동 제작 오픈소스 OFL 서체)를 display 표면에서 사용한다 [src:1][src:3]. 시스템의 가장 인지 가능한 마크는 **blue → magenta → orange** 3-stop 그라디언트로 그려진 심볼이며, 이 그라디언트는 심볼·아바타·잡카드 썸네일 placeholder에만 적용되고 CTA·헤더·풀-블리드 표면에는 적용되지 않는다 [src:1].

전체 무드는 **clean, generous, neutral-anchored** — Toss·Naver와 결이 가깝고 splashy한 서양 채용 브랜드와는 거리가 있다 [src:1]. 색은 절제되어 사용되고 타이포가 위계의 대부분을 짊어진다. 표면은 흰 캔버스(light) 또는 `oklch(0.148 0.004 277)` 다크 캔버스(dark)로 평면화되며, 텍스처·노이즈·전면 사진은 chrome에 사용되지 않는다 [src:1]. 카드는 기본적으로 그림자 없이 1px `border-subtle` 헤어라인이 구조를 짊어지고, 그림자는 popover·dropdown·modal 같은 elevated surface에서만 등장한다 [src:1].

대상 사용자는 후보자(구직자)와 리크루터 양쪽이며, 시스템은 마케팅 사이트·잡 마켓플레이스·리크루터 대시보드·네이티브 앱을 동일한 디자인 시스템으로 횡단한다 [src:1]. 본 문서는 잡 마켓플레이스(`wanted.co.kr` candidate-side) surface를 1차 관찰 대상으로 한다 — SSOT 번들의 `ui_kits/wanted-web/`이 이 surface를 1:1 재구성하기 때문이다 [src:1].

Voice는 **친근한 2인칭 + 부드러운 존댓말**로 요약된다 [src:1]. 사무어조와 격식 호칭은 회피되고, 종결어미는 격식 `-습니다`보다 따뜻한 `-요`/`-어요`/`-아요`를 표준으로 한다 — "이력서를 등록해 보세요", "받은 제안이 없어요", "지원이 완료되었어요" 같은 톤이 시스템 카피의 시그너처다 [src:1]. 버튼은 동사 — "지원하기", "저장하기", "시작하기", "둘러보기" — 가 라벨 형태이며 명사·디렉티브("여기를 눌러주세요")는 표준이 아니다 [src:1]. 본 catalog 메타 문서는 한국어 평서체(`-다`)로 기술하며, 원티드의 존댓말 정책은 product surface 카피에 한해 적용되는 규칙임을 분리해 둔다.

## Colors

원본 hex는 SSOT 번들 `colors_and_type.css`에 정의되어 있으며, 본 문서는 OKLCH로 변환해 표기한다 [src:1]. 시스템의 구조적 특징은 두 가지다 — (1) **dual neutral ramp** (`gray-*` 14-step 단순 흑백 톤 + `neutral-*` 19-step cool blue-tinted 톤이 별도 운영됨), (2) **alpha multiplier로 텍스트 위계를 합성** (별도 gray hex를 정의하는 대신 `neutral-825`/`neutral-875` 위에 13단계 알파를 곱해 라이트/다크 양쪽에서 일관된 "soft black/white" 톤을 만든다) [src:1].

### Brand

```yaml
blue-800:  oklch(0.563 0.232 257)   # core Wanted Blue (#0066FF), 단일 primary
blue-700:  oklch(0.607 0.225 257)   # hover step
blue-850:  oklch(0.529 0.220 258)
blue-900:  oklch(0.484 0.205 258)
blue-100:  oklch(0.954 0.022 250)   # --bg-brand-subtle
blue-50:   oklch(0.985 0.012 247)
blue-975:  oklch(0.149 0.069 257)   # dark theme --bg-brand-subtle
```

브랜드 primary는 `{colors.blue-800}` 단일 — 버튼, 링크, 포커스 링, 핵심 데이터에 사용된다 [src:1]. CTA 표면 외에는 배경으로 사용하지 않는다 — 채도 강조가 아니라 단일 strong stop 정책이다.

### Brand gradient (심볼 전용)

```yaml
gradient-stop-1: oklch(0.563 0.232 257)   # blue-800 (#0066FF)
gradient-stop-2: oklch(0.708 0.273 354)   # magenta (#FF53C0) — 핸드오프 README가 명시하는 mid-stop
gradient-stop-3: oklch(0.665 0.218 38)    # coral-600 (#FF5E00)
```

심볼 마크 자체 + 일부 아바타 circle + 일부 잡카드 썸네일 placeholder에만 적용된다 [src:1]. 마케팅 hero용 변형은 `0E1F3F → blue-800 → magenta`로 깊은 navy를 추가해 `linear-gradient(120deg, ...)`로 그려지지만, 카탈로그 토큰으로 노출된 것은 아니다 [src:1].

### Gray (14-step, single tint — 채도 0)

```yaml
gray-50:   oklch(0.971 0 0)
gray-100:  oklch(0.881 0 0)
gray-150:  oklch(0.808 0 0)
gray-200:  oklch(0.747 0 0)
gray-300:  oklch(0.681 0 0)
gray-400:  oklch(0.629 0 0)
gray-500:  oklch(0.555 0 0)
gray-600:  oklch(0.471 0 0)
gray-700:  oklch(0.382 0 0)
gray-800:  oklch(0.286 0 0)
gray-850:  oklch(0.258 0 0)
gray-900:  oklch(0.184 0 0)
gray-950:  oklch(0.155 0 0)
gray-1000: oklch(0.110 0 0)
```

`gray-*` 패밀리는 채도 0의 단순 흑백 톤이며, 시스템 토큰의 baseline이 아니라 utility용이다. UI 표면 색은 거의 항상 `neutral-*` 패밀리에서 호출된다 [src:1].

### Neutral (19-step, cool blue-tinted — 워크호스 패밀리)

```yaml
neutral-50:  oklch(0.972 0.002 286)
neutral-75:  oklch(0.961 0.002 286)
neutral-100: oklch(0.929 0.003 286)
neutral-150: oklch(0.896 0.005 270)
neutral-200: oklch(0.876 0.006 269)
neutral-300: oklch(0.792 0.009 272)
neutral-400: oklch(0.728 0.013 273)
neutral-500: oklch(0.659 0.015 273)
neutral-600: oklch(0.601 0.015 273)
neutral-700: oklch(0.521 0.018 273)   # text-secondary 앵커
neutral-750: oklch(0.438 0.018 273)
neutral-800: oklch(0.357 0.013 274)
neutral-825: oklch(0.298 0.010 273)   # alpha-text 베이스 (light)
neutral-850: oklch(0.281 0.011 273)
neutral-875: oklch(0.259 0.010 273)   # body text 앵커
neutral-900: oklch(0.237 0.008 273)
neutral-925: oklch(0.196 0.008 273)
neutral-950: oklch(0.166 0.005 271)
neutral-960: oklch(0.148 0.004 277)   # 다크 캔버스
neutral-970: oklch(0.135 0.002 286)
neutral-980: oklch(0.108 0.002 286)
```

`neutral-700` (`oklch(0.521 0.018 273)`)이 `border-subtle`/`border-default`/`border-strong`의 알파 베이스이며, `neutral-825` (`oklch(0.298 0.010 273)`)가 `fg-secondary`/`fg-tertiary`/`fg-disabled`의 알파 베이스, `neutral-875` (`oklch(0.259 0.010 273)`)가 `fg-default`(body)의 알파 베이스다 [src:1]. text와 border가 서로 다른 neutral 단계에서 알파를 곱하는 구조이므로, 토큰 정의 시 두 베이스를 혼동하지 않도록 분리해야 한다.

### Semantic signal (red / green / orange)

```yaml
red-700:    oklch(0.546 0.220 27)    # --fg-danger
red-600:    oklch(0.643 0.231 27)
red-100:    oklch(0.951 0.018 18)    # --bg-danger-subtle (#FEECEC)
red-200:    oklch(0.901 0.044 22)
green-600:  oklch(0.673 0.211 144)   # --fg-success
green-100:  oklch(0.968 0.052 154)   # --bg-success-subtle (#D9FFE6)
orange-700: oklch(0.625 0.148 56)    # --fg-warning
orange-600: oklch(0.733 0.179 56)
orange-100: oklch(0.967 0.030 81)    # --bg-warning-subtle (#FEF4E6)
coral-600:  oklch(0.665 0.218 38)    # brand gradient end-stop
pink-600:   oklch(0.673 0.279 339)   # brand gradient mid (atomic value; README magenta는 약간 다름)
```

이 외 lime/cyan/sky/violet/purple 패밀리도 11-step ramp로 ship되며, hover·select·일러스트 accent에 사용된다 [src:1]. 본 카탈로그는 코어 패밀리만 surface하고 나머지는 SSOT `colors_and_type.css`를 참조한다.

### Alpha 스케일 — 텍스트 oncoloring

```yaml
alpha-5:  0.05
alpha-8:  0.08
alpha-12: 0.12
alpha-16: 0.16
alpha-22: 0.22
alpha-28: 0.28
alpha-35: 0.35
alpha-43: 0.43
alpha-52: 0.52
alpha-61: 0.61
alpha-74: 0.74
alpha-88: 0.88
alpha-97: 0.97
```

13단계 알파 ladder. Light 테마는 `oklch(0.259 0.010 273)` (= neutral-875) 위에, dark 테마는 `oklch(1 0 0)` 위에 동일한 스케일을 곱한다 — 한 베이스에서 13단계 강도를 만들어내는 구조다 [src:1].

### Semantic alias — Light

```yaml
# Background
bg-canvas:         oklch(1 0 0)
bg-surface:        oklch(1 0 0)
bg-subtle:         oklch(0.972 0.002 286)    # neutral-50, page bg
bg-muted:          oklch(0.961 0.002 286)    # neutral-75, hover fill
bg-elevated:       oklch(1 0 0)              # dialog/popover
bg-inverse:        oklch(0.148 0.004 277)    # neutral-960
bg-brand:          oklch(0.563 0.232 257)    # blue-800
bg-brand-subtle:   oklch(0.954 0.022 250)    # blue-100
bg-danger-subtle:  oklch(0.951 0.018 18)
bg-success-subtle: oklch(0.968 0.052 154)
bg-warning-subtle: oklch(0.967 0.030 81)

# Foreground (alpha multiplier on neutral-825 / neutral-875)
fg-strong:         oklch(0.148 0.004 277)              # @ alpha 1 (= neutral-960)
fg-default:        oklch(0.259 0.010 273 / 0.88)       # body
fg-secondary:      oklch(0.298 0.010 273 / 0.61)       # labels, captions
fg-tertiary:       oklch(0.298 0.010 273 / 0.43)       # placeholder
fg-disabled:       oklch(0.298 0.010 273 / 0.28)
fg-on-brand:       oklch(1 0 0)
fg-brand:          oklch(0.563 0.232 257)
fg-link:           oklch(0.563 0.232 257)
fg-danger:         oklch(0.546 0.220 27)
fg-success:        oklch(0.673 0.211 144)
fg-warning:        oklch(0.625 0.148 56)

# Borders
border-subtle:     oklch(0.521 0.018 273 / 0.08)
border-default:    oklch(0.521 0.018 273 / 0.22)
border-strong:     oklch(0.521 0.018 273 / 0.35)
border-inverse:    oklch(1 0 0 / 0.16)
border-brand:      oklch(0.563 0.232 257)
```

### Semantic alias — Dark

```yaml
# Background
bg-canvas:        oklch(0.148 0.004 277)      # neutral-960
bg-surface:       oklch(0.166 0.005 271)      # neutral-950
bg-subtle:        oklch(0.135 0.002 286)      # neutral-970
bg-muted:         oklch(0.196 0.008 273)      # neutral-925
bg-elevated:      oklch(0.237 0.008 273)      # neutral-900
bg-inverse:       oklch(1 0 0)
bg-brand-subtle:  oklch(0.149 0.069 257)      # blue-975
bg-danger-subtle:  oklch(0.298 0.10 22 / 0.32)    # synthesized for dark contrast
bg-success-subtle: oklch(0.298 0.10 144 / 0.28)   # synthesized
bg-warning-subtle: oklch(0.298 0.10 56 / 0.32)    # synthesized

# Foreground (alpha on white in dark theme)
fg-strong:        oklch(1 0 0)
fg-default:       oklch(1 0 0 / 0.88)
fg-secondary:     oklch(1 0 0 / 0.61)
fg-tertiary:      oklch(1 0 0 / 0.43)
fg-disabled:      oklch(1 0 0 / 0.28)
fg-on-brand:      oklch(1 0 0)
fg-brand:         oklch(0.715 0.155 255)      # blue-400 (brightened from blue-800; synthesized)
fg-danger:        oklch(0.715 0.220 27)       # synthesized (red @ ↑ lightness)
fg-success:       oklch(0.760 0.180 144)      # synthesized (green @ ↑ lightness)
fg-warning:       oklch(0.778 0.158 64)       # synthesized (orange @ ↑ lightness)

# Borders
border-subtle:    oklch(1 0 0 / 0.08)
border-default:   oklch(1 0 0 / 0.22)
border-strong:    oklch(1 0 0 / 0.35)
```

다크 모드는 light 모드의 alpha multiplier 구조를 그대로 유지한다 — text 알파 베이스가 `neutral-825`/`neutral-875` → `oklch(1 0 0)`(흰색)로 뒤집힐 뿐이다 [src:1]. SSOT가 surface한 토큰은 위 표의 핵심 alias(background canvas/surface/subtle/muted/elevated/inverse/brand-subtle, foreground strong/default/secondary/tertiary/disabled/on-brand, border subtle/default/strong)이며, `bg-danger/success/warning-subtle`과 `fg-brand/danger/success/warning`은 본 카탈로그의 preview 구현을 위해 dark 환경에서 적정 대비를 갖도록 **합성(synthesized)**한 값이다 — light 모드 같은 시맨틱 alias가 dark에서 보이지 않으면 product surface 구현이 막히기 때문에, SSOT 빈자리를 명시적 synthesized 값으로 메웠다. 시맨틱 alias의 의미(fg-default = 본문, fg-secondary = label/caption, fg-tertiary = placeholder, fg-disabled = disabled)는 양 테마에서 동일하다.

## Typography

본문/UI 디폴트 서체는 **Pretendard JP** — 한국어 우선 variable 서체로 CJK + Latin 메트릭이 모두 우수하다 [src:1][src:4]. Display 표면(대형 헤드라인, 마케팅 커버)에는 **Wanted Sans** (Wanted + 산돌 공동 제작 오픈소스 OFL 서체)가 사용된다 [src:1][src:3].

```yaml
font-sans: >
  "Pretendard JP", "Pretendard Variable", Pretendard,
  -apple-system, BlinkMacSystemFont, system-ui,
  "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic",
  "Helvetica Neue", Arial, sans-serif

font-display: >
  "Wanted Sans Variable", "Wanted Sans", "Pretendard JP",
  "Pretendard Variable", system-ui, sans-serif

font-mono: >
  "SF Mono", ui-monospace, "JetBrains Mono",
  Menlo, Consolas, "Courier New", monospace
```

`body` font-feature-settings는 `"ss20"`, `"calt"`, `"kern"`이 기본 활성화되며, `-webkit-font-smoothing: antialiased`도 함께 적용된다 [src:1].

### Type ramp (7 hierarchy × 18 named styles — `colors_and_type.css` 정의 그대로)

```yaml
# Display (3)
display1:    { size: 56, line-height: 1.286, tracking: -0.0319em, weight: 700 }
display2:    { size: 40, line-height: 1.300, tracking: -0.0282em, weight: 700 }
display3:    { size: 36, line-height: 1.334, tracking: -0.0270em, weight: 700 }
# Title (3)
title1:      { size: 32, line-height: 1.375, tracking: -0.0253em, weight: 700 }
title2:      { size: 28, line-height: 1.358, tracking: -0.0236em, weight: 700 }
title3:      { size: 24, line-height: 1.334, tracking: -0.0230em, weight: 700 }
# Heading (2)
heading1:    { size: 22, line-height: 1.364, tracking: -0.0194em, weight: 700 }
heading2:    { size: 20, line-height: 1.400, tracking: -0.0120em, weight: 700 }
# Headline (2)
headline1:   { size: 18, line-height: 1.445, tracking: -0.0020em, weight: 600 }
headline2:   { size: 17, line-height: 1.412, tracking:  0,        weight: 600 }
# Body (2 × default/read)
body1:       { size: 16, line-height: 1.500, tracking: 0.0057em,  weight: 500 }
body1-read:  { size: 16, line-height: 1.625, tracking: 0.0057em,  weight: 500 }
body2:       { size: 15, line-height: 1.467, tracking: 0.0096em,  weight: 500 }
body2-read:  { size: 15, line-height: 1.600, tracking: 0.0096em,  weight: 500 }
# Label (2)
label1:      { size: 14, line-height: 1.429, tracking: 0.0145em,  weight: 500 }
label1-read: { size: 14, line-height: 1.571, tracking: 0.0145em,  weight: 500 }
label2:      { size: 13, line-height: 1.385, tracking: 0.0194em,  weight: 500 }
# Caption (2)
caption1:    { size: 12, line-height: 1.334, tracking: 0.0252em,  weight: 500 }
caption2:    { size: 11, line-height: 1.273, tracking: 0.0311em,  weight: 500 }
```

총 18 styles. 시스템의 두 가지 시그너처 — **(1) 17px 이상 모든 스타일에 네거티브 트래킹** (Display 1이 -3.19%로 가장 타이트, Heading 2가 -1.20%으로 가장 느슨), **(2) Body 이하는 0~positive 트래킹** (Body 1이 +0.57%, Caption 2가 +3.11%) — 캡션 크기에서 가독성을 보존하려는 의도다 [src:1].

### Two reading densities

`body1`/`body2`/`label1`은 각각 **default**(1.5/1.467/1.429)와 **read**(1.625/1.600/1.571) 두 line-height를 갖는다 [src:1]. 산문 단락(잡 디테일 본문, 마케팅 long-form)은 `{typography.body1-read}`를 사용하고, UI 표면(카드 본문, 라벨)은 기본 `body1`을 사용한다.

### HTML 디폴트 매핑

```yaml
h1 → title1     (32 / 700, tracking -0.0253em)
h2 → title2     (28 / 700, tracking -0.0236em)
h3 → title3     (24 / 700, tracking -0.0230em)
h4 → heading1   (22 / 700, tracking -0.0194em)
h5 → heading2   (20 / 700, tracking -0.0120em)
p  → body1-read (16 / 500, line-height 1.625)
small → caption1 (color: fg-secondary)
code, pre → font-mono, 14px
```

unstyled HTML이 그대로 reasonable한 디폴트를 갖도록 매핑되어 있다 [src:1].

### Wanted Sans

Wanted Sans는 오픈소스 (OFL 1.1) variable 서체로, 100~900 weight를 단일 파일로 ship한다 [src:3]. 한글 자형은 산돌과 공동 작업으로 그려졌으며, Pretendard 패밀리와 메트릭 호환성을 유지한다. **display 표면 전용**으로 권장되며, 본문 UI는 Pretendard JP가 표준이다 [src:1][src:3]. 번들의 `colors_and_type.css`는 두 서체를 모두 CDN으로 import한다 — Pretendard JP는 jsDelivr에서 dynamic-subset 변형, Wanted Sans는 webfontkit variable 변형 [src:1].

## Spacing

베이스 단위는 **4px**이며, 토큰 사다리는 0~128px 13단계로 정의된다 [src:1]:

```yaml
space-0:   0
space-2:   2
space-4:   4
space-8:   8
space-12:  12
space-16:  16
space-20:  20
space-24:  24
space-32:  32
space-40:  40
space-48:  48
space-64:  64
space-96:  96
space-128: 128
```

비-4의 배수(6, 10, 14, 18, 22)는 토큰에 존재하지 않는다 — discrete steps만 운영된다 [src:1]. 단 일부 컴포넌트는 SSOT preview에 명시된 ladder 외 값을 컴포넌트 로컬 padding으로 그대로 가져간다 (예: `{component.job-card}` body padding `14 16 16`, `{component.input}` 좌우 padding `14` — 모두 `colors_and_type.css` + components-* preview에서 verbatim) [src:1]. radius의 sm/lg 버튼 로컬값과 동일한 패턴이며, 새 컴포넌트를 추가할 때만 ladder 값을 사용하면 된다.

### Grid

| Surface | Columns | Gutter | Max content width |
| --- | --- | --- | --- |
| Mobile | 4 | 16 | — |
| Tablet | 8 | 24 | — |
| Desktop (marketing) | 12 | 24 | ~1080 |
| Desktop (dashboards) | 12 | 24 | ~1280 |

마케팅 표면은 보다 좁은 max-width(~1080)를 가지며, 대시보드는 ~1280으로 확장된다 [src:1]. `ui_kits/wanted-web/`는 1200을 잡고 desktop marketplace의 표준값으로 운영한다 [src:1].

### Vertical rhythm

마케팅 섹션 사이 **64–96px** 수직 간격이 표준 — 카드와 섹션은 generous한 vertical rhythm을 갖는다 [src:1]. `{component.job-card}` 그리드는 24px × 16px (row × col) gap으로 운영된다 [src:1].

## Rounded

라운드 토큰은 2~32px 8단계 + `full` 한 단계로 정의된다 [src:1]:

```yaml
radius-2:    2     # 미세 토큰
radius-4:    4     # checkbox
radius-8:    8     # 컴포넌트 디폴트 (버튼 md/lg, 카드, 입력)
radius-12:   12    # 카드, 디테일 로고 타일, 버튼 xl
radius-16:   16    # hero banner
radius-20:   20
radius-24:   24
radius-32:   32
radius-full: 9999  # pills (chip, filter-pill, toggle, avatar, icon button, search)
```

**대부분의 컴포넌트는 `{rounded.radius-8}` 또는 `{rounded.radius-12}`를 사용한다** [src:1]. Pills은 `{rounded.radius-full}`. 시스템은 **6px도 10px도 갖지 않는다** — 사다리는 discrete steps만 운영되며, "약간 둥근" 같은 임의값은 도입되지 않는다 [src:1].

버튼 라운드는 사이즈와 페어로 운영된다 — sm 6, md 8, lg 10, xl 12 [src:1]. (sm의 6은 컴포넌트 로컬값이며 글로벌 토큰은 아니다 — `components-buttons.html` preview 관찰값 [src:1].)

## Elevation & Depth

원티드는 평면이 기본이며 그림자는 elevated surface(popover, dropdown, modal, toast)에서만 등장한다 [src:1]. 카드 자체는 1px `{colors.border-subtle}` 헤어라인이 구조를 짊어진다 — 그림자가 카드 위계를 만들지 않는다 [src:1].

```yaml
shadow-1: >
  0 1px 2px oklch(0.155 0 0 / 0.06),
  0 1px 3px oklch(0 0 0 / 0.05)
  # 잡카드 로고 타일, 토글 노브
shadow-2: >
  0 2px 6px oklch(0.155 0 0 / 0.07),
  0 1px 2px oklch(0 0 0 / 0.06)
  # 디테일 로고 타일
shadow-3: >
  0 6px 16px oklch(0 0 0 / 0.08),
  0 2px 4px oklch(0.155 0 0 / 0.06)
  # 일반 elevated surface
shadow-4: >
  0 12px 32px oklch(0 0 0 / 0.12),
  0 4px 8px oklch(0.155 0 0 / 0.07)
  # 큰 elevated, 모달
shadow-pop: >
  0 8px 24px oklch(0 0 0 / 0.12)
  # popover, dropdown, modal
```

그림자 색은 `oklch(0.155 0 0)` 또는 순수 검정(`oklch(0 0 0)`) 베이스의 ~5–12% 알파로 통일된다 [src:1]. 두 톤이 함께 쌓이는 패턴(soft-tint + true-black)이 표준이며, navy-tinted 그림자(Toss 류)는 사용되지 않는다 — 단순 검정 + 흰 캔버스의 대비가 시그너처다 [src:1].

### Motion

```yaml
hover-transition: 100~150ms ease     # 빠르고 절제
press-overshoot: 없음
focus-ring:      2px blue-800 + 2px transparent offset
page-transition: ~200ms fade-in only
```

spring·bounce·parallax는 시스템 전반에서 사용되지 않는다 [src:1]. Hover는 darken(버튼) 또는 lighten(링크)이며, lift·scale은 잡 카드(translateY(-2px), 0.12s ease) 외에는 거의 등장하지 않는다 [src:1].

## Shapes

기하학은 **discrete radii + 평면 표면 + 헤어라인 보더**로 요약된다 [src:1]. 평면 흰 캔버스(또는 다크 캔버스) 위에 8~16px 라운드 카드/버튼을 얹고, chip·avatar·icon button·search·toggle에는 `{rounded.radius-full}`를 적용한다. **장식은 절제되고 색·타이포 위계가 카드 구조를 짊어진다** [src:1].

기본 보더는 **1px `{colors.border-subtle}` 헤어라인**이며 (rgba ~8%), 폼 입력·secondary 버튼은 1px `{colors.border-default}` (rgba ~22%)로 한 단계 강해진다 [src:1]. 포커스 상태는 1px `{colors.blue-800}` 보더 + 3px rgba blue glow(`oklch(0.563 0.232 257 / 0.16)` 부근)로 표현된다 [src:1]. 2px 장식용 보더, 컬러 left-rail accent 카드, color-shifted variant rim은 시스템 전반에서 사용되지 않는다 [src:1].

배경은 평면 색이 기본이며, 그라디언트는 (1) **심볼 마크 자체** (3-stop blue → magenta → coral), (2) **아바타 circle** 의 같은 3-stop, (3) **잡카드 썸네일 placeholder** (같은 3-stop 또는 다크 변형 `oklch(0.166 0.005 271) → oklch(0.357 0.013 274)`), (4) **마케팅 hero banner** (`120deg`, navy `oklch(0.183 0.044 256)` → `{colors.blue-800}` → magenta `oklch(0.708 0.273 354)`) — 이렇게 네 가지 문서화된 자리에만 등장한다 [src:1]. CTA·헤더·풀-블리드 본문 표면에는 그라디언트를 적용하지 않는다 [src:1].

**Iconography (wanted-icons 시스템)** [src:1][src:5] — 자체 아이콘 셋. **24×24 그리드**, **2px stroke**, **rounded line caps + joins**. 16/20/24/32 사이즈. outline-first 정책이며, filled 변형은 selected/active 탭 상태와 16px 미니 사이즈에만 사용된다. 기하는 원·둥근 사각형·single-curve arc로 구성되고, tapered stroke·아이콘 내부 gradient·아이콘 컬러는 금지된다 — 모든 아이콘은 monochrome이며 `currentColor`를 상속한다. SSOT 번들은 production용 wanted-icons npm 패키지의 stand-in으로 Lucide CDN을 link하며, Lucide의 24×24 + 2px outline + rounded caps 시스템이 Wanted와 거의 1:1로 일치한다 [src:1][src:5].

**No emoji policy** [src:1] — 원티드는 코어 제품 UI에서 이모지를 사용하지 않는다. 빈 상태·성과·상태 pill에서도 monochrome SVG 또는 평면 일러스트 자산으로 대체한다. CTA의 "→" 같은 화살표도 unicode가 아니라 SVG로 그려진다.

## Components

본 섹션은 SSOT의 14개 preview HTML 카드 + `ui_kits/wanted-web/` 마켓플레이스 재구성(`Header.jsx`, `Filters.jsx`, `JobCard.jsx`, `JobDetail.jsx`, `JobGrid.jsx`, `Footer.jsx`, `index.html`, `styles.css`)에서 직접 관찰한 컴포넌트 명세다 [src:1]. 토큰값(`{spacing.*}`, `{rounded.*}`, `{colors.*}`, `{typography.*}`)이 모두 surface되어 있으므로 prose에서 `{group.name}` 형태로 호출한다.

### button

원티드 Button은 **sm/md/lg/xl** 4단으로 운영되며 height·radius·label font가 사이즈와 함께 변한다 [src:1]:

| 사이즈 | height | radius | label |
|---|---|---|---|
| sm | 32 | 6 (컴포넌트 로컬) | 13/500 |
| md | 40 | `{rounded.radius-8}` | 14/600 |
| lg | 48 | 10 (컴포넌트 로컬) | 16/600 |
| xl | 56 | `{rounded.radius-12}` | 17/600 |

```tsx
<Button variant="primary" size="md">지원하기</Button>
<Button variant="ghost" size="md">더보기</Button>
```

### button-primary

`{colors.bg-brand}` (`oklch(0.563 0.232 257)`) 배경 + `{colors.fg-on-brand}` (흰 텍스트). 화면당 가장 중요한 단일 액션에 사용 [src:1]. Hover 시 `{colors.blue-900}` (`oklch(0.484 0.205 258)`)로 darken.

### button-secondary

투명 배경 + 1px `{colors.border-default}` 보더 + `{colors.fg-strong}` 텍스트. 같은 화면의 보조 액션 [src:1]. Hover 시 `{colors.bg-muted}` (`oklch(0.961 0.002 286)`) 배경 채움.

### button-tertiary

`{colors.neutral-75}` (`oklch(0.961 0.002 286)`) 배경 + `{colors.fg-strong}` 텍스트, 보더 없음. secondary보다도 약한 위계, "자세히 보기" 류의 inline action에 사용된다 [src:1].

### button-ghost

투명 배경 + `{colors.fg-brand}` 텍스트, 보더 없음. Hover 시 `{colors.bg-brand-subtle}` (`oklch(0.954 0.022 250)`) 배경 채움. 텍스트 링크에 가까운 약한 위계 [src:1].

### button-danger

`{colors.red-700}` (`oklch(0.546 0.220 27)`) 배경 + 흰 텍스트. 파괴적 액션 전용 [src:1].

### button-disabled

`{colors.neutral-100}` (`oklch(0.929 0.003 286)`) 배경 + `{colors.fg-disabled}` (alpha 0.28 텍스트). 부분 회색 처리 없이 컴포넌트 전체에 적용된다 [src:1].

### input / form field

```yaml
height: 44
border: 1px {colors.border-default}
radius: {rounded.radius-8}
padding: 0 14
font: 15/500
bg: {colors.bg-surface}
placeholder-color: {colors.fg-tertiary}
```

Focus 상태는 1px `{colors.blue-800}` 보더 + `0 0 0 3px oklch(0.563 0.232 257 / 0.16)` glow [src:1]. Error 상태는 1px `{colors.red-700}` 보더 + 아래쪽 `{colors.fg-danger}` 색의 12px/1.3 helper text. Disabled는 `{colors.neutral-75}` 배경 + `{colors.fg-disabled}` 텍스트 [src:1].

```tsx
<TextField
  label="이메일"
  placeholder="email@wanted.co.kr"
  helper="회사 이메일 권장"
/>
```

### checkbox

18×18 정사각, 1.5px `{colors.border-default}` 보더, `{rounded.radius-4}` (4px) [src:1]. Checked 상태는 `{colors.bg-brand}` 채움 + 흰 체크 SVG, border도 brand 색으로 전환된다.

### toggle

40×24 pill (`{rounded.radius-full}`). Off는 `{colors.neutral-150}` (`oklch(0.896 0.005 270)`), On은 `{colors.bg-brand}` [src:1]. 내부 노브는 20×20 흰 원, `{elevation.shadow-1}` 미세 그림자. left 2 → left 18 전환은 0.15s 트랜지션.

### chip (category selector)

```yaml
height: 34   # 8 padding-y + 13/500 font
radius: {rounded.radius-full}
padding: 8 14
font: 13/500
```

| 상태 | bg | fg | border |
| --- | --- | --- | --- |
| resting | `{colors.bg-surface}` | `{colors.fg-default}` | 1px `{colors.border-default}` |
| hover | `{colors.bg-muted}` | `{colors.fg-default}` | 1px `{colors.border-default}` |
| active (selected) | `{colors.fg-strong}` | white | `{colors.fg-strong}`, font-weight: 600 |
| brand | `{colors.bg-brand-subtle}` | `{colors.fg-brand}` | transparent, font-weight: 600 |

칩 active는 **invert-fill 패턴** — 채도 강조가 아니라 검정 배경 + 흰 텍스트로 명도 강조한다 [src:1].

### filter-pill

filter bar 안쪽 작은 칩 변형. resting은 chip과 동일하지만 padding이 `6 12`로 줄고, brand variant가 더 빈번하게 사용된다 (선택된 필터 노출용) [src:1].

### badge

22px height, `{rounded.radius-2}`~`{rounded.radius-4}` 사이 (관찰값 6px) — chip보다 작고 정보 밀도 높은 표면에 사용된다 [src:1]. 시맨틱 색에 매핑된 washed 배경 (예: `{colors.bg-danger-subtle}` + `{colors.fg-danger}`).

### header

```yaml
height: 60
bg: {colors.bg-surface}
border-bottom: 1px {colors.border-subtle}
position: sticky
z-index: 50
inner:
  max-width: 1200
  padding: 0 24
  gap: 28
```

좌측: `{component.logo}` + nav links + Pro 분리 표시 (`margin-left: 8, padding-left: 16, border-left: 1px border-subtle`) [src:1]. 우측: `{component.search}` + icon buttons + avatar.

### nav-link

`14/600` (`-0.01em` letter-spacing), `{colors.fg-default}` [src:1]. **Active 상태는 `{colors.fg-strong}` 색 + 하단 2px solid `{colors.fg-strong}` underline** (bottom: -22px 위치로 헤더 baseline에서 떨어진다). hover state는 별도 fill 없이 색만 약간 강해진다.

### search (header)

```yaml
height: 38
width: 240
bg: {colors.bg-subtle}      # neutral-50
radius: {rounded.radius-full}
padding: 0 14
gap: 6
font: 14/500
icon-color: {colors.fg-tertiary}
```

inline pill 형태 — bordered text field가 아니라 채워진 pill이다 [src:1].

### icon-button (header right)

```yaml
size: 36
radius: {rounded.radius-full}
bg: transparent
fg: {colors.fg-default}
hover-bg: {colors.bg-muted}
notification-dot:
  size: 6
  bg: {colors.red-700}
  position: top: 8, right: 9
```

알림 도트는 상단 우측에 6px 빨간 원으로 표시된다 [src:1].

### avatar

```yaml
size: 32
radius: {rounded.radius-full}
bg: 'linear-gradient(135deg, oklch(0.563 0.232 257) 0%, oklch(0.708 0.273 354) 50%, oklch(0.665 0.218 38) 100%)'
fg: oklch(1 0 0)
font: 12/700
```

브랜드 그라디언트가 적용되는 컴포넌트 — 심볼·잡카드 placeholder 외에 그라디언트가 정식 등장하는 컴포넌트는 avatar 하나다 [src:1].

### job-card

원티드의 **시그너처 컴포넌트**. 잡 마켓플레이스 그리드의 단위.

```yaml
card:
  bg: {colors.bg-surface}
  radius: {rounded.radius-8}
  overflow: hidden
  hover: 'translateY(-2px), 0.12s ease'

thumb:
  aspect-ratio: 16/12  # grid; preview 카드는 16/9
  radius: {rounded.radius-8}
  default-bg: brand gradient (blue-800 → magenta → coral-600)
  variant-dark:  'linear-gradient(135deg, neutral-950, neutral-800)'
  variant-light: {colors.bg-brand-subtle}

overlays:
  deadline-pill:
    position: top-left (10, 10)
    bg: oklch(0 0 0 / 0.55)
    fg: oklch(1 0 0)
    font: 11/600
    padding: 5 8
    radius: 6
    examples: 'D-3', '마감임박', 'NEW'
  save-button:
    position: top-right (8, 8)
    size: 28 or 32
    radius: {rounded.radius-full}
    bg: oklch(1 0 0 / 0.92)
    fg: {colors.fg-default}
    icon: bookmark (14px stroke)
  company-logo-tile:
    position: bottom-left (10, 10)
    size: 36
    radius: {rounded.radius-8}
    bg: oklch(1 0 0)
    shadow: {elevation.shadow-1}
    font: 14/700

body:
  padding: '12 4 0' (grid) | '14 16 16' (preview)
  gap: 4-6
  company:   { font: '12-13/500', color: fg-secondary, pattern: '{company} · {region}' }
  title:     { font: '15/600',   tracking: -0.01em, color: fg-strong }
  meta:      { font: '12/500',   color: fg-tertiary, pattern: '{경력} · {계약형태}' }
  payout:    { font: '13/600',   color: fg-brand,   pattern: '채용보상금 {₩,###}원' }
```

**채용보상금** 표시가 카드 우측 하단 `{colors.fg-brand}` 색으로 항상 노출되는 것이 Wanted 잡카드의 정체성이다 — 다른 채용 사이트와 구분되는 시그너처다 [src:1].

```tsx
<JobCard
  thumb="brand-gradient"
  deadline="D-3"
  company="원티드랩 · 서울 강남"
  title="시니어 프론트엔드 개발자"
  meta="경력 5-10년 · 정규직"
  payout={1500000}
/>
```

### job-detail-hero

잡 디테일 화면의 hero — aspect 16/8, `{rounded.radius-12}`, 좌측 하단에 56×56 회사 로고 타일(`{rounded.radius-12}`, `{elevation.shadow-2}`)이 anchored된다 [src:1]. 본문 영역은 max-width 920px, `0 24 120` padding으로 운영된다.

### hero-banner (마케팅)

```yaml
max-width: 1200
margin: 32 auto 24
height: 280
radius: {rounded.radius-16}
background: 'linear-gradient(120deg, oklch(0.183 0.044 256) 0%, oklch(0.563 0.232 257) 60%, oklch(0.708 0.273 354) 100%)'
padding: 36 40
fg: oklch(1 0 0)
content-align: flex-end (bottom-left)
```

- eyebrow: 13/600, tracking 0.04em, opacity 0.85
- title: 36/700/1.25, tracking -0.025em, max-width 580
- sub: 16/500/1.5, opacity 0.85, max-width 520
- cta: 흰 pill, fg-strong 텍스트, padding `12 22`, font 14/600 [src:1]

마케팅 hero는 **풀-블리드 그라디언트 + bottom-left 카피 + 흰색 pill CTA**의 패턴이 표준이다 [src:1]. 그라디언트 stop은 심볼 마크와 다르다 — navy를 prepend해 깊이를 만든다.

### filter-bar

```yaml
container:
  max-width: 1200
  padding: 0 24
  top-border: 1px {colors.border-subtle}
  vertical-padding: '12 0 16'
filter-pill (default):
  border: 1px {colors.border-default}
  bg: {colors.bg-surface}
  radius: {rounded.radius-full}
  padding: '6 12'
  font: 13/500
filter-pill (brand-active):
  bg: {colors.bg-brand-subtle}
  border: transparent
  fg: {colors.fg-brand}
  font-weight: 600
sort:
  position: right-aligned (margin-left: auto)
  item-font: 13/500
  resting-fg: {colors.fg-secondary}
  active-fg: {colors.fg-strong}, font-weight: 600
  divider: 1×10 {colors.border-default}
```

active filter는 brand-subtle 배경 + brand 텍스트로 표시되며, sort는 오른쪽 정렬 + bold-fg 강조로 위계를 만든다 [src:1].

### toast

`{colors.bg-inverse}` (light: `oklch(0.148 0.004 277)`) 배경 + 흰 라벨, `{rounded.radius-8}`~`{rounded.radius-12}`, `{elevation.shadow-pop}` [src:1]. 자동 dismiss 시간은 보통 4–5초.

```tsx
<Toast>지원이 완료되었어요</Toast>
```

### alert (inline)

`{colors.bg-{danger|success|warning}-subtle}` 배경 + 시맨틱 fg 색 + 좌측 아이콘 [src:1]. 인라인 알림이며 toast와 달리 dismiss 없이 페이지 흐름에 남는다.

### empty-state

```yaml
padding: 80 0
align: center
icon: 32px monochrome SVG or flat illustration (no emoji)
title: 700 18/1.3 {colors.fg-strong}
sub:   500 14/1.4 {colors.fg-secondary}
```

빈 상태 카피 패턴: "아직 받은 제안이 없어요" (alpha 88% body 톤, `-어요` 종결) [src:1].

### icon

wanted-icons system [src:1][src:5] — 24×24 그리드, 2px stroke, rounded line caps + joins, monochrome, `currentColor` 상속. outline-first; filled 변형은 active 탭과 16px 사이즈에 한정. 16/20/24/32 사이즈.

### Admin / Dashboard surface 컴포넌트 (synthesized)

아래 5종은 SSOT 번들에 직접 surface되지 않은 admin/dashboard 표면 컴포넌트로, 기존 토큰·atomic 컴포넌트(`button-*`, `input`, `checkbox`, `chip`, `badge`, `avatar`, `icon-button`)와 Brand & Style 정책(평면 표면 + 1px 헤어라인 + 단일 강조색 + 동일 카피 톤)을 조합해 합성한 명세다. 다운스트림 product가 admin FE를 신규로 만들 때 그대로 호출하거나 컴포넌트 로컬값만 미세 조정해 사용한다.

각 컴포넌트의 padding/row/gap 등 여백 토큰은 아래 `#### Admin Surface Density Cases` 4-케이스에서 한 가지를 화면 단위로 선택해 일괄 적용한다.

#### Admin Surface Density Cases

admin 표면(대시보드/KPI/리스트/상세) 전체에 일관된 여백을 적용하기 위한 밀도 케이스. 한 화면 안에서 두 케이스를 섞지 않는다(예: KPI는 표준인데 그 아래 테이블만 미니멈으로 축소 금지). 화면 단위 케이스 선택은 `templates/data-table-density.md §1 화면 컨텍스트`에 기록.

| 케이스 | content padding | card padding | KPI gap | KPI row | input/button height | data-table row | 적합 상황 |
|---|---|---|---|---|---|---|---|
| **A — 표준 (Spacious)** | `{spacing.space-32}` | `{spacing.space-24}` | `{spacing.space-16}` | 1열 4장 | 40 (md) | 56 (comfortable) | 데스크탑 운영(1440+), 일반 운영 |
| **B — 컴팩트 (Compact)** | `{spacing.space-24}` | `{spacing.space-16}` | `{spacing.space-12}` | 1열 4~6장 | 36 (md-compact) | 44 (compact) | 1280 해상도, 정보 밀도 우선 |
| **C — 미니멈 (Minimum)** | `{spacing.space-16}` | `{spacing.space-12}` | `{spacing.space-8}` | 1열 6~8장 | 32 (sm) | 40 (tight) | 1440+ 대형 모니터에 KPI 다량, 빽빽한 모니터링 |
| **D — 모니터링 (Monitor)** | `{spacing.space-8}` | `{spacing.space-8}` | `{spacing.space-8}` | 1열 8장+ | 32 (sm) | 36 (dense) | 24시간 모니터링/전광판/콜센터, 정보 최대화 |

운영 규칙:
- 모든 토큰은 4의 배수 ladder만 사용한다(6/10/14 같은 비-4 padding 금지). row 36은 컴팩트 한계, 그 아래(32/30)는 차단.
- 케이스 C/D에서 row 40 이하 채택 시 `{typography.body2}` → `{typography.label2}` 또는 `{typography.caption1}` 다운을 함께 적용해 시각 균형을 맞춘다.
- 케이스 D는 전광판/24시간 모니터링 표면 전용. 일반 운영 화면에 적용 시 hit-area·가독성 저하 차단.
- 카드 그림자 금지 정책은 그대로 — 케이스 변경이 그림자 도입을 허용하지 않는다.
- 케이스를 화면 단위로 결정한 뒤 `data-density` 속성(`spacious`/`compact`/`minimum`/`monitor`)을 root에 부여하면 모든 토큰이 일괄 적용되는 cascade를 host 앱이 정의한다.

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `toss-like` / `material-3` | A | 카드 padding 24 + row 56 표준 |
| `minimal-mono` | B | 미니멀 톤은 row 44 + content padding 24 |
| `linear-like` | **C** (디폴트) | compact 시그너처. Case D 채택 가능(모니터링 뷰) |

### login-layout

centered card 패턴. 마케팅 페이지가 아닌 standalone auth surface다.

```yaml
canvas:    {colors.bg-canvas}      # light: white, dark: oklch(0.148 0.004 277)
card:
  width:   400 (min)               # mobile <640은 width 100% - {spacing.space-32} 좌우 여백
  padding: {spacing.space-32}       # 32 32 32 32
  border:  1px {colors.border-subtle}
  radius:  {rounded.radius-12}
  bg:      {colors.bg-surface}
  shadow:  none                    # 카드 그림자 금지 정책 그대로
brand-block:
  logo:    24px symbol (ungradient flat) or 32px logotype + 24 margin-bottom
  title:   {typography.title2}     # "로그인", "어드민 로그인"
  sub:     {typography.body2} {colors.fg-secondary}
form:
  gap:     {spacing.space-16}
  fields:  {component.input} (44 height, full width)
  cta:     {component.button-primary} size=lg, full width
secondary:
  align:   center
  text:    {typography.body2} {colors.fg-secondary}
  link:    {component.button-ghost} inline (예: "비밀번호를 잊으셨나요?")
```

카피 패턴: 헤더는 격식 없는 단문(`로그인`, `다시 만나서 반가워요`), 에러는 `이메일 또는 비밀번호가 일치하지 않아요`, secondary 액션은 동사형(`비밀번호 찾기`, `회원가입`). admin 전용 표면이면 우측 상단에 환경 표시 chip(`{component.chip}` 변형, "운영"/"스테이징"/"개발")을 둘 수 있다.

### sidebar-nav

수직 네비게이션 컴포넌트. expand(240) / collapse(64) 두 폭만 운영한다.

```yaml
width:        240   # expanded
collapsed:    64    # icon-only
bg:           {colors.bg-surface}
border-right: 1px {colors.border-subtle}
padding:      {spacing.space-16} {spacing.space-12}
brand-area:
  height:     56
  padding:    0 {spacing.space-16}
  logo:       24px symbol + 8 gap + 16/700 wordmark (collapsed에서 logotype 숨김)
section-label:
  typography: {typography.caption1}  # 12/600
  color:      {colors.fg-tertiary}
  text-transform: none               # ALL-CAPS 금지
  margin:     {spacing.space-16} 0 {spacing.space-8}
nav-item:
  height:     40
  padding:    0 {spacing.space-12}
  radius:     {rounded.radius-8}
  gap:        {spacing.space-12}     # icon 20 + label
  typography: {typography.label1}    # 14/500
  color:      {colors.fg-default}
  hover:      bg {colors.bg-muted}
  active:
    bg:       {colors.bg-brand-subtle}
    color:    {colors.fg-brand}
    icon:     filled variant (16px 또는 20px)
    indicator: 없음              # 좌측 컬러 rail 금지 (Don't 정책)
nested-item:
  indent:     {spacing.space-16} (icon 빠지고 dot or thin guide line 1px {colors.border-subtle})
collapse-toggle:
  position:   하단 또는 brand-area 우측
  component:  {component.icon-button}
```

상태별 텍스트는 모두 동사/명사형 단문(`주문`, `정산`, `회원`). 격식체 또는 마침표 사용 금지. 알림 dot가 필요하면 nav-item 우측에 6px `{colors.bg-danger}` circle을 둔다(사이즈 텍스트는 `{component.badge}` 호출).

### top-bar (admin)

마케팅 `### header`와는 다른 admin 전용 chrome. 좌측 페이지 제목, 우측 user/notification.

```yaml
height:         56
bg:             {colors.bg-surface}
border-bottom:  1px {colors.border-subtle}
padding:        0 {spacing.space-24}
left-cluster:
  page-title:   {typography.title3}  # 18/700
  breadcrumb:   {typography.caption1} {colors.fg-secondary}
                separator: "/" 텍스트, 좌우 {spacing.space-8} 간격
right-cluster:
  gap:          {spacing.space-12}
  search:       optional, {component.search} max-width 320
  env-chip:     운영/스테이징/개발 식별 (운영=neutral, 스테이징={colors.bg-warning-subtle}, 개발={colors.bg-success-subtle})
  notification: {component.icon-button} + 우상단 6px {colors.bg-danger} dot
  avatar:       {component.avatar} 32px, 우측 끝
  user-menu:    avatar 클릭 시 popover dropdown ({elevation.shadow-pop})
```

좌측 사이드바와의 경계는 1px `{colors.border-subtle}` 한 라인만 사용한다. 그라디언트·그림자 사용 금지 — 평면 표면 정책 그대로다.

### stat-card (KPI)

대시보드 위쪽에 1열로 배치되는 숫자 강조 카드. 카드 그림자 금지 정책 유지.

```yaml
padding:      {spacing.space-24}
border:       1px {colors.border-subtle}
radius:       {rounded.radius-12}
bg:           {colors.bg-surface}
gap:          {spacing.space-8}     # 라벨 + 숫자 + delta 수직 간격
label:
  typography: {typography.caption1}  # 12/600
  color:      {colors.fg-secondary}
value:
  typography: {typography.display3}  # 32/700, negative tracking
  color:      {colors.fg-strong}
delta:
  typography: {typography.label2}    # 13/500
  positive:   {colors.fg-success}    # 합성 alias 사용
  negative:   {colors.fg-danger}
  neutral:    {colors.fg-secondary}
  prefix:     "▲" / "▼" 텍스트 금지 → 아이콘 12px {component.icon} arrow-up/down monochrome (currentColor 상속)
chart-slot:   optional, 카드 우측 또는 하단에 mini sparkline (단색 1px stroke, fill 없음)
```

같은 행에 4개를 평행 배치할 때 그리드 gap은 `{spacing.space-16}`. 모바일 collapse 시 1열 stack, 카드 padding은 `{spacing.space-16}`로 1단계 축소한다.

### data-table

admin의 워크호스 컴포넌트. 헤더 + 행 + sort + pagination 4가지 표면을 함께 명세한다.

```yaml
container:
  border:    1px {colors.border-subtle}
  radius:    {rounded.radius-8}
  bg:        {colors.bg-surface}
  overflow:  hidden                # rounded corner 유지
  shadow:    none
header-row:
  bg:        {colors.bg-muted}     # neutral-75 계열, 헤더 시각 분리
  height:    44
  padding:   0 {spacing.space-16}
  typography:{typography.caption1} {colors.fg-secondary}  # 12/600 ALL-CAPS 금지
  align:     left, 숫자 컬럼은 right
  sort:
    icon:    12px arrow-up-down monochrome (asc/desc/none 3-state)
    hover:   {colors.fg-strong}
body-row:
  height:
    comfortable: 56                # 디폴트
    compact:     44                # 데이터 밀도 높은 admin (체크박스 행)
  padding:   0 {spacing.space-16}
  border-top:1px {colors.border-subtle}
  bg:        {colors.bg-surface}
  hover:     {colors.bg-subtle}    # 매우 약한 highlight
  selected:  {colors.bg-brand-subtle}
  typography:{typography.body2}    # 14/500
checkbox-col:
  width:     44
  align:     center
  component: {component.checkbox}
status-cell:
  component: {component.badge} or {component.chip} (반경 full)
  variants:  active/pending/inactive — semantic alias 호출
action-cell:
  align:     right
  components:{component.button-tertiary} sm or {component.icon-button}
empty:
  use:       {component.empty-state} (테이블 container 내부에 padding 80 0)
pagination:
  position:  container 하단, 우측 정렬
  height:    52
  border-top:1px {colors.border-subtle}
  controls:
    info:    "1–20 / 320" {typography.caption1} {colors.fg-secondary}
    nav:     {component.button-ghost} sm × prev/next + page number {component.button-tertiary} sm
```

행 클릭으로 상세 진입하는 패턴을 쓸 때는 행 전체에 cursor:pointer + hover bg를 적용하고, 액션 셀의 버튼은 `event.stopPropagation()`로 분리한다. zebra striping(짝수행 배경 변화)은 사용하지 않는다 — 평면 표면 + 1px 라인이 행을 구분한다.

#### Wide Table Cases

위 명세는 표준 폭(컬럼 ≤8) 기준이다. 컬럼이 많아지거나 화면 폭이 부족할 때는 임의로 padding을 줄이지 않고 아래 4-케이스 매트릭스에서 한 가지를 선택해 합의한다. 요구사항 수집 양식은 `templates/data-table-density.md`.

| 케이스 | 컬럼 수 | row height | cell padding | sticky | 가로 스크롤 | 추가 정책 |
|---|---|---|---|---|---|---|
| **A — 표준** | ≤8 | 56 (comfortable) | `{spacing.space-16}` | 없음 | 없음 | 디폴트. `{typography.body2}` |
| **B — 컴팩트** | 9~12 | 44 (compact) | `{spacing.space-12}` | 없음 | 없음 | numeric 컬럼 right-align, checkbox-col 40으로 축소 가능 |
| **C — 와이드 + sticky** | 13~18 | 44 | `{spacing.space-12}` | 좌 1~2 + 우 액션 | 있음 | 헤더 row sticky, 좌/우 스크롤 affordance(시안별 분기, 아래 표 참조), 키보드 ←→ 스크롤 |
| **D — 초과밀도** | 19+ | 44 | `{spacing.space-12}` | 좌/우 + 헤더 | 있음 | column visibility toggle 필수, density toggle 사용자 노출, drag-reorder + resize 옵션, virtualization(행 30+), CSV export 항상 노출, 선택 상태 localStorage 저장 |

운영 규칙:

- cell padding을 `{spacing.space-8}` 이하로 내리지 않는다(hit area·가독성 위반). 비-4의 배수(6/10/14) 도입 금지.
- compact에서 row를 36 이하로 내리지 않는다.
- C/D 채택 시 좌측 sticky는 최소 한 컬럼(체크박스 또는 식별자)을 두어 가로 스크롤 중에도 행을 식별할 수 있어야 한다.
- C/D 채택 시 스크롤 가능 시각 단서를 반드시 둔다 — 시안별 정책은 아래 매트릭스 참조.

C/D 채택 시 시안별 스크롤 affordance 정책(`policy.gradient_locations`와 정합):

| 시안 | affordance 방식 | gradient_locations |
|---|---|---|
| `wanted` | sticky 컬럼 경계 1px `{colors.border-default}` 강조 | `["symbol", "avatar", "thumbnail", "hero"]` (fade-edge 미포함) |
| `minimal-mono` | sticky 컬럼 경계 1px `{colors.border-strong}` + 우측 inset shadow-1 4px | `[]` (전면 금지) |
| `toss-like` | **fade-edge 4px 좌/우 gradient mask** (`bg-canvas` → transparent) | `["hero", "table-fade-edge"]` |
| `material-3` | state-layer 8% brand alpha overlay 좌/우 4px 정적 | `[]` (전면 금지, M3 state layer로 대체) |
| `linear-like` | **fade-edge 4px 좌/우 gradient mask** (다크 캔버스 친화) | `["accent", "hero", "table-fade-edge"]` |

- 컬럼이 13개 이상이면 "다 보여주기" 대신 컬럼 가시성 토글 + 사용자 저장을 우선 검토한다(Case D 정책을 13~18 구간에도 선택적으로 적용 가능).

시안별 디폴트 매핑(`docs/admin-fe-design-guide.md ## 시안별 화면 조립 차이 ### 3. 리스트 페이지`와 정합):

| 시안 | 디폴트 케이스 | 비고 |
|---|---|---|
| `wanted` / `minimal-mono` | A | C/D 채택 시 fade-edge는 정책 합의 필요(gradient_locations 외 위치) |
| `toss-like` | A | shadow는 컨테이너 카드에만, 표 자체는 평면 유지 |
| `material-3` | A (row 52) | state-layer hover 유지, B/C/D 모두 가능 |
| `linear-like` | **B** (디폴트) | row 44 시그너처. ⌘K 컬럼 토글, ⌘\ side panel 권장 |

#### List Toolbar Cases

admin 리스트 페이지에서 검색·내보내기·페이지 크기 등 보조 컨트롤도 임의로 디자인하지 말고 아래 케이스 매트릭스에서 선택해 합의한다. 요구사항 수집 양식은 `templates/data-table-density.md`의 §9 List Toolbar.

**1) Search Clear (검색 입력 X 닫기)** — 검색 input 우측에 표시되는 clear indicator.

```yaml
slot:       input trailing (padding-right 36 확보)
hit-area:   20×20
icon:       14×14 stroke 1.5 close (X) — {component.icon}
color:      {colors.fg-tertiary}
hover:      {colors.fg-default}
focus:      ring 2px {colors.border-brand}
component:  {component.icon-button} ghost xs (radius-full)
keyboard:   Esc(focus 내) 또는 ⌘+Backspace
a11y:       aria-label "검색어 지우기"
trigger:    input.value.length > 0
```

| 케이스 | 표시 조건 | 적합한 상황 |
|---|---|---|
| **A — 항상 표시** | 값이 있으면 항상 노출 | 마우스 위주 + 즉시 가시성 필요 (운영 대시보드 기본) |
| **B — 호버/포커스 시만** | input 또는 trailing slot에 hover/focus일 때만 노출 | 미니멀 톤, 시각 노이즈 최소화 |
| **C — 없음 (키보드만)** | clear indicator 미노출, Esc/⌘+Backspace 단축키만 | 단축키 친화 시그너처(예: linear-like) |

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `toss-like` | A | 즉각 가시성 우선 |
| `minimal-mono` / `material-3` | B | 시각 노이즈 최소화 |
| `linear-like` | C | ⌘K/Esc 단축키 시그너처 |

**2) Excel Export (엑셀 다운로드)** — 리스트 페이지에서 현재 데이터 내보내기.

```yaml
position:   top-bar right-cluster 끝 또는 filter-bar 우측
default-size: md (height 40)
icon:       16×16 download arrow — {component.icon}
copy:       동사형 ("엑셀 다운로드", "내보내기")
file:       .xlsx (또는 .csv 옵션)
async:      행 수 > 1000 또는 서버 export 시 비동기 처리
toast:      비동기 완료 시 {component.toast} + 다운로드 링크
a11y:       aria-label "엑셀 다운로드"
```

| 케이스 | 컴포넌트 | 옵션 | 동작 |
|---|---|---|---|
| **A — 단일 버튼** | `{component.button-secondary}` md + 좌측 download icon | 없음 | 즉시 다운로드 (전체 결과) |
| **B — 아이콘 only** | `{component.icon-button}` md ghost + tooltip "엑셀 다운로드" | 없음 | 즉시 다운로드, 공간 절약형 |
| **C — 옵션 dropdown** | `{component.button-secondary}` md + chevron-down → popover ({elevation.shadow-pop}) | 전체 / 필터링 결과 / 선택한 항목만 / 현재 페이지 | 선택 후 다운로드. 선택 항목 0건이면 disabled |
| **D — 비동기 progress** | C와 동일 진입 + 진행 toast/modal (스피너 + 진행률) | C의 옵션 + 알림 이메일 옵션 | 서버 export 큐 등록 → 완료 시 toast로 다운로드 링크 노출 |

운영 규칙:
- export 중 동일 버튼 disabled, 진행 중인 비동기 작업은 상단 우측 `{component.icon-button}`(notification dot)로도 노출.
- CSV/Excel 선택지를 두면 옵션 dropdown(C) 패턴으로 통합한다. 별도 버튼 두 개 노출 금지.
- 비-chrome 위치 gradient 금지 정책은 그대로 — Excel 버튼 chip/popover에 gradient 사용 금지.

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `toss-like` / `material-3` | A | 텍스트 라벨 + 명확한 액션 |
| `minimal-mono` | B | 시각 노이즈 최소화, tooltip 의존 |
| `linear-like` | B + ⌘E 단축키 | 단축키 시그너처. 옵션 필요 시 C로 승격 |

**3) Page Size (리스트 보기 행 개수 선택)** — pagination 영역의 행 수 선택.

```yaml
position:   pagination 좌측(정보 옆) 또는 우측(nav 전)
default:    20
options:    [10, 20, 50, 100]                # 100은 가상 스크롤 적용 시만
storage:    localStorage `<page-slug>-page-size`
copy:       "20개씩 보기" 또는 "행: 20"
component:  case 별 분기 (아래 표)
a11y:       aria-label "페이지당 행 수"
```

| 케이스 | 컴포넌트 | 옵션 노출 | 적합한 상황 |
|---|---|---|---|
| **A — dropdown** | `{component.button-tertiary}` sm + chevron → popover list | 10 / 20 / 50 / 100 | 4단계 이상 옵션, 공간 절약 (기본) |
| **B — segmented control** | 3개 토글(pill 그룹, `{rounded.radius-full}` 컨테이너 + `{rounded.radius-8}` 내부 셀, active는 `{colors.bg-surface}` + `{elevation.shadow-1}`) | 10 / 20 / 50 (3단) | 시각적 즉시 비교, compact density 시그너처 |
| **C — auto-fit** | UI 없음, 컨테이너 높이로 자동 계산(`Math.floor((vh - header - filter - pagination) / row-height)`) | 사용자 노출 없음 | 풀-블리드 운영 화면, 사용자 선택 불필요한 모니터링 뷰 |

운영 규칙:
- 디폴트 행 수는 시안 디폴트 케이스(`Wide Table Cases`)와 정합되어야 한다. A(56) → 20, B(44) → 30 권장.
- 100 이상은 가상 스크롤(virtualization) 활성 시에만 허용한다.
- 변경 시 1페이지로 reset + URL query(`?size=`) 동기화는 host 앱 책임.
- C(auto-fit) 채택 시 행 수 정보는 pagination info(`1–N / total`)에 그대로 노출한다.

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `minimal-mono` / `toss-like` / `material-3` | A (20) | 4단계 옵션 popover |
| `linear-like` | **B** (20) | compact 시그너처. Case D 리스트는 C(auto-fit) 권장 |

#### Column Filter Cases

테이블 컬럼별 필터(헤더 안에서 정렬·필터를 동시 수행)를 어디까지 노출할지 선택한다. Filter Bar(`### filter-bar (admin) > #### Filter Bar Cases`)의 전역 필터와 충돌하지 않도록 듀얼 채택 시 우선순위를 명시한다.

```yaml
header-control:
  sort-icon: 12×12 arrow-up-down, 3-state (asc/desc/none)
  filter-icon: 12×12 funnel monochrome — 활성 시 {colors.fg-brand}로 dot indicator
  popover:
    trigger:    헤더 셀 우측 끝 icon-button xs (24×24)
    container:  {elevation.shadow-pop}, radius {rounded.radius-8}, padding {spacing.space-12}
    width:      240 (text 검색) / 280 (다중 선택) / 320 (날짜 범위)
    body:       검색 input | checkbox 리스트(스크롤 max-height 240) | date-range
    footer:     button-ghost sm '초기화' + button-primary sm '적용'
  inline-row:   thead 아래 별도 row, 컬럼별 input/select inline
counter:        Filter Bar의 `필터 (N)` 카운터와 합산, 컬럼 필터는 `+컬럼 N`로 분리 표기
```

| 케이스 | 헤더 컨트롤 | UI 위치 | 적합 상황 |
|---|---|---|---|
| **A — 정렬만** | sort 3-state icon | 헤더 셀 우측 끝, 텍스트 옆 | 컬럼별 필터 불필요(상태 chip 또는 전역 필터로 충분) — 기본 |
| **B — 헤더 아이콘 popover** | sort + funnel icon, 클릭 시 popover (검색/체크박스/날짜) | 헤더 셀 우측 끝, icon-button xs | 데이터 점검·임시 탐색이 필요한 운영 화면 |
| **C — 인라인 필터 row** | thead 다음 row에 컬럼별 input/select 영구 노출 | 헤더 row 바로 아래 (sticky 가능) | 빈번한 컬럼별 검색, "Excel 필터" 패턴 — 회계/정산 |
| **D — 듀얼 (전역 + 컬럼)** | B 또는 C + 전역 Filter Bar 동시 운영 | Filter Bar는 상단, 컬럼 필터는 헤더 | Case D(초과밀도) 테이블 + 운영자 전문 사용 |

운영 규칙:
- 컬럼 필터 적용 시 헤더 셀 우측 funnel icon에 brand dot(4×4)로 활성 상태를 표시한다. 텍스트로 'filtered'라고 적지 않는다.
- 적용된 컬럼 필터 요약은 표 상단에 chip(`상태: 대기·진행`) 형태로 함께 노출(Case D)하여 사용자가 어디서 적용됐는지 식별 가능하게 한다.
- Case C(인라인 필터 row)는 컬럼 폭이 좁아도 input height ≥32, 정렬은 thead와 동일 right/left 규칙.
- Case D 채택 시 "전역 Filter Bar = 데이터 셋 결정 / 컬럼 필터 = 결과 내 추가 좁히기" 역할 분리를 PR/문서에 명시한다.
- 정렬·필터 동시 적용 가능. 동일 컬럼에서 sort+filter는 popover 내부 두 영역으로 분리(하단 sort 토글 또는 별도 메뉴 항목).

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `toss-like` / `material-3` | A | 전역 Filter Bar 우선 |
| `minimal-mono` | A or B | popover 도입 시 헤어라인 보더 유지 |
| `linear-like` | **B** | ⌘F 컬럼 필터 단축키, popover에 키보드 탐색 시그너처 |

### filter-bar (admin)

마케팅 영역의 `### filter-bar`와 별개. admin 리스트 페이지의 검색·기간·정적 필터·내보내기를 통합 운영하는 상단 컨트롤 바.

```yaml
container:
  padding-y:       {spacing.space-12}      # density Case A. B는 12, C는 8, D는 8
  padding-x:       0                       # 외곽 content padding 상속
  gap:             {spacing.space-12}
  align:           center, flex-wrap on narrow
  border-bottom:   1px {colors.border-subtle}   # 옵션, Case C/D 다중 패널 시 제거
left-cluster:
  date-range:
    component:     {component.button-tertiary} md + chevron-down
    leading-icon:  16×16 calendar
    label:         '기간: 최근 7일' | '2026-05-01 — 2026-05-18'
    popover:       2-month grid + preset chips(오늘/어제/최근 7일/이번 달/최근 30일/직접 입력)
                   {elevation.shadow-pop}, radius {rounded.radius-8}
  status-chip:     {component.chip} multi-select (현재 선택은 brand-subtle)
  filter-pill:     {component.filter-pill}, ≥6개면 Case C 패널로 승격
center:
  search:          {component.search} max-width 320, growable
right-cluster:
  gap:             {spacing.space-8}
  counter:         '필터 (3)' 텍스트, 0이면 숨김
  reset:           {component.button-ghost} sm '필터 초기화'
  saved-views:     optional, {component.button-tertiary} sm '저장된 뷰 ▾'
  view-switch:     optional, segmented (테이블/보드/카드)
  column-toggle:   optional, {component.icon-button} 'columns' (Wide Table Case D)
  export:          {component.button-secondary} md 또는 icon-button
                   (List Toolbar Cases §2의 케이스 선택을 그대로 호출)
```

#### Filter Bar Cases

| 케이스 | 좌측 | 검색 | 우측 | 적합 상황 |
|---|---|---|---|---|
| **A — 기본 chip** | 상태/카테고리 chip 3~5종 | input 320 | reset | 일반 리스트, 필터 정적 |
| **B — 일시 범위 + 엑셀** | date-range picker + chip 1~3종 | input growable | reset + 엑셀 다운로드 (List Toolbar §2 케이스) | 주문/정산/매출 — 기간 + 내보내기 |
| **C — 다중 필터 패널** | 토글 버튼 `필터 (3)` → 좌측 slide panel(width 320, padding 24) | input 320 | 저장된 뷰 + 엑셀 | 복합 필터 6+종, 저장된 뷰 |
| **D — 검색만** | (없음) | input full-width 또는 600 | (없음) | 단일 검색 페이지(회원/주문 단건 조회) |

운영 규칙:
- 일시(date-range)는 **단일 컨트롤로 통합**한다 — 시작일/종료일 input 두 개 분리 금지. preset chips(오늘/어제/최근 7일/이번 달)는 popover 내부에 두고 상단 바에는 단일 트리거만 노출.
- 엑셀 다운로드는 `### data-table > #### List Toolbar Cases §2`의 케이스 선택을 그대로 호출한다. Filter Bar에서 별도 정의 금지.
- 필터 활성 개수 `필터 (3)` 카운터는 0일 때 숨긴다.
- 필터 chip이 6개 이상이거나 필터 종류가 시각적으로 한 줄에 안 들어가면 Case C(좌측 슬라이드 패널)로 승격한다.
- 필터 변경 시 1페이지로 reset + URL query 동기화는 host 책임.
- 패널(Case C)에서 적용 전 변경값은 `button-primary` '적용'을 누르기 전까지 본문 결과를 갱신하지 않는다(데이터 트래픽·인지 부담 방지).

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `minimal-mono` / `toss-like` / `material-3` | A (또는 화면 의도에 따라 B) | 운영 화면 기본 |
| `linear-like` | **C** (디폴트) | 저장된 뷰 + 단축키 시그너처, ⌘. 필터 토글 |

### tab (admin)

상세 페이지 또는 다중 섹션 화면에서 콘텐츠 그룹을 전환하는 컴포넌트. 페이지 헤더(top-bar) 바로 아래에 두며, browser tab과 다른 in-page tab을 가리킨다.

```yaml
height:          40   # Case A/B 기본. density C/D는 36
gap-between:     {spacing.space-8}
padding-x:       0    # 컨테이너 padding 상속
container:
  bg:            {colors.bg-surface}
  border-bottom: 1px {colors.border-subtle}    # Case A에서만, B/C/D는 없음
item:
  typography:    {typography.label1}     # 14/500
  color:         {colors.fg-secondary}
  padding-x:     {spacing.space-12}      # 가로 여백
  active-color:  {colors.fg-strong}
  active-weight: 600
  hover-color:   {colors.fg-default}
  disabled:      {colors.fg-disabled}
counter:
  position:      label 우측 4px 간격
  component:     {component.badge}  # ' (12)' 텍스트 금지 → badge sm
  active-variant:bg-brand-subtle + fg-brand
overflow:
  threshold:     컨테이너 폭 초과 시 우측 '... 더보기' menu (Case A/B)
                 또는 horizontal scroll (Case C/D)
```

#### Tab Page Cases

| 케이스 | active 표시 | 외형 | 적합 상황 |
|---|---|---|---|
| **A — line underline (기본)** | 하단 2px solid `{colors.fg-strong}` underline | 평면 + 1px bottom border, 라벨만 | 상세 페이지 안의 섹션 전환(주문 상세 > 기본/배송/이력), 기본 |
| **B — pill 채움** | `{colors.bg-brand-subtle}` + `{colors.fg-brand}` (또는 `{colors.bg-strong}` + white invert) 채움, `{rounded.radius-full}` | container border 없음, 탭은 채워진 칩 | 카테고리 전환(상품 카테고리 탭, 정산 유형 탭) |
| **C — segmented 카드** | active 셀: `{colors.bg-surface}` + `{elevation.shadow-1}`, 그 외: 투명 | `{colors.bg-muted}` 컨테이너 + `{rounded.radius-full}` 외곽, 내부 셀 `{rounded.radius-8}` | 2~3개 전환, 분명한 토글(테이블/보드 뷰, 일/월 단위) |
| **D — vertical 좌측** | 좌측 3px solid `{colors.fg-strong}` indicator + `{colors.bg-brand-subtle}` 행 채움 | 좌측 폭 200~240 좌측 컬럼 navigation, 본문 우측 | 세부 페이지 다단(설정 페이지: 일반/알림/권한/보안), 탭 수 5+ |

운영 규칙:
- 한 화면에 두 케이스를 섞지 않는다(섹션 탭은 A, 그 안의 서브 토글은 C 식으로 위계만 분리).
- 비활성 탭에 이모지·아이콘 장식 사용 금지. 의미가 필요하면 16px stroke icon을 라벨 좌측에 둔다.
- 활성 indicator에 gradient 사용 금지(Case A/B/C 모두). gradient 정책은 시안 `policy.gradient_locations` 따른다.
- 카운터(`주문(12)`)는 텍스트 괄호 표기 금지 → badge sm로 분리한다.
- 탭 ≥7개는 Case D(vertical) 또는 nav-link로 승격 검토. horizontal에서 강제 스크롤은 가독성 손해가 크다.
- 탭 라벨은 명사 단문(`기본 정보`, `배송`, `이력`). 격식체·동사형 금지.

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` | A | nav-link active 패턴(밑줄 underline)과 정합 |
| `minimal-mono` | A | underline 색 `{colors.fg-strong}` (단색 invert) |
| `toss-like` | A (또는 B) | 마케팅 카테고리 전환은 B |
| `material-3` | **A** | M3 Primary Tabs(라벨 + indicator) 매핑 |
| `linear-like` | **C** (디폴트) | segmented compact 시그너처. 설정·세부 페이지는 D |

### User FE surface 컴포넌트 (synthesized)

아래 5종은 consumer-facing user FE 표면(모바일 반응형 + 모바일 전용)을 신규로 만들 때 필요한 합성 컴포넌트다. admin 5종이 sidebar·top-bar 같은 chrome 중심이라면, user FE 5종은 mobile-first 화면 골격(app-bar·bottom-nav)과 consumer 카탈로그 패턴(feed-card·search-bar·bottom-sheet)을 다룬다. 기존 토큰·atomic 컴포넌트(`button-*`, `input`, `chip`, `badge`, `avatar`, `icon-button`)와 Brand & Style 정책(평면 표면 + 1px 헤어라인 + 단일 강조색 + 카피 톤)을 조합해 합성한 명세이며, 다운스트림 product가 user FE를 신규로 만들 때 그대로 호출하거나 컴포넌트 로컬값만 미세 조정해 사용한다.

각 컴포넌트는 반응형(mobile/tablet/desktop)과 모바일 전용(viewport 360~430) 두 운영 모드를 모두 지원한다. 반응형 동작은 본 섹션과 별개로 `## Responsive Behavior`의 breakpoint 사다리를 따른다.

### app-bar (mobile)

모바일 화면 상단 chrome. admin `### top-bar`의 user FE 변형이며, height·gap·우측 cluster 구성이 다르다. sticky top + safe-area-inset-top 보존이 표준.

```yaml
height:         52                          # mobile 디폴트. desktop ≥1024에서는 56으로 승격
bg:             {colors.bg-surface}
border-bottom:  1px {colors.border-subtle}  # 시안의 policy에 따라 생략 가능 (toss-like, material-3)
padding:        0 {spacing.space-16}
safe-area:      env(safe-area-inset-top)    # iOS notch 회피, 상단 padding에 합산
left-cluster:
  variants:
    - back-button: {component.icon-button} (chevron-left 24px) — 상세/하위 화면
    - hamburger:   {component.icon-button} (menu 24px) — 루트 화면(옵션)
    - logo:        24px symbol — 루트 화면 디폴트
  gap:        {spacing.space-12}
center-cluster:
  variants:
    - page-title: {typography.title3}  # 상세 화면 (back-button과 페어)
    - search-bar: full-width {component.search} (검색 중심 화면)
    - none:       (홈/피드 — 로고 좌측이면 center는 비움)
right-cluster:
  gap:        {spacing.space-8}
  items:      max 2개 {component.icon-button} (예: 검색, 알림). 3+ 시 우측 'more' menu 권장
  notification-dot: 6px {colors.bg-danger} circle, icon 우상단
```

좌측 cluster가 page-title을 포함하지 않는 디자인(toss-like 모바일)에서는 center를 사용하고, page-title은 항상 단문이며 줄바꿈 금지 — overflow는 `...` ellipsis.

### bottom-nav

모바일 1차 네비게이션. desktop에서는 sidebar 또는 top-nav로 분리되며 본 컴포넌트는 사용하지 않는다.

```yaml
height:         56                          # tap target 48 + 상하 padding
bg:             {colors.bg-surface}
border-top:     1px {colors.border-subtle}
padding-bottom: env(safe-area-inset-bottom) # iOS home indicator 회피
position:       sticky bottom, z-index 50
display:        flex, items 균등 분배
item:
  width:        100% / item-count           # 균등 분배 (3~5탭)
  min-width:    64                          # hit area
  padding:      {spacing.space-8} 0
  gap:          {spacing.space-4}           # icon + label 수직 간격
  icon:         24px stroke (active는 filled 또는 weight 상승)
  label:        {typography.caption2}       # 11/600, ALL-CAPS 금지
  color:        {colors.fg-tertiary}        # inactive
  active-color: {colors.fg-brand}
  active-icon:  filled variant + currentColor 상속
  indicator:    label 위에 4px dot 또는 아이콘 weight 상승만 (좌측 rail 금지)
fab-variant:                                # Cases B 중앙 강조 액션
  size:         56 (원형), radius-full
  bg:           {colors.bg-brand}
  fg:           {colors.fg-on-brand}
  position:     중앙 탭 자리에 -8 offset (bottom-nav 위로 살짝 돌출)
  shadow:       {elevation.shadow-2} (시안의 shadow_on_cards 정책 무시 — fab은 elevation 표면)
```

운영 규칙:
- 탭 개수는 3·4·5 중 하나. 6 이상은 더보기 메뉴로 그룹화한다.
- 활성 indicator에 gradient 사용 금지(시안 `policy.gradient_locations` 따른다).
- 라벨이 없는 icon-only 모드(`label-display: false`)는 hit area 보장을 위해 icon 28px로 승격.
- iOS Safari 하단 chrome 침범 회피용 `safe-area-inset-bottom` padding 필수.

#### Bottom Nav Cases

| 케이스 | 구성 | 적합 상황 |
|---|---|---|
| **A — 5탭 균등 (표준)** | icon + label 5개 균등 분배 | 일반 user FE 앱 디폴트 (커머스, SNS, 라이프스타일) |
| **B — 중앙 FAB + 4탭** | 좌2 + FAB + 우2. FAB은 주요 액션(글쓰기, 카메라, 신청) | 컨텐츠 생성 액션이 명확할 때 (인스타·트위터·신청 앱) |
| **C — 라벨 only (텍스트 탭)** | 텍스트 라벨만, 아이콘 없음. height 44 | 텍스트 위계 강조 (linear-like, 문서/뉴스 앱) |
| **D — 아이콘 only (compact)** | 아이콘만, 라벨 없음. icon 28px, height 48 | 모바일 game/카메라처럼 chrome 최소화 |

시안별 디폴트:

| 시안 | 디폴트 | 비고 |
|---|---|---|
| `wanted` / `toss-like` / `material-3` | A | 5탭 균등이 user FE 표준 |
| `minimal-mono` | A (또는 C) | 미니멀 톤은 텍스트 only도 정합 |
| `linear-like` | **C** | 텍스트 + dark 시그너처 |

### feed-card

홈/피드/리스트 화면의 기본 unit. 마케팅 `### job-card`의 일반화된 형태로, 썸네일 + 제목 + 메타 + (옵션) 액션 구성. consumer 카탈로그(상품, 게시물, 콘텐츠) 공통.

```yaml
container:
  bg:          {colors.bg-surface}
  border:      1px {colors.border-subtle}     # 시안 policy.shadow_on_cards가 true면 shadow-1로 대체 가능
  radius:      {rounded.radius-12}            # mobile은 12, desktop은 8~12 시안 정책
  padding:     {spacing.space-16}
  gap:         {spacing.space-12}             # 썸네일 + 본문 수직 또는 수평
layout-variants:
  - vertical:   썸네일 상단 full-width, 본문 하단. aspect 16/9 또는 4/3
  - horizontal: 썸네일 좌측 (96~120 width), 본문 우측. mobile list
  - compact:    썸네일 없음, 텍스트만. row 64
thumbnail:
  aspect:      16/9 (vertical media), 1/1 (avatar 카드), 4/3 (상품)
  radius:      {rounded.radius-8}
  placeholder: gradient (시안 policy.gradient_locations에 `"thumbnail"` 있을 때만) 또는 평면 {colors.bg-muted}
body:
  title:       {typography.title3}            # 18/700, 2줄 ellipsis
  description: {typography.body2} {colors.fg-secondary}  # 1~2줄 ellipsis
  meta-row:                                   # 작성자/시간/카테고리 등
    typography: {typography.caption1}
    color:      {colors.fg-tertiary}
    separator:  "·" 텍스트, 좌우 {spacing.space-8} 간격
  badges:      {component.badge} 또는 {component.chip} sm (좌측 정렬, 최대 2개)
action-row:                                    # 옵션
  position:    카드 하단 또는 우측 (변형에 따라)
  items:       {component.icon-button} sm 또는 {component.button-tertiary} sm
  examples:    좋아요, 북마크, 공유, 더보기
state-hover:
  bg:          {colors.bg-subtle}              # 매우 약한 highlight, mobile에서는 active state
  cursor:      pointer
```

운영 규칙:
- 카드 전체 click area로 상세 진입. action-row의 액션 버튼은 `event.stopPropagation()` 분리.
- 모바일에서 carousel 슬라이드 표시 시 카드 폭은 viewport - `{spacing.space-32}` (좌우 16 peek).
- 가격/숫자 강조가 필요하면 본문 하단에 `{typography.title2}` + `{colors.fg-strong}` 또는 `{colors.fg-brand}` (예: 쇼핑 카드의 가격).

### search-bar

화면 상단 또는 app-bar 안에 sticky로 두는 mobile-first 검색 표면. desktop은 header 내부 inline `{component.search}`를 사용하고 본 컴포넌트는 mobile-only 변형이다.

```yaml
container:
  bg:          {colors.bg-surface}              # 시안에 따라 bg-muted (sunken style)
  height:      48
  border:      1px {colors.border-subtle}       # bg-muted 변형은 border 생략
  radius:      {rounded.radius-12}              # mobile은 12, 시안 toss-like는 16
  padding:     0 {spacing.space-12}
  gap:         {spacing.space-8}
icon-left:
  component:   {component.icon} (search 20px), color {colors.fg-tertiary}
input:
  flex:        1
  typography:  {typography.body1}
  placeholder-color: {colors.fg-tertiary}
  placeholder-text:  "검색어를 입력해 보세요" (ko-friendly) / "Search" (en-sentence)
icon-right:
  variants:
    - clear:    {component.icon-button} sm (x icon 16px). input 비어있으면 숨김
    - voice:    {component.icon-button} sm (mic icon 16px) — 옵션
    - filter:   {component.icon-button} sm (sliders icon 18px) — 필터와 페어 운영 시
focus-mode:                                       # mobile 풀스크린 검색 패턴
  trigger:     input focus
  surface:     full-viewport overlay {colors.bg-canvas}
  app-bar:     좌측 back-button + 검색 input + 우측 cancel 텍스트 버튼
  content:     최근 검색어 / 추천 / 자동완성 list
  exit:        cancel 텍스트 버튼 (한글: "취소", en: "Cancel") 또는 back-button
```

#### Search Cases

| 케이스 | 트리거 동작 | 적합 상황 |
|---|---|---|
| **A — inline (표준)** | input focus → 같은 자리에서 입력. 자동완성은 dropdown | 검색이 보조 액션인 일반 user FE |
| **B — 풀스크린 overlay** | input focus → 풀스크린 검색 모드 진입. cancel 버튼으로 복귀 | 검색이 1차 액션인 앱(쇼핑·미디어·맵) |
| **C — voice + filter combo** | input + 우측 mic + filter icon. 모두 옵션 | 음성 검색이 의미 있는 도메인(맵, 음악) |
| **D — sunken pill** | bg-muted 채움, border 없음, radius-full | 미니멀 톤 또는 search가 chrome 안에 통합되는 경우 |

### bottom-sheet

모바일에서 modal·dropdown·picker를 대체하는 표준 surface. 데스크탑은 `{component.modal}` 또는 popover로 분기.

```yaml
container:
  bg:           {colors.bg-surface}
  border-top:   1px {colors.border-subtle}       # 시안 policy.shadow_on_cards가 true면 상단에 shadow-2 추가
  radius-top:   {rounded.radius-16} {rounded.radius-16} 0 0  # 상단 좌우만
  padding:      {spacing.space-16} {spacing.space-16} {spacing.space-24}
  max-height:   85vh                              # 화면 상단 15% 여백
  position:     fixed bottom
  z-index:      60
handle:                                            # 시각적 drag 가능 표시
  width:        36
  height:       4
  bg:           {colors.border-strong}
  radius:       {rounded.radius-full}
  align:        center, margin-bottom {spacing.space-12}
header:
  title:        {typography.title3}
  subtitle:     {typography.body2} {colors.fg-secondary}
  close:        {component.icon-button} 우측 (X icon 20px)
  border-bottom:1px {colors.border-subtle} (옵션, content 분리 시)
content:
  scroll:       overflow-y auto, padding bottom {spacing.space-24}
  list-style:   {component.input}, {component.checkbox}, list-row 등 자유 조립
action-bar:                                       # 옵션, sticky bottom
  bg:           {colors.bg-surface}
  border-top:   1px {colors.border-subtle}
  padding:      {spacing.space-12} {spacing.space-16}
  cta:          {component.button-primary} lg full-width
backdrop:
  bg:           rgba(0,0,0, 0.40)
  click:        dismiss (옵션 — 위험 액션은 dismiss 금지)
animation:
  enter:        translate-y from 100% to 0, 200ms ease-out
  exit:         translate-y from 0 to 100%, 150ms ease-in
```

운영 규칙:
- 단순 선택(필터, 정렬, 카테고리)은 bottom-sheet, 위험 액션(삭제 확인)은 `{component.modal}`로 분리.
- handle 표시는 드래그 가능한 sheet일 때만. 고정 sheet는 handle 생략.
- iOS safe-area-inset-bottom은 action-bar padding에 합산.
- sheet 내부 form은 한 화면 안에 들어가도록 — 길어지면 풀스크린 modal로 승격.

#### 모바일 전용 인터랙션 패턴 (mobile-only 운영)

본 절은 viewport 360~430 고정 운영(`docs/user-fe-mobile-design-guide.md`) 시점에 한해 적용되는 추가 인터랙션 패턴이다. 반응형 운영(`docs/user-fe-design-guide.md`)에서는 옵션이며 데스크탑 표면에는 적용하지 않는다.

**segmented-control (in-page tab)**
admin `### tab (admin)` Case C(segmented)의 모바일 변형. height 36, container `{colors.bg-muted}` + `{rounded.radius-full}`, active cell `{colors.bg-surface}` + `{elevation.shadow-1}` (시안 `policy.shadow_on_cards: false`인 경우 `{colors.border-default}` 1px로 대체). 2~3개 토글 전용(예: 일/월/연, 리스트/지도). 4개+는 `### tab (admin)` Case A(line underline) 사용.

**list-row swipe-action**
horizontal 스와이프로 행 우측에 액션 노출(삭제, 즐겨찾기 등). 액션 버튼은 height = row height, width 64~80, bg `{colors.bg-danger}` (삭제) 또는 `{colors.bg-brand}` (즐겨찾기), color `{colors.fg-on-brand}`, `{typography.label2}`. 시각 affordance: 행 우측 끝에 chevron 또는 dot indicator 노출(스와이프 가능 표시). 위험 액션(삭제)은 swipe만으로 즉시 실행 금지 — 확인 단계(`### bottom-sheet` 또는 second tap) 거침.

**pull-to-refresh**
화면 상단에서 아래로 당기는 제스처로 콘텐츠 새로고침. affordance: 당기는 동안 상단에 spinner 또는 progress arc 노출(`{spacing.space-32}` 높이 영역), 80px 임계 이상 당기면 release-to-refresh 표기. refresh 중에는 상단 sticky spinner 유지. 데스크탑/태블릿 표면에는 미적용 — 명시 새로고침 버튼 사용.

**native-like toast (mobile)**
`{component.toast}`의 모바일 변형. 위치는 상단 sticky(app-bar 아래 `{spacing.space-12}` offset) 또는 하단 sticky(bottom-nav 위 `{spacing.space-12}` offset, sticky CTA가 있으면 그 위). max-width: viewport - `{spacing.space-32}`. radius `{rounded.radius-12}`. duration 3~4초. swipe-to-dismiss 허용.

**sticky CTA 표준**
모든 1차 액션 화면(상세/폼/신청/결제)에서 sticky bottom CTA를 표준으로 둔다. height 64 (CTA 48 + padding 8/8), bg `{colors.bg-surface}`, border-top 1px `{colors.border-subtle}`. safe-area-inset-bottom 합산. desktop은 본 패턴 미사용(우측 사이드 패널 또는 페이지 인라인).

### logo

브랜드 마크는 두 형태 — **symbol** (3-stop 그라디언트가 적용된 둥근 사각형/마름모 형태)과 **logotype** (`Wanted` 워드마크) [src:1]. SSOT 번들 `assets/logos/`에 `wanted-symbol-fill.png`, `wanted-symbol-mask.svg`, `wanted-logotype.svg`로 ship되며, mask SVG는 `currentColor` 적용이 가능해 단색 표면 위에서 톤을 맞추는 용도다 [src:1].

## Do's and Don'ts

**Do**

- product-facing 색은 시맨틱 alias(`{colors.bg-brand}`, `{colors.fg-strong}`, `{colors.fg-default}`, `{colors.fg-secondary}`, `{colors.border-subtle}`)로 호출하고, atomic ramp(`{colors.blue-800}`, `{colors.neutral-700}`)는 새 alias를 만들 때만 직접 참조한다 [src:1].
- 화면당 단일 강조색 정책을 유지한다 — primary CTA는 `{colors.bg-brand}` 하나로 통일하고, 보조 액션은 button-secondary/tertiary/ghost로 분리한다 [src:1].
- 텍스트 위계는 **alpha multiplier 시스템**으로 표현한다 — primary `alpha-88`, secondary `alpha-61`, tertiary `alpha-43`, disabled `alpha-28` [src:1]. 별도 gray hex로 만들지 않는다.
- 카드는 1px `{colors.border-subtle}` 헤어라인으로 구조를 만든다 — 그림자를 카드에 적용하지 않는다 [src:1]. 그림자는 popover/dropdown/modal/toast에만 사용한다.
- 라운드는 **`{rounded.radius-8}` 또는 `{rounded.radius-12}`를 디폴트**로, pills는 `{rounded.radius-full}`로 사용한다 [src:1]. "약간 둥근" 같은 임의값은 도입하지 않는다.
- 버튼 라운드는 사이즈와 페어로 운영한다 — sm 6, md `{rounded.radius-8}`, lg 10, xl `{rounded.radius-12}` [src:1].
- 본문은 `{typography.body1}` (16/500/1.5 line-height)을 기본으로, 산문 단락은 `{typography.body1-read}` (1.625 line-height)을 사용한다 [src:1].
- 17px 이상 모든 헤딩에 네거티브 트래킹을 유지한다 (`-0.0319em` ~ `-0.0120em`) — display 1이 가장 타이트하다 [src:1].
- product 카피는 **친근한 존댓말**(`-요`/`-어요`/`-아요`)로 작성한다 — "지원이 완료되었어요", "받은 제안이 없어요", "잠시 후 다시 시도해 주세요" 같은 톤 시그너처를 따른다 [src:1].
- 버튼 라벨은 **동사 형태**로 작성한다 — "지원하기", "저장하기", "시작하기", "둘러보기"가 표준이다 [src:1].
- 잡카드 우측 하단에는 **채용보상금**을 `{colors.fg-brand}` 색으로 항상 노출한다 — Wanted를 다른 잡 사이트와 구분짓는 시그너처다 [src:1].
- 태그 칩은 `#` + 단어 형태로 표기한다 — `#성장가능성`, `#스타트업` [src:1].
- 아이콘은 `currentColor`를 상속하게 둔다 — 외부 컬러 직접 주입 금지 [src:1][src:5].
- 포커스 링은 항상 visible 상태로 유지한다 — 2px `{colors.blue-800}` ring + 2px transparent offset이 표준이다 [src:1].

**Don't**

- **이모지를 product UI에 inline으로 사용하지 않는다** — 빈 상태·성공·상태 pill에서도 monochrome SVG 또는 평면 일러스트 자산으로 대체한다. CTA의 "→" 같은 화살표도 unicode가 아니라 SVG로 그린다 [src:1].
- **그라디언트를 chrome에 사용하지 않는다** — 그라디언트는 (1) 심볼 마크, (2) 아바타 circle, (3) 잡카드 썸네일 placeholder, (4) 마케팅 hero banner — 네 가지 문서화된 자리에만 사용한다. CTA·헤더·풀-블리드 본문 표면에는 적용하지 않는다 [src:1].
- 격식체(`-습니다`/`-십시오`)나 단정형 `-다`를 product 카피에 사용하지 않는다 — `-요`/`-어요`가 표준이다 [src:1].
- ALL-CAPS, Title Case In Buttons를 사용하지 않는다 — 영어는 항상 sentence case다 [src:1].
- UI 라벨이나 리스트 아이템 끝에 마침표를 찍지 않는다 [src:1].
- 마케팅 과장 ("혁신적", "차세대", "최고의") 이나 챗봇 톤 ("~해보세요!", "여기를 눌러주세요")을 product 카피에 사용하지 않는다 [src:1].
- 카드에 그림자를 적용하지 않는다 — 1px `{colors.border-subtle}` 헤어라인이 표준이다 [src:1].
- 6px·10px·14px·18px·22px 같은 비-4의 배수 spacing/radius를 도입하지 않는다 — `{spacing.*}`와 `{rounded.*}` 사다리만 사용한다 [src:1].
- 텍스처·노이즈·grain을 표면에 사용하지 않는다 — 모든 표면은 평면 색이다 [src:1].
- glassy 효과(blur backdrop, translucent toolbar)를 사용하지 않는다 — Wanted 시스템은 평면 색 + 헤어라인 보더로 깊이를 만든다 [src:1].
- 2px 장식용 보더, 컬러 left-rail accent 카드, color-shifted variant rim을 사용하지 않는다 — 기본은 1px `{colors.border-subtle}` / `{colors.border-default}` 헤어라인이다 [src:1].
- spring·bounce·parallax·page slide 모션을 사용하지 않는다 — hover transition은 100–150ms ease, page transition은 ~200ms fade-in only가 표준이다 [src:1].
- 아이콘 내부에 그라디언트·컬러를 적용하지 않는다 — 모든 아이콘은 monochrome이며 `currentColor`를 상속한다 [src:1][src:5].
- gray-* 패밀리를 UI 표면 색으로 직접 사용하지 않는다 — UI 표면은 neutral-* 패밀리(cool blue-tinted)를 사용하고, gray-*는 utility용이다 [src:1].

## Responsive Behavior

원티드 시스템은 mobile-first 표준 패턴을 유지한다 — 모바일·태블릿·데스크톱 표면을 같은 시스템 위에서 운영하지만, 마케팅 표면은 max-width ~1080px, 대시보드는 ~1280px로 운영한다 [src:1].

### Breakpoints

| Name | Width | Columns | Gutter | Key Changes |
|---|---|---|---|---|
| Mobile | ≤ 640 | 4 | 16 | `{component.job-card}` 그리드를 1–2 컬럼으로 collapse, header 검색은 inline icon button으로 축약 [src:1] |
| Tablet | 641–1023 | 8 | 24 | 잡 그리드 2–3 컬럼, hero banner full-bleed 유지 [src:1] |
| Desktop (marketing) | 1024–1279 | 12 | 24 | max-content-width ~1080; hero `{component.hero-banner}` 가 standard [src:1] |
| Desktop (dashboard) | ≥ 1280 | 12 | 24 | max-content-width ~1280; 잡 그리드는 `{component.job-card}` 4 컬럼 [src:1] |

### Touch Targets

모든 인터랙티브 표면은 최소 44×44px hit area를 보장한다 [src:1]. `{component.input}`는 44px height로 시스템 디폴트와 일치한다. `{component.button}`의 sm(32)·md(40) 사이즈는 padding을 포함해 hit area를 보장한다. `{component.chip}` (34) · `{component.icon-button}` (36)도 동일한 정책이다.

### Collapsing Strategy

- **Job grid**: desktop 4 cols → tablet 2–3 cols → mobile 1–2 cols. card aspect는 그대로 유지된다 [src:1].
- **Header**: desktop의 nav links + search + icon buttons + avatar 풀 행 → tablet에서 일부 nav를 hamburger로 collapse → mobile은 hamburger + 로고 + 1–2 icon button.
- **Hero**: full-bleed gradient banner는 모든 breakpoint에서 유지되나, height가 모바일에서 축소된다 (관찰: desktop 280 → mobile ~200) [src:1].
- **Filter bar**: filter pills는 wrap, sort는 mobile에서 우측 정렬 유지하되 라벨이 축약될 수 있다.

### Image Behavior

마케팅 사진은 full-bleed로 표면에 사용되며, 카드의 썸네일은 16/12 (그리드) 또는 16/9 (상세) aspect로 잘려 표시된다 [src:1]. 일러스트는 빈 상태·온보딩에서만 등장 — 평면, 기하학적, primary blue + neutral.

## Known Gaps

- **OKLCH 변환 정확도** — 원본 `colors_and_type.css`는 hex (또는 일부 rgba) 토큰만 ship하며, 시스템 내장 OKLCH 표기는 surface되지 않는다 [src:1]. 본 문서의 OKLCH 값은 sRGB → OKLab 표준 변환이며, 실제 design tool/브라우저의 색재현에 따라 ±0.002 lightness/chroma 오차가 있을 수 있다.
- **그라디언트 mid-stop 미세 차이** — 브랜드 그라디언트의 mid-stop은 README와 atomic 팔레트에서 약간 다른 값으로 surface된다. README/avatar gradient는 `#FF53C0`(magenta-shifted), atomic pink-600은 `#F553DA` — UI kit `styles.css`에서 실제 사용되는 hex는 `#FF53C0`이며 본 문서는 이를 우선한다 [src:1].
- **공식 motion 토큰** — duration·easing의 시스템 토큰은 명시되지 않았으며, hover transition은 100–150ms ease, page transition은 ~200ms fade-in이라는 정책만 README에 prose로 surface된다 [src:1]. 본 문서의 Motion 표는 SSOT의 정책 prose에서 추출한 권장값이며, 명시 토큰은 아니다.
- **다크 모드 alias 완전성** — SSOT의 dark theme 토큰은 background(canvas, surface, subtle, muted, elevated, inverse, brand-subtle)·foreground(strong, default, secondary, tertiary, disabled, on-brand)·border(subtle, default, strong)까지 surface되어 있다 [src:1]. `bg-danger-subtle`/`bg-success-subtle`/`bg-warning-subtle`와 `fg-brand`/`fg-danger`/`fg-success`/`fg-warning`의 다크 alias는 SSOT가 surface하지 않았으며, 본 카탈로그의 preview 구현을 위해 위 `### Semantic alias — Dark` 블록에 적정 대비값으로 **합성(synthesized)**하여 수록했다 — 다운스트림이 동일 패턴(blue-400 brightened for fg-brand, semantic hue @ ↑ lightness for fg-*, low-alpha colored fill for bg-*-subtle)으로 host 토큰을 ship할 수 있게 한다.
- **wanted-icons 토큰 인벤토리** — wanted-icons는 자체 npm 패키지로 ship되며 Figma `/Icon` 페이지에 ~340개 아이콘이 정의된다 [src:1][src:5]. SSOT 번들은 production용 wanted-icons의 stand-in으로 Lucide CDN을 link하므로, 본 catalog가 적용되는 host는 production에서 `wanted-icons` 패키지로 교체해야 한다. 개별 아이콘의 토큰 명세(이름 매핑, 16px filled 변형 ID)는 본 문서 범위 외다.
- **catalog-only ladder 토큰** — 본 카탈로그는 alias 계약(`radius-2/4/8/12/16/full`) 외에 `radius-6`(button sm 로컬), `radius-10`(button lg 로컬), `radius-20`/`radius-24`/`radius-32`(일부 카드/hero)를 추가 ladder로 surface한다. 모두 4의 배수 또는 SSOT의 컴포넌트 로컬값에서 직접 가져온다. `_alias-contract.md ## 9b` fallback 표에 등재되어 다른 시안 활성 시 표준 `--radius-8` 또는 `--radius-16`으로 fallback된다.
- **catalog-only color/border alias** — `fg-link`(인라인 링크 강조)와 `border-inverse`(dark surface 분리)는 alias 계약 외 추가 토큰. 다른 시안에서는 `fg-brand`, `border-strong`로 fallback된다.
- **shadow-3 / shadow-4** — Wanted SSOT가 elevation을 5단까지 surface하지는 않지만, 본 catalog는 합성된 `shadow-3`/`shadow-4`를 popover/dropdown/modal/toast 외 카드 surface에 사용하지 않는 정책으로 ship한다. CSS Variables 블록에는 fallback 대상으로만 명시(`var(--shadow-3, var(--shadow-2))`).

## References

1. https://api.anthropic.com/v1/design/h/j7_orggLzbQ43g24R8OfYA — Wanted Design System 핸드오프 번들 (Claude Design SSOT). `README.md`, `colors_and_type.css`, `SKILL.md`, 14개 `preview/*.html` 카드, `ui_kits/wanted-web/` (Header.jsx · Filters.jsx · JobCard.jsx · JobDetail.jsx · JobGrid.jsx · Footer.jsx · index.html · styles.css), `assets/logos/` 심볼 + 로고타입. 본 entry의 1차 출처. © 2025 Wanted Lab.
2. https://www.wanted.co.kr — 원티드 공식 마케팅 + 잡 마켓플레이스. 슬로건·카피·비주얼 톤 참조.
3. https://wanted-sans.github.io — Wanted Sans 오픈소스 typeface (OFL). Wanted + 산돌 공동 제작.
4. https://github.com/orioncactus/pretendard — Pretendard JP variable typeface. 본 시스템의 베이스 UI face.
5. https://github.com/wanteddev/wanted-icons — Wanted 자체 아이콘 셋 npm 패키지. 24×24 그리드, 2px stroke, monochrome.

## CSS Variables

`docs/admin-fe-preview.html` 및 다운스트림 프로젝트가 그대로 호출할 CSS 변수 정의. 표기 규칙은 `designs/_alias-contract.md ## 10` 참조.

```css
:root[data-design="wanted"][data-theme="light"] {
  /* Background */
  --bg-canvas:         oklch(1 0 0);
  --bg-surface:        oklch(1 0 0);
  --bg-subtle:         oklch(0.972 0.002 286);
  --bg-muted:          oklch(0.961 0.002 286);
  --bg-elevated:       oklch(1 0 0);
  --bg-inverse:        oklch(0.148 0.004 277);
  --bg-brand:          oklch(0.563 0.232 257);
  --bg-brand-subtle:   oklch(0.954 0.022 250);
  --bg-danger-subtle:  oklch(0.951 0.018 18);
  --bg-success-subtle: oklch(0.968 0.052 154);
  --bg-warning-subtle: oklch(0.967 0.030 81);

  /* Foreground */
  --fg-strong:    oklch(0.148 0.004 277);
  --fg-default:   oklch(0.259 0.010 273 / 0.88);
  --fg-secondary: oklch(0.298 0.010 273 / 0.61);
  --fg-tertiary:  oklch(0.298 0.010 273 / 0.43);
  --fg-disabled:  oklch(0.298 0.010 273 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.563 0.232 257);
  --fg-success:   oklch(0.673 0.211 144);
  --fg-warning:   oklch(0.625 0.148 56);
  --fg-danger:    oklch(0.546 0.220 27);
  --fg-link:      oklch(0.563 0.232 257);                       /* catalog-only */

  /* Border */
  --border-subtle:  oklch(0.521 0.018 273 / 0.08);
  --border-default: oklch(0.521 0.018 273 / 0.22);
  --border-strong:  oklch(0.521 0.018 273 / 0.35);
  --border-brand:   oklch(0.563 0.232 257);
  --border-inverse: oklch(1 0 0 / 0.16);                        /* catalog-only */

  /* Spacing */
  --space-4: 4px;    --space-8: 8px;    --space-12: 12px;   --space-16: 16px;
  --space-20: 20px;  --space-24: 24px;  --space-32: 32px;   --space-40: 40px;
  --space-48: 48px;  --space-56: 56px;  --space-64: 64px;   --space-80: 80px;
  --space-96: 96px;  --space-128: 128px;

  /* Rounded (표준 + catalog-only ladder) */
  --radius-2: 2px;   --radius-4: 4px;   --radius-6: 6px;        /* catalog-only: button sm 로컬 */
  --radius-8: 8px;   --radius-10: 10px;                          /* catalog-only: button lg 로컬 */
  --radius-12: 12px; --radius-16: 16px;
  --radius-20: 20px; --radius-24: 24px; --radius-32: 32px;       /* catalog-only: 일부 카드/hero */
  --radius-full: 9999px;

  /* Elevation (popover/dropdown/modal/toast 전용) */
  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.04);
  --shadow-2:   0 4px 8px oklch(0 0 0 / 0.06);
  --shadow-3:   var(--shadow-2);                                 /* catalog-only fallback */
  --shadow-4:   var(--shadow-pop);                               /* catalog-only fallback */
  --shadow-pop: 0 8px 24px oklch(0 0 0 / 0.10);
}

:root[data-design="wanted"][data-theme="dark"] {
  --bg-canvas:        oklch(0.148 0.004 277);
  --bg-surface:       oklch(0.166 0.005 271);
  --bg-subtle:        oklch(0.135 0.002 286);
  --bg-muted:         oklch(0.196 0.008 273);
  --bg-elevated:      oklch(0.237 0.008 273);
  --bg-inverse:       oklch(1 0 0);
  --bg-brand:         oklch(0.563 0.232 257);
  --bg-brand-subtle:  oklch(0.149 0.069 257);
  --bg-danger-subtle: oklch(0.298 0.10 22 / 0.32);
  --bg-success-subtle:oklch(0.298 0.10 144 / 0.28);
  --bg-warning-subtle:oklch(0.298 0.10 56 / 0.32);

  --fg-strong:    oklch(1 0 0);
  --fg-default:   oklch(1 0 0 / 0.88);
  --fg-secondary: oklch(1 0 0 / 0.61);
  --fg-tertiary:  oklch(1 0 0 / 0.43);
  --fg-disabled:  oklch(1 0 0 / 0.28);
  --fg-on-brand:  oklch(1 0 0);
  --fg-brand:     oklch(0.715 0.155 255);
  --fg-success:   oklch(0.760 0.180 144);
  --fg-warning:   oklch(0.778 0.158 64);
  --fg-danger:    oklch(0.715 0.220 27);
  --fg-link:      oklch(0.715 0.155 255);                       /* catalog-only synthesized */

  --border-subtle:  oklch(1 0 0 / 0.08);
  --border-default: oklch(1 0 0 / 0.22);
  --border-strong:  oklch(1 0 0 / 0.35);
  --border-brand:   oklch(0.715 0.155 255);
  --border-inverse: oklch(0 0 0 / 0.32);                         /* catalog-only synthesized */

  /* spacing/radius는 light와 동일 — 상속 */
  --shadow-1:   0 1px 2px oklch(0 0 0 / 0.20);
  --shadow-2:   0 4px 8px oklch(0 0 0 / 0.32);
  --shadow-3:   var(--shadow-2);                                 /* catalog-only fallback */
  --shadow-4:   var(--shadow-pop);                               /* catalog-only fallback */
  --shadow-pop: 0 8px 24px oklch(0 0 0 / 0.48);
}
```

frontmatter `policy:` 블록:
- `shadow_on_cards: false` — 카드 그림자 금지(헤어라인 보더가 표준)
- `gradient_locations: ["symbol", "avatar", "thumbnail", "hero"]` — 4곳 한정
- `copy_tone: "ko-friendly"` — `-요`/`-어요`/`-아요` 종결, 동사형 버튼 라벨
- `dark_mode: "supported"` — light/dark 양쪽 정의
- `non_4_spacing: false` — 4의 배수만 (button sm radius 6, lg 10 같은 컴포넌트 로컬값은 예외)
