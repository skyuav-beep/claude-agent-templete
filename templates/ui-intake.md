# UI Intake Template

## 사용 디자인 시스템

- 활성 디자인 시안은 root `DESIGN.md`이며, 라이브러리 `designs/`에서 선택해 활성화한다.
- 라이브러리 목록: `bash .claude/plugins/select-design.sh --list`
- 다음 중 하나를 선택해 명시한다.
  - (a) 라이브러리 기본 시안 사용 (슬러그 명시: 예 `wanted`).
  - (b) 라이브러리 시안을 fork 해 프로젝트 전용 슬러그로 편집 (예: `cp designs/wanted.md designs/<slug>.md` 후 활성화).
  - (c) `_template.md`에서 새 시안을 처음부터 작성 (alias 계약 준수).
  - (d) 활성 DESIGN.md에서 일부 토큰만 override (override 대상 토큰을 아래에 나열).
- 선택 결과 + override 내역은 `STATE.md` `이번 세션에서 완료한 작업`에 남긴다.
- 라이브러리 운영 규칙은 `docs/design-guidelines.md`와 `designs/_alias-contract.md` 참조.

## 제품 톤과 느낌

- 원하는 UI 톤을 적는다.
- 피하고 싶은 스타일이 있다면 적는다.

## 참고 서비스 또는 레퍼런스

- 참고하고 싶은 서비스, 화면, 디자인 요소를 적는다.
- 참고 이유를 간단히 적는다.

## 핵심 사용자 흐름

- 가장 중요한 사용자 행동 3개 이내로 적는다.
- 각 흐름에서 가장 중요한 화면 또는 인터랙션을 적는다.

## 화면 상태

- 반드시 고려해야 하는 상태를 적는다.
- 예: loading, empty, error, success, disabled

## 접근성 기준

- 접근성 중요도를 적는다.
- 키보드 탐색, 대비, 스크린 리더 대응 등 필요한 항목을 적는다.

## 콘텐츠 원칙

- 버튼 문구, 에러 문구, 빈 상태 문구 톤을 적는다.
- 카피 톤 기본값: `DESIGN.md`의 친근한 존댓말(`-요`/`-어요`/`-아요`) + 버튼 동사형(예: `지원하기`, `저장하기`). 다르게 가져갈 항목만 적는다.

## 토큰 정책 (색·spacing·radius·typography)

- 기본값: `DESIGN.md`의 토큰 호출 형식(`{colors.bg-brand}`, `{spacing.space-16}`, `{rounded.radius-8}`, `{typography.body1}`)을 그대로 사용한다.
- 색상 톤: 기본값 사용. 변경할 영역만 명시 (예: `bg-accent`만 프로젝트 컬러로 override).
- spacing: 4의 배수만 사용 (DESIGN.md Don't 정책). 비-4의 배수(6/10/14/18/22)가 필요하면 사유와 함께 적는다.
- radius: 기본값 `{rounded.radius-8}`. 카드/버튼/입력 단위로 다르면 명시.
- typography: 기본값 `{typography.body1}` 등. 헤딩/본문/버튼별로 다르게 잡을 항목만 적는다.
- 다크 모드: 별도 alias 정책이 필요하면 적는다 (없으면 DESIGN.md `## Dark Alias` 그대로 사용).

## 작성 예시

```
## 사용 디자인 시스템
- (a) 라이브러리 시안 `wanted` 활성화. 신규 토큰/컴포넌트 추가는 본 프로젝트에서 발생 시 designs/wanted.md 갱신 절차(또는 fork)에 따른다.

## 제품 톤과 느낌
- 신뢰감 있고 정돈된 느낌. 정보 밀도 높음.
- 피하고 싶은 스타일: 과한 그라데이션, 큰 일러스트, 만화체 마이크로카피.

## 참고 서비스 또는 레퍼런스
- Linear: 정보 밀도와 키보드 친화 인터랙션.
- Stripe Dashboard: 표/필터 UX와 빈 상태 카피톤.

## 핵심 사용자 흐름
1. 주문 검색 → 필터 적용 → 상세 진입
2. 주문 상세에서 상태 변경 또는 취소
3. 신규 주문 등록 폼

## 화면 상태
- loading: 스켈레톤 (목록), 스피너 (액션 버튼)
- empty: 안내 문구 + 다음 액션 버튼
- error: 인라인 에러 + 재시도 버튼
- disabled: 사유 툴팁 동반

## 접근성 기준
- 모든 인터랙티브 요소 키보드 접근 가능.
- WCAG AA 명도 대비 준수.
- 폼 라벨/에러는 스크린 리더로 읽힌다.

## 콘텐츠 원칙
- 버튼: 동사 시작, 짧게 ("저장", "취소 요청").
- 에러: 사실 + 다음 액션 ("저장 실패. 잠시 후 다시 시도해주세요.").
- 빈 상태: 안내 + 다음 액션 버튼 1개.
- 카피 톤: DESIGN.md 기본값(친근한 존댓말 + 버튼 동사형) 그대로 사용.

## 토큰 정책
- 색·spacing·radius·typography 모두 DESIGN.md 기본값 사용.
- override: `bg-accent`만 프로젝트 브랜드 컬러로 교체 (별도 PR에서 토큰 정의 후 호출).
```
