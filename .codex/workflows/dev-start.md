# Dev Session Bootstrap Workflow

PC를 켜고 개발을 재개할 때 이 절차를 따른다.

## 절차

1. `docs/local-dev-ci-guide.md §2.0`(개발 세션 부트스트랩)을 읽는다. 절차의 정본이다.
2. 상태 브리핑 — `STATE.md`의 `## 이번 세션에서 완료한 작업`과 `## 다음 작업`을 읽고 직전 지점과 이어서 할 일을 요약한다.
3. dev 컨테이너 기동 — `docker compose up -d`(항상, 멱등) → `docker compose ps` 확인 → `docker compose logs -f <svc>`로 watcher 기동(HMR/reload) 확인. 컨테이너 모델·폴링·재빌드 판단은 §2.1~§2.4.
4. UI/로직 점검 준비 — 서비스 URL(`localhost:<port>`)과 (있으면) preview HTML 경로 안내 + 트리비얼 변경으로 hot reload 반영 확인.
5. 점검 후 `STATE.md ## 다음 작업`부터 개발을 이어간다.

## 정책

- 컨테이너 기동은 항상 `docker compose up -d`(멱등 — 이미 기동 중이면 재생성 안 함). 세션 시작을 이유로 rebuild하지 않는다(§2.4).
- 모두 로컬 작업이라 agent 자동 실행 범위 안이다. push·CI는 사용자 요청 시, 원격 배포/migration은 사용자 수동(`docs/local-dev-ci-guide.md §1`).
- 실제 명령·서비스명·포트는 `AGENTS.md ### Operational Commands`에서 치환한다.

## 산출물

- 직전 작업 상태 요약
- dev 컨테이너 기동·hot reload 확인 결과
- 이어서 진행할 다음 작업 지점
