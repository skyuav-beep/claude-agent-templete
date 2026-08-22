---
description: "라이브러리·패키지·런타임·Docker·개발 인프라 버전을 점검하고 안전한 업그레이드 계획을 세운다"
argument-hint: "[점검 또는 업그레이드 대상]"
---

# 기술 스택 업그레이드

`.claude/skills/stack-upgrade/SKILL.md`의 절차를 적용한다.

1. `$ARGUMENTS`가 있으면 점검 대상과 우선순위로 사용한다.
2. 없으면 프로젝트 전체의 라이브러리·런타임·Docker·개발 인프라 버전을 범위로 삼는다.
3. 현재 버전과 후보 버전, 호환성·보안·breaking change, 검증 계획을 먼저 보고한다.
4. 승인 전에는 파일 수정·설치·lockfile 변경·migration을 실행하지 않는다.

승인 절차와 로컬/원격 실행 경계는 `docs/approval-workflow.md`와 `docs/local-dev-ci-guide.md`를 따른다.
