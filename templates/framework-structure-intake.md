# Framework Structure Intake Template

## 프로젝트 형태

- 단일 앱인지, 다중 앱인지 적는다.
- 모노레포가 필요한 이유가 있는지 적는다.

## 초기 기술 구조

- 사용할 frontend / backend framework
- package manager
- build / test / lint 방식

## 예상 주요 영역

- 기능 영역
- 공용 UI
- 상태 관리
- 데이터 접근
- 비즈니스 로직
- 운영 스크립트

## 디렉터리 분리 기준

- feature 중심인지
- layer 중심인지
- hybrid 구조인지

## 파일 분리 기준

- 한 파일에 어떤 책임까지 허용할지
- 언제 hooks, service, component를 분리할지
- 파일 크기 경고 기준을 어떻게 둘지

## 공용화 기준

- 언제 shared로 올릴지
- 언제 feature 내부에 유지할지

## 주의할 안티패턴

- 피하고 싶은 구조가 있다면 적는다.
- 예: giant component, god service, utils 남용

## 작성 예시

```
## 프로젝트 형태
- 단일 앱(Next.js).
- 모노레포 불필요. 추후 라이더 모바일 앱 추가 시 재검토.

## 초기 기술 구조
- frontend / backend: Next.js 15 (App Router) 단일 프로젝트
- package manager: pnpm
- build: `pnpm build`, test: Vitest + Playwright, lint: Biome

## 예상 주요 영역
- 기능 영역: orders, riders, stores, dashboard
- 공용 UI: 디자인 시스템 컴포넌트 (button, table, modal 등)
- 상태 관리: 서버 상태는 React Query, 클라이언트 상태는 zustand 최소 사용
- 데이터 접근: Supabase 클라이언트는 server-only 모듈로 격리
- 비즈니스 로직: feature 내 `services/` 디렉터리에 도메인 함수
- 운영 스크립트: `scripts/` (시드, 마이그레이션, 임시 점검)

## 디렉터리 분리 기준
- feature 중심 hybrid.
- 최상위: `src/features/`, `src/shared/`, `src/app/` (Next.js 라우트)
- feature 내부: `components/`, `hooks/`, `services/`, `types.ts`

## 파일 분리 기준
- 한 파일 200줄 넘으면 책임 분리 검토.
- hook은 컴포넌트가 동일 로직을 2회 이상 사용할 때 분리.
- service는 외부 호출이 있거나 순수 도메인 로직일 때 분리.

## 공용화 기준
- 2개 이상 feature에서 사용하기 시작하면 `src/shared/`로 이동.
- 1개 feature에서만 쓰면 feature 내부 유지.

## 주의할 안티패턴
- 거대한 page 컴포넌트 (200줄 초과 + 다중 책임)
- `utils/` 잡다한 함수 모음
- 공용 context로 모든 상태 관리
- 한 파일에서 server/client 코드 혼재
```
