# 개발 세션 부트스트랩

기존 프로젝트에서 개발을 재개할 때, 작업 상태 브리핑 → dev 컨테이너 기동 → hot reload·UI/로직 점검 준비를 순서대로 수행한다.

## 실행 방법

1. `docs/local-dev-ci-guide.md §2.0`(개발 세션 부트스트랩)을 읽는다. 절차의 정본이다.
2. 3단계를 순서대로 수행한다.
   - 상태 브리핑: `STATE.md`의 `## 이번 세션에서 완료한 작업` + `## 다음 작업`을 읽고 직전 지점과 이어서 할 일을 요약한다.
   - dev 컨테이너 기동: `docker compose up -d`(항상, 멱등) → `docker compose ps` → `logs`로 watcher 확인.
   - UI/로직 점검 준비: 서비스 URL과 (있으면) preview HTML 경로 안내 + hot reload 반영 확인.
3. 점검 후 `STATE.md ## 다음 작업`부터 이어간다.

## 인수 처리

- `$ARGUMENTS`에 특정 서비스명/포트/작업 지점이 있으면 그 범위로 좁혀서 기동·점검한다.
- `$ARGUMENTS`가 비어 있으면 `STATE.md`의 "다음 작업" 기준으로 진행한다.

## 진행 규칙

- 컨테이너 기동은 항상 `docker compose up -d`(멱등). 세션 시작을 이유로 rebuild하지 않는다(§2.4).
- 실제 명령·서비스명·포트는 `AGENTS.md ### Operational Commands`에서 치환한다. 미정이면 사용자에게 확인한다.
