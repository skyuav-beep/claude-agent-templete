---
name: stack-upgrade
description: 라이브러리, 패키지, 런타임, Docker 이미지, base image, 개발 인프라 버전을 점검하거나 업그레이드할 때 사용한다.
---

# Stack Upgrade Skill

1. manifest·lockfile·runtime·Docker·CI·DB 도구를 읽기 전용으로 조사한다.
2. 현재·후보 버전, breaking change, 보안·호환성 영향을 비교한다.
3. 업데이트 순서·검증·롤백 계획을 제시하고 승인받는다.
4. 승인 후 작은 단위로 업데이트하고 lockfile·타입·빌드·테스트·healthcheck를 검증한다.
5. `STATE.md`에 버전·검증·보류 항목을 기록한다.

상세 절차는 `.codex/workflows/stack-upgrade.md`를 따른다.
