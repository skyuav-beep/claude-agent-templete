# STATE.md

## 현재 상태

- `dexchange` 프로젝트가 `/home/skyua/projects/claude-agent-template/dexchange`에 생성됐다.
- Claude/Codex 에이전트 템플릿 v1.1.0이 설치됐다.
- 현재 단계는 실제 DEX 앱 구현 전의 초기 운영/문서/모노레포 골격 설정이다.
- runtime app, contract framework, indexer framework는 아직 확정하지 않았다.

## 이번 세션에서 완료한 작업

- 에이전트 레이어 설치: `.claude/`, `.codex/`, `agents/`, `templates/`, `docs/`, `DESIGN.md`, `designs/`.
- 프로젝트 전용 운영 문서 작성: `AGENTS.md`, `CLAUDE.md`, `README.md`.
- DEX 초기 기준 문서 작성: `docs/project-guide.md`, `docs/architecture.md`, `docs/security-model.md`.
- 기본 모노레포 골격 추가: `apps/web`, `apps/indexer`, `packages/contracts`, `packages/sdk`, `packages/shared`, `infra`.
- 기본 설정 추가: `package.json`, `pnpm-workspace.yaml`, `.gitignore`, `.env.example`, `docker-compose.yml`, 검증 스크립트.

## 확정 사항

- 프로젝트명: `dexchange`
- 프로젝트 목적: 신규 DEX 거래소 개발
- 개발 경계: 실제 체인/실자금/mainnet 작업은 사용자 명시 승인 전 금지
- 기본 환경 호칭: `local`, `develop`, `production`
- 기본 패키지 매니저: pnpm
- 로컬 개발 기준: Docker Compose + hot reload 가능한 구조를 우선한다

## 미정 사항

- AMM 모델: constant product, concentrated liquidity, stable swap 중 선택 필요
- 지원 체인과 RPC 공급자
- contract framework: Foundry, Hardhat, 또는 병행 사용 여부
- frontend framework: Next.js 확정 여부
- backend/API 방식: REST, GraphQL, tRPC, direct indexer query 중 선택 필요
- database: PostgreSQL 확정 여부와 schema 설계
- wallet 지원 범위: EIP-1193, WalletConnect, account abstraction 여부
- 토큰 상장 정책, 수수료 정책, slippage 기본값

## 다음 작업

1. `templates/startup-checklist.md` 기준으로 프로젝트 intake를 진행해 미정 사항을 확정한다.
2. AMM 모델과 지원 체인을 먼저 결정한다.
3. frontend/contract/indexer 기술 스택을 확정하고 `package.json` scripts를 실제 명령으로 교체한다.
4. `packages/contracts`에 contract framework를 설치하고 local test chain 기준 MVP contract 범위를 정의한다.
5. `apps/web`에 지갑 연결 + swap mock UI부터 구현한다.

## 검증 기록

- 대기: `pnpm check`
- 대기: `node scripts/check-docs.mjs`
