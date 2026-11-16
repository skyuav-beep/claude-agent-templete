---
name: Grove
slug: grove
category: productivity
last_updated: "2026-11-16"
sources:
  - https://claude.ai/artifact/F4ctMyYSghiZYp2KVHToX5
related_services: ["Linear", "Notion"]
lang: ko
policy:
  shadow_on_cards: true
  gradient_locations: []
  copy_tone: "ko-friendly"
  dark_mode: "supported"
  non_4_spacing: false
claude_design_system:
  url: https://claude.ai/artifact/F4ctMyYSghiZYp2KVHToX5
  version: "1794797834-1fd9"
  synced: "2026-11-16"
  mode: adopt
  map: designs/_sync/grove.map.json
---

# Grove — design.md

> 정리는 사람이, 정돈은 AI가 — 프로젝트·기획 중심으로 항목을 모으고 AI 비서가 먼저 제안하는 데스크톱 3단 워크스페이스 시안.

본 시안은 Claude Design System 「Grove」(https://claude.ai/artifact/F4ctMyYSghiZYp2KVHToX5)의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(`designs/_alias-contract.md`)으로 옮긴 대응표는 `designs/_sync/grove.map.json`이고, `node scripts/design-sync.mjs adopt`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

정리는 사람이, 정돈은 AI가 — 프로젝트·기획 중심으로 항목을 모으고 AI 비서가 먼저 제안하는 데스크톱 3단 워크스페이스 시안.

- 카드 그림자: 허용 · gradient: 전면 금지 · 카피: ko-friendly · 다크 모드: supported
- 원칙·보이스·레이아웃의 원문은 아래 `## 원본 문서`에 그대로 있다.

## Colors

### Brand

```yaml
brand-primary: "#17834a"        # ← brand
brand-hover: "#126c3c"          # ← brand-hover
ai-signal: "#5a4bd1"            # ← ai
```

### Semantic alias — Light

```yaml
bg-canvas: "#f6f7f5"                # ← bg-canvas
bg-surface: "#ffffff"               # ← bg-surface
bg-subtle: "#eff1ee"                # ← bg-sunken
bg-muted: "#eceeea"                 # ← bg-hover
bg-elevated: "#ffffff"              # ← bg-surface
bg-inverse: "#17201b"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#17834a"                 # ← brand
bg-brand-subtle: "#e7f4eb"          # ← brand-soft
bg-success-subtle: "#e7f4eb"        # ← brand-soft · 합성 — 원본은 진행중·성공 토스트를 brand-soft로 표시
bg-warning-subtle: "#fff6e0"        # ← warn-soft
bg-danger-subtle: "#fff1e7"         # ← high-soft · 합성 — 원본에 danger 바탕이 없어 가장 가까운 high-soft(주황) 재사용
fg-strong: "#17201b"                # ← ink
fg-default: "#17201b"               # ← ink
fg-secondary: "#5b6660"             # ← ink-muted
fg-tertiary: "#646e68"              # ← ink-subtle
fg-disabled: "#646e68"              # ← ink-subtle · 합성 — 원본에 비활성 글자색이 없어 ink-subtle 재사용
fg-on-brand: "#ffffff"              # ← on-brand
fg-brand: "#146b3c"                 # ← brand-ink
fg-success: "#146b3c"               # ← brand-ink · 합성 — 원본은 성공을 brand-ink로 표시
fg-warning: "#8a5a00"               # ← warn
fg-danger: "#c62828"                # ← danger
border-subtle: "#e4e7e3"            # ← border-subtle
border-default: "#8a948e"           # ← border-control
border-strong: "#8a948e"            # ← border-control
border-brand: "#17834a"             # ← brand
```

### Semantic alias — Dark

```yaml
bg-canvas: "#121413"                # ← bg-canvas
bg-surface: "#1a1d1b"               # ← bg-surface
bg-subtle: "#0e100f"                # ← bg-sunken
bg-muted: "#24282a"                 # ← bg-hover
bg-elevated: "#1a1d1b"              # ← bg-surface
bg-inverse: "#eef2ef"               # ← ink · 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
bg-brand: "#45c07a"                 # ← brand
bg-brand-subtle: "#173524"          # ← brand-soft
bg-success-subtle: "#173524"        # ← brand-soft · 합성 — 원본은 진행중·성공 토스트를 brand-soft로 표시
bg-warning-subtle: "#352a12"        # ← warn-soft
bg-danger-subtle: "#3a2414"         # ← high-soft · 합성 — 원본에 danger 바탕이 없어 가장 가까운 high-soft(주황) 재사용
fg-strong: "#eef2ef"                # ← ink
fg-default: "#eef2ef"               # ← ink
fg-secondary: "#a3ada7"             # ← ink-muted
fg-tertiary: "#8f9a93"              # ← ink-subtle
fg-disabled: "#8f9a93"              # ← ink-subtle · 합성 — 원본에 비활성 글자색이 없어 ink-subtle 재사용
fg-on-brand: "#08140d"              # ← on-brand
fg-brand: "#6fd69a"                 # ← brand-ink
fg-success: "#6fd69a"               # ← brand-ink · 합성 — 원본은 성공을 brand-ink로 표시
fg-warning: "#f3c56b"               # ← warn
fg-danger: "#ff7b72"                # ← danger
border-subtle: "#2a2f2c"            # ← border-subtle
border-default: "#5f6a64"           # ← border-control
border-strong: "#5f6a64"            # ← border-control
border-brand: "#45c07a"             # ← brand
```

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
| `bg-canvas` | #f6f7f5 | #121413 | 앱 바탕, 사이드바 배경. 콘텐츠 카드가 그 위에 뜬다. |
| `bg-surface` | #ffffff | #1a1d1b | 카드, 보드 컬럼, 패널, 모달의 바탕. |
| `bg-sunken` | #eff1ee | #0e100f | 보드 컬럼 안쪽, 입력창, 세그먼트 컨트롤 트랙. |
| `bg-hover` | #eceeea | #24282a | 목록 행·내비 항목 hover. |
| `bg-selected` | #e7f4eb | #173524 | 현재 선택된 내비 항목, 선택된 행. 텍스트는 brand-ink. |
| `border-subtle` | #e4e7e3 | #2a2f2c | 카드·컬럼 외곽, 구분선. 장식용(대비 기준 없음). |
| `border-control` | #8a948e | #5f6a64 | 입력창·체크박스·보조 버튼 테두리. bg-surface 위 3:1 이상. |
| `ink` | #17201b | #eef2ef | 본문·제목. bg-canvas, bg-surface, bg-sunken 위. |
| `ink-muted` | #5b6660 | #a3ada7 | 보조 텍스트, 메타 정보(담당자·날짜). bg-surface, bg-canvas 위. |
| `ink-subtle` | #646e68 | #8f9a93 | 내비의 한글 보조 라벨, 섹션 캡션, 빈 상태 '없음'. bg-canvas·bg-surface 위 4.5:1. |
| `brand` | #17834a | #45c07a | 주요 행동(새 프로젝트, 빠른 생성, 저장). 화면당 하나. 글자는 on-brand. |
| `brand-hover` | #126c3c | #5ccd8b | brand 버튼 hover/pressed. |
| `on-brand` | #ffffff | #08140d | brand 위 텍스트·아이콘. |
| `brand-soft` | #e7f4eb | #173524 | 진행중 상태 칩, 선택 배경, 성공 토스트 바탕. |
| `brand-ink` | #146b3c | #6fd69a | brand-soft 위 텍스트, 링크, 선택된 내비 텍스트. |
| `ai` | #5a4bd1 | #a99dff | AI 비서의 목소리 전용: AI 버튼, 제안 카드 마커, 스파클 아이콘. 사람이 만든 콘텐츠에는 쓰지 않는다. |
| `on-ai` | #ffffff | #140f2e | ai 채움 위 텍스트. |
| `ai-soft` | #f0eeff | #26213f | AI 제안 카드·AI 말풍선·AI가 채운 필드 하이라이트 바탕. |
| `ai-ink` | #4a3cb8 | #bdb3ff | ai-soft 위 텍스트(AI 라벨, 제안 제목). |
| `info` | #1e4fc4 | #8fb2ff | 기획중 상태, Medium 우선순위 텍스트. info-soft 위. |
| `info-soft` | #eaf0ff | #1b2640 | 기획중·Medium 칩 바탕. |
| `warn` | #8a5a00 | #f3c56b | 보류 상태, 마감 임박 텍스트. warn-soft 위. |
| `warn-soft` | #fff6e0 | #352a12 | 보류·마감 임박 칩 바탕. |
| `high` | #b4430c | #ffa66b | High 우선순위, 미수금 텍스트. high-soft 위. |
| `high-soft` | #fff1e7 | #3a2414 | High 칩 바탕. |
| `danger` | #c62828 | #ff7b72 | 삭제·오류 텍스트와 아이콘. 항상 단어/아이콘과 함께. |
| `focus` | #2563eb | #6ea0ff | 키보드 포커스 링(2px 실선 + 2px 오프셋). 모든 표면 위 3:1 이상. |
| `kind-task` | #17834a | #45c07a | 할일 아이콘. |
| `kind-doc` | #1e4fc4 | #8fb2ff | 문서 아이콘. |
| `kind-memo` | #8a5a00 | #f3c56b | 메모 아이콘. |
| `kind-contact` | #0f7a7a | #5fd3d0 | 연락처 아이콘. |
| `kind-diagram` | #7a3fb0 | #d1a6ff | 다이어그램 아이콘. |
| `kind-finance` | #b4430c | #ffa66b | 견적서·경리 아이콘. |
| `kind-worklog` | #5b6660 | #a3ada7 | 작업일지 아이콘. |
| `ws-personal` | #5a4bd1 | #a99dff | 워크스페이스 점: 개인. |
| `ws-team` | #1e7fc4 | #7cc4ff | 워크스페이스 점: 단체/팀. |
| `ws-company` | #17834a | #45c07a | 워크스페이스 점: 회사. |
| `ws-client` | #d97706 | #f5b041 | 워크스페이스 점: 고객/외부 프로젝트. |

## Typography

### 서체 선택

- **Primary**: `Pretendard, "Noto Sans KR", "Apple SD Gothic Neo", system-ui, sans-serif`
- **Mono**: `"JetBrains Mono", ui-monospace, monospace`

### Type ramp

```yaml
display1: 26/700/1.31/-0.02em     # ← page-title (26px/34px) 페이지 제목. 화면당 하나.
display2: 26/700/1.31/-0.02em     # ← page-title (26px/34px) 페이지 제목. 화면당 하나.
display3: 18/650/1.44/-0.01em     # ← section-title (18px/26px) 패널·섹션 제목.
title1: 18/650/1.44/-0.01em       # ← section-title (18px/26px) 패널·섹션 제목.
title2: 15/600/1.47/0             # ← card-title (15px/22px) 카드·행의 항목 이름.
title3: 15/600/1.47/0             # ← card-title (15px/22px) 카드·행의 항목 이름.
label1: 13/500/1.54/0             # ← ui (13px/20px) 버튼, 탭, 내비 항목.
label2: 12/400/1.5/0              # ← meta (12px/18px) 담당자, 날짜, 카운트, 칩.
body1: 14/400/1.57/0              # ← body (14px/22px) 본문, AI 대화, 설명.
body1-read: 14/400/1.57/0         # ← body (14px/22px) 본문, AI 대화, 설명.
body2: 13/500/1.54/0              # ← ui (13px/20px) 버튼, 탭, 내비 항목.
caption1: 11/600/1.45/0.04em      # ← caption (11px/16px) 사이드바 섹션 캡션. 영문은 대문자.
```

### 시안 전용 글꼴 스타일

| 원본 스타일 | 크기/굵기/줄높이/자간 | 용도 |
|---|---|---|
| `figure` | 13/500/1.54/0 | 견적·경리 금액, 퍼센트. 표에서 오른쪽 정렬. |

## Spacing

```yaml
space-4: 4        # ← space-1 아이콘–라벨 간격, 칩 내부 세로.
space-8: 8        # ← space-2 칩 사이, 카드 내부 줄 간격.
space-12: 12      # ← space-3 카드 내부 패딩(밀집), 보드 컬럼 간격.
space-16: 16      # ← space-4 카드 패딩, 패널 패딩, 모바일 좌우 여백.
space-20: 20      # 표준 ladder (원본에 없음)
space-24: 24      # ← space-6 섹션 간격.
space-32: 32      # ← space-8 페이지 좌우 여백(데스크톱).
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
radius-16: 16       # 표준 ladder
radius-6: 6         # ← radius-sm 6px · 시안 전용(비-4) — 칩, 세그먼트 탭, 작은 버튼.
radius-10: 10       # ← radius-md 10px · 시안 전용(비-4) — 버튼, 입력창, 카드.
radius-14: 14       # ← radius-lg 14px · 시안 전용(비-4) — 보드 컬럼, 패널, 모달.
radius-full: 9999   # ← radius-full 999px — 아바타, 상태 점, 추천 프롬프트 칩.
```

## Elevation & Depth

```yaml
shadow-1: "0 1px 2px rgba(23,32,27,0.06)"  # ← shadow-card · dark 0 1px 2px rgba(0,0,0,0.4)
shadow-pop: "0 8px 24px rgba(23,32,27,0.12)"  # ← shadow-pop · dark 0 8px 24px rgba(0,0,0,0.5)
```

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
| button | Button (primary·secondary·ghost·ai·ai-solid, 높이 32/28) |
| input | CommandBar 입력 (원본에 독립 폼 입력 없음 — bg-sunken 바탕 + border-control) |
| badge | StatusChip (plan·progress·hold·done·cancel·우선순위) |
| chip | StatusChip · AssistantPanel 추천 칩(radius-full) |
| avatar | ProjectCard 담당자 아바타 (radius-full) |
| icon-button | 원본 없음 — Button ghost + 아이콘으로 대체 |
| icon | README 아이콘 (Lucide 1.5px, 16/14px, currentColor) |

### 원본 컴포넌트 (9종)

| 컴포넌트 | 요약 |
|---|---|
| AppShell | 앱 전체의 3단 레이아웃: 왼쪽 내비(`sidebar-width`) · 가운데 작업 영역 · 오른쪽 AI 비서(`assistant-width`). |
| AssistantPanel | 작업 영역 오른쪽에 붙는 AI 비서 대화 패널(폭 `assistant-width` 360px). |
| Button | 행동을 실행하는 버튼. |
| CommandBar | ⌘K로 여는 단일 입력창. |
| ItemRow | 모든 항목 종류가 공유하는 한 줄 목록 행. |
| PlanCard | 행사·여행·출장·미팅·런칭처럼 날짜에 맞춰 준비하는 기획 카드. |
| ProjectCard | 보드·카드 보기에서 프로젝트 하나를 요약하는 카드. |
| StatusChip | 상태·우선순위·메타 값을 보여 주는 작은 라벨. |
| SuggestionCard | AI가 데이터 변경을 제안할 때 쓰는 카드. |

## Known Gaps

- 원본 간격 이름은 단계 번호(space-1=4px … space-8=32px)라 템플릿 이름(space-4=4px)으로 값 기준 재매핑했다.
- 라운드 6·10·14는 4의 배수가 아니라 시안 전용 토큰(radius-6/10/14)으로 원래 값을 유지한다(계약 9b).
- 원본 section-title 굵기 650은 그대로 옮긴다(가변 서체 전제).
- `bg-inverse` ← `ink`: 합성 — 원본에 반전 면이 없어 본문 잉크를 재사용
- `bg-success-subtle` ← `brand-soft`: 합성 — 원본은 진행중·성공 토스트를 brand-soft로 표시
- `bg-danger-subtle` ← `high-soft`: 합성 — 원본에 danger 바탕이 없어 가장 가까운 high-soft(주황) 재사용
- `fg-disabled` ← `ink-subtle`: 합성 — 원본에 비활성 글자색이 없어 ink-subtle 재사용
- `fg-success` ← `brand-ink`: 합성 — 원본은 성공을 brand-ink로 표시

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

Grove는 개인·단체·회사가 **프로젝트와 기획을 중심으로** 할일, 문서, 메모, 연락처, 다이어그램, 견적서, 경리, 작업일지를 한곳에 정리하고, **AI 비서가 화면 맥락을 읽고 먼저 제안하는** 워크스페이스의 디자인 시스템이다. (Grove는 가칭)

> 컨셉 한 줄: **"정리는 사람이, 정돈은 AI가."** 사람은 프로젝트라는 나무를 심고, AI는 그 아래 흩어진 잎(할일·문서·돈·사람)을 모아 가지에 붙여 준다.

##### 디자인 원칙

1. **컨테이너 우선 (Container-first).** 모든 항목은 프로젝트 또는 기획 하나에 속한다. 소속이 없으면 `Inbox`에 들어가고, AI가 소속을 제안한다. 같은 할일을 Today·Tasks·프로젝트 상세에서 보더라도 하나의 레코드다.
2. **같은 데이터, 여러 렌즈.** 카드·표·보드·타임라인·워크로드·대시보드·리스트는 같은 데이터의 보기일 뿐이다. 보기 전환으로 필터·정렬이 사라지지 않는다.
3. **AI는 제안하고, 사람이 확정한다.** AI가 만든 변경은 항상 미리보기(diff) 카드로 먼저 보이고, `적용 / 수정 / 무시` 세 버튼으로 끝난다. 확정 전에는 데이터를 바꾸지 않는다.
4. **AI는 한 가지 색으로 말한다.** `ai` 계열 색과 스파클 아이콘은 AI가 말하거나 만든 것에만 쓴다. 사람이 만든 콘텐츠에 보라색이 보이면 버그다.
5. **조용한 밀도.** 업무 도구는 하루 종일 켜 둔다. 큰 장식 대신 정보 밀도와 정렬로 위계를 만든다. 강조색은 화면당 `brand` 버튼 하나.

##### 콘텐츠 원칙 (보이스·톤)

- 존댓말 해요체. 짧게. "프로젝트를 만들었어요", "마감이 3일 남았어요".
- AI는 1인칭을 쓰되 주어를 생략한다: "이번 주 마감 2건을 찾았어요. 일정에 넣을까요?" — 질문으로 끝내 결정을 사람에게 넘긴다.
- 버튼은 동사로: `새 프로젝트`, `적용`, `일정에 추가`. "확인"·"OK" 금지.
- 내비 라벨은 영문 + 한글 보조 라벨(`Projects 프로젝트`)을 유지한다. 한글 보조 라벨은 `ink-subtle`, `meta` 스타일.
- 숫자: 금액은 `₩ 2,400,000`(`figure` 스타일), 날짜는 `2026.06.30`, 상대 시간은 "3일 남음".
- 빈 상태는 "없음" 한 단어 + AI 제안 한 줄("비슷한 프로젝트에서 할일 5개를 가져올까요?").
- 이모지는 AI 인사 첫 줄에만 하나까지 허용. 카드·버튼·내비에는 쓰지 않는다.

##### 색

- 바탕은 `bg-canvas`, 그 위 카드·패널은 `bg-surface`, 보드 컬럼 안쪽·입력창은 `bg-sunken`.
- 본문 `ink`, 메타 `ink-muted`, 보조 라벨 `ink-subtle`. 세 단계 이상 회색을 만들지 않는다.
- 주요 행동은 `brand` 채움 + `on-brand` 글자. 한 화면에 하나(예: `새 프로젝트`). 상단 `빠른 생성`은 전역 행동이라 예외.
- AI: 버튼·마커는 `ai`, 제안 카드 바탕은 `ai-soft`, 그 위 글자는 `ai-ink`.
- 상태 칩(글자 + 연한 바탕, 반드시 단어 포함):
  - 기획중 `info` / `info-soft`
  - 진행중 `brand-ink` / `brand-soft`
  - 보류 `warn` / `warn-soft`
  - 완료 `ink-muted` / `bg-sunken` (+ 체크 아이콘)
  - 취소 `ink-subtle` / `bg-sunken` (+ 취소선)
- 우선순위: High `high`/`high-soft`, Medium `info`/`info-soft`, Low `ink-muted`/`bg-sunken`.
- 항목 종류 아이콘은 `kind-*` 색 하나로만 칠한다(바탕 없음). 워크스페이스 점은 `ws-*`.
- 다크 테마는 같은 이름의 토큰을 바꿔 끼운다. `brand`가 밝아지므로 `on-brand`는 어두운 글자가 된다 — 흰 글자를 하드코딩하지 않는다.

##### 타이포그래피

- 한글 우선 서체 Pretendard(자체 호스팅 권장), 없으면 Noto Sans KR. 숫자·금액은 `mono`의 `figure`.
- 위계: `page-title` 26/34 → `section-title` 18/26 → `card-title` 15/22 → `body` 14/22 → `ui` 13/20 → `meta` 12/18 → `caption` 11/16.
- 한 카드 안에서는 `card-title` + `meta` 두 단계만 쓴다.

##### 간격·모서리·그림자

- 4px 그리드: `space-1` 4 · `space-2` 8 · `space-3` 12 · `space-4` 16 · `space-6` 24 · `space-8` 32.
- 칩 `radius-sm`, 버튼·카드·입력 `radius-md`, 컬럼·패널·모달 `radius-lg`, 아바타·추천 칩 `radius-full`.
- 카드는 `border-subtle` 1px + `shadow-card`. 떠 있는 레이어(커맨드 바, 메뉴)만 `shadow-pop`.

##### 레이아웃

3단 셸: 왼쪽 내비(`sidebar-width` 232px) · 가운데 작업 영역 · 오른쪽 AI 비서(`assistant-width` 360px, 닫을 수 있음). 상단 바(`topbar-height` 48px)에는 브레드크럼, 검색/명령(⌘K), `AI` 토글, 알림, `빠른 생성`, 아바타.

- 1280px 미만: AI 패널은 오버레이 시트로 바뀐다.
- 768px 미만: 내비는 하단 탭(Today · Projects · Tasks · AI · 더보기), AI는 전체 화면 시트, 좌우 여백 `space-4`.

##### 상태와 인터랙션

- hover `bg-hover`, 선택 `bg-selected` + `brand-ink` 글자.
- 포커스: `focus` 2px 실선 링 + 2px 오프셋, 모든 표면 위 3:1 이상. 마우스 클릭에는 표시하지 않고 키보드에만(`:focus-visible`).
- 모션: 150ms ease-out(hover, 토글), 220ms(패널 열기). AI 응답 스트리밍 중엔 커서 깜빡임 하나만; 반짝이·그라데이션 애니메이션 금지.
- 낙관적 업데이트 + 하단 토스트 "되돌리기" 5초.

##### 아이콘

- Lucide 계열 1.5px 스트로크, 16px(내비·버튼) / 14px(칩·메타). `currentColor`로 칠한다.
- AI는 반드시 `sparkles` 아이콘 + `ai` 색. 다른 기능에 sparkles를 쓰지 않는다.
- 항목 종류: 할일 `check-square`, 문서 `file-text`, 메모 `sticky-note`, 연락처 `user-round`, 다이어그램 `workflow`, 견적서 `receipt`, 경리 `wallet`, 작업일지 `notebook-pen`, 프로젝트 `folder-kanban`, 기획 `calendar-range`.
- 로고는 아직 없다. 워드마크는 `sans` 700으로 "Grove"를 조판한다.

#### 정보 구조 (IA)

##### 3계층 모델

```
Workspace (누구의 것인가)        개인 · 단체/팀 · 회사 · 고객
  └─ Container (무엇을 위한 것인가)   프로젝트(결과물 중심) · 기획(일정·행사 중심)
       └─ Item (무엇을 다루는가)       할일 · 문서 · 메모 · 연락처 · 다이어그램 · 견적서 · 경리 · 작업일지
```

- **Workspace**: 권한과 공유의 경계. 사이드바의 색 점(`ws-*`)으로 구분한다. 개인 워크스페이스는 언제나 하나 존재한다.
- **Container**: 프로젝트는 "만들어서 끝내는 것"(API 개발, 지갑 연동), 기획은 "날짜에 맞춰 준비하는 것"(행사·여행·출장·미팅·런칭). 둘은 같은 컴포넌트를 쓰되 기획은 날짜·장소·준비율·예산이 카드 머리에 온다.
- **Item**: 모든 항목은 컨테이너 하나에 속하고, 다른 항목을 링크할 수 있다(견적서 → 연락처, 작업일지 → 할일). 소속 없는 항목은 `Inbox`.

##### 내비게이션

| 구역 | 항목 | 성격 |
| --- | --- | --- |
| 나의 하루 | Home, Today, Inbox | 모든 워크스페이스를 가로지르는 개인 뷰 |
| 컨테이너 | Projects, Plans | 그룹 단위 관리 |
| 항목 | Tasks, Calendar, Contacts, Docs, Diagrams, Finance(견적·경리), WorkLogs | 종류별 전체 목록(컨테이너 필터 가능) |
| 비서 | Assistant | AI 대화 기록, 자동화 규칙, 주간 리포트 |
| 기타 | Shared, Trash, Settings | |

- 상단 워크스페이스 전환기(현재 "개발 프로젝트")를 바꾸면 모든 목록이 그 범위로 좁혀진다. "모든 워크스페이스"도 선택 가능.
- `즐겨찾기`, `최근 문서`는 사이드바 하단에 접히는 섹션으로.

##### 프로젝트 상세 = 허브

프로젝트를 열면 상단 요약(상태·진행률·담당·마감) 아래 탭으로 항목 종류를 보여 준다:
`개요 · 할일 · 문서 · 다이어그램 · 견적/경리 · 연락처 · 작업일지 · 활동`

- **개요** 탭은 AI가 만든 "프로젝트 브리프"(진행 요약, 리스크, 다음 행동 3개)와 사람이 쓴 설명을 나란히 둔다.
- 각 탭은 Item 목록 컴포넌트를 그대로 재사용한다.

##### 보기(View)

카드 · 표 · 보드 · 타임라인 · 워크로드 · 대시보드 · 리스트. 보기 설정(그룹 기준, 표시 속성), 필터, 색 기준은 보기마다 저장되고 URL(`?view=board`)에 남는다.

##### 빠른 생성

`빠른 생성`(또는 `N`)은 하나의 입력창이다. 자연어를 받으면 AI가 종류와 소속을 추정해 제안한다:
"다음주 화요일 ABC사 계약 미팅, 견적서 같이" → 기획(미팅) 1 + 할일 1 + 견적서 초안 1, 소속 제안 "고객 프로젝트".

#### AI 비서 UX

AI 비서는 **세 개의 자리**에 나타난다. 어디에 있든 `ai` 색과 sparkles 아이콘으로 알아볼 수 있다.

##### 1. 오른쪽 패널 (대화)

- 헤더: "AI Assistant" + **맥락 칩**(`Projects 기준`, `Hashpower SaaS API 기준`). 사용자가 칩을 눌러 맥락을 넓히거나 좁힐 수 있다(이 화면 · 이 프로젝트 · 워크스페이스 전체).
- 연결 상태 칩: `AI 미연결`은 `warn` 칩. 미연결일 때도 규칙 기반 답(이번 달 매출 요약, 미수금, 우선순위)은 동작하며, 답변 아래에 "AI를 연결하면 더 자세히 답할 수 있어요 · 설정"을 한 줄로.
- 하단 **이 화면 추천**: 현재 화면에 맞는 프롬프트 칩 2–3개(`radius-full`, `ai-soft` 바탕). 화면이 바뀌면 교체된다.
  - Projects: "진행 상황 요약해줘", "마감이 가까운 프로젝트 알려줘"
  - Plans: "진행 중인 기획 요약해줘", "준비 안 된 항목 찾아줘"
  - Finance: "이번 달 미수금 정리해줘"
- AI 답변 안에 데이터가 있으면 텍스트가 아니라 **미니 카드**(프로젝트 카드 축약판)로 보여 주고, 눌러서 이동한다.

##### 2. 인라인 제안 (Suggestion card)

작업 영역 안, 관련 위치에 붙는 `ai-soft` 카드. 구성은 항상 같다:

```
[✦ AI 제안]  제목 한 줄
근거 한 줄 (ink-muted) — "Hashpower SaaS API 마감까지 14일, 진행률 68%"
변경 미리보기 (추가될 항목 / 바뀔 값)
[적용]  [수정]  [무시]
```

- 쌓이지 않게: 한 화면에 최대 1개, 나머지는 패널의 "제안 n개" 배지로.
- `무시`를 누르면 같은 종류 제안을 7일간 숨기고, "이런 제안 그만 보기" 링크를 함께 준다.

##### 3. 앰비언트 신호

- **Today 브리핑**: 아침 첫 진입 시 Today 상단에 3줄 요약(오늘 마감, 막힌 것, 추천 순서). 접으면 하루 동안 접힌 채 유지.
- **필드 하이라이트**: AI가 채운 필드는 `ai-soft` 밑줄 + 작은 sparkles. 사람이 수정하면 사라진다.
- **커맨드 바(⌘K)**: 검색 결과 맨 아래 "✦ AI에게 묻기: …" 줄. 명령과 질문을 같은 입력에서.

##### 제안 시나리오 (카탈로그)

| 트리거 | 제안 | 결과 |
| --- | --- | --- |
| 미팅 기획 생성 | 준비 체크리스트 8개, 참석자 연락처 연결 | 할일 n개 + 연락처 링크 |
| 견적서 발행 후 30일 미입금 | 미수금 알림 + 재요청 메일 초안 | 경리 항목 상태 변경 + 문서 초안 |
| 작업일지 3일 연속 같은 할일 | 할일을 쪼개자는 제안 | 하위 할일 생성 |
| 프로젝트 진행률 정체(7일 변화 0) | 상태 `보류` 전환 또는 담당 재배정 | 상태 변경 |
| 소속 없는 메모 | 가장 관련 높은 프로젝트로 이동 | Inbox → 컨테이너 |
| 금요일 오후 | 주간 리포트 초안(작업일지 + 완료 할일) | 문서 생성 |

##### 신뢰 규칙

- 확정 전엔 아무것도 바꾸지 않는다. 일괄 적용도 미리보기 목록을 먼저 보여 준다.
- 모든 AI 변경은 활동 로그에 "✦ AI 제안 · 스티브 적용" 형식으로 남고 되돌릴 수 있다.
- 금액(견적·경리)은 AI가 계산해도 사람이 `적용`해야 확정된다. 금액 필드에는 근거 툴팁을 단다.
- 근거 없는 제안 금지: 제안 카드에는 반드시 근거 한 줄이 있다.
