# CLAUDE.md

에이전트 헌법이다. 운영 프로세스와 라우팅은 `AGENTS.md`를 따른다.

## Core Philosophy

1. DEX는 사용자 자산과 직접 연결될 수 있으므로 보안과 검증을 기능 속도보다 우선한다.
2. 확인되지 않은 체인 동작, 토큰 정책, 수수료 정책, 서명 정책을 사실처럼 단정하지 않는다.
3. 루트 문서는 짧게 유지하고, 상세 기준은 `docs/`와 `agents/`에 위임한다.
4. 로컬에서 재현 가능한 검증을 남긴 뒤 다음 작업자가 이어받을 수 있게 한다.

## Golden Rules

- 사용자 요청 없이 파괴적 명령을 실행하지 않는다.
- 실제 private key, mnemonic, seed phrase, production secret은 절대 파일에 쓰지 않는다.
- 실제 자금 이동, mainnet 트랜잭션, contract deploy/upgrade, owner 권한 변경은 사용자 명시 승인 없이 실행하지 않는다.
- agent 자동 실행 범위는 `local` Docker Desktop, local test chain, local migration, local 검증, 로컬 commit까지다.
- `develop`/`production` 배포, 원격 migration, 원격 contract deploy, CI/PR/push는 사용자 요청 시에만 수행하거나 인계한다.
- 스마트컨트랙트 변경은 테스트와 보안 검증 계획 없이 완료로 보지 않는다.
- UI 변경은 서명 전 정보 명확성, slippage/fee/chain/token 표시, 실패 상태를 우선 검토한다.
- 작업이 끝나면 `STATE.md`를 갱신한다.

## 커뮤니케이션

- 모든 설명과 진행 보고는 한국어로 작성한다.
- 코드, 명령어, 경로, 식별자는 원문 그대로 유지한다.
- 결론과 실행 결과를 먼저 말하고, 미정 사항은 명확히 분리한다.

## Architecture Rules

- 기본 구조는 모노레포다.
- `apps/web`은 사용자 화면과 wallet 연결 UI를 담당한다.
- `apps/indexer`는 온체인 이벤트 수집, 정규화, 조회 최적화를 담당한다.
- `packages/contracts`는 스마트컨트랙트와 배포 스크립트를 담당한다.
- `packages/sdk`는 contract/API client와 typed helper를 담당한다.
- `packages/shared`는 공통 타입, 상수, 유틸만 담당한다.
- `infra`는 Docker, local chain, database, observability 같은 실행 인프라를 담당한다.
- feature 코드가 다른 feature를 직접 의존하지 않도록 shared/package 경계를 먼저 확인한다.

## Naming Conventions

- 파일명과 디렉터리명은 kebab-case를 기본으로 한다.
- TypeScript 패키지명은 `@dexchange/<name>` 형식을 사용한다.
- 환경명은 `local`, `develop`, `production`만 사용한다.
- 체인, 토큰, pool, route, swap, liquidity 같은 도메인 용어는 코드와 문서에서 일관되게 사용한다.

## Test Expectations

- 문서/구조 변경: `pnpm check`
- 프론트엔드 기능: unit test + 핵심 흐름 e2e 계획
- API/indexer 기능: unit test + fixture 기반 event replay 테스트
- contract 기능: unit/fuzz/invariant 테스트, static analysis 계획
- wallet/signature 기능: chain-id, signer, approval scope, replay 방지 테스트

## Repo Map

- `AGENTS.md` - 운영 규칙, 작업 경계, Context Map
- `STATE.md` - 현재 상태와 다음 작업
- `README.md` - 프로젝트 소개와 실행 방법
- `docs/project-guide.md` - 프로젝트 기준 문서
- `docs/architecture.md` - 아키텍처 초안
- `docs/security-model.md` - DEX 보안 기준
- `apps/web` - DEX web app 자리
- `apps/indexer` - indexer service 자리
- `packages/contracts` - smart contract package 자리
- `packages/sdk` - SDK/client package 자리
- `packages/shared` - shared types/utils 자리
- `infra` - local infrastructure 자리
- `.claude` - Claude 자동화 레이어
- `.codex` - Codex 실행 절차 레이어
