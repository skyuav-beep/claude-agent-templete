---
name: AITC
slug: aitc
category: finance
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/FRUXaMrwcG3vhTK5Dgr4d1
related_services: []
lang: ko
policy:
  shadow_on_cards: false
  gradient_locations: []
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/FRUXaMrwcG3vhTK5Dgr4d1
  version: "1794601408-7081"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/aitc.map.json
---

# AITC — design.md

> 내 돈이 지금 얼마이고 얼마를 뺄 수 있는지 3초 안에 — 모스 그린 브랜드와 선 옐로 한 점, 한 화면 한 숫자의 출금 한도 모바일 PWA 시안.

본 시안은 Claude Design System 「AITC (색인 제목 MOA)」(https://claude.ai/artifact/FRUXaMrwcG3vhTK5Dgr4d1)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/aitc.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

내 돈이 지금 얼마이고 얼마를 뺄 수 있는지 3초 안에 — 모스 그린 브랜드와 선 옐로 한 점, 한 화면 한 숫자의 출금 한도 모바일 PWA 시안.

- 카드 그림자: 금지(헤어라인 우선) · gradient: 전면 금지 · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#1d5c45"        # ← brand
accent-sun: "#f4c542"           # ← sun
hero-ground: "#16201b"          # ← hero
```

### Semantic alias — Light

```yaml
bg-canvas: "#f5f3ee"                # ← surface
bg-surface: "#ffffff"               # ← surface-raised
bg-subtle: "#ebe8e0"                # ← surface-sunken
bg-muted: "#ebe8e0"                 # ← surface-sunken
bg-elevated: "#ffffff"              # ← surface-raised
bg-inverse: "#16201b"               # ← hero · 합성 — 대시보드 최상단 한도 카드 전용 깊은 바탕을 반전 면으로 재사용
bg-brand: "#1d5c45"                 # ← brand
bg-brand-subtle: "#dceee4"          # ← brand-soft
bg-success-subtle: "#dceee4"        # ← brand-soft · 합성 — 원본은 들어온 금액·완료를 brand 계열로 표시
bg-warning-subtle: "#f8e3d6"        # ← caution-soft · 합성 — 원본은 주의·실패를 caution 하나로 표시
bg-danger-subtle: "#f8e3d6"         # ← caution-soft · 합성 — 원본은 주의·실패를 caution 하나로 표시
fg-strong: "#16201b"                # ← ink
fg-default: "#16201b"               # ← ink
fg-secondary: "#596359"             # ← ink-muted
fg-tertiary: "#596359"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#596359"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#ffffff"              # ← on-brand
fg-brand: "#1d5c45"                 # ← brand
fg-success: "#1d5c45"               # ← brand · 합성 — 원본은 들어온 금액(+)을 brand로 표시
fg-warning: "#a8420c"               # ← caution · 합성 — 원본은 주의·실패를 caution 하나로 표시
fg-danger: "#a8420c"                # ← caution
border-subtle: "#dcd8ce"            # ← line
border-default: "#757d77"           # ← line-strong
border-strong: "#757d77"            # ← line-strong
border-brand: "#1d5c45"             # ← brand
```

### Semantic alias — Dark

```yaml
bg-canvas: "#121614"                # ← surface
bg-surface: "#1b201d"               # ← surface-raised
bg-subtle: "#0c0f0d"                # ← surface-sunken
bg-muted: "#0c0f0d"                 # ← surface-sunken
bg-elevated: "#1b201d"              # ← surface-raised
bg-inverse: "#1f3a2e"               # ← hero · 합성 — 대시보드 최상단 한도 카드 전용 깊은 바탕을 반전 면으로 재사용
bg-brand: "#6fcf9f"                 # ← brand
bg-brand-subtle: "#1f3a2e"          # ← brand-soft
bg-success-subtle: "#1f3a2e"        # ← brand-soft · 합성 — 원본은 들어온 금액·완료를 brand 계열로 표시
bg-warning-subtle: "#3d2618"        # ← caution-soft · 합성 — 원본은 주의·실패를 caution 하나로 표시
bg-danger-subtle: "#3d2618"         # ← caution-soft · 합성 — 원본은 주의·실패를 caution 하나로 표시
fg-strong: "#eef1ec"                # ← ink
fg-default: "#eef1ec"               # ← ink
fg-secondary: "#a3ada6"             # ← ink-muted
fg-tertiary: "#a3ada6"              # ← ink-muted · 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
fg-disabled: "#a3ada6"              # ← ink-muted · 합성 — 원본에 비활성 글자색 없음
fg-on-brand: "#0d1f17"              # ← on-brand
fg-brand: "#6fcf9f"                 # ← brand
fg-success: "#6fcf9f"               # ← brand · 합성 — 원본은 들어온 금액(+)을 brand로 표시
fg-warning: "#ff9a5c"               # ← caution · 합성 — 원본은 주의·실패를 caution 하나로 표시
fg-danger: "#ff9a5c"                # ← caution
border-subtle: "#2b322e"            # ← line
border-default: "#68736c"           # ← line-strong
border-strong: "#68736c"            # ← line-strong
border-brand: "#6fcf9f"             # ← brand
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `surface` | #f5f3ee | #121614 | 앱 전체 바탕. 카드 사이 여백이 이 색으로 보입니다. |
| `surface-raised` | #ffffff | #1b201d | 카드, 시트, 하단 탭바 바탕. |
| `surface-sunken` | #ebe8e0 | #0c0f0d | 검색창, 입력칸, 아이콘 타일 바탕, 진행바 빈 트랙. |
| `line` | #dcd8ce | #2b322e | 카드 테두리와 목록 구분선(장식용, 의미 없음). |
| `line-strong` | #757d77 | #68736c | 입력칸·보조 버튼 테두리. surface와 surface-raised 위에서 3:1 이상. |
| `ink` | #16201b | #eef1ec | 본문·숫자 기본 글자색. surface, surface-raised, surface-sunken 위. |
| `ink-muted` | #596359 | #a3ada6 | 라벨, 날짜, 보조 설명. surface·surface-raised 위 4.5:1 이상. |
| `brand` | #1d5c45 | #6fcf9f | MOA 모스 그린. 주요 버튼, 활성 탭, 들어온 금액(+). surface·surface-raised 위 텍스트로도 사용 가능. |
| `on-brand` | #ffffff | #0d1f17 | brand 채움 위 글자·아이콘. |
| `brand-soft` | #dceee4 | #1f3a2e | 선택된 칩, 등급 배지, 브랜드 보너스 카드 바탕. 위 글자는 brand-ink. |
| `brand-ink` | #174a38 | #bfeed5 | brand-soft 위 글자. |
| `sun` | #f4c542 | #f4c542 | MOA 선 옐로. ‘지금 쓸 수 있는 돈’ 하나만 가리킵니다: 남은 출금 한도 막대, 출금 버튼. 위 글자는 on-sun. |
| `on-sun` | #16201b | #16201b | sun 채움 위 글자. |
| `sun-soft` | #fbefc8 | #3a3320 | 광고 배너, 이벤트 카드 바탕. 위 글자는 ink. |
| `hero` | #16201b | #1f3a2e | 대시보드 최상단 ‘출금 한도’ 카드 하나에만 쓰는 깊은 바탕. |
| `on-hero` | #f5f3ee | #f2f7f3 | hero 위 금액·제목. |
| `on-hero-muted` | #b7c2bb | #b9cdc1 | hero 위 라벨·범례. |
| `hero-used` | #5d6e65 | #6e8a7b | hero 막대에서 ‘이미 출금한 금액’ 구간. 남은 한도(sun)와 밝기로 구분됩니다. |
| `info` | #2457a6 | #8fb4f0 | 정보·진행 중 상태(접수됨, 처리 중). 텍스트로 사용 가능. |
| `info-soft` | #dfe8f6 | #1c2a40 | info 배지 바탕, 정보성 보너스 카드. |
| `caution` | #a8420c | #ff9a5c | 주의·실패·한도 부족. 항상 단어나 아이콘과 함께 씁니다(색만으로 구분 금지). |
| `caution-soft` | #f8e3d6 | #3d2618 | caution 배지 바탕. |
| `focus` | #2457a6 | #8fb4f0 | 키보드 포커스 링 2px. 모든 바탕에서 3:1 이상. |

## Typography

### 서체 선택

- **Primary**: `"Pretendard Variable", Pretendard, "Apple SD Gothic Neo", "Malgun Gothic", system-ui, sans-serif`

### Type ramp

```yaml
display1: 34/700/1.18/-0.8px      # ← amount-xl (34px/40px) 화면당 하나, 가장 중요한 금액. 고정폭 숫자(tnum).
display2: 24/700/1.33/-0.6px      # ← title (24px/32px) 화면 제목, 인사말.
display3: 24/700/1.25/-0.5px      # ← amount-lg (24px/30px) 보너스 카드·자산 상세의 대표 금액.
title1: 19/700/1.37/-0.4px        # ← headline (19px/26px) 섹션 제목.
title2: 19/700/1.37/-0.4px        # ← headline (19px/26px) 섹션 제목.
title3: 16/600/1.5/-0.2px         # ← body-strong (16px/24px) 버튼, 강조 목록 제목.
label1: 14/500/1.43/-0.1px        # ← label (14px/20px) 카드 라벨, 탭, 칩, 메뉴 타일.
label2: 13/400/1.38/0             # ← caption (13px/18px) 날짜, 보조 설명. 13px 미만 금지.
body1: 16/400/1.5/-0.2px          # ← body (16px/24px) 본문, 목록 제목.
body1-read: 16/400/1.5/-0.2px     # ← body (16px/24px) 본문, 목록 제목.
body2: 14/500/1.43/-0.1px         # ← label (14px/20px) 카드 라벨, 탭, 칩, 메뉴 타일.
caption1: 13/400/1.38/0           # ← caption (13px/18px) 날짜, 보조 설명. 13px 미만 금지.
```

### 시안 전용 글꼴 스타일

| 원본 스타일 | 크기/굵기/줄높이/자간 | 용도 |
|---|---|---|
| `amount-md` | 18/700/1.33/-0.3px | 요약 타일, 목록 오른쪽 금액. |

## Spacing

```yaml
space-4: 4        # ← space-1 아이콘과 글자 사이.
space-8: 8        # ← space-2 칩 사이, 라벨과 값 사이.
space-12: 12      # ← space-3 카드 안 행 간격, 그리드 간격.
space-16: 16      # ← space-4 화면 좌우 여백, 카드 사이.
space-20: 20      # ← space-5 카드 안쪽 여백.
space-24: 24      # ← space-6 섹션 사이.
space-32: 32      # ← space-8 화면 최상단·최하단 여백.
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
radius-12: 12       # 표준 ladder
radius-16: 16       # 표준 ladder
radius-8: 8         # ← radius-sm 8px — 배지, 작은 아이콘 타일.
radius-14: 14       # ← radius-md 14px · 시안 전용(비-4) — 버튼, 입력칸, 배너, 메뉴 타일.
radius-22: 22       # ← radius-lg 22px · 시안 전용(비-4) — 카드, 시트 상단.
radius-full: 9999   # ← radius-pill 999px — 계정 칩, 칩, 진행바.
```

## Elevation & Depth

```yaml
shadow-pop: "0 -8px 24px rgba(22,32,27,0.10)"  # ← shadow-sheet · dark 0 -8px 24px rgba(0,0,0,0.45)
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | 원본 컴포넌트 README 참조 (주요 버튼 brand, 보조 line-strong 테두리) |
| input | 검색창·입력칸 (surface-sunken 바탕) |
| badge | 등급·상태 배지 (brand-soft · info-soft · caution-soft) |
| chip | 선택 칩 (brand-soft) |
| avatar | 원본 없음 — 템플릿 DESIGN.md 기본 명세 + 이 시안 토큰 |
| icon-button | 원본 없음 — 아이콘 타일(surface-sunken)로 대체 |
| icon | README 아이콘 목록 (이름 기반 아이콘 세트) |

### 원본 컴포넌트 (13종)

| 컴포넌트 | 요약 |
|---|---|
| ActivityList | 최근 보너스·출금 내역. |
| AdBanner | 대시보드 중간과 쇼핑몰 상단에 들어가는 광고·이벤트 배너. |
| AppBar | 상단 바는 비워 둡니다: 왼쪽에 플랫폼 상호(또는 화면 제목), 오른쪽에 알림과 계정. |
| AssetList | 코인 · 포인트 · 채굴 코인을 한 카드 안 3행으로. |
| BonusCards | 누적 보너스 현황(구성 막대) + 보너스 종류별 카드(가로 스와이프). |
| BottomNav | 하단 탭 5개: 홈 · 보너스 · 채굴 · 쇼핑 · **전체**. |
| Buttons | 높이 52px(작은 버튼 40px), `radius-md`, 글자 `body-strong`. |
| Chips | 필터 칩(가로 스크롤)과 기간 선택용 세그먼트. |
| Field | 입력칸은 라벨을 위에, 높이 56px(금액은 72px 숫자 서체), 테두리 `line-strong`. |
| GradeChip | 나의 등급과 다음 등급까지의 진행률을 인사말 아래 한 줄 칩으로. |
| LimitCard | 출금 가능 한도, 남은 한도, 출금한 금액을 **숫자 3개가 아닌 막대 1개**로 보여주는 대시보드 최상단 카드. |
| ReferralLink | 추천 링크를 **복사 · QR · 공유** 세 버튼과 함께 한 줄로. |
| StatTiles | 내 구매실적 · 받은 총 보너스 · 나의 팀 전체 실적을 한 줄 3칸으로. |

## Known Gaps

- Design System 목록 제목은 AITC, 색인(design-system.json) 제목은 MOA다. 시안 slug는 기존 `moa`(AI 작업대)와 겹치지 않게 `aitc`로 했다.
- 원본은 주의와 실패를 `caution` 하나로 쓴다 — warning·danger 별칭이 같은 값이다(항상 단어·아이콘과 함께 쓰는 원칙).
- 원본 간격 이름은 단계 번호(space-1=4px …)라 템플릿 이름(space-4=4px)으로 값 기준 재매핑했다.
- 라운드 14·22는 4의 배수가 아니라 시안 전용 토큰으로 원래 값을 유지한다(계약 9b). 글꼴 자간은 원본처럼 px 단위다.
- `bg-inverse` ← `hero`: 합성 — 대시보드 최상단 한도 카드 전용 깊은 바탕을 반전 면으로 재사용
- `bg-success-subtle` ← `brand-soft`: 합성 — 원본은 들어온 금액·완료를 brand 계열로 표시
- `bg-warning-subtle` ← `caution-soft`: 합성 — 원본은 주의·실패를 caution 하나로 표시
- `bg-danger-subtle` ← `caution-soft`: 합성 — 원본은 주의·실패를 caution 하나로 표시
- `fg-tertiary` ← `ink-muted`: 합성 — 원본 글자색은 ink·ink-muted 두 단계뿐
- `fg-disabled` ← `ink-muted`: 합성 — 원본에 비활성 글자색 없음
- `fg-success` ← `brand`: 합성 — 원본은 들어온 금액(+)을 brand로 표시
- `fg-warning` ← `caution`: 합성 — 원본은 주의·실패를 caution 하나로 표시

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

MOA(모아)는 회원이 **‘내 돈이 지금 얼마이고, 얼마를 뺄 수 있는지’**를 3초 안에 알게 하는 모바일 웹앱 디자인 시스템입니다. 기준 폭 390px(360–430px 대응), PWA로 홈 화면에 설치해 쓰는 앱 환경을 전제로 합니다.

##### 원칙

1. **한 화면, 한 숫자.** 화면마다 가장 큰 숫자(`amount-xl`)는 하나뿐입니다. 대시보드에서는 ‘남은 출금 한도’.
2. **숫자 3개보다 막대 1개.** 총 한도 · 출금한 금액 · 남은 한도처럼 서로 더해지는 값은 하나의 막대(`LimitCard`, `BonusCards`)로 보여주고, 정확한 값은 범례에 적습니다.
3. **아이콘만 두지 않는다.** 모든 메뉴·탭·버튼은 아이콘 + 글자.
4. **상단은 비우고, 메뉴는 아래에.** 상단 바는 왼쪽 상호(MOA) · 오른쪽 알림 + 계정뿐. 전체 메뉴는 하단 탭 맨 오른쪽 **‘전체’**(격자 아이콘)에서 엽니다 — 엄지가 닿는 자리.
5. **누를 수 있는 것은 48px 이상** (`tap-min`). 숫자 카드·목록 행은 통째로 누를 수 있습니다.
6. **색만으로 말하지 않는다.** 증감은 ▲▼, 상태는 배지 글자, 금액은 +/− 부호를 먼저.

##### 말투

- 존댓말 해요체, 짧게. “출금은 평일 기준 1시간 안에 처리돼요.”
- 질문형 라벨로 입력을 안내합니다: “얼마를 출금할까요?”, “어디로 보낼까요?”
- 업계 용어는 화면에서 풀어 씁니다: ‘PV’는 배지로만, 설명 문장에서는 ‘실적 점수’.
- 이모지 쓰지 않음. 느낌표는 축하(등급 달성) 때만.
- 금액: 원화는 `3,240,000원`, 코인은 소수 4자리 `318.0742`. 1억 이상 요약 칸에서는 `1.2억`/`148.2M` 허용.

##### 색

- 바탕은 `surface`, 카드는 `surface-raised` + 1px `line` 테두리. 카드에 그림자를 쓰지 않습니다(`shadow-sheet`는 탭바·바텀시트 전용).
- `brand`(모스 그린): 주요 버튼, 활성 탭, 들어온 금액(+). 글자 위는 `on-brand`.
- `sun`(선 옐로): **지금 쓸 수 있는 돈**만 가리킵니다 — 남은 한도 막대, 출금 버튼. 다른 데 쓰지 마세요. 글자 위는 `on-sun`.
- `hero`: 대시보드 출금 한도 카드 단 하나의 바탕.
- 상태: 진행/정보 `info`(파랑), 주의/실패 `caution`(주황). 빨강·초록 대비를 쓰지 않아 색각 이상 사용자도 구분됩니다.
- 모든 글자색은 명시된 바탕 위 4.5:1 이상(라이트·다크 모두 확인). 포커스 링은 `focus` 2px.

##### 글꼴

- **Pretendard Variable 한 가족만** 씁니다(`fonts/PretendardVariable.woff2`, OFL). 글과 숫자 모두 `--font-sans` / `--font-num`(같은 스택). 삼성 One UI·국내 금융앱처럼 둥글고 넓은 현대 고딕 계열이라 기기 시스템 글꼴과 섞여도 이질감이 없습니다.
- 숫자는 항상 고정폭(`font-variant-numeric: tabular-nums`) — 금액이 바뀌어도 자릿수가 흔들리지 않습니다.
- 굵기는 3단계만: 400 본문 · 500~600 라벨/버튼 · 700 제목·금액(‘전체’ 화면 제목만 800).
- 자간: 본문 −0.2px, 제목 −0.4~−0.6px, 큰 금액 −0.8px. 한글은 자간을 좁힐수록 단단해 보이지만 13px 이하에서는 0.
- 크기: `title` 24 · `headline` 19 · `body` 16 · `label` 14 · `caption` 13. **13px 미만 금지**(배지 12px 제외). 메뉴 타일 글자 14, 탭 13.
- 숫자: `amount-xl` 34 · `amount-lg` 24 · `amount-md` 18, 모두 700.
- 워드마크 ‘MOA’는 Pretendard 800, ‘MO’ `ink` + ‘A’ `brand`.

##### 간격 · 모서리

- 화면 좌우 `space-4`, 카드 안 `space-5`, 카드 사이 `space-4`, 섹션 사이 `space-6`.
- 카드 `radius-lg`, 버튼·입력·배너 `radius-md`, 배지 `radius-sm`, 계정 칩·칩·막대 `radius-pill`.

##### 아이콘

- 24px 선 아이콘, 선 굵기 1.8(활성 2.2), 둥근 끝. `components/bundle.js`의 `MOA.icon(name)` 또는 `<i data-i="home"></i>` + `MOA.mount()`.
- 이름: all home gift gem bag users user bell copy share chev back down x search coin point up in wallet book receipt inbox globe moon sun notice chat doc shield tree chart award link qr plus check bolt clock logout eye swap.
- 로고 파일은 아직 없습니다. 워드마크는 `--font-num` 700, ‘MO’ `ink` + ‘A’ `brand`로 글자 조판합니다.

##### 광고 배너

- 대시보드 1개(요약 타일과 추천 링크 사이), 채굴·쇼핑 화면 상단 1개. 그 이상 넣지 않습니다.
- 항상 `광고` 표기와 `1 / 3` 페이지 표시. 5초 자동 넘김, 손가락이 닿으면 멈춤.

#### UX 컨셉 · 메뉴 구조

##### 상단 바 — 상호와 계정만

- **홈:** 왼쪽 워드마크 `MOA`, 오른쪽 알림 · 계정 칩(아바타 + 이름 ›). 메뉴 버튼 없음.
- **탭 화면:** 왼쪽 화면 제목, 오른쪽 알림 · 아바타.
- **하위 화면:** 뒤로가기 + 제목만.

##### 전체 메뉴 — 하단 탭 맨 오른쪽

하단 탭 **홈 · 보너스 · 채굴 · 쇼핑 · 전체** 중 맨 오른쪽 `전체`(4칸 격자 아이콘)를 누르면 메뉴만 모인 전체 화면이 탭으로 열립니다(`AllMenu` 화면). 서랍이나 팝업이 아니라 하나의 탭 페이지라서 하단 탭이 그대로 남고, 닫기 버튼이 필요 없습니다.

1. 상단: 큰 제목 ‘전체’ + 오른쪽 검색 · 설정 아이콘
2. 내 프로필(이름 · 등급 · ID) + ‘내 정보’
3. **최근** 쓴 메뉴 한 줄(가로 스크롤)
4. 자주 쓰는 4개(출금하기 · 추천링크 · 조직도 · 1:1문의)
5. 하나의 흰 시트 안에 그룹 제목(회색 + 점선) + 4열 타일
6. 맨 아래: 로그아웃 · 버전

| 그룹 | 메뉴 |
| --- | --- |
| 내 실적 | 내 구매실적 · 팀 전체 실적 · 나의 등급 · 조직도 |
| 보너스 | 누적 보너스 · 보너스 카드 · 최근 내역 · 추천링크 |
| 자산 · 채굴 | 코인 · 포인트 · 채굴 코인 · 채굴현황 |
| 출금 | 출금하기 · 출금주소 설정 · 주소록 · 출금 한도 |
| 쇼핑 | 쇼핑몰 · 주문내역 · 접수내역 |
| 설정 | 언어 설정 · 화면 테마 |
| 고객지원 | 공지사항 · 1:1 문의 · 이용약관 · 개인정보 처리방침 |

조직도는 자주 쓰는 4개와 ‘내 실적’ 그룹에 있고, 들어가도 하단 `전체` 탭이 활성으로 남습니다.

##### 대시보드 순서 (위 → 아래)

1. 인사말 + **등급 칩**(다음 등급까지 링 진행률)
2. **출금 한도 카드** — 남은 한도 큰 숫자, 총 한도/출금한 금액/남은 한도를 막대 하나로, [출금하기] [출금 내역]
3. **요약 타일 3칸** — 내 구매실적 · 받은 총 보너스 · 팀 전체 실적 (▲▼ 증감)
4. **광고 배너** 1개
5. **추천 링크** — 복사 · QR · 공유 한 줄
6. **누적 보너스** — 종류별 구성 막대 + 보너스 카드 가로 스와이프
7. **내 자산** — 코인 · 포인트 · 채굴 코인
8. **최근 보너스** — 날짜별 묶음, 상태 배지

##### 다른 플랫폼과 다른 점

| 흔한 방식 | MOA |
| --- | --- |
| ☰ 아이콘 → 옆 서랍, 긴 목록 | 하단 ‘전체’ 탭 → 최근·자주 쓰는 메뉴 + 그룹 타일 한 페이지 |
| 상단에 메뉴·검색·설정 아이콘이 몰림 | 상단은 상호 + 알림 + 계정만 |
| 숫자 카드 6–9개를 격자로 나열 | 한도는 막대 1개, 요약은 3칸, 나머지는 섹션으로 |
| 출금 한도/남은 한도/출금액 각각 표시 | 하나의 막대에 더해지는 관계로 표시 |
| 조직도 = 확대·축소하는 그래프 | 폴더처럼 펼치는 목록, 이름 탭하면 그 사람 기준으로 재정렬 |
| 주소를 매번 붙여넣기 | 주소록에서 선택 + 네트워크 배지 + 등록 후 24시간 대기 |
| 빨강/초록 증감 | ▲▼ 기호 + 모스/주황 색 |
| 테마 설정은 토글 하나 | 라이트 · 다크 · 기기 설정을 미리보기 카드로 |

##### 화면 목록

`Home` 대시보드 · `AllMenu` 전체(하단 탭) · `Bonus` 보너스 · `Mining` 채굴 · `Withdraw` 출금/주소록 · `Shop` 쇼핑/주문/접수 · `OrgChart` 조직도 · `Settings` 언어/테마/고객지원.
