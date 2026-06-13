# User FE 디자인 가이드 (모바일 전용판)

모바일 전용(viewport 360~430 고정, 데스크탑 미지원, 네이티브-like 인터랙션) consumer-facing user FE 표면을 만들 때 사용하는 가이드다. 반응형판(`docs/user-fe-design-guide.md`)과 동일한 5종 컴포넌트와 7종 화면 패턴을 공유하지만, 컴포넌트 로컬값과 인터랙션 패턴이 모바일에 최적화된다.

본 가이드는 `DESIGN.md`를 1차 소스로 호출하며, 반응형판 가이드의 1차 원칙·시안별 정책은 그대로 상속한다. 본 문서는 **차이점**과 **모바일 전용 추가 인터랙션**만 명세한다.

## 적용 범위

- viewport 360~430 (iPhone SE 375 / iPhone 14 390 / Pixel 7 412 / iPhone 14 Pro Max 430 등).
- 데스크탑/태블릿 미지원. 데스크탑 사용자는 별도 반응형 surface 또는 PWA 설치 안내.
- 네이티브 앱 또는 PWA 컨테이너 가정. 브라우저 chrome(주소창)은 환경 따라 노출.
- iOS Safari + Android Chrome 두 브라우저를 baseline.

## 반응형판과의 차이 (역방향 표)

본 가이드 시점에서 본 반응형판과의 차이. 반응형판 가이드 끝의 표와 동일하지만 시점이 반대.

| 항목 | 모바일 전용 (본 가이드) | 반응형 (`user-fe-design-guide.md`) |
|---|---|---|
| viewport | 360~430 고정 | 360~1280+ 모두 지원 |
| nav | `### bottom-nav` 고정 (3~5탭) | mobile bottom-nav → tablet sidebar → desktop sidebar |
| 그리드 | 4 cols 고정 (또는 단열) | 4 → 8 → 12 cols |
| sticky CTA | **모든 1차 액션 화면 표준** | mobile only (옵션) |
| modal | `### bottom-sheet` 중심, 풀스크린 modal | desktop `{component.modal}` 중심 |
| swipe/gesture | **표준** (carousel, sheet drag, swipe-action, pull-to-refresh) | 옵션 (mobile only) |
| toast 위치 | 상단 sticky 또는 하단(bottom-nav 위) | 우측 하단 corner (desktop) |
| max-content-width | 폭 100% | 1200~1280 (desktop) |
| hover state | 미사용 (active state만) | desktop에서 hover, mobile에서 active |
| keyboard 단축키 | 미사용 (`linear-like` ⌘K 등도 표면 X) | desktop에서 옵션 |

## 1차 원칙 (모바일 전용 특화)

반응형판 1차 원칙(mobile-first / touch target 44 / safe-area-inset)을 그대로 상속하고 아래를 추가한다.

**모바일 전용 추가 원칙**
- **viewport 폭 360 기준 디자인**, 412/430에서 확장 동작 점검. 미디어쿼리는 사용하지 않거나 360~430 범위 내 미세 조정만(`@media (min-width: 412px) { ... }` 정도).
- **hover state 금지** — 모든 인터랙티브 요소는 `:active` 상태만 사용(터치 only). `:hover`는 브라우저가 mobile에서 sticky로 잘못 적용할 수 있어 명시적으로 분리.
- **gesture 우선** — carousel은 swipe(좌우), sheet는 drag(상하), list-row는 swipe-action(좌우), 새로고침은 pull-to-refresh. 모든 gesture는 시각 affordance(handle/chevron/dot indicator) 동반 필수.
- **sticky bottom CTA 표준** — 상세/폼/신청/결제 화면 모두 sticky bottom CTA. height 64, safe-area-inset-bottom 합산.
- **single-page-flow 우선** — 다단계 작업은 page navigation 또는 풀스크린 modal(`### bottom-sheet`로는 부족할 때)로 분리. tab 전환으로 다른 작업 영역을 한 화면에 섞지 않는다.
- **keyboard 단축키 미사용** — 시안 `linear-like`의 ⌘K, `material-3`의 keyboard navigation 표시는 모바일 전용판에서 제거(또는 desktop fallback).
- **back-button 일관성** — iOS는 좌측 swipe-back 제스처와 동일 위치(좌상단), Android는 시스템 back 외 명시적 back-button 항상 노출. cross-platform 단일 패턴은 좌상단 `chevron-left` 24px.

## Breakpoints (모바일 전용판)

본 가이드에서는 반응형판의 4단 breakpoint를 단일 breakpoint로 축소한다.

| Name | Width | Columns | Gutter | 비고 |
|---|---|---|---|---|
| Mobile | 360~430 | 4 | `{spacing.space-16}` | 단일 breakpoint, 미세 조정만 |

412+ device에서 추가 여백 또는 폰트 한 단계 승격은 옵션. 본 가이드는 360을 baseline으로 모든 spec을 정의한다.

## 화면 골격

모든 화면이 동일 골격을 따른다.

```
+--------------------------+
| status-bar safe-area     |  ← env(safe-area-inset-top)
+--------------------------+
| app-bar (52h, sticky)    |  ← {component.app-bar (mobile)}
+--------------------------+
|                          |
|  content (scroll)        |
|  padding {space-16}      |
|                          |
+--------------------------+
| sticky CTA (64h) [옵션]  |  ← 1차 액션 화면 필수
+--------------------------+
| bottom-nav (56h, sticky) |  ← 루트 화면. 상세/폼은 미노출
+--------------------------+
| home-indicator safe-area |  ← env(safe-area-inset-bottom)
+--------------------------+
```

루트 화면(홈/탐색/즐겨찾기/알림/마이)은 bottom-nav 노출, 상세/폼/신청은 bottom-nav 숨김 + sticky CTA 노출.

## 컴포넌트 — 모바일 전용 로컬값

반응형판 5종 컴포넌트(`### app-bar`/`### bottom-nav`/`### feed-card`/`### search-bar`/`### bottom-sheet`)를 그대로 호출하되 아래 로컬값을 모바일 전용으로 적용한다.

### app-bar
- height 52 유지. desktop 56 승격 정책 미적용(모바일 전용은 52 단일).
- 좌측 cluster `back-button` 또는 `hamburger`. 루트 5탭(홈/탐색/즐겨찾기/알림/마이)은 hamburger 미사용 — 모든 nav는 bottom-nav가 담당.
- right-cluster icon-button은 최대 2개. 3+ 시 'more' menu(... 아이콘) 분리.

### bottom-nav
- 모든 루트 화면 노출 표준. 상세/폼/신청 화면은 숨김.
- 4 Cases 중 시안별 디폴트 적용. 모바일 전용은 Case A(5탭 균등) 또는 Case B(FAB+4탭)이 표준, Case C/D는 시안 시그너처에 한정.
- safe-area-inset-bottom 합산 필수.

### feed-card
- mobile 단열 vertical 또는 horizontal 중 선택. grid 모드 미사용(반응형판은 viewport에 따라 2~3열).
- carousel 모드: 카드 폭 = viewport - `{spacing.space-32}` (좌우 16 peek). 좌우 dot indicator 또는 progress bar.
- horizontal 변형 thumbnail width 96(데이터 밀도) 또는 120(메인 추천).

### search-bar
- 디폴트 Case A(inline) 또는 Case B(풀스크린 overlay). Case C voice는 도메인 적합 시만.
- 시안 `toss-like`/`linear-like`는 Case B 모바일 1차.
- 풀스크린 overlay 진입 시 hardware back-button(Android) + swipe-back(iOS)로 dismiss 가능.

### bottom-sheet
- 모달 표준. 정렬/필터/픽커/액션 선택 모두 sheet로.
- 풀스크린 modal(`### bottom-sheet` 100vh)도 옵션 — sheet 내부 form이 6+ field인 경우 또는 step-by-step.
- backdrop tap dismiss는 단순 선택만. 위험 액션·작성 중인 form은 명시 X 버튼 또는 'cancel' 버튼만.

## 모바일 전용 인터랙션 패턴

`DESIGN.md ### bottom-sheet > #### 모바일 전용 인터랙션 패턴`을 1차 소스로 호출. 아래는 화면 단위 적용 패턴.

### segmented-control (in-page tab)

2~3개 토글 전용. height 36, `{rounded.radius-full}` 외곽 + active cell 색 분리. 사용 위치:
- 상세 페이지 내 정보 분기(예: 리뷰/문의/일정)
- 리스트/지도 토글
- 일/월/연 단위 전환

4개+는 admin Case A(line underline)로 대체. 본 컴포넌트는 화면 본문 폭에 자동 fit.

### list-row swipe-action

목록(주문 내역/즐겨찾기/알림)에서 행 좌→우 swipe로 우측 액션 노출.

- swipe 트리거: 행 width의 30% 이상 left translate.
- 액션 버튼: width 72, height = row height. bg 시맨틱 색(`{colors.bg-danger}` 삭제 / `{colors.bg-brand}` 즐겨찾기).
- 위험 액션(삭제)은 swipe만으로 즉시 실행 금지 → 두 번째 confirm tap 또는 `### bottom-sheet` 확인.
- 시각 affordance: 행 우측 끝에 chevron 또는 점 3개 메뉴 아이콘(swipe 가능 표시). 첫 진입 시 한 번 hint animation(0.5초 좌측 nudge) 권장.

### pull-to-refresh

화면 상단(app-bar 아래)에서 아래로 당겨 새로고침. 적용 화면: 홈/피드/리스트/알림/마이.

- 당기는 동안: 상단 32~48px 영역에 spinner 또는 progress arc.
- 80px 임계 이상: release-to-refresh 표기(텍스트 변경 `당겨서 새로고침` → `놓으면 새로고침`).
- refresh 중: 상단 sticky spinner 유지, 콘텐츠는 그대로.
- 완료 후: spinner 200ms fade-out + 새 콘텐츠 즉시 노출.

### native-like toast

- 위치: 화면 **하단** 표준(bottom-nav 위 `{spacing.space-12}` offset, sticky CTA 있으면 그 위). 상단은 critical alert에 한정.
- duration 3~4초 auto dismiss. swipe-down-to-dismiss 허용(하단 toast는 swipe-up은 무시).
- max-width: viewport - `{spacing.space-32}`. 좌우 마진 `{spacing.space-16}`.
- 단일 toast 정책. 새 toast가 떴을 때 기존은 즉시 사라짐(stack 금지).

### sticky bottom CTA

상세/폼/신청/결제 화면 표준. 본문 스크롤 영역과 분리된 sticky 영역.

- height 64 (CTA button 48 + padding 8/8).
- bg `{colors.bg-surface}`, border-top 1px `{colors.border-subtle}`.
- safe-area-inset-bottom padding 합산 (iOS home indicator).
- CTA button: `{component.button-primary} lg full-width`. 두 액션이 필요하면 우측 primary + 좌측 secondary(40:60 비율), 단 primary 1개가 표준.

## 7 화면 — 모바일 전용 변형

반응형판 7 화면을 모바일 전용 인터랙션으로 강화. 골격은 동일하나 인터랙션 패턴이 추가된다.

### 1. Splash / Onboarding

- 풀스크린 carousel 3-step. swipe 좌우 + dot indicator + skip 버튼(우상단).
- 마지막 step에서 sticky bottom CTA "시작하기" + ghost "이미 계정이 있어요".
- iOS notch / Android cutout 회피용 상단 safe-area-inset 적용.

### 2. Login

- 반응형 mobile 변형 그대로. 카드 없이 풀스크린.
- 키보드 노출 시 입력 필드가 viewport 중앙에 오도록 `scroll-into-view`.
- 소셜 로그인 버튼 height 52(모바일 전용은 한 단계 큼).

### 3. 홈 / 피드

- **pull-to-refresh** 적용.
- hero banner 또는 promo card는 swipe carousel (2~3 슬라이드, auto-rotate 옵션 — 정지 가능).
- 카테고리 chip-row는 horizontal scroll. 좌우 peek 16px.
- feed-card는 vertical 단열. 카드 간 gap `{spacing.space-12}`.
- 무한 스크롤 — 하단 30% 진입 시 다음 페이지 prefetch.

### 4. 탐색 / 리스트

- 상단 search-bar 시안 디폴트(`toss-like`/`linear-like`는 Case B 풀스크린).
- 필터 chip-row + 우측 정렬 chip. 필터 진입은 `### bottom-sheet` 풀스크린.
- 결과 grid가 아닌 vertical 단열 또는 2열(thumbnail 위주는 2열).
- **pull-to-refresh** 적용.

### 5. 상세

- 상단 media gallery swipe carousel. dot indicator 또는 progress bar.
- 본문 스크롤 + 하단 sticky CTA.
- 위험 액션(취소/삭제)은 본문 끝 `{component.button-tertiary}` 또는 mypage 메뉴에 분리 — 상세 화면 sticky CTA에는 두지 않음.
- 리뷰/댓글 진입은 본문 하단 `리뷰 32개 보기 →` tap → 별도 페이지(modal 풀스크린).

### 6. 폼 / 신청

- step-by-step 진행. 한 step = 한 화면(모바일 전용은 wizard 패턴 표준).
- step indicator 상단(app-bar 아래).
- 각 step의 마지막 액션은 sticky CTA "다음 단계" / "신청 완료".
- 입력 필드 height 48~52 (모바일 전용은 hit area 강화).
- placeholder picker(날짜/지역) tap → `### bottom-sheet` 풀스크린 picker.
- 키보드 노출 시 sticky CTA가 키보드 위로 따라 올라옴(또는 자동 scroll).

### 7. 마이 / 설정

- 프로필 카드 + 메뉴 리스트.
- 주문 내역/즐겨찾기는 **list-row swipe-action** (좌→우 swipe로 삭제/숨김).
- 다크 모드 토글은 시스템 따름 옵션 + 명시 토글 함께 제공.
- 로그아웃은 본문 끝 ghost danger 버튼 + `### bottom-sheet` 확인.

## 시안별 모바일 전용 디폴트

5개 시안 모두 모바일 전용판에서 동작. 시안별 모바일 강화 정책:

| 시안 | bottom-nav | search-bar | feed-card | CTA |
|---|---|---|---|---|
| `wanted` | A 5탭 | A inline | vertical, 1px border, padding 16 | bg-brand 채움 lg |
| `minimal-mono` | A 또는 C | D sunken pill | vertical, 1px border 흑백 | 검정 채움 lg |
| `toss-like` | A 5탭 + 활성 아이콘 강조 | B 풀스크린 (모바일 1차) | shadow-1, radius-16 | bg-brand lg + shadow-cta |
| `material-3` | A M3 navigation bar | A inline (M3 search bar) | elevated card shadow-1 | filled button radius-full + ripple |
| `linear-like` | **C 텍스트 only** | B 풀스크린 (단, ⌘K kbd 미표면) | 1px border 컴팩트 padding 12 | gradient accent CTA (kbd 미표면) |

## 카피 톤

반응형판 가이드와 동일(`policy.copy_tone` 따름). 추가 정책:
- 모바일 전용은 카피가 짧을수록 좋다 — 버튼 1단어 3~4자(`시작`, `다음`, `완료`) 우선, 풀 문장 사용 자제.
- 알림 토스트는 한 줄(viewport 폭에 맞춰).
- swipe-action 액션 텍스트는 1~2자(`삭제`, `숨김`, `별표`).

## 다크 모드 대응

- 시스템 따름 표준(`prefers-color-scheme: dark`).
- 마이/설정 화면 명시 토글 함께 제공.
- 모바일 OLED 절전 고려 — 다크 캔버스는 `{colors.bg-canvas}` (시안의 dark 정의 따름) + 풀-블랙(#000)은 사용 안 함(번인 위험 없음, OLED 대비 효율은 우수).

## preview 시각 확인

`docs/user-fe-mobile-preview.html`을 브라우저에서 열면 모바일 전용판 컴포넌트 + 인터랙션 패턴 + 7종 화면 specimen을 시안 5종 × light/dark × phone model 3종(360/390/430) 토글로 확인할 수 있다.

- 상단 셀렉터: 시안 dropdown + phone model dropdown(iPhone SE 360 / Pixel 7 390 / iPhone 14 Pro Max 430) + light/dark.
- 폰 bezel/notch 시각화로 native 환경 시뮬레이션.
- 각 specimen은 sticky CTA + bottom-nav 노출 상태 점검 가능.
- 인터랙션 패턴(segmented-control / swipe-action / pull-to-refresh / native toast) 별도 섹션에서 시각화.

### 시안 추가 후 preview 등록

라이브러리에 새 시안(`designs/<slug>.md`)을 추가했다면 다음 2가지를 `user-fe-mobile-preview.html`에 반영한다.

1. 시안 md의 `## CSS Variables` 섹션 두 블록을 `<style>` 블록 안에 inline.
2. `<script>` 안의 `DESIGNS` 객체에 한 항목 추가.

## 디자인 런타임 연계

모바일 전용 키워드(앱, 모바일, 네이티브, swipe, bottom-sheet, pull-to-refresh, sticky CTA)는 Claude에서는 `.claude/skills/design/SKILL.md`를 자동 활성화하고, Codex에서는 `.codex/workflows/design.md`를 명시 적용해 `DESIGN.md`를 강제 로드한다. 본 가이드는 그 연장선으로 호출된다.

## 운영 메모

- 본 가이드를 갱신하면 `STATE.md ## 이번 세션에서 완료한 작업`에 변경 이력을 한 줄 남긴다(운영 규칙).
- 본 가이드의 패턴은 `DESIGN.md`의 토큰/컴포넌트와 어긋날 수 없다. 어긋나면 `DESIGN.md`를 정본으로 보고 본 가이드를 갱신한다.
- 반응형판과 본 가이드의 공통 원칙은 반응형판을 정본으로 두고, 본 가이드는 차이점과 모바일 전용 인터랙션만 명세한다.
- 화면 mockup이 필요하면 Claude에서는 `.claude/agents/design-reviewer.md`, Codex에서는 `.codex/agents/design-reviewer.md`로 토큰/Do-Don't 점검을 분리 위임할 수 있다. A-12 + A-13(모바일 전용) + B-7 항목을 적용한다.
