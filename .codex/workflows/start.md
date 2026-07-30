# Start Workflow

새 프로젝트 시작 요청을 받으면 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 입력

- 사용자 프로젝트 설명
- 목표, 범위, UI, 반응형, 기술 스택, 협업/배포 조건

## 절차

1. `templates/startup-checklist.md`를 읽는다.
2. 섹션 1~11을 순서대로 질문한다.
3. 각 섹션 답변을 확정 사항, 미정 사항, 제외 사항으로 분류한다.
4. 결과를 `docs/project-guide-template.md` 구조를 참고해 `docs/project-guide.md`에 옮기고 프로젝트 가이드 정본으로 삼는다.
5. 확정된 실행 명령은 `AGENTS.md ### Operational Commands`에 반영하도록 제안하거나 수정한다.
6. 작업 종료 시 `STATE.md`에 현재 상태와 다음 작업을 기록한다.

## 산출물

- 초기 설정 결과 요약
- 프로젝트 가이드 초안 또는 작성 계획
- 다음 액션
