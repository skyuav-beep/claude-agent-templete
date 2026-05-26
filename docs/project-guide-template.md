# Project Guide Template

이 문서는 intake 설문 답변을 정리하여 실제 개발 기준으로 사용하는 프로젝트 전용 가이드 템플릿이다.

## 1. Project Summary

- 프로젝트 한 줄 설명
- 핵심 목표
- 주요 사용자
- 이번 단계 범위

## 2. Confirmed Decisions

- 확정된 기능 범위
- 확정된 UI 방향
- 확정된 반응형 방향
- 확정된 기술 스택

## 3. Open Questions

- 아직 결정되지 않은 항목
- 결정이 늦어질 경우 영향이 큰 항목

## 4. Scope and Priorities

- 반드시 해야 할 일
- 하면 좋은 일
- 이번 범위에서 제외할 일

## 5. UI/UX Guidelines

- 제품 톤과 스타일
- 핵심 사용자 흐름
- 반드시 고려해야 하는 상태
- 접근성 기준
- 콘텐츠 톤

## 6. Responsive Rules

- 모바일/PC 우선순위
- breakpoint 기준
- 디바이스별 핵심 행동
- 레이아웃 원칙
- 인터랙션 차이

## 7. Component Rules

- 컴포넌트 분리 기준
- 재사용 기준
- variant / state 규칙
- 금지할 중복 패턴

## 7-1. Repository and Directory Rules

- 단일 레포 / 모노레포 선택 이유
- 최상위 디렉터리 구조
- feature / shared / infra 분리 기준
- 공용화 승격 기준

## 7-2. File Split Rules

- 한 파일에 허용하는 책임 범위
- 파일 분리 트리거
- 파일 크기 경고 기준
- giant file 방지 규칙

## 8. Tech Stack and Commands

- frontend / backend / database
- package manager
- 개발 서버 실행 명령
- 테스트 명령
- 빌드 명령
- 린트 명령

## 8-1. I18n Policy

- 지원 언어
- 기본 locale
- fallback locale
- 번역 범위
- formatting 정책
- 라우팅 / locale switch 정책

## 9. Constraints

- 일정 제약
- 기술 제약
- 보안 제약
- 수정 금지 범위

## 10. Development Rules

- 구현 시 우선 기준
- 리뷰 시 우선 기준
- 테스트 기준
- 문서 업데이트 규칙

## 11. Initial Backlog

- 첫 번째 작업
- 두 번째 작업
- 세 번째 작업

## 12. Change Policy

- 요구사항이 바뀌면 먼저 이 문서를 갱신한다.
- 이 문서와 실제 작업 방식이 어긋나면 `AGENTS.md` 또는 관련 하위 문서 갱신을 제안한다.

---

## 작성 예시 (Worked Example)

다음은 `templates/startup-checklist.md`, `templates/project-intake.md`, `templates/ui-intake.md`, `templates/tech-intake.md`, `templates/i18n-intake.md`의 운영 대시보드 placeholder 시나리오 답변을 위 1~12 섹션 구조에 그대로 옮긴 결과다. 실제 프로젝트에서는 이 형태의 `docs/project-guide.md`를 산출물로 만든다.

```
# Project Guide — <프로젝트명> 운영 대시보드 MVP

## 1. Project Summary

- 한 줄 설명: <프로젝트 한 줄 설명>의 본사 운영자 대시보드.
- 핵심 목표: 신규 <엔티티B>의 첫 <엔티티A> 처리 시간을 24시간 → 1시간으로 단축.
- 주요 사용자: 본사 운영자(10명 이내), <2차 사용자>(30개 단위).
- 이번 단계 범위: MVP 4주. <엔티티A> 목록/상세, <엔티티B> 현황, 수동 <핵심 액션>, 일별 KPI 카드.

## 2. Confirmed Decisions

- 기능 범위: <엔티티A> 목록/상세, <엔티티B> 현황, 수동 <핵심 액션>, 일별 KPI(<지표1> / <지표2> / <지표3>) 3종.
- UI 방향: Linear/Stripe 참고. 정보 밀도 높은 운영 도구 톤. 미니멀, 라이트 테마 우선.
- 반응형 방향: PC 우선 (운영자는 PC, <2차 사용자>는 태블릿까지). 모바일은 읽기 전용.
- 기술 스택: Next.js 15 (App Router) + TypeScript + Supabase(Postgres + Auth) + pnpm + Biome + Vitest + Playwright.
- 인증: Supabase Auth. 권한 3등급 (운영자 / <2차 사용자> / 일반).
- 배포: Vercel preview(PR 단위) + production(main).

## 3. Open Questions

- 알림 채널: Slack 웹훅 vs 자체 푸시. 1주 차 결정 예정. 늦으면 운영자 SLA 측정 영향.
- 모니터링 깊이: Sentry 단독 vs Datadog 추가. 운영 시작 후 결정.
- e2e 테스트 DB 시드 전략: CI 환경 구성 시점에 결정.

## 4. Scope and Priorities

- 반드시(Must): <엔티티A> 목록/상세, <엔티티B> 현황 실시간 갱신, 수동 <핵심 액션>, 일별 KPI 3종, 권한 3등급.
- 좋으면(Should): <엔티티A> 검색/필터, <엔티티B> 상세 모달, KPI 기간 비교.
- 제외(Won't): 정산, 고객 CS, <엔티티B> 모바일 앱, 다국어, AI 추천 기능.

## 5. UI/UX Guidelines

- 톤: 정보 밀도 높음. 표/카드 중심. 색은 상태 신호용으로만 사용.
- 핵심 흐름: (1) 신규 <엔티티A> 도착 → 5분 내 <핵심 액션> 확인, (2) 미처리 <엔티티A> 수동 <핵심 액션>, (3) 일별 KPI 확인.
- 필수 상태: loading, empty, error, partial-loaded(스트리밍), unauthorized.
- 접근성: 키보드 탐색 전체 가능, 색상 대비 WCAG AA, 토스트는 `aria-live=polite`.
- 콘텐츠 톤: 운영자 친화 한국어. 명령형보다 상태 서술형 ("<핵심 액션> 대기 3건").

## 6. Responsive Rules

- 모바일/PC 우선순위: PC 우선. 모바일은 읽기 전용 fallback.
- breakpoint: sm 640 / md 768 / lg 1024 / xl 1280. 작업 화면은 lg 이상 보장.
- 디바이스별 핵심 행동: PC는 단축키 + 다중 패널, 태블릿은 단일 패널, 모바일은 KPI/<엔티티A> 요약만.
- 레이아웃 원칙: 좌측 글로벌 nav + 우측 컨텐츠. 컨텐츠 영역은 12열 그리드.
- 인터랙션 차이: 모달은 PC/태블릿 동일, 모바일은 풀스크린 시트로 전환.

## 7. Component Rules

- 분리 기준: 도메인 단위(`features/<entity-a>`, `features/<entity-b>`) → UI primitives(`shared/ui`) → 인프라(`shared/lib`).
- 재사용 기준: 두 번째 사용 시점에 `shared/ui`로 승격. 첫 사용에는 feature 내부에 둔다.
- variant/state: variant는 prop, state는 데이터 기반(loading/empty/error). 동일 컴포넌트에서 표현.
- 금지 패턴: feature 코드가 다른 feature를 직접 import 금지. 공통 필요 시 `shared/`로 승격.

## 7-1. Repository and Directory Rules

- 단일 레포 (Next.js 단일 앱). 사이드 서비스 추가 시 모노레포 전환 검토.
- 최상위: `src/app/`, `src/features/`, `src/shared/`, `src/server/`(BFF/RPC), `src/lib/`(infra).
- feature/shared/infra 분리: feature는 화면+로직, shared는 재사용 UI/util, infra는 외부 의존.
- 공용화 승격 기준: 2개 이상 feature에서 동일 형태로 사용될 때.

## 7-2. File Split Rules

- 한 파일 책임: 한 컴포넌트 + 그 컴포넌트 전용 hook/util까지.
- 분리 트리거: (1) 200줄 초과, (2) 외부에서 재사용 발생, (3) 테스트 단위가 분리됨.
- 경고 기준: 300줄 경고, 500줄 차단(리뷰에서 분리 요구).
- giant file 방지: index 파일은 re-export만. 로직 금지.

## 8. Tech Stack and Commands

- frontend: Next.js 15 (App Router), TypeScript 5.x, Tailwind, shadcn/ui.
- backend: Next.js Route Handlers + Supabase RPC.
- database: Supabase Postgres.
- package manager: pnpm 9.
- 개발 서버: `pnpm dev` (Next.js, 기본 :3000).
- 테스트: `pnpm test` (Vitest), `pnpm e2e` (Playwright).
- 빌드: `pnpm build`.
- 린트/포맷: `pnpm lint` (Biome), `pnpm format`.

## 8-1. I18n Policy

- 지원 언어: ko 단독 (운영자 한국어 전용).
- 기본 locale: ko-KR.
- fallback locale: 해당 없음.
- 번역 범위: 미적용. 향후 <2차 사용자> 영문 지원 시 재논의.
- formatting: 통화 KRW 고정, 숫자 천단위 구분자, 시간 Asia/Seoul 표시. UTC로 저장.
- 라우팅 정책: locale prefix 없음.

## 9. Constraints

- 일정: MVP 4주. 1주차 스캐폴딩, 2~3주차 주요 기능, 4주차 안정화/배포.
- 기술: 사내 표준 Next.js + Supabase. 외부 BaaS 추가 금지.
- 보안: 운영자 권한 데이터는 RLS 강제. 클라이언트에 service role key 노출 금지.
- 수정 금지: 기존 <외부 연동 시스템> API 스키마, <외부 연동 시스템> 인증 토큰 발급 로직.

## 10. Development Rules

- 구현 우선: 정확성 > 완성도 > 속도. 운영 데이터 다루므로 정확성이 최우선.
- 리뷰 우선: 권한 검증, 에러 처리, 빈 상태 처리.
- 테스트 기준: 비즈니스 로직(<핵심 액션>/권한)은 단위 테스트 필수, 핵심 흐름 3종은 e2e 필수.
- 문서 갱신: 의사결정 변경 시 본 문서 → 관련 하위 문서 → 코드 순으로 반영.

## 11. Initial Backlog

1. 프로젝트 스캐폴딩 (Next.js + Supabase 연결, Biome/Vitest 셋업, CI 파이프라인).
2. 인증/권한 (Supabase Auth + RLS + 권한 3등급 라우트 가드).
3. <엔티티A> 목록 화면 (목록 + 필터 + 상세 모달).

## 12. Change Policy

- 요구사항이 바뀌면 본 문서를 먼저 갱신하고 PR에 변경 이유를 적는다.
- 본 문서와 실제 작업 방식이 어긋나면 `AGENTS.md` 또는 관련 하위 문서(`docs/i18n-guidelines.md`, `docs/framework-structure-guide.md` 등) 갱신을 제안한다.
- "확정 사항"이 "미정"으로 되돌아가는 변경은 별도 의사결정 메모를 남긴다.
```

---

## 변환 절차 요약

intake 답변 → 본 가이드 변환은 다음 매핑을 따른다.

| 본 가이드 섹션 | 주된 입력 소스 |
| --- | --- |
| 1. Project Summary | `templates/project-intake.md` 한 줄 설명/목표/사용자/범위 |
| 2. Confirmed Decisions | `templates/startup-checklist.md` 섹션 1·2·3·5·7·11 결과 요약의 "확정 사항" |
| 3. Open Questions | startup-checklist 결과 요약의 "미정 사항" |
| 4. Scope and Priorities | project-intake 범위 + startup-checklist 섹션 1 |
| 5. UI/UX Guidelines | `templates/ui-intake.md` |
| 6. Responsive Rules | `templates/responsive-intake.md` |
| 7 / 7-1 / 7-2 | `templates/framework-structure-intake.md` + `docs/framework-structure-guide.md` |
| 8 / 8-1 | `templates/tech-intake.md` + `templates/i18n-intake.md` (있을 때만 8-1 작성) |
| 9. Constraints | project-intake 제약 + tech-intake 제약 |
| 10. Development Rules | startup-checklist 섹션 11 + `agents/executor-agent.md`, `agents/reviewer-agent.md` |
| 11. Initial Backlog | startup-checklist 결과 요약의 "다음 액션" |
| 12. Change Policy | 고정 문구 (본 템플릿 그대로 사용) |

비어 있는 입력 소스가 있으면 해당 섹션은 "미정"으로 비워두지 말고 `## 3. Open Questions`로 옮긴다.
