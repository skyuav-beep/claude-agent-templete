# Tech Intake Template

## 기본 스택

- frontend framework
- backend framework
- database
- 배포 환경

## 개발 도구

- package manager
- lint / format 도구
- test 도구

## 실행 명령

- 개발 서버 실행 명령 (hot reload/watch 모드 여부 포함)
- 테스트 실행 명령
- 빌드 명령
- 린트 명령

## 로컬 Docker 개발 루프

- Docker Desktop 사용 여부 / dev 컨테이너 구성
- 소스 bind mount 경로 (이미지 COPY 대신 즉시 반영 구조인지)
- 파일 감지 폴링 필요 여부 (WSL2/Docker Desktop에서 hot reload가 동작하려면 폴링 env가 필요할 수 있음 — `docs/local-dev-ci-guide.md §2.1`)

## 아키텍처 선호

- 선호하는 구조나 패턴이 있다면 적는다.
- 피하고 싶은 패턴이 있다면 적는다.

## 운영 제약

- 환경 변수 정책
- 외부 서비스 사용 제한
- 보안 또는 규정상 제약

## 미정 기술 항목

- 아직 결정되지 않은 기술 선택이 있다면 적는다.

## 작성 예시

```
## 기본 스택
- frontend: Next.js 15 (App Router), React 19, TypeScript
- backend: Next.js Route Handler + Supabase
- database: PostgreSQL (Supabase managed)
- 배포 환경: Vercel (preview + production)

## 개발 도구
- package manager: pnpm
- lint / format: Biome
- test: Vitest (단위), Playwright (e2e)

## 실행 명령
- 개발 서버: `pnpm dev` (port 3000, HMR/watch)
- 테스트: `pnpm test`, `pnpm test:e2e`
- 빌드: `pnpm build`
- 린트: `pnpm lint`, `pnpm format`

## 로컬 Docker 개발 루프
- Docker Desktop 사용. dev 컨테이너 상시 기동(`docker compose up -d`).
- bind mount: `./:/app` + `/app/node_modules` 익명 볼륨. 코드 수정 즉시 반영.
- 폴링: WSL2라 `CHOKIDAR_USEPOLLING=true` 설정.

## 아키텍처 선호
- feature-first 디렉터리 구조.
- 서버 컴포넌트 우선, 클라이언트 컴포넌트는 인터랙션 단위로 최소화.
- 피하고 싶은 패턴: 거대한 context provider, util 디렉터리에 잡다한 함수 모음.

## 운영 제약
- 환경 변수는 `.env.local`에 보관, Vercel 환경에 동기화. 커밋 금지.
- 외부 SaaS 추가는 기술 리드 승인 필요.
- 개인정보는 Supabase RLS로 1차 격리.

## 미정 기술 항목
- e2e 환경 시드 전략 (CI에서 매번 reset vs 영속 테스트 DB).
- 모니터링 도구 선택 (Sentry vs Datadog).
```
