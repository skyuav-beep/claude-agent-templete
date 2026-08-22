---
description: "프로젝트의 특정 영역(UI, API, i18n, 라우팅, 폼, 에러, 지식 문서 등) 상세 정보 수집이 필요할 때 활성화 (intake, topic deep-dive)"
---

# 개별 Intake 토픽 수집

프로젝트 특정 영역의 상세 정보를 대화형으로 수집한다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/` 경로는 프로젝트 루트 기준이다. 프로젝트에 해당 파일이 없으면 `rules/` 아래 같은 경로를 읽는다(공통 템플릿을 `rules/` symlink로 연결한 프로젝트).

## 토픽 매핑

- `project` -> `templates/project-intake.md`
- `tech` -> `templates/tech-intake.md`
- `ui` -> `templates/ui-intake.md`
- `responsive` -> `templates/responsive-intake.md`
- `i18n` -> `templates/i18n-intake.md`
- `framework` -> `templates/framework-structure-intake.md`
- `api` -> `templates/api-intake.md`
- `error` -> `templates/error-intake.md`
- `form` -> `templates/form-intake.md`
- `format` -> `templates/format-intake.md`
- `routing` -> `templates/routing-intake.md`
- `qa` -> `templates/qa-intake.md`
- `knowledge` -> `templates/knowledge-entry.md`

## 입력 처리

- 사용자 메시지에서 토픽명을 추출하면 해당 `templates/*-intake.md` 파일을 읽고 질문을 시작한다.
- 토픽이 명시되지 않으면 아래 토픽 목록을 표시하고 선택을 요청한다.
- 여러 토픽이 동시에 언급되면 우선순위가 높아 보이는 것부터 진행하고 나머지는 큐에 둔다.

## 실행 방법

1. 해당 `templates/*-intake.md` 파일을 읽는다.
2. 파일의 질문을 대화형으로 자연스럽게 진행한다.
3. 답변을 받으면 각 항목을 **확정 / 미정 / 제외**로 분류해서 요약한다.

## 토픽 목록

토픽이 명시되지 않았을 때 아래를 표시한다:

```
사용 가능한 토픽:
- project: 프로젝트 목표, 사용자, 범위, 성공 기준
- tech: 프레임워크, 테스트, 배포, 개발 명령
- ui: 화면 톤, 주요 사용자 흐름, 참고 서비스
- responsive: PC/모바일 우선순위, breakpoint별 요구사항
- i18n: 지원 언어, 기본 locale, 번역 범위
- framework: 레포 형태, 디렉터리 분리 기준, 파일 크기 기준
- api: API 데이터 페칭 방식, 명세서, Mocking 전략
- error: Error Boundary, 화면 노출 방식, 로깅 연동
- form: 폼 상태 관리, 검증 스키마
- format: UTC, 화폐, 천 단위 구분자 등 포맷 설정
- routing: URL 상태 동기화, 권한별 라우팅 제어
- qa: 테스트 강제 유무, Git 커밋 컨벤션, CI/CD
- knowledge: 사용자 입력 원문, 개념·백서·요구사항·설계·개발계획 분류
```

## 진행 규칙

- 템플릿 원문의 질문을 그대로 사용하되, 대화형으로 자연스럽게 진행한다.
- 섹션 단위로 끊어서 진행한다.
- 사용자가 "모름"이라고 하면 해당 항목을 **미정**으로 분류하고 넘어간다.

## 승인 절차 연결

- 수집·점검 결과를 문서로 남기거나 코드를 바꾸는 단계부터 `docs/approval-workflow.md`의 6단계 승인 절차를 적용한다. 한 턴에는 한 단계만 진행한다.
- 시작·종료 게이트는 `.claude/CLAUDE.md`, 종료 확인 목록은 `docs/finish-checklist.md`를 적용한다.
