# Security Model - dexchange

## 원칙

- DEX 보안의 기본 단위는 사용자 자산 보호다.
- 자동화는 `local`에서만 실행한다.
- private key, mnemonic, seed phrase, production secret은 저장소에 기록하지 않는다.

## Wallet

- 사용자는 wallet provider를 통해서만 서명한다.
- UI는 서명 전 chain, token, amount, fee, slippage, approval scope를 보여준다.
- wrong-chain 상태에서는 transaction 실행을 막는다.
- approval은 가능한 최소 범위를 우선한다.

## Smart Contracts

- contract 변경은 테스트 없이 merge 대상이 될 수 없다.
- pool invariant, fee accounting, rounding, reentrancy, oracle/price manipulation, permit/signature replay를 우선 검토한다.
- owner/admin 권한은 명시적으로 문서화한다.
- upgrade 가능 contract를 채택하면 upgrade 권한, timelock, pause 정책을 별도 문서로 둔다.

## API and Indexer

- indexer 데이터는 조회 최적화용이며 chain source of truth를 대체하지 않는다.
- event replay가 가능해야 한다.
- API는 token address, chain-id, amount, pagination input을 검증한다.
- 외부 RPC 실패, reorg, duplicate event, partial sync 상태를 표현한다.

## Secrets

- `.env.example`에는 placeholder만 둔다.
- `.env`, `.env.local`, key 파일은 git에 포함하지 않는다.
- production secret은 agent가 요청하거나 생성하지 않는다.

## Deployment Boundary

- local chain deploy: agent 자동 가능
- testnet deploy: 사용자 명시 승인 필요
- mainnet deploy: 사용자 수동 인계
- contract upgrade: 사용자 수동 인계
- 실제 liquidity movement: 사용자 수동 인계

## Review Checklist

- chain-id 검증이 있는가
- signer/address 검증이 있는가
- token decimals 처리가 정확한가
- slippage와 price impact가 표시되는가
- allowance 범위가 명확한가
- transaction pending/failed/reverted 상태가 처리되는가
- event replay와 reorg 대응 계획이 있는가
- private key나 secret이 파일에 포함되지 않았는가
