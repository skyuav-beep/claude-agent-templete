# 프로젝트 지식 관리 가이드

이 문서는 사용자 입력, 개념·백서, 제품 요구사항, 설계, 개발계획을 시간순과 주제별로
보관하고 다시 찾기 위한 공통 운영 기준이다. 실제 프로젝트에서는 프로젝트 루트의
로컬 문서를 먼저 적용하고, 이 문서는 공통 기본값으로 사용한다.

## 문서 영역

```text
docs/
├── 00-inbox/          # 원문 입력, 회의 메모, 아직 분류하지 않은 자료
├── 01-concept/        # 문제 정의, 핵심 개념, 용어집, 비전
├── 02-whitepaper/     # 백서, 시장·기술 배경, 연구·근거 자료
├── 03-product/        # 사용자, 요구사항, 기능, 정책, 성공 기준
├── 04-design/         # UX/UI, 데이터 흐름, 상태, 인터페이스 설계
├── 05-development/    # 아키텍처, 개발계획, 로드맵, 작업 분해
├── 06-operations/     # 배포, 운영, 보안, 모니터링, 장애 대응
├── 07-decisions/      # ADR 및 중요한 선택의 기록
├── 90-reports/        # 조사·리뷰·검증·분석 보고서
└── 99-archive/        # 폐기·대체·이전 문서
```

`docs/project-guide.md`는 현재 프로젝트의 확정 기준을 모은 정본으로 유지한다.
분류 폴더의 원문과 결정 기록을 대신하지 않으며, 확정된 내용을 요약하고 링크한다.

## 시간순과 내용별 분류

- 내용별 탐색은 폴더로 한다. 문서 하나는 가장 핵심적인 주제 폴더 하나에 둔다.
- 시간순 탐색은 파일명의 날짜와 `created`, `updated` 메타데이터로 한다.
- 여러 주제를 다루면 주제를 섞어 하나의 거대 문서를 만들지 말고 관련 문서 링크로 연결한다.
- `00-inbox`는 임시 보관함이다. 정식 분류가 끝난 자료는 반드시 이동한다.
- 문서가 대체되면 삭제하지 않고 `99-archive`로 이동하거나 상태를 `superseded`로 바꾼다.

## 파일명 규칙

```text
YYYY-MM-DD__문서유형__짧은-kebab-case-제목.md
```

예시:

```text
2026-08-21__concept__project-overview.md
2026-08-21__whitepaper__technical-background.md
2026-08-22__development__milestone-plan.md
2026-08-22__decision__runtime-selection.md
```

날짜는 문서를 처음 확정한 날짜를 사용한다. 내용이 크게 바뀌어도 파일명을 매번
바꾸지 말고 `updated`를 갱신한다. 날짜가 중요한 이벤트 기록은 새 문서로 만든다.

## 공통 메타데이터

```yaml
---
id: DOC-20260821-001
type: concept
status: draft
created: 2026-08-21
updated: 2026-08-21
source: user-input
related: []
---
```

- `id`: 문서 간 연결에 사용할 불변 식별자. `<접두사>-YYYYMMDD-NNN` 형식이며 접두사는 유형을 따른다.
  `DOC`(inbox 원문), `CON`(concept), `WP`(whitepaper), `PRD`(product), `DSN`(design), `DEV`(development), `OPS`(operations), `DEC`(decision), `RPT`(report)
- `type`: `concept`, `whitepaper`, `product`, `design`, `development`, `operations`, `decision`, `report`
- `status`: `inbox`, `draft`, `review`, `approved`, `superseded`, `archived`
- `source`: `user-input`, `meeting`, `research`, `planning`, `implementation`, `decision` 중 하나 또는 설명
- `related`: 관련 문서 ID 또는 상대 경로 목록

## 입력에서 정식 문서로 승격하는 흐름

1. 사용자가 제공한 원문을 가능한 한 의미를 바꾸지 않고 `00-inbox`에 기록한다.
2. 핵심 주장, 결정, 요구사항, 미정 사항을 분리한다.
3. 주제 폴더로 문서를 이동하고 파일명과 메타데이터를 부여한다.
4. 근거가 필요한 내용은 출처와 확인 날짜를 기록한다.
5. 확정된 내용은 `docs/project-guide.md` 또는 개발계획에 링크해 반영한다.
6. 변경·대체 시 관련 문서의 `updated`, 상태, 링크를 함께 갱신한다.

## 개발계획 연결 규칙

개발계획에는 반드시 다음을 연결한다.

- 어떤 개념 또는 요구사항에서 시작했는가
- 어떤 설계·결정 문서가 구현 기준인가
- 마일스톤별 산출물과 완료 조건은 무엇인가
- 검증 방법과 미결정 사항은 무엇인가

문서 색인은 프로젝트가 정한 방식을 따른다. 이 템플릿은 `node scripts/build-docs-index.mjs`
가 생성하는 `docs/docs-index.json`을 사용하며, 문서 추가 후 `--check`와 재생성을 수행한다.
자동 색인기가 없는 소비 프로젝트는 자체 `docs/INDEX.md` 또는 동등한 색인 파일을 정하고
문서 추가 시 갱신한다.
