# Architecture - dexchange

## 목표

DEX를 `web`, `contracts`, `indexer`, `sdk`, `shared`, `infra`로 분리해 각 영역의 책임을 명확하게 유지한다.

## 시스템 경계

- `apps/web`: 사용자 지갑 연결, swap/liquidity UI, transaction 상태 표시.
- `apps/indexer`: contract event 수집, 정규화, 조회용 저장.
- `packages/contracts`: AMM, factory, router, token fixture, deployment scripts.
- `packages/sdk`: contract ABI binding, quote helper, API client, chain config.
- `packages/shared`: shared domain types, constants, formatting helpers.
- `infra`: local database, redis, local chain, monitoring, docker compose.

## 기본 데이터 흐름

1. 사용자가 `apps/web`에서 wallet을 연결한다.
2. web은 `packages/sdk`를 통해 chain config, token list, quote helper를 호출한다.
3. swap 실행 전 web은 chain-id, token, amount, slippage, fee, allowance를 보여준다.
4. 사용자가 wallet에서 서명하면 transaction hash를 추적한다.
5. `apps/indexer`는 contract event를 수집해 database에 저장한다.
6. web은 indexer/API 조회로 pool, swap, position 상태를 갱신한다.

## 개발 단계

### Phase 0 - Skeleton

- 현재 단계.
- 에이전트 레이어, 문서, monorepo, local infra 초안만 준비한다.

### Phase 1 - Local MVP

- local chain
- sample ERC-20 token
- AMM contract
- swap mock UI
- transaction state

### Phase 2 - Indexer MVP

- event schema
- replay fixture
- pool/swap query
- transaction history

### Phase 3 - Testnet 후보

- testnet deploy plan
- RPC/key management
- monitoring
- external audit checklist

## 의존 방향

- `apps/web` -> `packages/sdk` -> `packages/shared`
- `apps/indexer` -> `packages/sdk` -> `packages/shared`
- `packages/contracts`는 runtime app에 의존하지 않는다.
- `packages/shared`는 app이나 infra에 의존하지 않는다.

## 금지

- UI에서 private key를 직접 다루지 않는다.
- contract address, chain-id, token decimals를 하드코딩하지 않는다. `packages/sdk` 또는 config로 이동한다.
- indexer 저장 데이터를 chain source of truth보다 우선하지 않는다.
