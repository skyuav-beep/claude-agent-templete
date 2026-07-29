---
description: "작업 설명을 feature/bugfix/refactor/business-logic/review로 분류해 해당 흐름을 시작한다"
argument-hint: "[작업 설명]"
---

# 작업 요청 유형 라우터

사용자의 작업 설명을 분석해서 적절한 요청 유형으로 안내한다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/` 경로는 프로젝트 루트 기준이다. 프로젝트에 해당 파일이 없으면 `rules/` 아래 같은 경로를 읽는다(공통 템플릿을 `rules/` symlink로 연결한 프로젝트).

## 분류 기준

`agents/main-agent.md`의 작업 유형 식별 가이드를 따른다:

- Feature: "추가하자", "만들자", 신규 화면/엔드포인트/명령 -> `/feature`
- Bugfix: "안 된다", "에러 난다", 재현 절차 동반 -> `/bugfix`
- Refactor: "정리하자", "구조만", 동작 불변 조건 동반 -> `/refactor`
- Business Logic: 시나리오/권한/경계값 언급, 정책 변경 -> `/business-logic`
- Review: "검토해줘", PR/변경 범위 지정 -> `/review`

## 실행 방법

1. `$ARGUMENTS`가 있으면 내용을 분석해서 위 5종 중 하나로 분류한다.
2. 분류가 명확하면 해당 유형의 질문 흐름을 바로 시작한다.
   - 해당 `templates/*-request.md`를 읽고 섹션별 대화형 질문을 진행한다.
3. 분류가 애매하면 사용자에게 한 줄로 확인한 뒤 진행한다.
4. 복합 요청이면 주작업을 정해 그 흐름을 우선 진행하고, 보조 유형 항목은 추가로 점검한다.

## 인수가 없을 때

`$ARGUMENTS`가 비어 있으면 아래 목록을 표시하고 선택을 요청한다:

```
작업 유형을 선택하거나, 작업 내용을 설명해 주세요:

- feature: 신규 기능 추가
- bugfix: 버그 수정
- refactor: 구조 개선 (동작 불변)
- business-logic: 비즈니스 로직 변경
- review: 코드 리뷰
```

## 완료 후

해당 유형의 `templates/*-request.md` 구조에 맞는 마크다운 블록을 출력한다.
