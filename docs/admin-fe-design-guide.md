# Admin FE 디자인 가이드

admin/dashboard 표면을 만들 때 `DESIGN.md`의 토큰·컴포넌트를 어떻게 조립하는지 정리한 가이드다. `DESIGN.md`가 atomic spec이라면 이 문서는 화면 단위 patterns다. 본 가이드는 `DESIGN.md`를 1차 소스로 호출하며, 토큰값을 직접 적지 않고 `{group.name}` 형식으로만 호출한다.

## 1차 원칙 (admin에도 동일 적용)

본 섹션은 모든 시안에 공통 적용되는 시안 무관 원칙이다. 시안별 정책(카드 그림자 허용 여부, gradient 위치, 카피 톤)은 활성 시안의 frontmatter `policy:` 블록과 `## Do's and Don'ts` 섹션을 따른다.

**시안 무관 (alias 계약 기반)**
- 색상은 시맨틱 alias 우선(`bg-*`, `fg-*`, `border-*`), atomic ramp는 새 alias 정의 시에만.
- spacing/radius는 `{spacing.*}` / `{rounded.*}` 사다리만 사용. 6/10/14/18/22 도입 금지(시안의 `policy.non_4_spacing`이 false인 한).
- 텍스트 위계는 alpha multiplier(`fg-strong/default/secondary/tertiary/disabled`)로 표현. 별도 gray hex 금지.
- 이모지를 product UI에 inline 사용 금지. 화살표 등은 모두 monochrome SVG `currentColor` 상속.
- 1px 헤어라인 보더(`{colors.border-subtle}`)가 카드 구조의 기본. 그림자 사용 여부는 시안 정책.

**시안 정책에 따라 분기**
- 카드 그림자: `policy.shadow_on_cards` (true: toss-like/material-3, false: wanted/minimal-mono/linear-like)
- gradient 위치: `policy.gradient_locations` 배열에 명시된 위치 외 사용 금지
- 카피 톤: `policy.copy_tone` (ko-friendly: `-요`/`-어요`/`-아요` + 동사형 / ko-formal: `-습니다` / en-sentence: sentence case)
- 단일 강조색: `{colors.bg-brand}` 1개만 primary CTA에 (시안의 brand 정의 따름 — solid hue 또는 gradient pair)

## 화면 골격

admin의 표준 골격은 3개 영역으로 구성된다.

```
+------+-------------------------------+
| side | top-bar                       |
| nav  +-------------------------------+
| 240  | content                       |
|      |   (page-title omitted —      |
|      |    이미 top-bar에 있음)        |
|      |                               |
|      |                               |
+------+-------------------------------+
```

- 좌측 `sidebar-nav` 240(expand) / 64(collapse). bg `{colors.bg-surface}`, 우측 1px `{colors.border-subtle}`.
- 상단 `top-bar (admin)` 56 height. 좌측 페이지 제목 + breadcrumb, 우측 search/env/notification/avatar.
- content 영역 padding `{spacing.space-24}` ~ `{spacing.space-32}` (페이지 밀도에 따라). max-content-width 1280 권장.
- 사이드바 + top-bar 경계는 1px 단일 라인만 사용. cross-shadow 금지.

## 로그인 화면 패턴

`### login-layout` 컴포넌트를 사용. 골격 외부에 standalone surface로 둔다(사이드바·top-bar 없음).

```
+----------------------------------+
|                                  |
|     [logo 24px]                  |
|     로그인                        |  ← {typography.title2}
|     사용 중인 계정으로 들어가요    |  ← {typography.body2} fg-secondary
|                                  |
|     [email input  44h ]          |
|     [password input  44h ]       |
|     [ 로그인하기  ] button-primary lg full
|                                  |
|     비밀번호 찾기 · 회원가입       |  ← {component.button-ghost} 2개 중앙
|                                  |
+----------------------------------+
```

- 카드 너비 400(min), padding `{spacing.space-32}`, radius `{rounded.radius-12}`.
- 에러 inline: 입력 하단에 `{component.alert}` inline. 카피 예 (ko-friendly): `이메일 또는 비밀번호가 일치하지 않아요`. (en-sentence: `Email or password is incorrect`)
- 다중 환경(운영/스테이징/개발) 운영 시 우측 상단에 `{component.chip}` 변형으로 환경 표시.
- 다크 모드 대응: 카드 `{colors.bg-surface}` alias가 light/dark 자동 분기.

## 대시보드 (홈) 패턴

상단 KPI row + 하단 위젯/테이블 row. 모두 1px 헤어라인 카드.

```
top-bar
+--------+--------+--------+--------+
| stat 1 | stat 2 | stat 3 | stat 4 |  ← stat-card × 4, grid gap {spacing.space-16}
+--------+--------+--------+--------+
+----------------------+ +----------+
| 시계열 차트 카드        | | 요약 카드 |
| 1px border-subtle    | | 동일 사양 |
| padding space-24     | |          |
+----------------------+ +----------+
+---------------------------------+
|  최근 활동 data-table             |
|  comfortable density            |
+---------------------------------+
```

- `stat-card` 4개 1행은 desktop 기본. mobile에서 1열 stack + padding 1단계 축소.
- 차트 카드 내부 차트는 단색 stroke + fill 없음. 색은 brand alias 또는 semantic signal 한 가지.
- 카드 사이 grid gap은 `{spacing.space-16}` 또는 `{spacing.space-24}`. row gap도 동일 ladder.

## 리스트 페이지 패턴

가장 빈도 높은 admin 페이지. top-bar 아래에 filter bar → table → pagination 순.

```
top-bar (page-title: "주문 목록")
+-----------------------------------------------+
| [상태 ▼] [기간 ▼] [검색 input    ]  [필터 초기화]  |  ← filter row
+-----------------------------------------------+
| ☑ | 주문번호 | 회원 | 상태  | 금액 | 등록일 | ⋯ |  ← header-row bg bg-muted
+-----------------------------------------------+
| ☐ | #1023   | 홍길동| pending| 24,000 | 5/15 | ⋯ |
| ☐ | #1022   | 김민지| active | 18,500 | 5/15 | ⋯ |
| ☐ | #1021   | 이서연| done   |  9,200 | 5/14 | ⋯ |
+-----------------------------------------------+
| 1–20 / 320                       < 1 2 3 ⋯ > |
+-----------------------------------------------+
```

- filter row 컴포넌트: `{component.chip}` 또는 dropdown-style `{component.button-secondary}` + `{component.search}`. row 내부 gap `{spacing.space-8}`, row 자체 padding `{spacing.space-16}` 0.
- table은 `### data-table` 명세 그대로. status 셀은 `{component.badge}` 시맨틱 색.
- **컬럼이 많을 때**(9개 이상) 또는 사용자가 "여백 과다"를 호소할 때는 padding을 임의로 줄이지 않는다. `DESIGN.md ### data-table > #### Wide Table Cases`의 4-케이스(A 표준 / B 컴팩트 / C 와이드+sticky / D 초과밀도)에서 한 가지를 선택하고, 요구사항은 `templates/data-table-density.md` 양식으로 합의한다.
- 행 클릭으로 상세 진입 시 cursor:pointer + hover bg `{colors.bg-subtle}`. 액션 셀 `{component.button-tertiary}` sm은 `event.stopPropagation()` 분리.
- 빈 상태: `{component.empty-state}`를 테이블 container 내부에 padding 80 0으로 둠. 카피 예 (ko-friendly): `조회된 주문이 없어요. 필터를 조정해 보세요` / (en-sentence): `No orders found. Try adjusting filters.`
- 페이지네이션 컨트롤은 우측 정렬, ghost/tertiary 버튼 sm.

## 상세 페이지 패턴

리스트에서 행 클릭으로 진입. top-bar의 page-title은 상위 페이지 + breadcrumb로 위치 유지.

```
top-bar (page-title: "주문 #1023", breadcrumb: 주문 / #1023)
+----------------------+-------------------+
| 좌: 상세 정보 카드      | 우: 사이드 패널     |
| 1px hairline border  | 1px hairline      |
| padding space-24     | padding space-24  |
|                      |                   |
| 섹션 라벨 caption1     | 액션 묶음            |
| 값 body1/title3      | button-primary md  |
+----------------------+-------------------+
| 활동 로그 list (timeline 패턴 — line 1px) |
+------------------------------------------+
```

- 좌측 카드는 max-width ~720, 우측 사이드 패널은 ~320. 둘 사이 gap `{spacing.space-24}`.
- 액션 묶음에서 단일 강조 액션 1개만 primary. 나머지는 secondary/tertiary/ghost.
- 위험 액션(주문 취소/회원 정지)은 `{component.button-danger}` 별도 행에 분리. 클릭 시 `{component.modal}` 확인 단계 필요.

## 폼 / 설정 페이지 패턴

`{component.input}` + `{component.checkbox}` + `{component.toggle}`를 수직 stack. 섹션 단위로 카드 분리.

- 섹션 카드 padding `{spacing.space-24}`. 섹션 제목 `{typography.title3}` + sub `{typography.body2} {colors.fg-secondary}`.
- 폼 필드 간 vertical gap `{spacing.space-16}`. 라벨은 필드 위 `{typography.label2}`.
- 도움말 문구는 필드 아래 `{typography.caption1} {colors.fg-secondary}`. 에러는 같은 위치를 `{colors.fg-danger}`로 교체.
- 하단 액션 바: sticky bottom 카드 또는 카드 내부 우측 정렬. 단일 primary `저장하기` + ghost `취소`.

## 알림 / 토스트 / 모달

- 작업 결과: `{component.toast}` 4–6초 자동 dismiss. 위치는 우측 하단(`{spacing.space-24}` offset). 카피 예 (ko-friendly): `저장되었어요`, `삭제할 수 없어요. 진행 중인 작업이 있어요` / (en-sentence): `Saved`, `Cannot delete: an operation is in progress`.
- 인라인 경고: `{component.alert}` 페이지 상단 또는 섹션 헤드. 색은 semantic alias.
- 확인 다이얼로그: `{component.modal}`(`DESIGN.md ### modal / dialog`). 항상 커스텀 표면으로 구현하고(native·pre-styled 라이브러리 모달 금지, a11y 동작은 headless 위임 허용), 닫기는 헤더 X·푸터 닫기 버튼·`ESC` 세 가지로만 — 배경(scrim) 클릭으로는 닫지 않는다. 위험 액션은 본문에 결과를 명시한 후 `{component.button-danger}` 확정.

## 카피 톤 체크리스트

admin 표면도 product 카피 톤은 활성 시안의 `policy.copy_tone`을 따른다. 본 가이드는 ko-friendly / ko-formal / en-sentence 3종을 비교 표로 제공한다.

### copy_tone 별 패턴

| copy_tone | OK 본문 | OK 버튼 | X 금지 |
|---|---|---|---|
| **ko-friendly** (wanted, minimal-mono, toss-like) | `저장되었어요`, `삭제할 수 없어요`, `정산을 다시 계산해 보세요` | `저장하기`, `취소`, `내보내기`, `다시 시도` | `저장되었습니다` (격식체), `저장 완료!` (이모지/느낌표), `여기를 눌러주세요` (챗봇 톤), `Save` (영문 Title Case) |
| **ko-formal** | `저장되었습니다`, `삭제할 수 없습니다` | `저장`, `취소`, `내보내기` | `저장되었어요` (친근체), `Save All Items` (Title Case), 챗봇 톤 |
| **en-sentence** (material-3, linear-like) | `Saved`, `Cannot delete: an operation is in progress` | `Save`, `Cancel`, `Export`, `Try again` | `SAVE` (ALL-CAPS), `Save All Items` (Title Case), `Please click here` (챗봇 톤), 격식 영문 |

### 모든 copy_tone 공통

- 표 헤더는 ALL-CAPS 금지. 한국어 명사 단문 또는 영문 sentence case.
- 마침표는 본문 산문에만. UI 라벨/리스트/버튼 라벨 끝에는 찍지 않는다.
- 이모지를 product UI inline 사용 금지(상태 표시도 monochrome SVG로 대체).
- 마케팅 과장 어휘(`혁신적`, `차세대`, `최고의`, `Innovative`, `Best in class`) 사용 금지.

활성 시안의 정확한 카피 톤은 `designs/<active-slug>.md` 의 `## Brand & Style` 섹션 Voice 단락과 `## Do's and Don'ts` 의 카피 항목을 정본으로 본다.

## 데이터 밀도 결정

- comfortable(56 row): 표준 admin. 사용자 1인당 동시 화면 행 ~12 이내.
- compact(44 row): 분석 도구·로그 뷰어처럼 한 화면에 50행 이상 노출이 필요할 때만.
- compact를 쓰면 `{typography.body2}` → `{typography.caption1}`로 1단계 내릴지 사용자 테스트 후 결정.

## 다크 모드 대응

- alias 토큰만 호출하면 light/dark 자동 분기됨(`{colors.bg-surface}`, `{colors.fg-default}`, `{colors.border-subtle}` 등).
- semantic signal 배경 alias(`bg-success-subtle`, `bg-warning-subtle`, `bg-danger-subtle`)와 fg alias(`fg-success`, `fg-warning`, `fg-danger`, `fg-brand`)는 `DESIGN.md ## Known Gaps`의 합성 규칙을 따른다(blue-400 brightened for fg-brand, semantic hue @ ↑ lightness for fg-*).
- 사이드바·top-bar 경계 라인 alpha를 dark에서 한 단계 강하게 조정해도 좋다(`{colors.border-default}`로 승격).

## preview 시각 확인

`docs/admin-fe-preview.html`을 브라우저에서 열면 admin 5종 컴포넌트 + 화면 조립 패턴 + 토큰 swatch를 한 페이지에서 확인할 수 있다.

- 상단 셀렉터에서 **시안(designs/<slug>)**과 **테마(light/dark)** 를 독립적으로 토글한다 — `data-design` + `data-theme` 두 속성이 cascade로 적용된다.
- 셀렉터 아래 POLICY strip은 활성 시안의 frontmatter `policy:` 블록을 chip으로 시각화한다(카드 그림자/gradient 허용/카피 톤/dark 지원/non-4 spacing 5종).
- 선택 상태는 localStorage에 저장되어 새로고침 후에도 유지된다.

### 시안 추가 후 preview 등록

라이브러리에 새 시안(`designs/<slug>.md`)을 추가했다면 다음 2가지를 preview HTML에 반영한다.

1. 시안 md의 `## CSS Variables` 섹션 두 블록(`:root[data-design="<slug>"][data-theme="light/dark"] { ... }`)을 `admin-fe-preview.html` `<style>` 블록 안의 시안 변수 영역에 inline 한다.
2. `<script>` 안의 `DESIGNS` 객체에 한 항목 추가(label + policy frontmatter 복사).
3. 셀렉터 dropdown은 `DESIGNS` 객체에서 자동 생성되므로 별도 수정 불필요.

## 디자인 런타임 연계

admin FE 작업 키워드(테이블, 사이드바, 로그인, 카드, 폼, 토스트)는 Claude에서는 `.claude/skills/design/SKILL.md`를 자동 활성화하고, Codex에서는 `.codex/workflows/design.md`를 명시 적용해 `DESIGN.md`를 강제 로드한다. 본 가이드는 그 연장선으로 호출된다. 새로운 admin 컴포넌트가 필요하면 `docs/design-guidelines.md ## 새 컴포넌트 추가 절차`를 따른다.

## 시안별 화면 조립 차이

본 가이드의 화면 패턴(login/dashboard/list/상세/폼)은 alias 호출을 사용하므로 라이브러리 5개 시안 모두 자동 호환된다. 다만 각 시안의 정책 차이로 시각 결과는 달라진다. 아래는 동일 화면 패턴이 시안별로 어떻게 다르게 보이는지를 정리한 비교 매트릭스다.

### 1. login 화면

| 시안 | 카드 표면 | brand mark | CTA | 톤 |
|---|---|---|---|---|
| `wanted` | 1px border, radius-12, 그림자 없음 | 24px symbol(평면, gradient 미사용 — 카드 내부는 chrome) | bg-brand 채움, lg height 48 | "다시 만나서 반가워요" |
| `minimal-mono` | 1px border, radius-12, 그림자 없음 | 24px logo (검정) | 검정 채움, lg height 48 | "다시 만나서 반가워요" |
| `toss-like` | shadow-1 + 1px border 또는 보더 생략, radius-16 | 32px logo + 환경 chip | bg-brand 파랑 채움, lg height 52 | "안녕하세요!" 친근체 |
| `material-3` | shadow-2, radius-12 | 24px Material Symbols | filled button, radius-full, "Sign in" | 영문 sentence case |
| `linear-like` | 1px border-default, radius-8, 그림자 없음 | 20px logo + 다크 캔버스 | gradient accent CTA, "Sign in" + ⌘ Enter kbd hint | dark 1차, en-sentence |

### 2. 대시보드 (홈)

| 시안 | stat-card | 차트 카드 | row gap |
|---|---|---|---|
| `wanted` | 1px border, padding 24, 그림자 없음 | 1px border, 그림자 없음 | space-16 |
| `minimal-mono` | 1px border, padding 24, 그림자 없음 | 1px border, 그림자 없음 | space-16 |
| `toss-like` | shadow-1, radius-16, padding 24 | shadow-1, radius-16 | space-20 |
| `material-3` | shadow-1 (level 1) 또는 shadow-2, radius-12, padding 24 | elevated card shadow-2 | space-24 |
| `linear-like` | 1px border, radius-8, padding 16 (컴팩트) | 1px border, radius-8 | space-12 |

stat-card의 delta 표시는 모든 시안 공통(`fg-success`/`fg-danger`/`fg-secondary` + arrow 아이콘). gradient 강조는 linear-like만 — accent gradient로 큰 숫자(`gradient-text`)를 표현 가능.

### 3. 리스트 페이지 (data-table)

| 시안 | row height | header bg | hover | status pill |
|---|---|---|---|---|
| `wanted` | 56 (comfortable) | bg-muted | bg-subtle | radius-full badge |
| `minimal-mono` | 56 | bg-muted | bg-subtle | radius-full badge |
| `toss-like` | 56 (모바일은 64) | bg-muted | bg-subtle (또는 shadow-1) | radius-full badge |
| `material-3` | 52 | bg-muted | state-layer 8% brand alpha | radius-8 chip (M3 input chip) |
| `linear-like` | 44 (compact 디폴트) | bg-muted, 작은 typography | bg-subtle | radius-4 직사각 (시그너처) |

linear-like는 row 클릭 시 우측 panel slide(prose 명시)가 시그너처. 다른 시안은 별도 페이지 진입.

### 4. 상세 페이지

| 시안 | 좌측 카드 | 우측 사이드 패널 | 위험 액션 |
|---|---|---|---|
| `wanted` | 1px border, padding 24 | 1px border, padding 24 | button-danger 별도 행 + 모달 확인 |
| `minimal-mono` | 1px border, padding 24 | 1px border, padding 24 | 동일 |
| `toss-like` | shadow-1, radius-16, padding 24 | shadow-1, radius-16 | 동일 + bottom-sheet 모달 |
| `material-3` | shadow-2 elevated card, radius-12 | shadow-1 | filled tonal danger button |
| `linear-like` | 1px border, radius-8, padding 16 | 컴팩트 또는 floating panel | inline confirm + Esc 단축키 |

### 5. 폼 / 설정 페이지

| 시안 | 입력 height | 라벨 위치 | 액션 바 |
|---|---|---|---|
| `wanted` | 44 | 필드 위 (label2) | sticky bottom 또는 카드 내 우측 |
| `minimal-mono` | 44 | 필드 위 | 동일 |
| `toss-like` | 52 (큰 height) | 필드 위 또는 placeholder 만 | sticky bottom + 큰 라운드 |
| `material-3` | 56 | floating label (focus 시 위로) | snackbar + bottom action |
| `linear-like` | 32 (컴팩트) | inline label | inline save + ⌘S 단축키 |

### 시안 선택 가이드

| 프로젝트 유형 | 권장 시안 | 이유 |
|---|---|---|
| 일반 admin / internal tool | `minimal-mono` | 도메인 중립, 빠른 시작, 색 결정 부담 없음 |
| 한국 채용/마케팅 surface | `wanted` | 친근체 + 동사형 라벨, 한국어 우선 |
| 한국 핀테크 / consumer mobile | `toss-like` | 큰 라운드 + 카드 그림자, 모바일 우선 hit area |
| 글로벌 enterprise / cross-platform | `material-3` | M3 표준, Android·iOS·Web 일관성, dynamic color |
| 다크 우선 productivity / 개발자 도구 | `linear-like` | dark 1차, 키보드 시그너처, 컴팩트 밀도 |

### 시안 변경의 안전 범위

라이브러리 5개 시안은 모두 alias 계약을 준수하므로 select-design.sh로 즉시 전환해도 본 가이드 패턴이 깨지지 않는다. 다만 다음은 시안 변경 시 추가 점검이 필요하다.

- 컴포넌트 로컬값(예: linear-like의 `radius-6` input, toss-like의 `radius-20` modal)을 직접 호출한 코드 — alias가 아닌 추가 토큰은 시안 변경 시 fallback 검토.
- 시안 전용 컴포넌트(`kbd`, `amount` input, `reward-card`) — 호출한 코드는 시안 변경 시 fallback 또는 비활성 처리.
- gradient 사용 위치 — 시안의 `policy.gradient_locations` 와 다른 위치에 적용된 gradient는 시안 변경 시 위반.
- 카피 톤 — `policy.copy_tone` 변경 시 product 카피 일괄 검토 (ko-friendly ↔ en-sentence 전환 시 영향 큼).

## 운영 메모

- 본 가이드를 갱신하면 `STATE.md ## 이번 세션에서 완료한 작업`에 변경 이력을 한 줄 남긴다(운영 규칙).
- 본 가이드의 패턴은 `DESIGN.md`의 토큰/컴포넌트와 어긋날 수 없다. 어긋나면 `DESIGN.md`를 정본으로 보고 본 가이드를 갱신한다.
- 화면 mockup이 필요하면 Claude에서는 `.claude/agents/design-reviewer.md`, Codex에서는 `.codex/agents/design-reviewer.md`로 토큰/Do-Don't 점검을 분리 위임할 수 있다.
