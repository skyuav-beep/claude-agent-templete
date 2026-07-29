# Startup Checklist

## 목적

에이전트가 새 프로젝트 작업을 시작할 때 사용자에게 순서대로 질문해서
확정 사항, 미정 사항, 제약 사항을 빠르게 수집하는 QnA 체크리스트다.

---

## 사용 방법

에이전트는 아래 섹션을 순서대로 사용자에게 질문한다.
- 각 섹션의 질문을 한 번에 모아서 물어본다.
- 답변을 받으면 해당 섹션의 결과를 `확정 / 미정 / 제외` 로 분류해서 요약한다.
- 모든 섹션이 끝나면 전체 결과를 하나의 요약으로 정리하고 다음 액션을 제안한다.

---

## 섹션 1 - 프로젝트 기본 정보

```
Q1. 이 프로젝트를 한 문장으로 설명하면?
Q2. 이번 단계에서 반드시 구현해야 하는 기능은?
Q3. 이번 단계에서 제외하거나 나중으로 미룰 기능은?
Q4. 일정 제약이 있다면?
Q5. 수정하거나 교체하면 안 되는 기존 코드 또는 시스템이 있다면?
```

---

## 섹션 2 - 기술 스택

```
Q1. 사용할 프론트엔드 프레임워크는? (예: Next.js, React, Vue, Svelte)
Q2. 백엔드 또는 API 방식은? (예: REST, GraphQL, tRPC, 없음)
Q3. 데이터베이스는? (예: PostgreSQL, MySQL, SQLite, 없음)
Q4. 패키지 매니저는? (예: npm, pnpm, yarn, bun)
Q5. 테스트 도구는? (예: Vitest, Jest, Playwright, 없음)
Q6. 린트/포맷 도구는? (예: ESLint + Prettier, Biome, 없음)
Q7. 배포 환경은? (예: Vercel, AWS, Docker, 미정)
Q8. 로컬 개발은 Docker Desktop으로 하는가? (dev 컨테이너 상시 기동 + 소스 bind mount + hot reload 구조 — `docs/local-dev-ci-guide.md §2.1`)
```

---

## 섹션 3 - UI 및 디자인 기준

```
Q1. UI 톤 또는 스타일 방향은? (예: 미니멀, 다크, 기업형, 없음)
Q2. 참고하고 싶은 서비스나 디자인이 있다면?
Q3. 가장 중요한 사용자 흐름 1~3개는?
Q4. 반드시 고려해야 할 화면 상태는? (예: loading, empty, error, disabled)
Q5. 접근성 대응 수준은? (예: 키보드 탐색, 스크린 리더, 색상 대비 기준)

# 디자인 시스템 선택 (designs/ 라이브러리 기반)
Q6. 사용할 디자인 시안 슬러그는?
    먼저 라이브러리 목록 확인:
        bash .claude/plugins/select-design.sh --list
    옵션:
    A. 라이브러리 기본 시안 사용 (예: wanted) — `select-design.sh wanted`
    B. 라이브러리 시안을 fork 해 프로젝트 전용으로 편집
        cp designs/wanted.md designs/<custom-slug>.md
        # frontmatter name/slug/category/last_updated 갱신
        # 본문 토큰/컴포넌트 수정
        bash .claude/plugins/select-design.sh <custom-slug>
    C. 빈 골격에서 새로 작성
        cp designs/_template.md designs/<custom-slug>.md
        # _alias-contract.md 의 alias 25종 + 컴포넌트 7종 시그너처를 모두 채움
        bash .claude/plugins/select-design.sh <custom-slug>
Q7. 활성화 검증
    cat .claude/.active-design          # 슬러그가 기록됐는지 확인
    head -20 DESIGN.md                  # frontmatter가 선택한 시안과 일치하는지 확인
Q8. 위 결정과 frontmatter 변경을 STATE.md `이번 세션에서 완료한 작업`에 기록한다.
    예: "designs/library에서 toss-like 시안을 fork → designs/myadmin.md로 활성화. 카드 그림자 정책만 허용으로 override."
```

---

## 섹션 4 - 모달 방식 설정

표준값은 `DESIGN.md ### modal / dialog`를 따른다 — 모달은 항상 커스텀 표면으로 구현하고, 닫기는 닫기 버튼·헤더 X·ESC 세 가지로만 한다(배경 클릭 닫기 금지). 아래는 그 외 결정 항목을 수집한다.

```
Q1. 모달 구현 방식은? (표준: A)
    A. 커스텀 모달 — 시각은 직접 구현, a11y 동작(focus-trap/scroll-lock/ESC/aria)만 headless 라이브러리(Radix / Headless UI / React Aria) 위임 가능 [표준]
    B. 완전 직접 구현 — 라이브러리 없이 a11y 동작까지 직접 구현
    (native window.alert/confirm/prompt·pre-styled 라이브러리 모달은 사용하지 않음)

Q2. 모달 열기/닫기 애니메이션은?
    A. 페이드 (Fade)
    B. 슬라이드 (Slide-up 또는 Slide-down)
    C. 스케일 (Scale)
    D. 애니메이션 없음
    E. 미정

Q3. 모달을 닫는 방법은? (표준 고정: A + 닫기/취소 버튼 + C)
    A. 헤더 X 버튼 [표준]
    B. ESC 키 [표준]
    C. 푸터 닫기/취소 버튼 [표준]
    D. 특정 조건에서만 닫힘 (예: 폼 제출 후에만) — 케이스별
    (배경(Overlay) 클릭·시트 스와이프 닫기는 비표준 — 예외 승인 시에만)

Q4. 모달 위에 모달 스택(중첩)을 허용하는가?
    A. 허용 (최대 N단계)
    B. 불허 (항상 단일 모달만)
    C. 미정

Q5. 모달 외부 스크롤 처리는?
    A. 배경 스크롤 잠금 (body scroll lock)
    B. 배경 스크롤 허용
    C. 미정

Q6. 모달 내부 스크롤이 필요한가?
    A. 필요 (콘텐츠가 길어질 수 있음)
    B. 불필요 (항상 콘텐츠가 짧음)
    C. 케이스별 상이

Q7. 모달 접근성 대응 수준은?
    A. 최소 (닫기 버튼 aria-label 정도)
    B. 표준 (focus trap, role="dialog", aria-modal)
    C. 높음 (스크린 리더 완전 대응 포함)
    D. 미정
```

---

## 섹션 5 - 반응형 및 레이아웃

```
Q1. PC/모바일 중 우선순위는?
    A. PC 우선
    B. 모바일 우선
    C. 동일 우선

Q2. 지원해야 하는 브레이크포인트 기준은?
    예: sm(640), md(768), lg(1024), xl(1280)

Q3. 반응형에서 모달 처리 방식은? (바텀 시트도 섹션 4 닫기 정책 동일 적용)
    A. 모바일에서는 바텀 시트(Bottom Sheet)로 전환 — 닫기는 X/닫기 버튼/ESC만, 배경 클릭·스와이프 닫기 금지
    B. 모바일에서도 동일한 모달 유지
    C. 미정
```

---

## 섹션 6 - 다국어(i18n) 여부

```
Q1. 다국어 지원이 필요한가?
    A. 필요 (지원 언어: )
    B. 불필요
    C. 미정

Q2. 기본 locale은?
    예: ko, en, ja

Q3. 번역 범위는?
    A. UI 전체 (버튼, 레이블, 에러 메시지, 모달 내용 포함)
    B. 일부만 (핵심 화면만)
    C. 미정
```

---

## 섹션 7 - 비즈니스 로직 및 상태 관리

```
Q1. 전역 상태 관리가 필요한가?
    A. 필요 (도구: Zustand / Redux / Jotai / Context API / 미정)
    B. 불필요 (로컬 상태만으로 충분)
    C. 미정

Q2. 서버 상태 관리(캐시, 패칭)가 필요한가?
    A. 필요 (도구: React Query / SWR / tRPC / 미정)
    B. 불필요
    C. 미정

Q3. 인증/권한 처리가 필요한가?
    A. 필요 (방식: 세션, JWT, OAuth, 미정)
    B. 불필요
    C. 미정
```

---

## 섹션 8 - 포맷 및 현지화 정책 (Format & Localization)

```
Q1. 세계시 및 타임존: 데이터베이스/서버는 UTC를 기준으로 통신하는가?
    A. UTC 통신 및 저장, 클라이언트에서만 현지 시간(Local Time)으로 변환
    B. 특정 타임존 기준 통신 및 고정 표시 (예: Asia/Seoul)
    C. 미정

Q2. 화폐 단위(Currency) 설정은 어떻게 할 것인가?
    A. 단일 통화 (예: KRW 또는 USD 고정)
    B. 다중 통화 지원
    C. 기호 위치(앞/뒤) 및 소수점 표기 여부 우선순위 기준 (예: 원화는 소수점 제외)

Q3. 숫자 표기(Numbers): 숫자를 노출할 때 천 단위 구분자와 축약(1M, 10K 등) 표기를 기본으로 적용하는가?

Q4. 금액을 다루는 프로젝트인가? (결제, 정산, 주문, 잔액 등)
    A. 예 -> 저장 타입(십진/최소 단위 정수)과 정수화 확정 시점을 함께 확정한다
       (기준: `docs/money-quantity-guidelines.md`)
    B. 아니오 -> 표기 규칙만 적용

Q5. 수량을 다룬다면 소수 수량(kg, L, 시간)이 있는가? 있다면 단위별 허용 소수 자릿수는?
```

---

## 섹션 9 - API 및 예외 처리 정책

```
Q1. API 통신 방식과 타입 자동화 전략은 무엇인가? (예: REST/GraphQL, Swagger 기반 타입 생성 유무)
Q2. API 미완성 시 선제 개발을 위한 Mocking(MSW 등)을 설정할 것인가?
Q3. 치명적인 에러 발생 시 Fallback UI(Error Boundary) 전략 및 에러 로깅 서비스(Sentry 등) 연동 계획은?
```

---

## 섹션 10 - 라우팅 및 폼 검증

```
Q1. 파라미터 상태 동기화: 탭, 검색어, 페이지네이션 상태를 URL 쿼리 파라미터에 강제 동기화할 것인가?
Q2. 대상별 권한 라우팅 접근 제어(Protected Route) 수준은? (예: 단순 비로그인 제한 유무 vs 직군별 권한 제어)
Q3. 폼 상태 관리 및 검증 전략은? (예: React Hook Form + Zod 활용 여부)
```

---

## 섹션 11 - 협업 및 배포 환경

```
Q1. 기능 구현 시 에이전트의 테스트 코드(Unit/E2E) 작성을 필수로 강제할 것인가?
Q2. 커밋 메시지 작성 템플릿/컨벤션이 별도로 정의되어 있는가? (예: `feat:`, `fix:`)
Q3. CI는 로컬에서 개발자 요청 시 실행한다(GitHub Actions 자동 트리거 없음). 로컬 CI 스위트(lint/typecheck/test/build, Docker smoke 포함 여부)와 단일 진입점은? 자동 배포 파이프라인 필요 여부는? (`docs/local-dev-ci-guide.md §6`)
```

---

## 결과 요약 형식

에이전트는 모든 섹션이 완료되면 아래 형식으로 결과를 정리한다.

```
## 초기 설정 결과 요약

### 확정 사항
- [항목]: [답변]

### 미정 사항
- [항목]: 개발 중 결정 예정 또는 추가 논의 필요

### 제외 사항
- [항목]: 이번 단계 제외

### 다음 액션
1. [첫 번째 액션]
2. [두 번째 액션]
```

---

## 결과 요약 작성 예시

```
## 초기 설정 결과 요약

### 확정 사항
- 프로젝트: <프로젝트 한 줄 설명> 운영 대시보드 MVP (4주)
- 핵심 기능: <엔티티A> 목록/상세, <엔티티B> 현황, 수동 <핵심 액션>, 일별 KPI
- 스택: Next.js 15 + TypeScript + Supabase + pnpm + Biome + Vitest/Playwright
- 배포: Vercel preview + production
- 로컬 개발: Docker Desktop, dev 컨테이너 상시 기동 + bind mount + hot reload (WSL2 폴링)
- UI 톤: Linear/Stripe 참고. 정보 밀도 높음, 미니멀
- 우선 디바이스: PC 우선 (운영자 대상)
- 인증: Supabase Auth, 권한 3등급 (운영자/<2차 사용자>/일반)
- 다국어: 미적용 (운영자 한국어 전용)
- 에러: Sentry, 토스트 + 폼 인라인
- API: BFF 경유, React Query, OpenAPI 자동 타입
- 폼: React Hook Form + Zod
- 테스트 강제: 비즈니스 로직 단위, 핵심 흐름 e2e
- Git: Conventional Commits, `feat/<scope>` 브랜치, 머지 후 브랜치 정리(squash + 로컬/원격 삭제)
- CI/CD: 로컬 CI(`pnpm ci:local` = lint+typecheck+test+build)를 개발자 요청 시 로컬 실행. GitHub Actions 자동 트리거 없음(필요 시 `workflow_dispatch` 강등). production 배포 수동

### 미정 사항
- 알림 채널 (Slack vs 자체 푸시): 1주 차 결정 예정
- 모니터링 (Sentry only vs Datadog 추가): 운영 시작 후 결정
- e2e 테스트 DB 시드 전략: 로컬 CI(e2e) 환경 구성 시 결정

### 제외 사항
- 정산 모듈, 고객 CS 도구, <엔티티B> 모바일 앱, 다국어, AI 추천

### 다음 액션
1. `docs/project-guide.md` 작성 (project-guide-template 기준)
2. `docs/ui-decisions.md` 작성 (UI/반응형 결정 저장)
3. `AGENTS.md`의 Operational Commands에 pnpm 명령 반영
4. 초기 디렉터리 구조 생성 (`src/features/`, `src/shared/`, `src/app/`)
```

---

## 연계 문서

- 수집된 답변은 `docs/project-guide-template.md` 기준으로 프로젝트 가이드 문서를 작성한다.
- 모달 설정 답변은 `docs/ui-decisions.md`로 별도 저장을 권장한다.
- 다국어 설정이 확정되면 `docs/i18n-guidelines.md`를 생성한다.
- 기술 스택이 확정되면 `AGENTS.md`의 `Operational Commands` 섹션을 갱신한다.
- 포맷, API, 예외, 라우팅, QA 등 특정 주제에 대한 상세 질문은 `templates/format-intake.md` 등 개별 템플릿 문서를 활용한다.
