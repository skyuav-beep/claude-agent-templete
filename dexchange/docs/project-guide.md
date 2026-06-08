# Project Guide - dexchange

## 1. Project Summary

- 한 줄 설명: 지갑 연결, 토큰 스왑, 유동성 공급, 풀/거래 내역 조회를 제공하는 신규 DEX 거래소.
- 핵심 목표: 실제 구현 전 에이전트 운영 규칙과 안전한 개발 골격을 만든다.
- 주요 사용자: 암호화폐 지갑을 보유한 거래 사용자, 유동성 공급자, 운영자.
- 이번 단계 범위: 에이전트 설정, 문서, 모노레포 구조, local infra 초안.

## 2. Confirmed Decisions

- 프로젝트명: `dexchange`
- 기본 개발 구조: monorepo
- 에이전트 레이어: Claude/Codex 템플릿 v1.1.0 설치
- 패키지 매니저: pnpm
- local infra 초안: PostgreSQL, Redis
- 보안 경계: private key와 실제 자금 작업은 사용자 명시 승인 전 금지

## 3. Open Questions

- AMM 모델: constant product, concentrated liquidity, stable swap 중 무엇을 MVP로 할지 결정해야 한다.
- 지원 체인: EVM local chain만 먼저 할지, testnet 범위를 포함할지 결정해야 한다.
- contract framework: Foundry, Hardhat, 또는 병행 사용 여부를 결정해야 한다.
- frontend framework: Next.js 사용 여부를 확정해야 한다.
- indexer: 자체 indexer, subgraph, RPC polling, event streaming 중 선택해야 한다.
- API: REST, GraphQL, tRPC, direct SDK 중 선택해야 한다.
- database schema: pool, token, swap, position, event 저장 기준을 정해야 한다.
- wallet: EIP-1193, WalletConnect, account abstraction 지원 범위를 정해야 한다.
- token policy: 토큰 상장 기준, allowlist/denylist, 위험 토큰 표시 기준을 정해야 한다.
- fee/slippage: 수수료 구조와 기본 slippage를 정해야 한다.

## 4. Scope and Priorities

- Must: 지갑 연결, 체인 확인, 토큰 선택, swap quote, swap 실행 전 확인, transaction 상태 표시, pool 조회.
- Should: 유동성 공급/회수, 거래 내역, indexer 기반 빠른 조회, 가격 영향 표시.
- Won't for now: mainnet 배포, 실제 유동성 운영, cross-chain swap, leverage, lending, custodial wallet.

## 5. UI/UX Guidelines

- 톤: 거래 화면은 조용하고 명확해야 하며, 서명 전 사용자가 승인 범위를 바로 이해할 수 있어야 한다.
- 핵심 흐름: wallet connect -> chain check -> token/amount input -> quote -> review -> sign -> transaction status.
- 필수 상태: loading, empty, error, disabled, wallet-not-connected, wrong-chain, insufficient-balance, high-slippage, tx-pending, tx-failed.
- 접근성: 키보드 탐색, 명확한 focus state, WCAG AA 색상 대비를 기본으로 한다.
- 콘텐츠 톤: 자산 이동과 위험 안내는 짧고 직접적으로 작성한다.

## 6. Responsive Rules

- 우선순위: 모바일과 데스크톱 동시 고려. swap은 모바일 우선, 운영/모니터링은 데스크톱 우선.
- breakpoint: sm 640, md 768, lg 1024, xl 1280을 기본값으로 검토한다.
- 모바일: 단일 주요 행동, 하단 CTA, signing state 명확화.
- 데스크톱: 차트, 풀 정보, 거래 내역을 보조 패널로 확장한다.

## 7. Component Rules

- `apps/web`의 feature는 swap, pool, wallet, transaction, settings 단위로 나눈다.
- 두 feature 이상에서 재사용하는 UI/type/util은 `packages/shared` 또는 `packages/sdk`로 승격한다.
- amount input, token selector, wallet button, chain switcher, transaction modal은 상태와 실패 케이스를 먼저 정의한다.

## 7-1. Repository and Directory Rules

- `apps/web`: DEX web app
- `apps/indexer`: on-chain event indexer
- `packages/contracts`: smart contracts and deploy scripts
- `packages/sdk`: typed client, contract bindings, quote helpers
- `packages/shared`: shared types, constants, utilities
- `infra`: Docker Compose, local chain, observability

## 7-2. File Split Rules

- 한 파일은 한 책임만 갖는다.
- 250줄 초과, 테스트 단위 분리, 외부 재사용 발생 시 파일 분리를 검토한다.
- contract, routing, pricing, signature 로직은 UI 파일 안에 두지 않는다.

## 8. Tech Stack and Commands

- package manager: pnpm 10
- runtime: Node.js 22 이상
- local infra: Docker Compose
- 현재 검증: `pnpm check`
- 개발 서버: `pnpm dev`는 runtime app 확정 후 실제 명령으로 교체
- 테스트: `pnpm test`는 현재 skeleton check, 이후 package별 테스트로 교체
- 빌드: `pnpm build`는 runtime app 확정 후 실제 명령으로 교체

## 8-1. I18n Policy

- 기본 locale: ko
- 초기 범위: 한국어 단일
- 향후 글로벌 출시 시 en fallback과 locale routing을 별도 결정한다.

## 9. Constraints

- 실제 private key, mnemonic, production secret은 저장소에 기록하지 않는다.
- mainnet, 실자금, 원격 contract deploy는 자동화하지 않는다.
- 보안 결정이 필요한 항목은 코드보다 문서 결정을 먼저 남긴다.

## 10. Development Rules

- 구현 우선순위: 보안 정확성 > 테스트 가능성 > UX 완성도 > 속도.
- contract 변경은 테스트와 보안 검증 계획을 동반한다.
- wallet/signature 변경은 chain-id, signer, approval scope, replay 방지 검증을 포함한다.
- indexer 변경은 fixture 기반 event replay 테스트를 포함한다.
- UI 변경은 서명 전 정보, 실패 상태, wrong-chain 상태를 포함한다.

## 11. Initial Backlog

1. startup intake로 AMM 모델, 지원 체인, 기술 스택 확정.
2. contract framework 선택 후 `packages/contracts` 초기화.
3. `apps/web` swap mock UI와 wallet connect 흐름 구현.
4. local chain + sample token + sample pool fixture 구성.
5. indexer event schema와 replay 테스트 초안 작성.

## 12. Change Policy

- 요구사항이 바뀌면 이 문서를 먼저 갱신한다.
- 실제 구현 방식이 이 문서와 다르면 `AGENTS.md` 또는 관련 `docs/*.md` 업데이트를 제안한다.
