---
name: stack-upgrade
description: "라이브러리·패키지·런타임·Docker 이미지·개발 인프라의 버전 점검, 호환성 분석, 안전한 업그레이드 작업에 활성화 (stack upgrade, stack-upgrade, 라이브러리 버전 체크, 라이브러리 업데이트, 의존성 업데이트, 패키지 버전 확인, 개발환경 최신화, Docker 이미지 업데이트, base image 업데이트, 개발 인프라 버전 점검, 기술 스택 업그레이드)"
---

# 기술 스택 업그레이드

라이브러리와 개발 인프라의 현재 버전을 조사하고, 업데이트 위험을 분석한 뒤 승인된 범위만 단계적으로 적용한다.

## 실행 방법

1. `AGENTS.md`, `CLAUDE.md`의 응답 정책, `STATE.md`, `docs/project-guide.md`, 하위 `AGENTS.md`와 관련 `docs/`를 읽는다.
2. 대상과 범위를 분리한다: 패키지/라이브러리, 런타임, Docker/Compose/base image, DB·ORM·migration, CI 도구, 보안 취약점.
3. package manager와 manifest/lockfile을 탐색하고 프로젝트가 정의한 버전 확인 명령을 우선 사용한다. 없는 경우에만 해당 생태계의 표준 명령을 선택한다.
4. 현재 버전, 후보 버전, 직접·간접 의존성, breaking change, peer/runtime 요구사항, 보안 영향, Docker 재빌드 필요 여부를 보고한다.
5. 업데이트 순서와 검증 계획을 제시하고, 승인 전에는 파일 수정·설치·lockfile 변경·migration을 실행하지 않는다.
6. 승인 후 작은 단위로 업데이트하고 각 단위마다 lockfile, 타입/빌드, 관련 테스트, 컨테이너 기동과 smoke를 검증한다.

## 탐색 기준

- Node: `package.json`, lockfile, workspace 설정, `npm outdated`/`pnpm outdated`/`yarn outdated` 등 실제 package manager에 맞는 명령.
- Python: `pyproject.toml`, lockfile 또는 requirements 파일, 프로젝트가 정의한 `uv`/`poetry`/`pip` 명령.
- Go/Rust/기타: module manifest와 lockfile, 프로젝트의 공식 검사 명령.
- 컨테이너: `Dockerfile*`, Compose 파일, base image tag/digest, healthcheck, 개발용 bind mount와 hot reload.
- 인프라: IaC·CI 설정·런타임 버전·ORM/DB 도구·코드 생성 도구.

최신 버전이라는 이유만으로 major 업데이트를 선택하지 않는다. 안정 릴리스, 프로젝트 지원 범위, 보안 패치, 변경량과 롤백 가능성을 함께 비교한다. 네트워크 조회가 필요한 경우 출처와 조회 시점을 결과에 남긴다.

## 안전 경계

- `staging`/`production` 배포와 migration, GitHub Actions release/배포는 실행하지 않고 사용자에게 인계한다.
- `docker compose down -v`, 데이터 삭제, 강제 push, 비밀 파일 변경은 사용자 확인 없이는 실행하지 않는다.
- migration이나 인증·권한·결제·정산 영역에 영향을 주면 관련 무결성·보안 검증을 전체 CI보다 먼저 수행한다.
- 테스트 실패가 코드·환경·업그레이드 충돌 중 무엇인지 불명확하면 업데이트를 더 진행하지 않고 원인과 선택지를 보고한다.

## 산출물

- 현재/후보 버전과 업데이트 근거
- 영향 범위와 breaking change 위험도
- 승인된 변경 목록과 재빌드·migration 판단
- 검증 명령과 결과
- 보류 항목, 롤백 지점, 남은 리스크

## 승인 절차 연결

이 흐름은 `docs/approval-workflow.md`의 1~6단계를 따른다. 조사와 계획은 읽기 전용으로 수행하고, 3단계 명시 승인 후에만 업데이트와 로컬 검증을 실행한다. 작업 종료 시 `STATE.md`와 전체 CI 대기열을 기록한다.
