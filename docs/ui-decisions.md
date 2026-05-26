# UI Decisions

본 문서는 프로젝트의 UI/디자인 결정 사항을 한 곳에서 관리하는 결정 기록처다.
`templates/startup-checklist.md` 섹션 3~5(UI/디자인, 모달, 반응형) 답변과 `templates/ui-intake.md`, `templates/responsive-intake.md`, `templates/form-intake.md`, `templates/data-table-density.md`에서 합의한 결정을 통합한다.

## 사용 방법

- startup-checklist 완료 후 답변에서 UI/디자인 결정을 본 문서로 옮긴다.
- 개발 중 추가 결정(컴포넌트 변형, 토큰 override, 새 화면 패턴, 데이터 테이블 케이스 선택)이 생기면 해당 섹션에 추가하고 `## 변경 이력`에 한 줄 기록한다.
- 미정 항목은 `[미정]` 태그로 유지하고 결정자/결정일이 확정되면 갱신한다.
- 단순한 토큰 호출은 본 문서에 중복 기록하지 않는다. `DESIGN.md`의 정의를 참조하고, 본 문서에는 프로젝트 고유 결정만 남긴다.

## 1. 디자인 시스템 선택

- 활성 시안 슬러그: `<slug>`
- 선택 사유: <한 문장>
- fork 여부: 없음 | fork → `<custom-slug>` (사유: <override 이유>)
- override 토큰:
  - 없음 | `<token-name>`: 기본값 → 변경값 — 사유

활성화/검증:

```bash
bash .claude/plugins/select-design.sh <slug>
cat .claude/.active-design   # 슬러그 확인
head -20 DESIGN.md           # frontmatter 일치 확인
```

라이브러리 운영 규칙: `designs/README.md`, `designs/_alias-contract.md`, `docs/design-guidelines.md`.

## 2. UI 톤과 레퍼런스

- UI 톤: <한 문장>
- 정보 밀도: 높음 | 중간 | 낮음
- 참고 서비스(3개 이내):
  1. <서비스> — <참고 요소>
  2. ...
- 피하고 싶은 스타일: <한 문장>

## 3. 핵심 사용자 흐름

1. <흐름 1> — 주요 화면/인터랙션
2. <흐름 2> — ...
3. <흐름 3> — ...

## 4. 화면 상태 정책

| 상태 | 처리 |
|---|---|
| loading | 스켈레톤 / 스피너 / 진행률 |
| empty | 안내 문구 + 다음 액션 버튼 (카피 예: ...) |
| error | 인라인 / 토스트 / 모달 + 재시도 |
| success | 토스트 / 인라인 / 페이지 전환 |
| disabled | 사유 툴팁 / 비활성 색 |

## 5. 접근성 기준

- 키보드 탐색: 필수 | 부분 | 해당 없음
- 색상 대비: WCAG AA | AAA | 미적용
- 스크린 리더: 모든 인터랙티브 | 핵심 흐름 | 미적용
- focus ring: 항상 visible (활성 시안의 정책 따름)
- hit area 하한: 44×44px

## 6. 모달 정책

- 구현 방식: 커스텀 | 라이브러리(<이름, 예: Radix UI / Headless UI / shadcn>)
- 애니메이션: 페이드 | 슬라이드(up/down) | 스케일 | 없음
- 닫기 방법(복수 가능): 닫기 버튼 / 배경 클릭 / ESC / 조건부
- 중첩 허용: 허용 (최대 <N>단) | 불허
- 배경 스크롤: 잠금 | 허용
- 내부 스크롤: 필요 | 불필요 | 케이스별
- 접근성: focus trap / `role="dialog"` / `aria-modal` / aria-label

## 7. 반응형과 레이아웃

- 우선 디바이스: PC | 모바일 | 동일
- 브레이크포인트: sm(640) / md(768) / lg(1024) / xl(1280) [필요 항목만 사용]
- 모바일에서 모달: 바텀 시트 전환 | 동일 모달 유지
- 콘텐츠 max-width: <값>px (예: 1280)
- 사이드바 collapse: 있음(축소 폭 <px>) | 없음

## 8. 폼 정책

- 라이브러리: <예: React Hook Form + Zod>
- 라벨 위치: 필드 위(`label2`) | inline | floating
- 에러 표시: 인라인 / 폼 상단 alert / 토스트
- 액션 바: sticky bottom | 카드 내부 우측 정렬 | inline 저장
- 키보드 단축키: <있다면 — 예: ⌘S 저장>

## 9. 데이터 테이블 정책

`DESIGN.md ### data-table > #### Wide Table Cases` 4-케이스 기반.
요구사항 수집은 `templates/data-table-density.md` 양식 사용.

| 페이지 | Case | 컬럼 수 | row height | cell padding | sticky | 가로 스크롤 | 비고 |
|---|---|---|---|---|---|---|---|
| <예: /admin/orders> | C | 14 | 44 | `{spacing.space-12}` | 좌 2 / 우 1 | 있음 | 활성 시안 affordance 따름 |

여러 페이지에 같은 패턴을 재사용하면 한 행으로 묶고 `비고`에 페이지 목록을 적는다.

## 10. 컴포넌트 변형/추가

- 신규 추가한 컴포넌트:
  - <컴포넌트명> — 사유, 토큰 호출 형식, `DESIGN.md ## Components`에 추가 여부
- 활성 시안에서 변형한 컴포넌트:
  - <컴포넌트명> — 변경 항목, 사유

## 11. 카피 톤

- 기본 톤: 활성 시안 `policy.copy_tone` 따름 (`ko-friendly` / `ko-formal` / `en-sentence`).
- 버튼 라벨 규칙: 동사형 (`저장하기`, `지원하기`) | sentence case (`Save`)
- 도메인 특수 어휘:
  - <원문/번역, 예: `운영자 → operator, 관리자 → admin`>
- 금기어/표현:
  - <예: `혁신적`, `최고의` 등 마케팅 과장 어휘 사용 금지>

## 변경 이력

- YYYY-MM-DD: <변경 내용> — <결정자>

## 작성 예시

```
# UI Decisions

## 1. 디자인 시스템 선택
- 활성 시안: linear-like
- 선택 사유: 운영자 대상 productivity 도구, 정보 밀도 높음, dark 1차
- fork: 없음
- override: bg-brand만 사내 컬러 oklch(0.510 0.190 280)으로 교체

## 2. UI 톤과 레퍼런스
- UI 톤: 다크 캔버스, 키보드 친화, 데이터 밀도 높음
- 정보 밀도: 높음
- 참고:
  1. Linear — 컴팩트 row, ⌘K 팔레트
  2. Stripe Dashboard — 필터 + 데이터 테이블 UX
- 피하고 싶은 스타일: 큰 일러스트, 둥근 카드 그림자

## 3. 핵심 사용자 흐름
1. 주문 검색 → 필터 → 상세 (메인 워크플로)
2. 주문 상세에서 상태 변경, 담당자 재배정
3. 신규 담당자 등록 폼

## 4. 화면 상태 정책
| 상태 | 처리 |
|---|---|
| loading | 행 스켈레톤, 액션은 spinner |
| empty | 안내 + 다음 액션 버튼 ("조회된 주문이 없어요. 필터를 조정해 보세요") |
| error | 인라인 alert + 재시도 |
| success | 토스트 우하단 4초 |
| disabled | 사유 툴팁 |

## 7. 반응형과 레이아웃
- 우선 디바이스: PC
- 브레이크포인트: lg(1024), xl(1280) — sm/md 미사용
- 콘텐츠 max-width: 1440px
- 사이드바: 220 → 64 collapse

## 9. 데이터 테이블 정책
| 페이지 | Case | 컬럼 수 | row | padding | sticky | 스크롤 | 비고 |
|---|---|---|---|---|---|---|---|
| /admin/orders | C | 14 | 44 | space-12 | 좌 2/우 1 | 있음 | linear-like fade-edge mask |
| /admin/orders/refunds | C | 14 | 44 | space-12 | 좌 2/우 1 | 있음 | orders와 컬럼 셋 재사용 |
| /admin/staff | B | 10 | 44 | space-12 | — | 없음 | — |

## 변경 이력
- 2026-05-16: 초기 작성 — PM(김OO), Design(박OO), FE(이OO)
- 2026-05-20: /admin/orders 컬럼 13 → 14로 증가, Case B → C 변경 — FE(이OO)
```
