# Stack Upgrade Workflow

라이브러리·패키지·런타임·Docker 이미지·개발 인프라의 버전을 점검하거나 업그레이드할 때 따른다.

## 절차

1. `AGENTS.md`, `CLAUDE.md`의 커뮤니케이션·답변 정책, `STATE.md`, `docs/project-guide.md`, 하위 `AGENTS.md`와 관련 `docs/`를 읽는다.
2. 사용자 요청에서 점검 대상, 업데이트 범위, 제외 범위, 보안/호환성 우선순위를 분리한다.
3. package manager, manifest/lockfile, 런타임, Docker/Compose/base image, CI·IaC·DB 도구를 읽기 전용으로 조사한다.
4. 현재 버전·후보 버전·breaking change·peer/runtime 요구사항·보안 영향·재빌드 필요 여부를 정리한다.
5. 업데이트 순서, 검증 명령, 롤백 지점과 예상 변경 파일을 제시하고 `docs/approval-workflow.md` 3단계 승인을 기다린다.
6. 승인 후 작은 단위로 업데이트하고 lockfile, 타입/빌드, 관련 테스트, 컨테이너 기동·healthcheck·smoke를 검증한다.
7. 인증·권한·결제·정산·migration 영향이 있으면 해당 무결성·보안 검증을 먼저 수행한다.
8. `STATE.md`에 변경 버전, 검증 결과, 보류 항목과 전체 CI 대기열을 기록한다.

## 범위 판단

- Node/Python/Go/Rust 등은 실제 프로젝트 package manager와 manifest/lockfile을 우선 확인한다.
- Docker는 `Dockerfile*`, Compose 파일, base image tag/digest, healthcheck와 hot reload 모델을 확인한다.
- major 업데이트는 최신이라는 이유만으로 적용하지 않고 지원 범위, 변경량, 보안 패치와 롤백 가능성을 비교한다.
- 네트워크 조회가 필요하면 출처와 조회 시점을 보고한다.

## 안전 경계

- 승인 전 파일 수정, 설치, lockfile 변경, migration을 실행하지 않는다.
- `staging`/`production` migration·배포·release workflow는 사용자 수동 영역이다.
- `docker compose down -v`, 데이터 삭제, 강제 push, 비밀 파일 변경은 사용자 확인 없이는 실행하지 않는다.
- 테스트 실패 원인이 불명확하면 추가 업그레이드를 중단하고 원인과 선택지를 보고한다.

## 산출물

- 버전 비교와 근거
- 영향·위험도·업데이트 순서
- 실제 변경과 검증 결과
- 남은 리스크와 롤백/후속 작업
