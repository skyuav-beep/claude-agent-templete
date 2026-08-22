---
name: dev-start
description: 개발 세션을 재개하거나 PC를 켜고 프로젝트 작업을 이어갈 때 사용한다. 상태 브리핑, 로컬 컨테이너 기동, hot reload 점검이 목적이다.
---

# Dev Start Skill

1. `docs/local-dev-ci-guide.md`의 개발 세션 부트스트랩을 읽는다.
2. `STATE.md`의 최근 완료와 다음 작업을 요약한다.
3. 가이드가 지정한 local 개발 서비스를 `up -d`로 기동한다.
4. hot reload와 핵심 UI·로직 점검 결과를 보고한다.
5. `STATE.md`의 다음 작업부터 이어간다.

상세 호환 절차는 `.codex/workflows/dev-start.md`를 따른다.
