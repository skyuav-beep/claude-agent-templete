# AGENTS.md

## 목적

`dexchange`는 신규 DEX 거래소 개발을 위한 프로젝트다. 현재 단계의 목표는 실제 온체인 배포가 아니라, 에이전트 운영 규칙과 개발 골격을 먼저 고정해 이후 UI, API, 인덱서, 스마트컨트랙트 작업을 안전하게 진행할 수 있게 만드는 것이다.

에이전트는 다음 목표를 우선한다.

- DEX 기능을 구현할 때 보안, 자산 보호, 재현 가능한 검증을 속도보다 우선한다.
- 요구사항이 모호한 온체인 동작은 구현 전에 `docs/project-guide.md`의 미정 항목으로 남긴다.
- 실제 자금, mainnet, 개인키, seed phrase를 다루는 작업은 사용자 명시 승인 없이 수행하지 않는다.
- 작업 완료 시 `STATE.md`에 현재 상태와 다음 작업을 갱신한다.

## Project Context & Operations

### 비즈니스 목표 및 Tech Stack 요약

- 목적: 지갑 연결, 토큰 스왑, 유동성 공급, 풀/거래 내역 조회를 갖춘 DEX 거래소 MVP 개발.
- 현재 범위: 에이전트 레이어 설치, 모노레포 기본 구조, 프로젝트 전용 문서, 로컬 검증 스크립트.
- 기본 구조: `apps/web`, `apps/indexer`, `packages/contracts`, `packages/sdk`, `packages/shared`, `infra`.
- 기본 도구: Node.js 22, pnpm 10, Docker Compose, TypeScript 기반 모노레포를 전제로 한다.

### Operational Commands

- 의존성 설치: `pnpm install`
- 현재 골격 검증: `pnpm check`
- 문서/구조 검증: `pnpm lint`
- 테스트 자리표시자: `pnpm test`
- 빌드 자리표시자: `pnpm build`
- 개발 서버 자리표시자: `pnpm dev`
- 로컬 인프라 기동: `docker compose up -d`
- 로컬 인프라 로그 확인: `docker compose logs -f`

현재 `pnpm dev`, `pnpm build`는 런타임 앱이 확정되기 전까지 안내 메시지만 출력한다. 실제 Next.js, indexer, contract 도구를 추가하면 해당 스크립트를 실제 명령으로 교체한다.

### 환경 경계

- 환경 호칭은 `local`(내 PC Docker Desktop), `develop`(원격 개발서버), `production`(원격 운영서버) 3-tier로 통일한다.
- `local`에서만 agent가 Docker, 테스트, local migration, local chain, local contract deploy를 자동 수행할 수 있다.
- `develop`/`production` 배포, migration, contract deploy, mainnet 또는 실자금 트랜잭션은 사용자 수동 작업으로 인계한다.
- `dev` 단독 표기는 사용하지 않는다. 명령 이름에 포함된 `dev`는 도구 명령 모드로만 해석한다.

## DEX 보안 규칙

- private key, mnemonic, seed phrase, wallet backup, production RPC secret은 저장소에 쓰지 않는다.
- `.env.example`에는 placeholder만 둔다.
- 실제 네트워크 트랜잭션, mainnet RPC, 유동성 이동, contract upgrade, owner 권한 변경은 사용자 명시 승인 없이는 실행하지 않는다.
- 스마트컨트랙트 변경은 단위 테스트, 시나리오 테스트, 정적 분석, 배포 스크립트 dry-run 계획이 없으면 완료로 보지 않는다.
- 가격, slippage, routing, fee, pool invariant, permit/signature, chain-id 검증은 리뷰 우선순위 상위 항목이다.
- UI는 사용자가 서명하는 자산, 체인, 금액, 수수료, slippage, 승인 범위를 명확하게 보여줘야 한다.

## 빠른 읽기 순서

1. `AGENTS.md`
2. `STATE.md`
3. `README.md`
4. `docs/project-guide.md`
5. `docs/architecture.md`
6. `docs/security-model.md`

## Context Map

- **[현재 상태](./STATE.md)** - 최근 변경, 완료 작업, 다음 작업 확인.
- **[프로젝트 안내](./README.md)** - 설치, 실행, 구조 요약.
- **[프로젝트 가이드](./docs/project-guide.md)** - DEX 범위, 확정/미정 사항, 우선순위.
- **[아키텍처 초안](./docs/architecture.md)** - apps/packages/infra 경계와 데이터 흐름.
- **[보안 모델](./docs/security-model.md)** - wallet, contract, API, indexer 보안 기준.
- **[로컬/CI 실행 가이드](./docs/local-dev-ci-guide.md)** - local/develop/production 경계와 Docker 개발 루프.
- **[구현 작업](./agents/executor-agent.md)** - 코드/문서/설정 변경 시.
- **[조사 작업](./agents/researcher-agent.md)** - 기술 조사, 중복 확인, 근거 수집 시.
- **[리뷰 작업](./agents/reviewer-agent.md)** - 리스크, 회귀, 테스트 누락 점검 시.
- **[Codex Layer](./.codex/)** - Codex workflow/check/subagent prompt guide.
- **[Claude Layer](./.claude/)** - Claude skills, commands, hooks, subagents.

## 사용자 확인이 필요한 상황

- 실제 체인 RPC, wallet private key, secret, API key가 필요한 경우
- mainnet/testnet contract deploy, upgrade, ownership transfer, liquidity movement가 필요한 경우
- 데이터베이스 볼륨 삭제, `docker compose down -v`, chain state reset이 필요한 경우
- 의존성 대규모 추가, 프레임워크 교체, 모노레포 구조 변경이 필요한 경우
- DEX 수수료, 토큰 상장 기준, 지원 체인, custody 범위 등 비즈니스 결정이 필요한 경우

## 문서화 원칙

- 기능, 스크립트, 설정을 추가하면 관련 문서를 함께 갱신한다.
- 중요한 결정은 `docs/project-guide.md` 또는 별도 `docs/*.md`에 남긴다.
- 세션 종료 전 `STATE.md`에 완료/검증/다음 작업을 기록한다.
