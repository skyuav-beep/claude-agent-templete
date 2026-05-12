# API & Data Fetching Intake Template

## API 통신 방식
- 다이렉트 REST API, BFF 구조, GraphQL, tRPC 등
- 선호하는 클라이언트 데이터 페칭 라이브러리 (React Query, SWR 등)

## API 명세서
- Swagger, OpenAPI 등 명세서 존재 여부
- Type (타입) 자동 생성 사용 여부

## Mocking 환경
- 백엔드 미완성 시 프론트엔드 단독 개발을 위한 Mocking 전략 (MSW, 더미 JSON 등)

## 작성 예시

```
## API 통신 방식
- BFF(Next.js Route Handler) 경유. 클라이언트는 BFF만 호출한다.
- 데이터 페칭은 React Query v5 사용. mutation은 서버 액션 사용 가능.

## API 명세서
- OpenAPI 3.1 스펙을 백엔드에서 제공.
- `pnpm gen:api`로 타입과 fetch 클라이언트를 자동 생성한다.

## Mocking 환경
- MSW(Mock Service Worker)를 dev 모드에서 활성화.
- 시나리오별 mock은 `src/mocks/handlers/` 아래에 feature별 파일로 분리한다.
```
