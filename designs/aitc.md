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

### 변형 대응

#### button

| 계약 변형 | 원본 대응 |
|---|---|
| primary | primary (.m-btn--primary, brand 바탕 + on-brand, 화면의 일반 확인 동작) |
| secondary | ghost (.m-btn--ghost, line-strong 1px 테두리 + surface-raised — 원본은 보조 동작을 'ghost'로 부름) |
| tertiary | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| ghost | 원본 없음(원본 ghost는 테두리 있는 보조 버튼이라 secondary에 배정, 배경·테두리 없는 버튼은 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| danger | 원본 없음(파괴 행동 전용 버튼 변형 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | .m-btn[disabled] (surface-sunken 바탕 + ink-muted 글자) |
| (원본 추가) | sun (.m-btn--sun): 돈이 나가는 동작(출금) 단 하나에만, sun 바탕 + on-sun |
| (원본 추가) | onhero (.m-btn--onhero): hero 카드 위 테두리 버튼(출금 내역) |
| (원본 추가) | sm (.m-btn--sm): 높이 40px, radius-sm |
| (원본 추가) | block (.m-btn--block): 가로 꽉 참 |
| (원본 추가) | 원본 ghost는 테두리가 있는 보조 버튼이라 템플릿 secondary에 대응, 배경 없는 ghost는 원본에 없음 |

#### input

| 계약 변형 | 원본 대응 |
|---|---|
| default | .m-input (높이 56px, line-strong 1px 테두리, radius-md, 라벨은 위 .m-field > span) |
| focus | :focus-visible (focus 2px 실선 + 2px 오프셋, 전역 규칙) |
| error | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | 원본 없음(입력 비활성 상태 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |

#### badge

| 계약 변형 | 원본 대응 |
|---|---|
| active | .m-badge--brand (brand-soft + brand-ink, '지급완료') |
| pending | .m-badge--info (info-soft + info, '정산 중'·'배송 중') |
| inactive | .m-badge 기본 (surface-sunken, '완료') |
| danger | .m-badge--caution (caution-soft + caution, '실패'·'확인 필요' — 빨강 대신 주황) |

### 모바일 컴포넌트 대응

| 템플릿 모바일 컴포넌트 | 원본 대응 |
|---|---|
| bottom-sheet | 원본 없음(README에 바텀시트 언급(shadow-sheet 용도)은 있으나 전용 컴포넌트·CSS 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| mobile-nav | BottomNav — 하단 탭 5개(홈·보너스·채굴·쇼핑·전체), 활성 brand 글자 + 굵은 선 아이콘 |
| nav-drawer | 원본 없음(ux-concept.md: 서랍 대신 하단 '전체' 탭 페이지 사용) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| fab | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| card-row | ActivityList / AssetList의 .m-item — 최소 64px 행, 40px 원형 아이콘 + 제목 + 오른쪽 금액·배지 |

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

- 출금 한도 히어로 카드 — hero 바탕은 이 카드 하나뿐, 남은 한도 34px 700 자간 -0.8px(.m-limit, .m-limit__amt)
- 더해지는 값 막대 1개 — 높이 12px, 조각 간격 3px, radius-pill, hero-used + sun(.m-bar)
- sun 색 = 지금 쓸 수 있는 돈 — 남은 한도 막대와 출금 버튼에만(.m-btn--sun, .m-bar__left)
- 카드는 그림자 없이 1px line 테두리 + radius-lg(.m-card), 그림자는 탭바·시트 전용(shadow-sheet)
- 추천 링크 점선 — 1px dashed line-strong 테두리, 44px 버튼 3개, 복사 성공 시 1.4초 brand + 체크(.m-ref, .is-done)
- 보너스 카드 스와이프 — 232px 폭 스냅 스크롤 카드, 종류별 soft 바탕(.m-swipe, .m-bcard)

### 원본 컴포넌트 (13종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
| ActivityList | 최근 보너스·출금 내역. |  |
| AdBanner | 대시보드 중간과 쇼핑몰 상단에 들어가는 광고·이벤트 배너. |  |
| AppBar | 상단 바는 비워 둡니다: 왼쪽에 플랫폼 상호(또는 화면 제목), 오른쪽에 알림과 계정. |  |
| AssetList | 코인 · 포인트 · 채굴 코인을 한 카드 안 3행으로. |  |
| BonusCards | 누적 보너스 현황(구성 막대) + 보너스 종류별 카드(가로 스와이프). |  |
| BottomNav | 하단 탭 5개: 홈 · 보너스 · 채굴 · 쇼핑 · **전체**. |  |
| Buttons | 높이 52px(작은 버튼 40px), `radius-md`, 글자 `body-strong`. |  |
| Chips | 필터 칩(가로 스크롤)과 기간 선택용 세그먼트. |  |
| Field | 입력칸은 라벨을 위에, 높이 56px(금액은 72px 숫자 서체), 테두리 `line-strong`. |  |
| GradeChip | 나의 등급과 다음 등급까지의 진행률을 인사말 아래 한 줄 칩으로. |  |
| LimitCard | 출금 가능 한도, 남은 한도, 출금한 금액을 **숫자 3개가 아닌 막대 1개**로 보여주는 대시보드 최상단 카드. |  |
| ReferralLink | 추천 링크를 **복사 · QR · 공유** 세 버튼과 함께 한 줄로. |  |
| StatTiles | 내 구매실적 · 받은 총 보너스 · 나의 팀 전체 실적을 한 줄 3칸으로. |  |

### 원본 화면 예시

원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).

- `AllMenu` — 하단 '전체' 탭 — 프로필, 최근 메뉴, 자주 쓰는 4개, 그룹별 4열 타일 시트, 로그아웃·버전
- `Bonus` — 보너스 — 기간 세그먼트, 누적 보너스 구성 막대, 종류별 카드 스와이프, 유형 칩, 날짜별 내역
- `Cover` — 960×288 표지 — hero 슬랩에 한도 막대 3줄, sun·brand 블록과 brand-soft 띠, 워드마크 'MOA', 태그라인 '모으는 만큼, 한눈에. 회원용 모바일 웹앱 디자인 시스템'
- `Home` — 대시보드 — 등급 칩, 출금 한도 히어로 카드, 요약 타일 3칸, 광고, 추천 링크, 누적 보너스, 내 자산, 최근 보너스
- `Mining` — 채굴 — 오늘 목표 진행 링, 누적 채굴·채굴 파워 2칸, 광고, 내 자산, 채굴 내역
- `OrgChart` — 조직도 — 추천/후원 세그먼트, 좌우 라인 실적, 검색, 폴더처럼 펼치는 트리 목록
- `Settings` — 설정·고객지원 — 라이트/다크/기기 테마 미리보기 카드, 언어 라디오, 공지·1:1 문의·약관 목록
- `Shop` — 쇼핑 — 검색, 광고, 카테고리 칩, 2열 상품 카드(PV 배지), 주문/접수 내역
- `Withdraw` — 출금 — 남은 한도 막대, 큰 금액 입력, 빠른 금액 칩, 주소록 선택(네트워크 배지), 수수료·받는 금액, 주의 노트, sun 출금 버튼

### 원본 컴포넌트 스타일

원본 `components/bundle.css`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). `var(--x)`는 원본 토큰 `x`다.

| 구역 | 선택자 | 핵심 속성 |
|---|---|---|
| MOA — component styles. Every value comes from tokens.css. | `body` | background surface · color ink · font-family font-sans · font-size 16px · letter-spacing -0.2px |
| MOA — component styles. Every value comes from tokens.css. | `button` | font inherit · color inherit · background none · border 0 · padding 0 |
| MOA — component styles. Every value comes from tokens.css. | `:focus-visible` | outline 2px solid focus |
| MOA — component styles. Every value comes from tokens.css. | `.m-num` | font-family font-num · letter-spacing -0.3px |
| MOA — component styles. Every value comes from tokens.css. | `.m-ico` | width 24px · height 24px |
| MOA — component styles. Every value comes from tokens.css. | `.m-ico svg` | width 100% · height 100% |
| MOA — component styles. Every value comes from tokens.css. | `.m-ico--sm` | width 18px · height 18px |
| MOA — component styles. Every value comes from tokens.css. | `.m-ico--lg` | width 28px · height 28px |
| MOA — component styles. Every value comes from tokens.css. | `.m-muted` | color ink-muted |
| MOA — component styles. Every value comes from tokens.css. | `.m-plus` | color brand |
| MOA — component styles. Every value comes from tokens.css. | `.m-pad` | padding 0 space-4 |
| MOA — component styles. Every value comes from tokens.css. | `.m-row` | gap space-2 |
| MOA — component styles. Every value comes from tokens.css. | `.m-between` | gap space-3 |
| ── App frame ───────────────────────────── | `.m-app` | width screen-w · max-width 100% · min-height 100% · background surface |
| ── App frame ───────────────────────────── | `.m-body` | padding space-2 space-4 calc(tabbar-h + space-8) |
| ── App bar with “전체” ─────────────────── | `.m-appbar` | height appbar-h · gap space-2 · padding 0 space-3 0 space-4 |
| ── App bar with “전체” ─────────────────── | `.m-appbar__title` | min-width 0 · font-weight 700 · font-size 22px · letter-spacing -0.5px |
| ── App bar with “전체” ─────────────────── | `.m-appbar__end` | gap 2px |
| ── App bar with “전체” ─────────────────── | `.m-account` | gap 6px · height 40px · padding 0 6px 0 4px · border-radius radius-pill · font-size 15px · font-weight 600 · letter-spacing -0.3px |
| ── App bar with “전체” ─────────────────── | `.m-account__av` | width 32px · height 32px · border-radius 50% · background brand · color on-brand · font-size 14px · font-weight 700 |
| ── App bar with “전체” ─────────────────── | `.m-account .m-ico` | width 16px · height 16px · color ink-muted |
| ── App bar with “전체” ─────────────────── | `.m-wordmark` | font-family font-num · font-weight 800 · font-size 21px · letter-spacing 0.5px · color ink |
| ── App bar with “전체” ─────────────────── | `.m-wordmark b` | color brand |
| ── App bar with “전체” ─────────────────── | `.m-iconbtn` | width tap-min · height tap-min · border-radius radius-pill |
| ── App bar with “전체” ─────────────────── | `.m-dot` | width 8px · height 8px · border-radius 50% · background caution · border 2px solid surface |
| ── App bar with “전체” ─────────────────── | `.m-appbar--sub .m-appbar__title` | font-size 18px |
| ── Greeting + grade ────────────────────── | `.m-hello` | font-size 24px · font-weight 700 · letter-spacing -0.6px |
| ── Greeting + grade ────────────────────── | `.m-grade` | gap space-2 · height 36px · padding 0 12px 0 6px · border-radius radius-pill · background brand-soft · color brand-ink · font-size 14px · font-weight 600 |
| ── Greeting + grade ────────────────────── | `.m-grade__ring` | width 26px · height 26px · border-radius 50% · background conic-gradient(brand calc(p * 1%), surface-raised 0) |
| ── Greeting + grade ────────────────────── | `.m-grade__ring i` | width 18px · height 18px · border-radius 50% · background brand-soft |
| ── Greeting + grade ────────────────────── | `.m-grade__ring .m-ico` | width 13px · height 13px |
| ── Greeting + grade ────────────────────── | `.m-grade small` | font-weight 500 · font-size 13px · opacity .9 |
| ── Cards ───────────────────────────────── | `.m-card` | background surface-raised · border 1px solid line · border-radius radius-lg · padding space-5 |
| ── Cards ───────────────────────────────── | `.m-card--flat` | padding 0 |
| ── Cards ───────────────────────────────── | `.m-label` | font-size 14px · font-weight 500 · color ink-muted |
| ── Cards ───────────────────────────────── | `.m-cap` | font-size 13px · color ink-muted |
| ── Limit hero (출금 한도) ──────────────── | `.m-limit` | background hero · color on-hero · border-radius radius-lg · padding space-5 |
| ── Limit hero (출금 한도) ──────────────── | `.m-limit .m-label, .m-limit .m-cap` | color on-hero-muted |
| ── Limit hero (출금 한도) ──────────────── | `.m-limit__amt` | font-family font-num · font-size 34px · font-weight 700 · letter-spacing -0.8px |
| ── Limit hero (출금 한도) ──────────────── | `.m-limit__amt small` | font-size 18px · font-weight 500 · color on-hero-muted |
| ── Limit hero (출금 한도) ──────────────── | `.m-bar` | gap 3px · height 12px |
| ── Limit hero (출금 한도) ──────────────── | `.m-bar > span` | border-radius radius-pill |
| ── Limit hero (출금 한도) ──────────────── | `.m-bar__used` | background hero-used |
| ── Limit hero (출금 한도) ──────────────── | `.m-bar__left` | background sun |
| ── Limit hero (출금 한도) ──────────────── | `.m-legend` | gap space-2 |
| ── Limit hero (출금 한도) ──────────────── | `.m-legend div` | font-size 13px · color on-hero-muted |
| ── Limit hero (출금 한도) ──────────────── | `.m-legend b` | font-family font-num · font-size 15px · font-weight 700 · color on-hero |
| ── Limit hero (출금 한도) ──────────────── | `.m-legend i` | width 8px · height 8px · border-radius 50% |
| ── Limit hero (출금 한도) ──────────────── | `.m-limit__actions` | gap space-2 |
| ── Buttons ─────────────────────────────── | `.m-btn` | height 52px · min-width tap-min · padding 0 space-5 · gap space-2 · border-radius radius-md · font-size 16px · font-weight 600 |
| ── Buttons ─────────────────────────────── | `.m-btn--primary` | background brand · color on-brand |
| ── Buttons ─────────────────────────────── | `.m-btn--sun` | background sun · color on-sun |
| ── Buttons ─────────────────────────────── | `.m-btn--ghost` | border 1px solid line-strong · color ink · background surface-raised |
| ── Buttons ─────────────────────────────── | `.m-btn--onhero` | border 1px solid hero-used · color on-hero |
| ── Buttons ─────────────────────────────── | `.m-btn--block` | width 100% |
| ── Buttons ─────────────────────────────── | `.m-btn--sm` | height 40px · padding 0 space-4 · font-size 14px · border-radius radius-sm |
| ── Buttons ─────────────────────────────── | `.m-btn[disabled]` | background surface-sunken · color ink-muted |
| ── Stat tiles ──────────────────────────── | `.m-stats` | gap space-2 |
| ── Stat tiles ──────────────────────────── | `.m-stat` | background surface-raised · border 1px solid line · border-radius radius-md · padding 14px 12px · min-height 108px |
| ── Stat tiles ──────────────────────────── | `.m-stat__ico` | width 28px · height 28px · border-radius radius-sm · background surface-sunken · color brand |
| ── Stat tiles ──────────────────────────── | `.m-stat__ico .m-ico` | width 17px · height 17px |
| ── Stat tiles ──────────────────────────── | `.m-stat b` | font-family font-num · font-size 18px · font-weight 700 · letter-spacing -0.4px |
| ── Stat tiles ──────────────────────────── | `.m-delta` | font-size 13px · font-weight 600 · color brand |
| ── Stat tiles ──────────────────────────── | `.m-delta--down` | color caution |
| ── Section head ────────────────────────── | `.m-sec__head h2` | font-size 19px · font-weight 700 · letter-spacing -0.4px |
| ── Section head ────────────────────────── | `.m-more` | min-height 40px · font-size 14px · font-weight 500 · color ink-muted |
| ── Section head ────────────────────────── | `.m-more .m-ico` | width 16px · height 16px |
| ── Ad banner ───────────────────────────── | `.m-ad` | gap space-3 · min-height 84px · padding 14px 44px 14px space-4 · border-radius radius-md · background sun-soft · color ink |
| ── Ad banner ───────────────────────────── | `.m-ad__tag` | font-size 11px · font-weight 600 · padding 1px 6px · border-radius 4px · border 1px solid line-strong · color ink-muted |
| ── Ad banner ───────────────────────────── | `.m-ad__art` | width 52px · height 52px · border-radius radius-md · background sun · color on-sun |
| ── Ad banner ───────────────────────────── | `.m-ad__txt b` | font-size 16px |
| ── Ad banner ───────────────────────────── | `.m-ad__txt span` | font-size 13px · color ink-muted |
| ── Ad banner ───────────────────────────── | `.m-ad__page` | font-family font-num · font-size 12px · color ink-muted |
| ── Ad banner ───────────────────────────── | `.m-ad--brand` | background brand-soft |
| ── Ad banner ───────────────────────────── | `.m-ad--brand .m-ad__art` | background brand · color on-brand |
| ── Ad banner ───────────────────────────── | `.m-ad--brand .m-ad__txt b` | color brand-ink |
| ── Ad banner ───────────────────────────── | `.m-ad--wide` | min-height 132px |
| ── Referral link ───────────────────────── | `.m-ref` | gap space-3 · padding 12px 12px 12px space-4 · background surface-raised · border 1px dashed line-strong · border-radius radius-md |
| ── Referral link ───────────────────────── | `.m-ref__txt` | min-width 0 |
| ── Referral link ───────────────────────── | `.m-ref__url` | font-family font-num · font-size 15px · font-weight 600 |
| ── Referral link ───────────────────────── | `.m-ref__btns` | gap 6px |
| ── Referral link ───────────────────────── | `.m-ref__btns button` | width 44px · height 44px · border-radius radius-sm · background surface-sunken |
| ── Referral link ───────────────────────── | `.m-ref__btns button.is-done` | background brand · color on-brand |
| ── Bonus composition + cards ───────────── | `.m-mix` | height 10px · gap 2px · border-radius radius-pill |
| ── Bonus composition + cards ───────────── | `.m-mix span:nth-child(1)` | background brand |
| ── Bonus composition + cards ───────────── | `.m-mix span:nth-child(2)` | background sun |
| ── Bonus composition + cards ───────────── | `.m-mix span:nth-child(3)` | background info |
| ── Bonus composition + cards ───────────── | `.m-mix span:nth-child(4)` | background line-strong |
| ── Bonus composition + cards ───────────── | `.m-mixkey` | gap 6px space-3 · font-size 13px · color ink-muted |
| ── Bonus composition + cards ───────────── | `.m-mixkey b` | color ink · font-family font-num · font-weight 700 |
| ── Bonus composition + cards ───────────── | `.m-mixkey i` | width 8px · height 8px · border-radius 2px |
| ── Bonus composition + cards ───────────── | `.m-swipe` | gap space-3 · padding 0 space-4 4px |
| ── Bonus composition + cards ───────────── | `.m-bcard` | width 232px · min-height 148px · border-radius radius-lg · padding space-4 · background brand-soft · color brand-ink |
| ── Bonus composition + cards ───────────── | `.m-bcard__top` | font-size 14px · font-weight 600 |
| ── Bonus composition + cards ───────────── | `.m-bcard__amt` | font-family font-num · font-size 24px · font-weight 700 · letter-spacing -0.5px · color ink |
| ── Bonus composition + cards ───────────── | `.m-bcard .m-cap` | color inherit · opacity .92 |
| ── Bonus composition + cards ───────────── | `.m-bcard--sun` | background sun-soft · color ink |
| ── Bonus composition + cards ───────────── | `.m-bcard--info` | background info-soft · color info |
| ── Bonus composition + cards ───────────── | `.m-bcard--ink` | background hero · color on-hero-muted |
| ── Bonus composition + cards ───────────── | `.m-bcard--ink .m-bcard__amt` | color on-hero |
| ── Bonus composition + cards ───────────── | `.m-badge` | gap 4px · height 24px · padding 0 8px · border-radius radius-sm · font-size 12px · font-weight 600 · background surface-sunken · color ink |
| ── Bonus composition + cards ───────────── | `.m-badge--brand` | background brand-soft · color brand-ink |
| ── Bonus composition + cards ───────────── | `.m-badge--info` | background info-soft · color info |
| ── Bonus composition + cards ───────────── | `.m-badge--caution` | background caution-soft · color caution |
| ── Bonus composition + cards ───────────── | `.m-badge--sun` | background sun · color on-sun |
| ── Asset rows / list ───────────────────── | `.m-list` | padding 0 |
| ── Asset rows / list ───────────────────── | `.m-item` | gap space-3 · min-height 64px · padding 10px space-4 |
| ── Asset rows / list ───────────────────── | `.m-item + .m-item` | border-top 1px solid line |
| ── Asset rows / list ───────────────────── | `.m-item__ico` | width 40px · height 40px · border-radius 50% · background surface-sunken · color ink |
| ── Asset rows / list ───────────────────── | `.m-item__ico--brand` | background brand-soft · color brand-ink |
| ── Asset rows / list ───────────────────── | `.m-item__ico--sun` | background sun · color on-sun |
| ── Asset rows / list ───────────────────── | `.m-item__ico--info` | background info-soft · color info |
| ── Asset rows / list ───────────────────── | `.m-item__main` | min-width 0 |
| ── Asset rows / list ───────────────────── | `.m-item__main b` | font-size 16px · font-weight 600 |
| ── Asset rows / list ───────────────────── | `.m-item__end b` | font-family font-num · font-size 16px · font-weight 700 |
| ── Asset rows / list ───────────────────── | `.m-item > .m-ico:last-child` | color ink-muted · width 18px · height 18px |
| ── Asset rows / list ───────────────────── | `.m-date` | padding 14px space-4 6px · font-size 13px · font-weight 600 · color ink-muted · background surface-raised |
| ── Bottom tab bar ──────────────────────── | `.m-tabbar` | height tabbar-h · background surface-raised · border-top 1px solid line · box-shadow shadow-sheet |
| ── Bottom tab bar ──────────────────────── | `.m-tab` | gap 2px · font-size 13px · font-weight 500 · color ink-muted |
| ── Bottom tab bar ──────────────────────── | `.m-tab.is-on` | color brand · font-weight 700 |
| ── “전체” menu sheet ───────────────────── | `.m-all` | background surface · min-height 100% |
| ── “전체” menu sheet ───────────────────── | `.m-all__top` | height 64px · padding 0 space-2 0 space-4 |
| ── “전체” menu sheet ───────────────────── | `.m-all__top h1` | font-size 26px · font-weight 800 · letter-spacing -0.8px |
| ── “전체” menu sheet ───────────────────── | `.m-me` | gap space-3 · padding space-4 · background surface-raised · border 1px solid line · border-radius radius-lg |
| ── “전체” menu sheet ───────────────────── | `.m-avatar` | width 48px · height 48px · border-radius 50% · background brand · color on-brand · font-weight 700 · font-size 18px |
| ── “전체” menu sheet ───────────────────── | `.m-recent` | gap space-4 · min-height 56px · padding 0 space-4 · background surface-raised · border 1px solid line · border-radius radius-lg |
| ── “전체” menu sheet ───────────────────── | `.m-recent b` | font-size 15px · color ink-muted |
| ── “전체” menu sheet ───────────────────── | `.m-recent button` | font-size 15px · font-weight 500 · min-height 44px |
| ── “전체” menu sheet ───────────────────── | `.m-search` | gap space-2 · height 48px · padding 0 space-4 · border-radius radius-md · background surface-sunken · color ink-muted · font-size 15px |
| ── “전체” menu sheet ───────────────────── | `.m-quick` | gap space-2 |
| ── “전체” menu sheet ───────────────────── | `.m-quick button` | min-height 76px · border-radius radius-md · background brand · color on-brand · gap 6px · font-size 13px · font-weight 600 |
| ── “전체” menu sheet ───────────────────── | `.m-quick button:nth-child(2)` | background sun · color on-sun |
| ── “전체” menu sheet ───────────────────── | `.m-quick button:nth-child(n+3)` | background surface-raised · color ink · border 1px solid line |
| ── “전체” menu sheet ───────────────────── | `.m-sheet` | background surface-raised · border 1px solid line · border-radius radius-lg · padding space-2 space-2 space-4 |
| ── “전체” menu sheet ───────────────────── | `.m-group h3` | gap space-3 · font-size 14px · font-weight 700 · color ink-muted |
| ── “전체” menu sheet ───────────────────── | `.m-group h3::after` | border-top 2px dotted line |
| ── “전체” menu sheet ───────────────────── | `.m-tile` | min-height 88px · gap 6px · border-radius radius-md · font-size 14px · letter-spacing -0.3px · padding 6px 2px |
| ── “전체” menu sheet ───────────────────── | `.m-tile i.m-ico` | width 44px · height 44px · padding 10px · border-radius radius-md · background surface-sunken · color brand |
| ── “전체” menu sheet ───────────────────── | `.m-all__foot` | padding space-4 space-2 · font-size 13px · color ink-muted |
| ── Chips / segmented / fields ──────────── | `.m-chips` | gap space-2 |
| ── Chips / segmented / fields ──────────── | `.m-chip` | height 36px · padding 0 14px · border-radius radius-pill · border 1px solid line-strong · background surface-raised · font-size 14px · font-weight 500 |
| ── Chips / segmented / fields ──────────── | `.m-chip.is-on` | background ink · color surface · font-weight 600 |
| ── Chips / segmented / fields ──────────── | `.m-seg` | padding 4px · border-radius radius-md · background surface-sunken |
| ── Chips / segmented / fields ──────────── | `.m-seg button` | height 40px · border-radius 10px · font-size 14px · font-weight 500 · color ink-muted |
| ── Chips / segmented / fields ──────────── | `.m-seg button.is-on` | background surface-raised · color ink · font-weight 700 · box-shadow 0 1px 2px rgba(22,32,27,.12) |
| ── Chips / segmented / fields ──────────── | `.m-field > span` | font-size 14px · font-weight 500 · color ink-muted |
| ── Chips / segmented / fields ──────────── | `.m-input` | gap space-2 · min-height 56px · padding 0 space-4 · border-radius radius-md · border 1px solid line-strong · background surface-raised · font-size 16px |
| ── Chips / segmented / fields ──────────── | `.m-input--big` | font-family font-num · font-size 28px · font-weight 700 · letter-spacing -0.6px · min-height 72px |
| ── Chips / segmented / fields ──────────── | `.m-note` | gap space-2 · padding 12px space-4 · border-radius radius-md · background info-soft · color info · font-size 14px |
| ── Chips / segmented / fields ──────────── | `.m-note--caution` | background caution-soft · color caution |
| ── Mining ──────────────────────────────── | `.m-mine` | gap space-5 |
| ── Mining ──────────────────────────────── | `.m-ring` | width 120px · height 120px · border-radius 50% · background conic-gradient(brand calc(p * 1%), surface-sunken 0) |
| ── Mining ──────────────────────────────── | `.m-ring > div` | width 96px · height 96px · border-radius 50% · background surface-raised |
| ── Mining ──────────────────────────────── | `.m-ring b` | font-family font-num · font-size 24px · font-weight 700 |
| ── Mining ──────────────────────────────── | `.m-live` | gap 6px · font-size 13px · font-weight 600 · color brand |
| ── Mining ──────────────────────────────── | `.m-live::before` | width 8px · height 8px · border-radius 50% · background brand · box-shadow 0 0 0 4px brand-soft |
| ── Mining ──────────────────────────────── | `.m-progress` | height 8px · border-radius radius-pill · background surface-sunken |
| ── Mining ──────────────────────────────── | `.m-progress > span` | height 100% · background brand · border-radius inherit |
| ── Shop ────────────────────────────────── | `.m-products` | gap space-3 |
| ── Shop ────────────────────────────────── | `.m-product` | background surface-raised · border 1px solid line · border-radius radius-md |
| ── Shop ────────────────────────────────── | `.m-product__img` | background surface-sunken · color line-strong |
| ── Shop ────────────────────────────────── | `.m-product__img .m-ico` | width 44px · height 44px |
| ── Shop ────────────────────────────────── | `.m-product__body` | padding 10px 12px 12px |
| ── Shop ────────────────────────────────── | `.m-product__body p` | font-size 14px |
| ── Shop ────────────────────────────────── | `.m-product__body b` | font-family font-num · font-size 16px |
| ── Org chart (folder tree) ─────────────── | `.m-tree` | padding 0 |
| ── Org chart (folder tree) ─────────────── | `.m-node` | gap space-3 · min-height 60px · padding 8px space-4 8px calc(space-4 + var(--d, 0) * 22px) · border-top 1px solid line |
| ── Org chart (folder tree) ─────────────── | `.m-node::before` | width 10px · border-bottom 1px solid line-strong |
| ── Org chart (folder tree) ─────────────── | `.m-node__av` | width 36px · height 36px · border-radius 50% · background surface-sunken · font-size 13px · font-weight 700 |
| ── Org chart (folder tree) ─────────────── | `.m-node__main` | min-width 0 |
| ── Org chart (folder tree) ─────────────── | `.m-node__main b` | font-size 15px |
| ── Org chart (folder tree) ─────────────── | `.m-node__end` | font-family font-num · font-size 14px · font-weight 600 |
| ── Org chart (folder tree) ─────────────── | `.m-legs` | gap space-2 |
| ── Org chart (folder tree) ─────────────── | `.m-leg` | padding 14px · border-radius radius-md · background surface-sunken |
| ── Org chart (folder tree) ─────────────── | `.m-leg b` | font-family font-num · font-size 18px |
| ── Settings rows ───────────────────────── | `.m-radio` | width 22px · height 22px · border-radius 50% · border 2px solid line-strong |
| ── Settings rows ───────────────────────── | `.m-radio.is-on` | border 7px solid brand |
| ── Settings rows ───────────────────────── | `.m-themes` | gap space-2 |
| ── Settings rows ───────────────────────── | `.m-theme` | border-radius radius-md · border 2px solid line · padding 8px · font-size 14px · font-weight 600 · background surface-raised |
| ── Settings rows ───────────────────────── | `.m-theme__mini` | height 64px · border-radius 8px · padding 8px · gap 5px |
| ── Settings rows ───────────────────────── | `.m-theme__mini i` | height 8px · border-radius 4px |
| ── Settings rows ───────────────────────── | `.m-theme__mini--l` | background #f5f3ee · border 1px solid #dcd8ce |
| ── Settings rows ───────────────────────── | `.m-theme__mini--l i` | background #16201b |
| ── Settings rows ───────────────────────── | `.m-theme__mini--l i + i` | background #1d5c45 · width 60% |
| ── Settings rows ───────────────────────── | `.m-theme__mini--d` | background #121614 · border 1px solid #2b322e |
| ── Settings rows ───────────────────────── | `.m-theme__mini--d i` | background #eef1ec |
| ── Settings rows ───────────────────────── | `.m-theme__mini--d i + i` | background #6fcf9f · width 60% |
| ── Settings rows ───────────────────────── | `.m-theme__mini--s` | background linear-gradient(90deg, #f5f3ee 50%, #121614 50%) · border 1px solid #8a928c |
| ── Settings rows ───────────────────────── | `.m-theme__mini--s i` | background #8a928c |
| ── Settings rows ───────────────────────── | `.m-theme__mini--s i + i` | background #f4c542 · width 60% |

## Do's and Don'ts

**Do**

- 화면마다 가장 큰 숫자(amount-xl)는 하나
- 서로 더해지는 값은 막대 하나로, 정확한 값은 범례에
- 모든 메뉴·탭·버튼은 아이콘 + 글자
- 누를 수 있는 것은 48px 이상(tap-min)
- 증감은 ▲▼, 상태는 배지 글자, 금액은 +/− 부호를 먼저
- 숫자는 항상 tabular-nums
- 새 메뉴는 '전체' 화면 그룹에 추가
- 입력은 질문형 라벨로 안내(얼마를 출금할까요?)

**Don't**

- 카드에 그림자 쓰지 않기
- sun 색을 '쓸 수 있는 돈' 외에 쓰지 않기
- 빨강·초록 대비로 상태 구분하지 않기
- 13px 미만 글자 금지(배지 12px 제외)
- 이모지 쓰지 않기, 느낌표는 등급 달성 축하 때만
- 하단 탭 늘리지 않기
- 광고 배너는 화면당 1개 초과 금지
- 상단 바에 메뉴 버튼 두지 않기(오른쪽 요소 최대 2개)

## Responsive Behavior

- 기준 폭 390px, 360–430px 대응, PWA 설치 전제
- 화면 좌우 space-4, 카드 안 space-5, 카드 사이 space-4, 섹션 사이 space-6
- 본문 하단 패딩 tabbar-h + space-8로 하단 탭에 가리지 않게(.m-body)
- 터치 타깃 48px(tap-min), 아이콘 버튼도 tap-min 정사각(.m-iconbtn)

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
