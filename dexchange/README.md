# dexchange

신규 DEX 거래소 개발 프로젝트다. 현재 저장소는 실제 앱 코드보다 에이전트 운영 규칙, 문서, 모노레포 골격, 로컬 검증 기준을 먼저 갖춘 초기 상태다.

## 현재 포함된 것

- Claude/Codex 에이전트 레이어
- DEX 전용 `AGENTS.md`, `CLAUDE.md`, `STATE.md`
- 프로젝트 가이드, 아키텍처 초안, 보안 모델 문서
- 모노레포 기본 구조
- pnpm 기반 검증 스크립트
- Docker Compose local infra 초안

## 구조

```text
apps/
  web/        # DEX web app 자리
  indexer/    # on-chain event indexer 자리
packages/
  contracts/  # smart contracts 자리
  sdk/        # typed client/sdk 자리
  shared/     # shared types/utils 자리
infra/        # local infra, docker, observability 자리
docs/         # project guides
```

## 명령

```bash
pnpm install
pnpm check
pnpm lint
pnpm test
pnpm dev
docker compose up -d
```

`pnpm dev`와 `pnpm build`는 아직 런타임 앱이 없으므로 안내 메시지만 출력한다. frontend, indexer, contract framework가 확정되면 실제 명령으로 교체한다.

## 보안 경계

- 실제 private key, mnemonic, seed phrase, production secret은 저장소에 기록하지 않는다.
- mainnet 트랜잭션, contract deploy/upgrade, 실제 유동성 이동은 사용자 명시 승인 없이는 실행하지 않는다.
- local test chain과 placeholder 값만 자동화 대상이다.

## 다음 결정

1. AMM 모델
2. 지원 체인
3. contract framework
4. frontend framework
5. indexer/API/database 구조
