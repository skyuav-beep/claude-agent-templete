# Data Table Density Intake

admin/리스트 페이지에서 컬럼 수·밀도·sticky·스크롤 정책을 결정하기 위한 양식.
`DESIGN.md ### data-table`의 `#### Wide Table Cases` 4-케이스(A/B/C/D) 매트릭스와 1:1 매핑된다.

## 1. 화면 컨텍스트

- 페이지 경로 또는 화면명:
- 활성 시안(`bash .claude/plugins/select-design.sh --current`):
- 사용자 운영 PC 해상도 하한(예: 1280 / 1440 / 1920):
- 사용자 주요 행동(스캔/비교 우선 | 클릭/편집 우선):
- 화면 surface density(`DESIGN.md ### Admin / Dashboard surface > #### Admin Surface Density Cases`):
  - [ ] A — 표준 (content 32 / card 24 / gap 16 / btn 40 / row 56)
  - [ ] B — 컴팩트 (content 24 / card 16 / gap 12 / btn 36 / row 40)
  - [ ] C — 미니멈 (content 16 / card 12 / gap 8 / btn 32 / row 36)
  - [ ] D — 모니터링 (content 8 / card 8 / gap 8 / btn 32 / row 36) — 전광판/콜센터 전용
  - 사유:

## 2. 컬럼 구성

- 노출할 컬럼 수: <n>개
- 컬럼 목록(왼쪽→오른쪽 순서, 가변/고정 표시):
  - 1. <컬럼명> · 형식(text/number/badge/date/action) · 기본 너비
  - 2. ...
- 좌측 sticky 컬럼 수: <0~2>
- 우측 sticky 컬럼 수: <0~1, 보통 액션 셀>
- 컬럼 너비 사용자 조정(resize): y/n
- 컬럼 순서 사용자 변경(drag-reorder): y/n
- 컬럼 표시/숨김 토글: y/n (선택 저장: localStorage y/n)
- 셀 내용 가변 길이 정책: ellipsis(1줄 ...) | wrap(2줄까지) | hover-tooltip 표시

## 3. 밀도와 행 정책

- 동시 노출 행 수 목표: <12 이하 | 12~30 | 30+>
- 행 높이: 56(comfortable) | 44(compact) | (시안 디폴트 따름)
- cell padding: `{spacing.space-16}` | `{spacing.space-12}` (8 이하 비허용)
- 행 클릭 동작: 상세 페이지 진입 | 우측 패널 slide | 없음
- 체크박스 컬럼: y/n (width 44 또는 compact 시 40)
- zebra striping: 사용 금지(기본 정책)
- 가상 스크롤(virtualization): 행 30+ 시 적용 | 불필요

## 4. 케이스 선택(`DESIGN.md ### data-table > Wide Table Cases`)

다음 4개 중 하나를 선택하고 사유 1줄을 적는다.

- [ ] **Case A — 표준**: 컬럼 ≤8, padding `{spacing.space-16}`, row 56, 가로 스크롤 없음
- [ ] **Case B — 컴팩트**: 컬럼 9~12, padding `{spacing.space-12}`, row 44, numeric right-align
- [ ] **Case C — 와이드 + sticky**: 컬럼 13~18, 좌/우 sticky, padding `{spacing.space-12}`, row 44, 헤더 sticky, fade-edge
- [ ] **Case D — 초과밀도**: 컬럼 19+, column visibility toggle 필수, density toggle 노출, virtualization, CSV export

사유:

## 5. 가로 스크롤 정책(Case C/D 선택 시)

- 좌측 sticky 컬럼: <체크박스, 식별자/이름 등>
- 우측 sticky 컬럼: <액션 셀 등>
- 스크롤 가능 시각 단서: fade-edge(좌/우 4px gradient mask) | 1px border 강조 | shadow-1 inset
  - fade-edge 채택 시 시안 정책 확인: 활성 시안의 `policy.gradient_locations`에 비chrome 위치 허용 여부 합의 필요
- 키보드 ←/→ 스크롤 지원: y/n
- 헤더 row sticky(vertical): y/n
- pagination 위치: 컨테이너 하단 우측(기본) | 좌측 정보 + 우측 nav

## 6. 컬럼 가시성/저장 정책(Case D 선택 시)

- 상단 "표시 컬럼" dropdown 위치: filter-bar 우측 | 테이블 상단 액션 영역
- 기본 표시 컬럼 집합:
- 숨김 컬럼은 CSV export에 포함: y/n
- 사용자별 저장: localStorage 키(예: `<page-slug>-table-cols`)
- density toggle 위치: filter-bar 우측 icon-button

## 7. 빈/오류/로딩 상태

- empty: `{component.empty-state}` 카피 — 예: `조회된 <대상>이 없어요. 필터를 조정해 보세요`
- loading: 스켈레톤 행(컬럼 너비에 맞춰 placeholder) 또는 spinner overlay
- error: 인라인 상단 alert + 재시도 버튼
- partial(일부 컬럼 데이터 없음): `—` 단일 em-dash(이모지/문자 금지), `{colors.fg-tertiary}`

## 8. List Toolbar (검색 clear / 엑셀 / 페이지 크기)

`DESIGN.md ### data-table > #### List Toolbar Cases`와 1:1 매핑된다. 각 항목 한 가지 케이스를 선택하고 사유 1줄을 적는다.

### 8.1 검색 입력 X(clear)
- [ ] **A — 항상 표시**: 값이 있으면 항상 X 노출(기본)
- [ ] **B — 호버/포커스 시만**: hover 또는 input focus 시만 X 노출
- [ ] **C — 없음(키보드만)**: Esc 또는 ⌘+Backspace로 clear, X 미노출

사유:

### 8.2 엑셀 다운로드
- [ ] **A — 단일 버튼**: `button-secondary` md + download icon, 즉시 다운로드
- [ ] **B — 아이콘 only**: `icon-button` md + tooltip, 즉시 다운로드
- [ ] **C — 옵션 dropdown**: 전체 / 필터 결과 / 선택한 항목 / 현재 페이지 popover
- [ ] **D — 비동기 progress**: 서버 export 큐 + toast 알림 + 다운로드 링크

사유:
- 옵션이 두 개 이상 필요하면 C로 승격(별도 버튼 두 개 노출 금지).
- 행 수 1000+ 또는 서버 export면 D 필수.
- 단축키 노출(예: ⌘E): y/n

### 8.3 페이지 크기(행 개수) 선택
- [ ] **A — dropdown**: popover list (10 / 20 / 50 / 100)
- [ ] **B — segmented control**: 3단 토글 (10 / 20 / 50)
- [ ] **C — auto-fit**: UI 미노출, 컨테이너 높이로 자동 계산

디폴트 값: <10 | 20 | 30 | 50>
저장 키: `<page-slug>-page-size` (localStorage y/n)

사유:
- 100 이상은 가상 스크롤(virtualization) 활성 시에만 허용.
- 케이스 디폴트는 `Wide Table Cases` 선택과 정합(A/56 → 20, B/44 → 30 권장).

## 9. Filter Bar (admin) — `DESIGN.md ### filter-bar (admin) > #### Filter Bar Cases`

- [ ] **A — 기본 chip**: 상태/카테고리 chip 3~5종 + 검색 + reset
- [ ] **B — 일시 범위 + 엑셀**: date-range 단일 트리거 + chip 1~3 + 우측 엑셀 다운로드(`§8.2` 케이스 호출)
- [ ] **C — 다중 패널**: 좌측 slide panel(320) + 저장된 뷰 + 엑셀
- [ ] **D — 검색만**: 단일 검색(회원/주문 단건)

사유:
- 일시 컨트롤이 필요한가: y/n (y면 B 이상 필수)
- 정적 필터 종류 수: <n>개 (≥6이면 C 승격)
- 저장된 뷰가 필요한가: y/n (y면 C)
- URL query 동기화: y/n (`?from=&to=&status=`)

## 10. Column Filter — `DESIGN.md ### data-table > #### Column Filter Cases`

- [ ] **A — 정렬만**: sort 3-state icon, 컬럼 필터 없음 (전역 Filter Bar로 충분)
- [ ] **B — 헤더 popover**: 헤더 funnel icon + popover (검색/체크박스/날짜), 활성 시 brand dot
- [ ] **C — 인라인 row**: thead 다음 row에 input/select 영구 노출 (Excel 필터 패턴)
- [ ] **D — 듀얼 (전역 + 컬럼)**: 전역 Filter Bar + 컬럼 popover/inline 동시

사유:
- 컬럼별 검색 빈도가 높은가: y/n
- 듀얼(D) 채택 시 역할 분리 문구: 전역=<...> / 컬럼=<...>
- 활성 카운터 합산 표기: `필터 (N) +컬럼 (M)` 형식 y/n

## 11. Tab Page (있을 때만, 상세/세부 페이지) — `DESIGN.md ### tab (admin) > #### Tab Page Cases`

- [ ] **A — line underline**: 상세 페이지 안 섹션 전환(기본/배송/이력)
- [ ] **B — pill 채움**: 카테고리/유형 전환
- [ ] **C — segmented**: 2~3개 분명한 토글(테이블/보드, 일/월)
- [ ] **D — vertical 좌측**: 설정 페이지 등 5+ 다단

탭 수: <n>개 (≥7이면 D 또는 nav-link 승격 검토)
카운터 노출(예: `배송 (2)`): y/n (y면 텍스트 괄호 금지 → `{component.badge}` sm 호출)

## 12. 합의 및 기록

- 결정자: <name>
- 결정일: <YYYY-MM-DD>
- 변경 시 영향 받는 화면 목록(같은 패턴 재사용 페이지):
- `STATE.md` 변경 이력 기록 여부: y(권장)

## 작성 예시

```
## 1. 화면 컨텍스트
- 페이지 경로: /admin/orders
- 활성 시안: wanted
- 운영 PC 해상도 하한: 1440
- 사용자 주요 행동: 스캔/비교 우선 (당일 주문 점검)

## 2. 컬럼 구성
- 노출할 컬럼 수: 14개
- 컬럼 목록:
  1. checkbox · 고정 44
  2. 주문번호 · text · 120 (좌 sticky)
  3. 주문일시 · date · 140
  4. 고객명 · text · 120
  5. 상품 · text · 200 (ellipsis)
  6. 수량 · number · 60 (right)
  7. 금액 · number · 100 (right)
  8. 결제수단 · badge · 100
  9. 배송상태 · badge · 100
  10. 배송지 · text · 200 (ellipsis)
  11. 라이더 · text · 100
  12. 메모 · text · 160 (ellipsis + hover-tooltip)
  13. 등록자 · text · 100
  14. 액션 · action · 80 (우 sticky)
- 좌측 sticky: 2 (checkbox + 주문번호)
- 우측 sticky: 1 (액션)
- resize: n
- drag-reorder: n
- 표시/숨김 토글: y, localStorage 저장 y
- 셀 내용: ellipsis + 메모만 hover-tooltip

## 3. 밀도와 행 정책
- 동시 노출 행 수: 12~30
- 행 높이: 44 (compact)
- cell padding: {spacing.space-12}
- 행 클릭: 상세 페이지 진입
- 체크박스 컬럼: y (width 44)

## 4. 케이스 선택
- [x] Case C — 와이드 + sticky
- 사유: 컬럼 14개, 좌측 식별자/우측 액션 sticky 필요, 운영자가 가로 스크롤로 부가 정보(메모/등록자) 확인하는 패턴

## 5. 가로 스크롤 정책
- 좌측 sticky: checkbox + 주문번호
- 우측 sticky: 액션
- 스크롤 단서: fade-edge 4px (gradient 비-chrome 위치 도입 — wanted 정책 합의 필요 → policy 회의 후 결정)
- 키보드 ←/→: y
- 헤더 row sticky: y
- pagination: 컨테이너 하단 우측

## 7. 빈/오류/로딩 상태
- empty: "조회된 주문이 없어요. 필터를 조정해 보세요"
- loading: 스켈레톤 14컬럼 5행
- error: 인라인 alert + 재시도
- partial: em-dash

## 8. List Toolbar
- 8.1 검색 clear: [x] A 항상 표시 — 운영자가 마우스 위주, 즉시 클리어 필요
- 8.2 엑셀 다운로드: [x] C 옵션 dropdown — "전체 / 필터 결과 / 선택한 항목" 3옵션. 행 수 1000+ 가능성으로 D 승격 여지 있음(별도 PR로 검토). 단축키 ⌘E: n
- 8.3 페이지 크기: [x] A dropdown, 디폴트 30 (Case C/row 44 정합), 저장 키 `orders-page-size`

## 9. Filter Bar
- [x] B — 일시 범위 + 엑셀
- 일시 필요: y (당일/최근 7일 운영). 정적 필터 3종(상태/매장/결제). 저장된 뷰 불필요.
- URL query 동기화: y (`?from=&to=&status=&store=`)

## 10. Column Filter
- [x] B — 헤더 popover
- 컬럼별 검색 빈도: 중간 (고객명/메모 컬럼은 임시 탐색 빈번). 듀얼(D) 미채택 — 전역 Filter Bar로 데이터 셋 결정 + popover로 결과 내 좁히기.
- 활성 카운터: `필터 (3)` 단일 표기 (전역만 운영, 컬럼 카운터 분리 불필요)

## 11. Tab Page
- 상세 페이지(/admin/orders/[id])는 A — line, 4개 탭(기본 정보 / 배송 / 결제 / 이력). `배송`에 미처리 카운터(`{component.badge}` sm) 노출.

## 12. 합의 및 기록
- 결정자: PM(김OO), Design(박OO), FE(이OO)
- 결정일: 2026-05-18
- 영향 화면: /admin/orders, /admin/orders/refunds (같은 컬럼 셋 재사용)
- STATE.md 변경 이력: y
```
