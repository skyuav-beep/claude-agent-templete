---
name: AEG Soft
slug: aeg-soft
category: consumer
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/65R8okgmxrb2cHf92VHXBC
related_services: ["Samsung Health"]
lang: ko
policy:
  shadow_on_cards: true
  gradient_locations: ["background","hero"]
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/65R8okgmxrb2cHf92VHXBC
  version: "1794797831-7047"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/aeg-soft.map.json
---

# AEG Soft — design.md

> Samsung Health(One UI) 스타일로 다시 정리한 AEG 회원 앱 — 밝은 파스텔 바탕 위 큰 라운드 흰 카드, 카드마다 굵은 고딕 숫자 하나가 먼저 읽히는 모바일 시안.

본 시안은 Claude Design System 「AEG Soft」(https://claude.ai/artifact/65R8okgmxrb2cHf92VHXBC)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/aeg-soft.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

Samsung Health(One UI) 스타일로 다시 정리한 AEG 회원 앱 — 밝은 파스텔 바탕 위 큰 라운드 흰 카드, 카드마다 굵은 고딕 숫자 하나가 먼저 읽히는 모바일 시안.

- 카드 그림자: 허용 · gradient: background, hero · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#f2b705"        # ← gold-500
brand-text: "#7f5900"           # ← gold-700
brand-tint: "#fff3c4"           # ← gold-100
```

### Semantic alias — Light

```yaml
bg-canvas: "#f3f5f1"                # ← bg-base
bg-surface: "#ffffff"               # ← surface-card
bg-subtle: "#f1f3ef"                # ← surface-sunken
bg-muted: "#f1f3ef"                 # ← surface-sunken
bg-elevated: "#ffffff"              # ← surface-card
bg-inverse: "#16181b"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용(칩 선택 상태가 ink 면)
bg-brand: "#f2b705"                 # ← gold-500
bg-brand-subtle: "#fff3c4"          # ← gold-100
bg-success-subtle: "#f1f3ef"        # ← surface-sunken · 합성 — 원본에 성공 바탕이 없음(중립 타일)
bg-warning-subtle: "#ffe9d6"        # ← warn-100
bg-danger-subtle: "#ffe9d6"         # ← warn-100 · 합성 — 원본에 위험 바탕이 없어 경고 바탕 재사용
fg-strong: "#16181b"                # ← ink
fg-default: "#16181b"               # ← ink
fg-secondary: "#474c53"             # ← ink-2
fg-tertiary: "#676c74"              # ← ink-3
fg-disabled: "#676c74"              # ← ink-3 · 합성 — 원본은 ink-3보다 연한 글자를 금지
fg-on-brand: "#1d1606"              # ← on-gold
fg-brand: "#7f5900"                 # ← gold-700
fg-success: "#147a38"               # ← up
fg-warning: "#9a4300"               # ← warn-700
fg-danger: "#c8323a"                # ← down
border-subtle: "#e5e8e2"            # ← line
border-default: "#e5e8e2"           # ← line
border-strong: "#e5e8e2"            # ← line · 합성 — 원본은 선 색 하나(카드 바깥 테두리 금지)
border-brand: "#f2b705"             # ← gold-500
```

### Semantic alias — Dark

```yaml
bg-canvas: "#0e1013"                # ← bg-base
bg-surface: "#1c1f23"               # ← surface-card
bg-subtle: "#262a2f"                # ← surface-sunken
bg-muted: "#262a2f"                 # ← surface-sunken
bg-elevated: "#1c1f23"              # ← surface-card
bg-inverse: "#f3f4f5"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용(칩 선택 상태가 ink 면)
bg-brand: "#f5c02a"                 # ← gold-500
bg-brand-subtle: "#3a3012"          # ← gold-100
bg-success-subtle: "#262a2f"        # ← surface-sunken · 합성 — 원본에 성공 바탕이 없음(중립 타일)
bg-warning-subtle: "#3b2414"        # ← warn-100
bg-danger-subtle: "#3b2414"         # ← warn-100 · 합성 — 원본에 위험 바탕이 없어 경고 바탕 재사용
fg-strong: "#f3f4f5"                # ← ink
fg-default: "#f3f4f5"               # ← ink
fg-secondary: "#c4c8cd"             # ← ink-2
fg-tertiary: "#9aa0a8"              # ← ink-3
fg-disabled: "#9aa0a8"              # ← ink-3 · 합성 — 원본은 ink-3보다 연한 글자를 금지
fg-on-brand: "#1d1606"              # ← on-gold
fg-brand: "#f5c64a"                 # ← gold-700
fg-success: "#4cd07a"               # ← up
fg-warning: "#ffb27a"               # ← warn-700
fg-danger: "#ff6b6e"                # ← down
border-subtle: "#30353b"            # ← line
border-default: "#30353b"           # ← line
border-strong: "#30353b"            # ← line · 합성 — 원본은 선 색 하나(카드 바깥 테두리 금지)
border-brand: "#f5c02a"             # ← gold-500
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `bg-base` | #f3f5f1 | #0e1013 | 앱 바탕. 위에 bg-glow-* 세 개를 방사형으로 겹쳐 Samsung Health식 파스텔 그라데이션을 만든다. |
| `bg-glow-butter` | #fff0b8 | #2a2410 | 배경 상단 글로우 — AEG 골드를 옅게 푼 버터 옐로. |
| `bg-glow-mint` | #e3f4df | #10241b | 배경 중간 글로우 — 민트. |
| `bg-glow-sky` | #d6ebfa | #0f1c2b | 배경 하단 글로우 — 스카이. |
| `surface-card` | #ffffff | #1c1f23 | 모든 카드의 면. 라운드 radius-xl, shadow-card와 함께. |
| `surface-glass` | #ffffffb8 | #23272cc7 | 상단 세그먼트 탭·하단 내비 같은 떠 있는 유리 바. backdrop-filter blur 20px와 함께. |
| `surface-sunken` | #f1f3ef | #262a2f | 카드 안의 회색 웰: 미니 스탯 타일, 입력칸, 비활성 진행바. |
| `line` | #e5e8e2 | #30353b | 카드 안 리스트 구분선(1px). 카드 바깥 테두리에는 쓰지 않는다. |
| `ink` | #16181b | #f3f4f5 | 기본 텍스트·큰 숫자. surface-card, surface-sunken, bg-base 위 모두 4.5:1 이상. |
| `ink-2` | #474c53 | #c4c8cd | 보조 텍스트: 카드 라벨(걸음, 총 보너스), 리스트 설명. |
| `ink-3` | #676c74 | #9aa0a8 | 단위·캡션·목표치(9,800 걸음, USDT 단위). surface-card 위 4.5:1 이상 — 이보다 연하게 쓰지 않는다. |
| `gold-500` | #f2b705 | #f5c02a | AEG 브랜드 골드 면: 활성 탭 캡슐, 주요 버튼, 홈 FAB. 위 텍스트는 on-gold. |
| `gold-100` | #fff3c4 | #3a3012 | 골드 틴트: 선택된 칩 배경, 아이콘 타일 배경. |
| `gold-700` | #7f5900 | #f5c64a | 골드 계열 텍스트·아이콘(가격 강조, 활성 라벨). surface-card 위 4.5:1 이상. |
| `on-gold` | #1d1606 | #1d1606 | gold-500 면 위의 텍스트·아이콘. 흰색 금지. |
| `brown-800` | #5a3d0c | #4a3410 | 프리미엄 카드(등급·개인현황) 면. 위 텍스트는 on-dark. |
| `navy-900` | #17223a | #1a2744 | 채굴 서버 카드 같은 '야간' 컬러 카드 면 — Samsung Health 수면 카드 대응. |
| `on-dark` | #ffffff | #ffffff | brown-800·navy-900 컬러 카드 위 텍스트. |
| `on-dark-2` | #c9d2e3 | #c9d2e3 | 컬러 카드 위 보조 텍스트. |
| `circle-green` | #3d8b43 | #3d8b43 | 액션 서클: 조직도/입금. 흰 아이콘 3:1 이상. |
| `circle-olive` | #687b1f | #687b1f | 액션 서클: 크라우드펀딩. |
| `circle-coral` | #cf543d | #d65b44 | 액션 서클: 마이너/출금. 채굴 계열 액센트. |
| `circle-teal` | #16806a | #1a8a72 | 액션 서클: 지갑/송금. USDT 계열. |
| `circle-slate` | #81868d | #6b7078 | 액션 서클: 더보기·내역. |
| `chart-a` | #2f9e2b | #4cc24a | 미니 바 차트 기본 막대(Samsung 걸음 그린). |
| `chart-b` | #2f86e0 | #5aaef7 | 미니 바 차트 강조 막대(목표 달성일·오늘). |
| `up` | #147a38 | #4cd07a | 상승 수치(+16.56%). 텍스트용, surface-card 위 4.5:1 이상. |
| `down` | #c8323a | #ff6b6e | 하락 수치(-5.85%), 오류. 텍스트용. |
| `warn-100` | #ffe9d6 | #3b2414 | 경고 배지 배경(미인증). |
| `warn-700` | #9a4300 | #ffb27a | 경고 배지 텍스트. |
| `live` | #e2462f | #ff6a52 | LIVE·실시간 점. 아이콘/점 전용. |
| `focus` | #2f86e0 | #5aaef7 | 키보드 포커스 링 2px, 2px 오프셋. |

## Typography

### 서체 선택

- **Primary**: `Pretendard, "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", system-ui, sans-serif`

### Type ramp

```yaml
display1: 44/800/1.09/-0.03em     # ← num-hero (44px/48px) 화면당 하나의 주인공 숫자: 총 잔고, 총 보너스, 보유 해시파워. tabular-nums.
display2: 32/800/1.19/-0.025em    # ← num-xl (32px/38px) 카드의 대표 숫자(Samsung '2,826' 자리).
display3: 26/800/1.31/-0.02em     # ← title-page (26px/34px) 화면 제목. 상단 좌측, 한 화면에 하나.
title1: 24/800/1.33/-0.02em       # ← title-hero (24px/32px) 히어로 배너 헤드라인(최대 2줄).
title2: 18/700/1.44/-0.01em       # ← title-card (18px/26px) 카드 제목.
title3: 16/700/1.38/0             # ← title-row (16px/22px) 리스트 행 제목, 상품명.
label1: 14/500/1.43/0             # ← body-sm (14px/20px) 카드 라벨, 리스트 설명.
label2: 12/700/1.33/0             # ← label (12px/16px) 하단 내비 라벨, 배지, 단위 칩. 굵게만.
body1: 16/500/1.5/0               # ← body (16px/24px) 본문·히어로 서브카피.
body1-read: 16/500/1.5/0          # ← body (16px/24px) 본문·히어로 서브카피.
body2: 14/500/1.43/0              # ← body-sm (14px/20px) 카드 라벨, 리스트 설명.
caption1: 13/500/1.38/0           # ← caption (13px/18px) 환산값·목표치·보조 정보. 최소 크기.
```

### 시안 전용 글꼴 스타일

| 원본 스타일 | 크기/굵기/줄높이/자간 | 용도 |
|---|---|---|
| `num-lg` | 22/800/1.27/-0.02em | 스탯 타일·상품 가격. |
| `num-md` | 17/700/1.29/-0.01em | 리스트 우측 금액. |

## Spacing

```yaml
space-4: 4        # ← space-1 아이콘-라벨 간격.
space-8: 8        # ← space-2 카드 내 줄 간격, 칩 간격.
space-12: 12      # ← space-3 카드와 카드 사이 간격, 그리드 거터.
space-16: 16      # ← space-4 작은 카드·타일 패딩.
space-20: 20      # ← space-5 화면 좌우 여백(gutter), 섹션 간격.
space-24: 24      # ← space-6 큰 카드 패딩.
space-32: 32      # ← space-8 헤더 상단 여백, 히어로 내부 여백.
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
radius-16: 16       # 표준 ladder
radius-12: 12       # ← radius-sm 12px — 아이콘 타일, 작은 칩.
radius-18: 18       # ← radius-md 18px · 시안 전용(비-4) — 카드 안 스탯 타일, 입력칸, 버튼.
radius-24: 24       # ← radius-lg 24px — 상품 카드, 리스트 그룹 카드.
radius-30: 30       # ← radius-xl 30px · 시안 전용(비-4) — 메인 카드·히어로 — Samsung Health의 큰 라운드.
radius-full: 9999   # ← radius-pill 999px — 세그먼트 탭, 하단 내비, 칩, 배지.
```

## Elevation & Depth

```yaml
shadow-1: "0 1px 2px rgba(24,34,20,0.04), 0 8px 24px rgba(24,34,20,0.06)"  # ← shadow-card · dark 0 1px 2px rgba(0,0,0,0.5)
shadow-pop: "0 12px 32px rgba(24,34,20,0.16)"  # ← shadow-float · dark 0 12px 32px rgba(0,0,0,0.6)
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | Button (primary 골드·tonal, 높이 52/38, pill) |
| input | 원본 없음 — surface-sunken 입력칸(radius-md) 규칙만 README에 있음 |
| badge | Badge (기본 골드·warn·live) |
| chip | Chips (가로 스크롤, 선택은 ink 반전) |
| avatar | ScreenSettings 프로필 골드 아바타 |
| icon-button | ActionCircle (64px 원형 컬러 버튼) |
| icon | README §8 아이콘 (Lucide, 24 그리드, 선 2, currentColor) |

### 변형 대응

#### button

| 계약 변형 | 원본 대응 |
|---|---|
| primary | .ag-btn.primary (gold-500 알약 + on-gold 글자, 화면당 하나, 흰 글씨 금지) |
| secondary | .ag-btn.tonal (surface-sunken 면 + ink 글자, primary 외 나머지 버튼) |
| tertiary | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| ghost | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| danger | 원본 없음(파괴 행동 전용 버튼 변형 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | .cl-cta .ag-btn[disabled] (Clear 컨셉 하단 고정 버튼 비활성: surface-sunken + ink-3) |
| (원본 추가) | .ag-btn.sm: 높이 38px 작은 알약 |
| (원본 추가) | .ag-fab: 70px gold-500 원형 FAB(QR 입금·송금) |
| (원본 추가) | .ag-circle: 64px 원형 컬러 액션 버튼, 기능별 circle-* 색 고정 |
| (원본 추가) | ScreenWalletTxDetail README: 파괴적 행동 '출금 취소'도 별도 danger 변형 없이 tonal 사용 |

#### input

| 계약 변형 | 원본 대응 |
|---|---|
| default | 원본 없음(입력 필드 컴포넌트·CSS 없음(Clear 출금은 키패드 방식)) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| focus | .ag :focus-visible (focus 2px 실선 + 2px 오프셋, 입력 전용이 아닌 전역 규칙) |
| error | 원본 없음(원본 README·컴포넌트 문서·bundle.css·index.d.ts에 해당 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| disabled | 원본 없음(입력 비활성 상태 정의 없음) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |

#### badge

| 계약 변형 | 원본 대응 |
|---|---|
| active | .ag-badge.ok (bg-glow-mint 바탕 + up 글자, 완료 등 긍정) |
| pending | .ag-badge.wait (surface-sunken + ink-2, '처리중' 등 진행 중) |
| inactive | .ag-badge 기본 (gold-100 + gold-700, PV·등급·프로모션 메타) |
| danger | .ag-badge.err (warn-100 + down 글자, '실패') |

### 모바일 컴포넌트 대응

| 템플릿 모바일 컴포넌트 | 원본 대응 |
|---|---|
| bottom-sheet | cl-sheet — Clear 출금 확인 시트(ClearWithdrawConfirm), 위 모서리 28px + 40×5 그랩 핸들 |
| mobile-nav | BottomNav — 떠 있는 유리 알약 4탭(홈·쇼핑몰·마이너·지갑), Clear 대안은 화면에 붙은 .cl-tabbar |
| nav-drawer | 원본 없음(README 6장: 햄버거 드로어를 세그먼트 탭으로 대체해 없앰) — 템플릿 기본 명세를 이 시안 토큰으로 쓴다 |
| fab | BottomNav의 .ag-fab — 70px gold-500 원형, QR 입금·송금 |
| card-row | ListRow — 리스트 카드 안 최소 68px 한 줄(아이콘 타일·제목·캡션·금액/셰브런) |

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

- 파스텔 글로우 바탕 — bg-base 위 bg-glow-butter/mint/sky 방사형 3종(README 3장)
- 큰 라운드 흰 카드 — surface-card + radius-xl(30) + shadow-card, 테두리 없음, 패딩 space-6(.ag-card)
- 떠 있는 유리 하단 바 — surface-glass + blur 24px 알약, 탭 높이 58px, 현재 탭 gold-100 캡슐 + gold-700 아이콘, 하단 22px 위(.ag-nav, .ag-navwrap)
- 골드 원형 FAB — 70px gold-500 + on-gold 아이콘(.ag-fab)
- 유리 세그먼트 탭 — surface-glass + blur 20px, 선택 탭만 흰 캡슐 + shadow-card, 높이 46px(.ag-seg)
- 히어로 숫자 — num-hero 44 / num-xl 32, 굵기 800, 자간 -0.03em, tabular-nums(README 1·4장)

### 원본 컴포넌트 (23종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
| ActionCircle | 64px 원형 컬러 버튼 — Samsung Health 운동 시작(걷기·달리기·자전거·더보기) 버튼의 대응. |  |
| Badge | 상태와 짧은 메타(PV, 인증 상태, LIVE)를 담는 24px 알약. |  |
| BottomNav | 떠 있는 유리 알약 내비 4탭 + 오른쪽 골드 원형 FAB — Samsung Health 하단 바 구조. |  |
| Button | 알약형(pill) 버튼 — 한 화면에 `primary`(골드)는 하나, 나머지는 `tonal`. |  |
| Chips | 쇼핑몰 카테고리처럼 개수가 가변적인 필터 — 가로 스크롤 칩 줄. |  |
| ClearHome | 홈의 주인공은 **내 총 자산**과 오늘의 변화. |  |
| ClearMining | 마이닝은 **큰 진행 링(오늘 채굴 %)** 하나로 상태를 전달한다. |  |
| ClearSettings | 상단 아바타로 여는 **내 정보**. |  |
| ClearShop | 쇼핑은 **검색 → 칩 → 사진·이름·가격**만. |  |
| ClearWallet | 지갑은 총 자산 아래 **자산 구성 도넛**(범례를 누르면 해당 목록으로 이동), 듀오톤 바로가기, 7일 스파크라인이 붙은 코인 목록, 최근 거래 3건. |  |
| ClearWithdrawAmount | 출금 4단계(코인 → **금액** → 주소 → 확인) 중 2단계. |  |
| ClearWithdrawConfirm | 출금 마지막 단계의 **확인 시트**. |  |
| ListRow | 리스트 카드 안의 한 줄(최소 68px) — 설정 메뉴, 코인 잔고, 채굴 현황에 공통. |  |
| ProductCard | 쇼핑몰 2열 그리드의 상품 카드 — 정사각 이미지 + 이름 2줄 + 큰 가격. |  |
| ScreenHome | 홈(대시보드) 컨셉 — 히어로 배너(등급 챌린지) → 총 보너스 큰 숫자 카드 → 액션 서클 + 이번 주 실적 → AEC 시세 → 추천 링크 컬러 카드. |  |
| ScreenMiner | 마이너(해시파워) 컨셉 — 보유 해시파워 히어로 숫자 + 7일 바 → 2×2 스탯 타일 → 채굴 서버 네이비 카드 → 실시간 채굴 리스트. |  |
| ScreenSettings | 설정·개인정보 컨셉 — 프로필 카드(아바타·인증 배지·요약 타일·인증 버튼) → 계정 / 앱 설정 / 고객 지원 리스트 카드. |  |
| ScreenShop | 쇼핑몰 컨셉 — 카테고리 칩 → 프로모션 히어로 → 2열 상품 카드. |  |
| ScreenWallet | 지갑 컨셉 — 총 잔고 히어로 숫자 + 입금·출금·송금·내역 액션 서클 → 자산 종류 탭 → 그룹별 코인 리스트 카드. |  |
| ScreenWalletHistory | 지갑 내역 컨셉 — 지갑 화면의 ‘내역’ 원형 버튼에서 들어오는 하위 화면. |  |
| ScreenWalletTxDetail | 거래 상세 컨셉 — 지갑 내역에서 한 건을 눌렀을 때. |  |
| SegmentTabs | Samsung Health 상단 아이콘 탭을 옮긴 유리(glass) 알약 탭 — 화면 안의 하위 섹션 전환용. |  |
| StatCard | 라벨 하나 + 큰 숫자 하나 + (선택) 미니 바 차트 — Samsung Health ‘걸음’ 카드의 구조. |  |

### 원본 화면 예시

원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).

- `Cover` — 960×300 표지 — gold-500 큰 슬랩 + 하늘색 파스텔 블록(7일 막대 알약) + navy-900 카드 위 골드 코인, 태그라인 '밝은 파스텔 바탕, 큰 라운드 카드, 굵은 고딕 숫자.'

### 원본 컴포넌트 스타일

원본 `components/bundle.css`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). `var(--x)`는 원본 토큰 `x`다.

| 구역 | 선택자 | 핵심 속성 |
|---|---|---|
|  | `.ag` | font-family font-sans · color ink |
|  | `:where(.ag) button` | font inherit · color inherit · border 0 · background none · padding 0 |
|  | `.ag :focus-visible` | outline 2px solid focus |
|  | `.ag-app` | width 390px · min-height 844px · padding 0 space-5 120px · background radial-gradient(120% 34% at 30% 0%, bg-glow-butter 0%, transparent 70%),
    radial-gradient(90% 40% at 100% 38%, bg-glow-mint 0%, transparent 70%),
… |
|  | `.ag-status` | height 44px · font-size 15px · font-weight 700 · padding 0 6px |
| ---------- Header ---------- | `.ag-header` | padding space-5 4px space-4 |
| ---------- Header ---------- | `.ag-header h1` | font-size 26px · font-weight 800 · letter-spacing -0.02em |
| ---------- Header ---------- | `.ag-header .ag-right` | gap space-2 |
| ---------- Header ---------- | `.ag-iconbtn` | width 40px · height 40px · border-radius radius-pill · color ink |
| ---------- Header ---------- | `.ag-avatar` | width 40px · height 40px · border-radius radius-pill · background gold-500 · color on-gold · font-size 14px · font-weight 800 |
| ---------- Header ---------- | `.ag-avatar.lg` | width 64px · height 64px · font-size 22px |
| ---------- Segmented tabs (glass pill) ---------- | `.ag-seg` | gap 2px · padding 5px · border-radius radius-pill · background surface-glass · backdrop-filter blur(20px) · box-shadow inset 0 0 0 1px line |
| ---------- Segmented tabs (glass pill) ---------- | `.ag-seg > button` | height 46px · border-radius radius-pill · gap 6px · color ink-2 · font-size 15px · font-weight 700 |
| ---------- Segmented tabs (glass pill) ---------- | `.ag-seg > button[aria-selected="true"]` | background surface-card · color ink · box-shadow shadow-card |
| ---------- Segmented tabs (glass pill) ---------- | `.ag-seg.text > button` | height 40px · font-size 14px |
| Chips (scrolling category filter) | `.ag-chips` | gap space-2 |
| Chips (scrolling category filter) | `.ag-chip` | height 38px · padding 0 16px · border-radius radius-pill · background surface-card · color ink-2 · font-size 14px · font-weight 700 · gap 6px · box-shadow shadow-card |
| Chips (scrolling category filter) | `.ag-chip[aria-selected="true"]` | background ink · color surface-card |
| ---------- Cards ---------- | `.ag-stack` | gap space-3 |
| ---------- Cards ---------- | `.ag-grid2` | gap space-3 |
| ---------- Cards ---------- | `.ag-card` | background surface-card · border-radius radius-xl · padding space-6 · box-shadow shadow-card |
| ---------- Cards ---------- | `.ag-card.tight` | padding space-5 |
| ---------- Cards ---------- | `.ag-card.flush` | padding 0 |
| ---------- Cards ---------- | `.ag-card .ag-label` | font-size 15px · font-weight 600 · color ink-2 |
| ---------- Cards ---------- | `.ag-card .ag-title` | font-size 18px · font-weight 700 · letter-spacing -0.01em |
| ---------- Cards ---------- | `.ag-dot-new` | width 8px · height 8px · border-radius radius-pill · background live |
| Hero banner card: glass over a soft tint, big headline | `.ag-hero` | background linear-gradient(160deg, surface-glass, surface-card) · border-radius radius-xl · padding space-6 space-6 space-5 · box-shadow shadow-card · min-height 196px |
| Hero banner card: glass over a soft tint, big headline | `.ag-hero h2` | font-size 24px · font-weight 800 · letter-spacing -0.02em · max-width 230px |
| Hero banner card: glass over a soft tint, big headline | `.ag-hero p` | font-size 16px · font-weight 500 · color ink-2 · max-width 196px |
| Hero banner card: glass over a soft tint, big headline | `.ag-pager` | gap 6px |
| Hero banner card: glass over a soft tint, big headline | `.ag-pager i` | width 8px · height 8px · border-radius radius-pill · background line |
| Hero banner card: glass over a soft tint, big headline | `.ag-pager i.on` | width 22px · background surface-card · box-shadow inset 0 0 0 1px line |
| Big numbers | `.ag-num` | font-weight 800 · letter-spacing -0.03em |
| Big numbers | `.ag-num.hero` | font-size 44px |
| Big numbers | `.ag-num.xl` | font-size 32px · letter-spacing -0.025em |
| Big numbers | `.ag-num.lg` | font-size 22px · letter-spacing -0.02em |
| Big numbers | `.ag-num.md` | font-size 17px · font-weight 700 · letter-spacing -0.01em |
| Big numbers | `.ag-unit` | font-size 15px · font-weight 700 · color ink-3 · letter-spacing 0 |
| Big numbers | `.ag-sub` | font-size 14px · font-weight 500 · color ink-3 |
| Big numbers | `.ag-cap` | font-size 13px · font-weight 500 · color ink-3 |
| Big numbers | `.ag-up` | color up · font-weight 700 |
| Big numbers | `.ag-down` | color down · font-weight 700 |
| Stat card: label top, big number bottom-left, chart right | `.ag-statcard` | gap space-4 |
| Mini bars (Samsung steps chart) | `.ag-bars` | gap 10px · height 64px |
| Mini bars (Samsung steps chart) | `.ag-bars .col` | gap 8px |
| Mini bars (Samsung steps chart) | `.ag-bars .bar` | width 12px · border-radius radius-pill · background chart-a |
| Mini bars (Samsung steps chart) | `.ag-bars .bar.b` | background chart-b |
| Mini bars (Samsung steps chart) | `.ag-bars .bar.dot` | height 12px !important |
| Mini bars (Samsung steps chart) | `.ag-bars .d` | font-size 12px · font-weight 600 · color ink-3 |
| Mini bars (Samsung steps chart) | `.ag-bars .d.today` | color down |
| Stat tiles inside a card | `.ag-tile` | background surface-sunken · border-radius radius-md · padding space-4 |
| Stat tiles inside a card | `.ag-tile .k` | gap 6px · font-size 13px · font-weight 700 · color ink-2 |
| Progress | `.ag-progress` | height 10px · border-radius radius-pill · background surface-sunken |
| Progress | `.ag-progress > i` | height 100% · border-radius radius-pill · background gold-500 |
| ---------- Action circles ---------- | `.ag-circles` | gap 12px |
| ---------- Action circles ---------- | `.ag-circle` | gap 6px |
| ---------- Action circles ---------- | `.ag-circle > span:first-child` | width 64px · height 64px · border-radius radius-pill · color on-dark |
| ---------- Action circles ---------- | `.ag-circle .t` | font-size 13px · font-weight 700 · color ink-2 |
| ---------- Action circles ---------- | `.c-green` | background circle-green |
| ---------- Action circles ---------- | `.c-olive` | background circle-olive |
| ---------- Action circles ---------- | `.c-coral` | background circle-coral |
| ---------- Action circles ---------- | `.c-teal` | background circle-teal |
| ---------- Action circles ---------- | `.c-slate` | background circle-slate |
| ---------- Action circles ---------- | `.c-gold` | background gold-500 · color on-gold !important |
| ---------- Buttons & badges ---------- | `.ag-btn` | height 52px · padding 0 22px · border-radius radius-pill · gap 8px · font-size 16px · font-weight 800 |
| ---------- Buttons & badges ---------- | `.ag-btn.primary` | background gold-500 · color on-gold |
| ---------- Buttons & badges ---------- | `.ag-btn.tonal` | background surface-sunken · color ink |
| ---------- Buttons & badges ---------- | `.ag-btn.sm` | height 38px · padding 0 14px · font-size 14px · font-weight 700 |
| ---------- Buttons & badges ---------- | `.ag-badge` | gap 4px · height 24px · padding 0 10px · border-radius radius-pill · font-size 12px · font-weight 700 · background gold-100 · color gold-700 |
| ---------- Buttons & badges ---------- | `.ag-badge.warn` | background warn-100 · color warn-700 |
| ---------- Buttons & badges ---------- | `.ag-badge.live::before` | width 6px · height 6px · border-radius radius-pill · background live |
| ---------- Lists ---------- | `.ag-list` | padding 0 |
| ---------- Lists ---------- | `.ag-row` | gap 14px · min-height 68px · padding 10px 0 |
| ---------- Lists ---------- | `.ag-row + .ag-row` | border-top 1px solid line |
| ---------- Lists ---------- | `.ag-row .body` | min-width 0 |
| ---------- Lists ---------- | `.ag-row .t` | font-size 16px · font-weight 700 |
| ---------- Lists ---------- | `.ag-row .s` | font-size 13px · font-weight 500 · color ink-3 |
| ---------- Lists ---------- | `.ag-row .chev` | color ink-3 |
| ---------- Lists ---------- | `.ag-ictile` | width 42px · height 42px · border-radius radius-sm · background gold-100 · color gold-700 |
| ---------- Lists ---------- | `.ag-coin` | width 44px · height 44px · border-radius radius-pill · color on-dark · font-size 13px · font-weight 800 · letter-spacing -0.03em |
| ---------- Lists ---------- | `.ag-coin.gold` | background gold-500 · color on-gold |
| ---------- Lists ---------- | `.ag-section-label` | font-size 14px · font-weight 700 · color ink-3 |
| Toggle | `.ag-toggle` | width 52px · height 30px · border-radius radius-pill · background circle-slate |
| Toggle | `.ag-toggle::after` | width 24px · height 24px · border-radius radius-pill · background surface-card |
| Toggle | `.ag-toggle[aria-checked="true"]` | background gold-500 |
| ---------- Product card ---------- | `.ag-product` | background surface-card · border-radius radius-lg · box-shadow shadow-card |
| ---------- Product card ---------- | `.ag-product .info` | padding 14px 14px 16px · gap 6px |
| ---------- Product card ---------- | `.ag-product .name` | font-size 15px · font-weight 700 · min-height 42px |
| ---------- Product card ---------- | `.ag-product .price` | gap 2px |
| ---------- Product card ---------- | `.ag-product .pv` | font-size 12px · font-weight 700 · color gold-700 |
| ---------- Colour (night) card ---------- | `.ag-night` | background navy-900 · color on-dark · border-radius radius-xl · padding space-6 · box-shadow shadow-card |
| ---------- Colour (night) card ---------- | `.ag-night .ag-label, .ag-night .ag-sub, .ag-night .ag-cap` | color on-dark-2 |
| ---------- Colour (night) card ---------- | `.ag-premium` | background brown-800 · color on-dark · border-radius radius-xl · padding space-6 · box-shadow shadow-card |
| ---------- Colour (night) card ---------- | `.ag-premium .ag-sub` | color on-dark-2 |
| ---------- Colour (night) card ---------- | `.ag-meter` | height 8px · border-radius radius-pill · background rgba(255,255,255,0.14) |
| ---------- Colour (night) card ---------- | `.ag-meter > i` | height 100% · border-radius radius-pill |
| ---------- Colour (night) card ---------- | `.ag-navwrap` | gap 10px |
| ---------- Colour (night) card ---------- | `.ag-nav` | padding 6px · border-radius radius-pill · background surface-glass · backdrop-filter blur(24px) · box-shadow shadow-float, inset 0 0 0 1px line |
| ---------- Colour (night) card ---------- | `.ag-nav > button` | height 58px · border-radius radius-pill · gap 3px · color ink-2 · font-size 12px · font-weight 700 |
| ---------- Colour (night) card ---------- | `.ag-nav > button[aria-current="page"]` | background gold-100 · color ink |
| ---------- Colour (night) card ---------- | `.ag-nav > button[aria-current="page"] [data-ic]` | color gold-700 |
| ---------- Colour (night) card ---------- | `.ag-fab` | width 70px · height 70px · border-radius radius-pill · background gold-500 · color on-gold · box-shadow shadow-float |
| ---------- Sub-page header (back + title) ---------- | `.ag-subhead` | gap 4px · padding space-3 0 space-4 |
| ---------- Sub-page header (back + title) ---------- | `.ag-subhead h1` | font-size 22px · font-weight 800 · letter-spacing -0.02em |
| ---------- Transaction rows ---------- | `.ag-tx` | width 44px · height 44px · border-radius radius-pill |
| ---------- Transaction rows ---------- | `.ag-tx.in` | background bg-glow-mint · color circle-green |
| ---------- Transaction rows ---------- | `.ag-tx.out` | background warn-100 · color circle-coral |
| ---------- Transaction rows ---------- | `.ag-tx.send` | background bg-glow-sky · color chart-b |
| ---------- Transaction rows ---------- | `.ag-tx.bonus` | background gold-100 · color gold-700 |
| ---------- Transaction rows ---------- | `.ag-tx.mine` | background surface-sunken · color ink-2 |
| ---------- Transaction rows ---------- | `.ag-tx.lg` | width 64px · height 64px |
| ---------- Transaction rows ---------- | `.ag-amt-in` | color up |
| ---------- Transaction rows ---------- | `.ag-badge.ok` | background bg-glow-mint · color up |
| ---------- Transaction rows ---------- | `.ag-badge.err` | background warn-100 · color down |
| ---------- Transaction rows ---------- | `.ag-badge.wait` | background surface-sunken · color ink-2 |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps::before` | height 3px · border-radius radius-pill · background surface-sunken |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps .fill` | height 3px · border-radius radius-pill · background gold-500 |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps > div` | gap 6px · font-size 12px · font-weight 700 · color ink-3 |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps > div > i` | width 24px · height 24px · border-radius radius-pill · background surface-sunken |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps > div.done > i` | background gold-500 · color on-gold |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps > div.done, .ag-steps > div.now` | color ink |
| ---------- Stepper (transaction progress) ---------- | `.ag-steps > div.now > i` | background surface-card · box-shadow inset 0 0 0 3px gold-500 |
| ---------- Key–value detail rows ---------- | `.ag-kv` | gap space-4 · min-height 52px · padding 8px 0 · font-size 15px |
| ---------- Key–value detail rows ---------- | `.ag-kv + .ag-kv` | border-top 1px solid line |
| ---------- Key–value detail rows ---------- | `.ag-kv .k` | color ink-2 · font-weight 600 |
| ---------- Key–value detail rows ---------- | `.ag-kv .v` | font-weight 700 · min-width 0 · gap 6px |
| ---------- Key–value detail rows ---------- | `.ag-kv .v .mono` | letter-spacing -0.01em |
| ---------- Key–value detail rows ---------- | `.cl-app` | width 390px · min-height 844px · background bg-base · padding 0 0 110px |
| ---------- Key–value detail rows ---------- | `.cl-pad` | padding 0 space-5 |
| ---------- Key–value detail rows ---------- | `.cl-status` | height 44px · font-size 15px · font-weight 700 · padding 0 26px |
| Header band with the orbit motif (home / mining only) | `.cl-band` | background linear-gradient(180deg, bg-glow-butter 0%, bg-base 100%) |
| Header band with the orbit motif (home / mining only) | `.cl-orbit` | width 300px · height 300px |
| Header band with the orbit motif (home / mining only) | `.cl-orbit .o1` | opacity .55 |
| Header band with the orbit motif (home / mining only) | `.cl-orbit .o2` | opacity .35 |
| Header band with the orbit motif (home / mining only) | `.cl-orbit .o3` | opacity .2 |
| Header band with the orbit motif (home / mining only) | `.cl-orbit .coin` | opacity 1 |
| Header band with the orbit motif (home / mining only) | `.cl-top` | padding space-3 space-5 space-2 |
| Header band with the orbit motif (home / mining only) | `.cl-top h1` | font-size 24px · font-weight 800 · letter-spacing -0.02em |
| Header band with the orbit motif (home / mining only) | `.cl-top .r` | gap 6px |
| Hero total | `.cl-total` | padding space-4 space-5 0 |
| Hero total | `.cl-total .k` | font-size 15px · font-weight 600 · color ink-2 · gap 6px |
| Hero total | `.cl-total .v` | font-size 40px · font-weight 800 · letter-spacing -0.03em |
| Hero total | `.cl-total .v small` | font-size 18px · font-weight 700 · color ink-3 · letter-spacing 0 |
| Hero total | `.cl-total .krw` | font-size 15px · font-weight 600 · color ink-2 |
| Hero total | `.cl-delta` | gap 4px · height 28px · padding 0 10px · border-radius radius-pill · background surface-card · font-size 13px · font-weight 700 · color up · box-shadow shadow-card |
| Quick actions: duotone rounded squares | `.cl-quick` | gap 8px |
| Quick actions: duotone rounded squares | `.cl-quick button` | gap 8px · font-size 14px · font-weight 700 · color ink |
| Quick actions: duotone rounded squares | `.cl-ic` | width 56px · height 56px · border-radius 20px · background surface-card · color gold-700 · box-shadow shadow-card |
| Quick actions: duotone rounded squares | `.cl-ic.sm` | width 42px · height 42px · border-radius 14px · box-shadow none · background gold-100 |
| Quick actions: duotone rounded squares | `.cl-ic.sm.n` | background surface-sunken · color ink-2 |
| Panels | `.cl-stack` | gap space-3 |
| Panels | `.cl-card` | background surface-card · border-radius radius-lg · padding space-5 · box-shadow shadow-card |
| Panels | `.cl-card.list` | padding 4px space-5 |
| Panels | `.cl-head h2` | font-size 18px · font-weight 800 · letter-spacing -0.01em |
| Panels | `.cl-more` | font-size 14px · font-weight 700 · color ink-3 |
| Panels | `.cl-hint` | gap 4px · font-size 13px · font-weight 600 · color ink-3 |
| Progress ring | `.cl-ring` | width 120px · height 120px |
| Progress ring | `.cl-ring svg` | width 100% · height 100% · transform rotate(-90deg) |
| Progress ring | `.cl-ring .c b` | font-size 28px · font-weight 800 · letter-spacing -0.03em |
| Progress ring | `.cl-ring .c span` | font-size 12px · font-weight 700 · color ink-3 |
| Progress ring | `.cl-ring.lg` | width 200px · height 200px |
| Progress ring | `.cl-ring.lg .c b` | font-size 44px |
| Progress ring | `.cl-ring.lg .c span` | font-size 14px |
| Rows | `.cl-row` | gap 12px · min-height 64px · padding 10px 0 |
| Rows | `.cl-row + .cl-row` | border-top 1px solid line |
| Rows | `.cl-row .b` | min-width 0 |
| Rows | `.cl-row .t` | font-size 16px · font-weight 700 |
| Rows | `.cl-row .s` | font-size 13px · font-weight 500 · color ink-3 |
| Rows | `.cl-row .e .n` | font-size 16px · font-weight 700 · letter-spacing -0.01em |
| Rows | `.cl-row .chev` | color ink-3 |
| Rows | `.cl-spark` | width 56px · height 24px |
| Status dot + chips | `.cl-state` | gap 6px · font-size 14px · font-weight 700 |
| Status dot + chips | `.cl-state::before` | width 8px · height 8px · border-radius radius-pill · background chart-a |
| Status dot + chips | `.cl-pill` | height 26px · padding 0 10px · border-radius radius-pill · background surface-sunken · font-size 12px · font-weight 700 · color ink-2 |
| Status dot + chips | `.cl-pill.ok` | background bg-glow-mint · color up |
| Status dot + chips | `.cl-pill.warn` | background warn-100 · color warn-700 |
| Notice line | `.cl-notice` | gap 10px · padding 14px space-4 · border-radius radius-md · background surface-card · font-size 14px · font-weight 600 · box-shadow shadow-card |
| Notice line | `.cl-notice span.txt` | min-width 0 |
| Info explainer | `.cl-explain` | gap 10px · padding space-4 · border-radius radius-md · background surface-sunken · font-size 14px · color ink-2 · font-weight 500 |
| Info explainer | `.cl-explain b` | color ink |
| Donut legend | `.cl-donut` | gap space-5 |
| Donut legend | `.cl-donut svg` | width 104px · height 104px · transform rotate(-90deg) |
| Donut legend | `.cl-legend` | gap 10px |
| Donut legend | `.cl-legend button` | gap 8px · font-size 14px · font-weight 700 · width 100% |
| Donut legend | `.cl-legend i` | width 10px · height 10px · border-radius 3px |
| Donut legend | `.cl-legend .p` | color ink-2 |
| Search | `.cl-search` | gap 10px · height 50px · padding 0 16px · border-radius radius-md · background surface-card · color ink-3 · font-size 15px · font-weight 600 · box-shadow shadow-card |
| Simple product card | `.cl-prod` | gap 10px |
| Simple product card | `.cl-prod .ph` | border-radius radius-lg |
| Simple product card | `.cl-prod .ph svg.orb` | width 100% · height 100% |
| Simple product card | `.cl-prod .ph svg.orb circle` | opacity .25 |
| Simple product card | `.cl-prod .nm` | font-size 15px · font-weight 700 · min-height 42px |
| Simple product card | `.cl-prod .pr` | font-size 19px · font-weight 800 · letter-spacing -0.02em |
| Simple product card | `.cl-prod .pr small` | font-size 13px · font-weight 700 · color ink-3 |
| Docked tab bar | `.cl-tabbar` | height 84px · padding 8px 12px 22px · background surface-card · box-shadow 0 -1px 0 line |
| Docked tab bar | `.cl-tabbar button` | gap 4px · font-size 13px · font-weight 700 · color ink-3 |
| Docked tab bar | `.cl-tabbar button[aria-current="page"]` | color ink |
| Docked tab bar | `.cl-tabbar button[aria-current="page"] [data-ic]` | color gold-700 |
| Docked tab bar | `.cl-tabbar button[aria-current="page"]::before` | width 28px · height 3px · border-radius radius-pill · background gold-500 |
| Flow pages (withdraw) | `.cl-flowtop` | padding space-2 space-3 |
| Flow pages (withdraw) | `.cl-steps` | gap 6px · padding 0 space-5 |
| Flow pages (withdraw) | `.cl-steps i` | height 4px · border-radius radius-pill · background line |
| Flow pages (withdraw) | `.cl-steps i.on` | background gold-500 |
| Flow pages (withdraw) | `.cl-q` | font-size 24px · font-weight 800 · letter-spacing -0.02em |
| Flow pages (withdraw) | `.cl-amount` | font-size 48px · font-weight 800 · letter-spacing -0.03em · gap 6px |
| Flow pages (withdraw) | `.cl-amount small` | font-size 22px · color ink-3 · font-weight 700 · letter-spacing 0 |
| Flow pages (withdraw) | `.cl-amount .caret` | width 3px · height 44px · background gold-500 · border-radius 2px |
| Flow pages (withdraw) | `.cl-quickamt` | gap 8px · padding 0 space-5 |
| Flow pages (withdraw) | `.cl-quickamt button` | height 36px · padding 0 14px · border-radius radius-pill · background surface-card · font-size 14px · font-weight 700 · box-shadow shadow-card |
| Flow pages (withdraw) | `.cl-calc` | padding space-4 · border-radius radius-md · background surface-card · box-shadow shadow-card |
| Flow pages (withdraw) | `.cl-calc div` | font-size 15px · font-weight 600 · color ink-2 · padding 4px 0 |
| Flow pages (withdraw) | `.cl-calc div b` | color ink |
| Flow pages (withdraw) | `.cl-keypad` | padding 0 space-5 |
| Flow pages (withdraw) | `.cl-keypad button` | height 58px · font-size 26px · font-weight 700 · border-radius radius-md |
| Flow pages (withdraw) | `.cl-cta .ag-btn` | width 100% · height 56px · font-size 17px · border-radius radius-md |
| Flow pages (withdraw) | `.cl-cta .ag-btn[disabled]` | background surface-sunken · color ink-3 |
| Bottom sheet over dim | `.cl-dim` | background rgba(10,12,14,.45) |
| Bottom sheet over dim | `.cl-sheet` | background surface-card · border-radius 28px 28px 0 0 · padding 12px space-5 28px |
| Bottom sheet over dim | `.cl-sheet .grab` | width 40px · height 5px · border-radius radius-pill · background line |
| Bottom sheet over dim | `.cl-sheet h2` | font-size 22px · font-weight 800 · letter-spacing -0.02em |
| Bottom sheet over dim | `.cl-warn` | gap 10px · padding 14px · border-radius radius-md · background warn-100 · color warn-700 · font-size 14px · font-weight 600 |

## Do's and Don'ts

**Do**

- 카드당 주인공 숫자는 하나, 나머지는 ink-3 캡션
- 한 카드 = 한 주제로 쪼개기
- 구분은 테두리 대신 흰 카드와 파스텔 바탕의 명도 차
- gold-500 면 위 글자는 반드시 on-gold
- 모든 숫자는 tabular-nums, 천 단위 콤마
- 버튼 라벨은 동사로 끝나는 짧은 한국어
- 한국어 줄바꿈은 word-break: keep-all

**Don't**

- 카드에 테두리 금지
- 한 카드에 큰 숫자 두 개 금지
- 골드를 넓은 배경으로 쓰지 않기
- 흰 글자 on 골드 금지
- 13px 미만 텍스트 금지
- 그라데이션 버튼 금지
- 이모지·3D 일러스트 아이콘 금지

## Responsive Behavior

- 기준 폭 390px, 좌우 여백 space-5(20), 카드 사이 space-3(12)
- 하단 내비는 화면 하단 22px 위 고정, 콘텐츠 하단 120px 여백
- Clear 컨셉 하단 고정 CTA 높이 56px(.cl-cta)
- prefers-reduced-motion이면 궤도·진행 링 애니메이션 정지

## Known Gaps

- 한 시스템 안에 두 컨셉(Soft · Clear)이 있다. 토큰은 공유하고 Clear는 bundle.css의 cl- 클래스만 다르다.
- 원본 간격 이름은 단계 번호(space-1=4px … space-8=32px)라 템플릿 이름(space-4=4px)으로 값 기준 재매핑했다.
- 라운드 18·30은 4의 배수가 아니라 시안 전용 토큰(radius-18/30)으로, 12·24는 표준값과 같은 이름으로 원래 값을 유지한다.
- 바탕 글로우(bg-glow-*)는 방사형 gradient 재료라 별칭에 넣지 않고 원본 색 표에만 둔다.
- `bg-inverse` ← `ink`: 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용(칩 선택 상태가 ink 면)
- `bg-success-subtle` ← `surface-sunken`: 합성 — 원본에 성공 바탕이 없음(중립 타일)
- `bg-danger-subtle` ← `warn-100`: 합성 — 원본에 위험 바탕이 없어 경고 바탕 재사용
- `fg-disabled` ← `ink-3`: 합성 — 원본은 ink-3보다 연한 글자를 금지
- `border-strong` ← `line`: 합성 — 원본은 선 색 하나(카드 바깥 테두리 금지)

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

#### AEG Soft — 디자인 시스템

AEG 회원 앱(쇼핑몰 · 마이너 · 홈 대시보드 · 지갑 · 설정)을 **Samsung Health(One UI) 스타일**로 다시 정리한 UI 컨셉입니다. 밝은 파스텔 바탕 위에 큰 라운드의 흰 카드를 쌓고, 카드마다 **굵은 고딕 숫자 하나**가 먼저 읽히게 만드는 것이 핵심입니다.

##### 1. 레퍼런스 분석 — Samsung Health에서 가져온 것

| 관찰 | AEG에 적용 |
| --- | --- |
| 노랑 → 민트 → 하늘색으로 번지는 파스텔 그라데이션 바탕 | `bg-glow-butter` / `bg-glow-mint` / `bg-glow-sky` 세 개의 방사형 글로우를 `bg-base` 위에 겹친다. 상단 버터 옐로가 AEG 골드와 자연스럽게 이어진다. |
| 흰 카드, 매우 큰 라운드(약 30px), 테두리 없이 아주 옅은 그림자 | `.ag-card` = `surface-card` + `radius-xl` + `shadow-card`. 테두리 금지. |
| 카드당 라벨 하나 + 거대한 숫자 하나(“걸음 2,826”) | 카드당 주인공 숫자는 하나. `num-hero`(44) / `num-xl`(32), 굵기 800, 자간 -0.03em. |
| 숫자 옆 미니 막대 차트(초록/파랑, 오늘은 점) | `.ag-bars` — `chart-a` 기본, `chart-b` 강조, 오늘은 점 + 빨간 날짜. |
| 상단 아이콘 세그먼트 탭(유리 알약, 선택 탭만 흰 캡슐) | `.ag-seg` — 홈의 대시보드·조직도·보너스·크라우드펀딩·공지 전환. |
| 2×2 원형 컬러 버튼(걷기·달리기·자전거·더보기) | `.ag-circle` — 조직도·마이너·크라우드펀딩·공유 / 입금·출금·송금·내역. |
| 떠 있는 유리 하단 바 + 별도 원형 FAB | `.ag-nav` 4탭(홈·쇼핑몰·마이너·지갑) + 골드 FAB(QR 입금·송금). |
| 아래쪽에 컬러 카드(주황, 남색 수면 카드) | `navy-900` 채굴 서버 카드, `brown-800` 추천 링크·프리미엄 카드. |

##### 2. 원칙

1. **숫자가 먼저.** 각 카드에서 가장 먼저 읽혀야 할 값 하나를 고르고, 나머지는 `ink-3` 캡션으로 내린다.
2. **카드로 쪼갠다.** 기존의 노란 대형 박스(개인현황)처럼 정보를 한 박스에 몰지 않는다. 한 카드 = 한 주제.
3. **면으로 구분한다.** 테두리·구분 박스 대신 흰 카드와 파스텔 바탕의 명도 차, 카드 안에서는 `surface-sunken` 타일.
4. **골드는 아껴 쓴다.** `gold-500`은 활성 탭 캡슐, 주요 버튼, FAB, 아바타에만. 넓은 배경으로 쓰지 않는다.
5. **고딕, 굵게, 크게.** 본문 최소 500, 숫자·제목 700–800. 13px 미만 텍스트 금지.

##### 3. 색

- 바탕: `bg-base` + 글로우 3종. 다크 테마에서는 같은 구성이 짙은 톤으로 바뀐다.
- 면: `surface-card`(카드), `surface-glass`(탭·내비, blur 20–24px), `surface-sunken`(카드 안 타일).
- 텍스트: `ink` → `ink-2` → `ink-3` 3단계. 세 가지 모두 `surface-card` 위 4.5:1 이상(라이트·다크 모두 검증).
- 브랜드: `gold-500` 면 위 글자는 반드시 `on-gold`(검정에 가까운 갈색). `gold-700`은 골드 계열 텍스트용.
- 기능 색: 액션 서클 `circle-*`(흰 아이콘 3:1 이상), 차트 `chart-a`/`chart-b`, 등락 `up`/`down`.
- 등락 색은 현재 앱 관례(상승 초록 · 하락 빨강)를 유지한다. 국내 증권 관례(상승 빨강)로 바꿀 경우 `up`/`down` 값만 교체하면 된다.

##### 4. 타이포그래피 — 고딕

- 서체: **Pretendard**(SIL OFL 1.1) 400·500·600·700·800. 폴백 `Apple SD Gothic Neo` → `Noto Sans KR` → `Malgun Gothic`.
- 모든 숫자는 `tabular-nums`(자리 고정) — 잔고·해시파워가 갱신돼도 흔들리지 않는다.
- 단계: 숫자 `num-hero 44` · `num-xl 32` · `num-lg 22` · `num-md 17` / 제목 `title-page 26` · `title-hero 24` · `title-card 18` · `title-row 16` / 본문 `body 16` · `body-sm 14` · `caption 13` · `label 12(700)`.
- 단위(USDT, MH/s, PV)는 숫자보다 작게, `ink-3`, 700 — 숫자와 같은 줄 baseline 정렬.
- 한국어 줄바꿈은 `word-break: keep-all`.

##### 5. 레이아웃

- 기준 폭 390px, 좌우 여백 `space-5`(20), 카드 사이 `space-3`(12), 큰 카드 패딩 `space-6`(24).
- 화면 구조: 상태바 → 헤더(제목 좌측 + 아이콘·아바타 우측) → 세그먼트 탭/칩 → 히어로 → 카드 스택 → 떠 있는 하단 내비(하단 120px 여백).
- 라운드: 메인 카드 30 · 상품/리스트 카드 24 · 타일 18 · 아이콘 타일 12 · 탭/버튼/배지 알약.

##### 6. 정보 구조 제안

| 지금 | 제안 |
| --- | --- |
| 하단 5탭(쇼핑몰·마이너·홈·지갑·설정), 홈이 가운데 원형 | 하단 4탭 **홈·쇼핑몰·마이너·지갑** + 오른쪽 골드 FAB **QR 입금·송금** |
| 설정이 하단 탭 | 상단 우측 **아바타** → 설정·개인정보 (Samsung Health 프로필 위치) |
| 햄버거 드로어(대시보드·조직도·보너스·크라우드펀딩·공지·문의) | 홈 상단 **세그먼트 탭**(대시보드·조직도·보너스·크라우드펀딩·공지) + ⋮ 메뉴(1:1 문의 등) |
| 홈 ‘개인현황’ 노란 박스 1장 | 등급 챌린지 히어로 · 총 보너스 카드 · 이번 주 실적 카드로 분리 |

##### 7. 화면 컨셉 — Soft (Components → Screens · Soft)

- **ScreenHome** — 등급 챌린지 히어로, 총 보너스 + 7일 바, 액션 서클 2×2, AEC 시세, 추천 링크 컬러 카드.
- **ScreenShop** — 카테고리 칩, 프로모션 히어로, 2열 상품 카드(가격 22px 800, PV 배지).
- **ScreenMiner** — 보유 해시파워 히어로 숫자, 2×2 스탯 타일, 네이비 채굴 서버 카드, 실시간 채굴 리스트.
- **ScreenWallet** — 총 잔고 44px + KRW 환산, 입금·출금·송금·내역 서클, 자산 탭, 그룹별 코인 리스트.
- **ScreenWalletHistory** — 지갑 ‘내역’에서 진입. 월별 순입금 요약 카드 + 7일 바, 유형 칩, 날짜별 거래 리스트(들어온 돈만 초록 +, 실패는 취소선).
- **ScreenWalletTxDetail** — 거래 한 건: 금액 히어로, 신청→검토→전송→완료 단계, 주소·수수료·실수령액·TXID 상세.
- **ScreenSettings** — 프로필 카드(미인증 배지 + 인증 버튼), 계정 / 앱 설정 / 고객 지원 리스트.

수치는 기존 화면 캡처에서 가져왔고, 실시간 채굴 리스트의 DOGE·BELLS 값과 일부 환산값은 예시입니다. 지갑 내역·거래 상세의 거래 수치도 예시입니다. 상품 이미지는 아이콘 플레이스홀더이며 실제 사진이 들어갑니다.

##### 8. 아이콘

Lucide(ISC) 라인 아이콘, 24px 그리드, 선 굵기 2. `components/bundle.js`의 `AEG.icons()`가 `<span data-ic="wallet">`을 SVG로 바꾼다. 색은 `currentColor`라 부모 텍스트 색을 따른다. 이모지·3D 일러스트 아이콘은 쓰지 않는다.

##### 9. 쓰는 법

- `tokens.css`(자동 생성) → `components/bundle.css` → `components/bundle.js` 순서로 불러오고, 루트에 `class="ag"`.
- 라이트/다크는 `<html data-theme="light|dark">` 하나로 전환한다.
- 하지 말 것: 카드에 테두리, 한 카드에 큰 숫자 두 개, 골드 넓은 배경, 흰 글자 on 골드, 13px 미만 텍스트, 그라데이션 버튼.

##### 10. 대안 컨셉 — AEG Clear (Components → Screens · Clear)

같은 데이터로 만든 비교용 대안입니다. 다단계·보상을 앞세우는 요소를 빼고, **내 자산과 이용 중인 서비스**를 중심에 둔 쉬운 UX입니다. 스타일은 `components/bundle.css`의 `cl-` 클래스이며, 토큰(색·글자·간격)은 Soft와 같은 것을 씁니다.

**Soft와 다른 점**

| | Soft | Clear |
| --- | --- | --- |
| 홈 주인공 | 승급 배너, 총 보너스 | 총 자산 + 오늘 변화 |
| 바탕 | 화면 전체 파스텔 그라데이션 | 단색 바탕, 홈·마이닝 상단에만 골드 그라데이션 |
| 그래픽 모티프 | 막대 차트, 색 원형 버튼 | **골드 궤도**(동심원 + 회전하는 코인 점) 하나를 반복 |
| 바로가기 | 색 원형 버튼(조직도·공유 포함) | 흰 둥근 사각 듀오톤 아이콘(입금·출금·송금·QR) |
| 하단 바 | 떠 있는 유리 알약 + FAB | 화면에 붙은 4탭 바(홈·마이닝·쇼핑·지갑), 골드 밑줄 표시 |
| 조직·정산·초대 | 홈 탭·카드로 노출 | 내 정보 > 활동 내역 / 친구 초대 (한 단계 안쪽) |
| 데이터 표현 | 큰 숫자 + 7일 막대 | 진행 링, 자산 구성 도넛, 코인별 스파크라인 |

**쉬운 사용성 규칙**

- 화면 하나에 목적 하나. 출금 같은 흐름은 단계마다 질문 하나(`cl-q`), 진행 막대(`cl-steps`), 하단 고정 56px 버튼(`cl-cta`).
- 쉬운 말 + 괄호 속 전문 용어: 채굴 성능(해시파워), 오류율(리젝트). 낯선 지표 옆에는 ⓘ, 화면 아래 설명 카드(`cl-explain`).
- 금액 입력 중 수수료·받는 금액을 계속 보여주고(`cl-calc`), 확인은 문장형 시트(“149.00 USDT를 보낼게요”) + 처음 쓰는 주소 경고 + 생체 인증.
- 상태는 다음 행동과 함께: “처리중 · 보통 10분 이내”, “설정 필요”.
- 움직임은 의미 있을 때만: 진행 링 채우기, 궤도 코인 회전(18초), 입력 커서. `prefers-reduced-motion`이면 멈춘다.
- 내 정보에 **큰 글씨 모드** 토글을 둔다.

**화면:** ClearHome · ClearMining · ClearShop · ClearWallet · ClearWithdrawAmount · ClearWithdrawConfirm · ClearSettings. 오늘 변화(+18.42), 자산 구성 비율, 원화 환산 일부, 공지 문구는 예시 값입니다.

