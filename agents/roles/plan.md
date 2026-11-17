# plan 역할 (기획)

공통 규칙과 결과 보고 공통 형식은 `agents/roles/README.md`를 따른다.

## 역할

요청을 구현 가능한 요구사항·계획·카드 분해안으로 바꾼다. 코드는 쓰지 않는다.

## 입력

- 카드(목표·범위·완료 조건), 사용자 요청 원문
- intake 답변(`templates/*-intake.md`로 모은 것), 기존 `docs/project-guide.md`, `docs/03-product/`·`docs/05-development/` 문서
- 관련 코드 구조(읽기만)

## 산출물

프로젝트 가이드가 위치를 정했으면 그쪽을 따른다. 없으면 `docs/knowledge-management-guide.md` 관례를 쓴다.

| 산출물 | 기본 위치 | 형식 |
|---|---|---|
| PRD(요구사항) | `docs/03-product/YYYY-MM-DD__product__<slug>.md` | 공통 메타데이터 + 사용자·문제·기능·정책·성공 기준·제외 범위 |
| 개발계획 | `docs/05-development/YYYY-MM-DD__development__<slug>.md` | `templates/development-plan.md` |
| 결정 기록 | `docs/07-decisions/YYYY-MM-DD__decision__<slug>.md` | `templates/decision-record.md`(선택지가 갈린 것만) |
| 카드 분해안 | 결과 보고 안 | 카드마다 제목·역할·의존 카드·수정 파일 범위·완료 조건 |

- 카드 분해안은 같은 파일을 두 카드가 동시에 고치지 않게 나누고, 공유 API·DB는 계약 카드를 먼저 둔다(`docs/claude-codex-collaboration.md ## 작업 카드`).
- 정상·실패·경계값·권한 시나리오를 요구사항에 적는다. 금액·수량이 있으면 `docs/money-quantity-guidelines.md`의 저장 타입·라운딩 위치를 요구사항에 명시한다.

## 완료 조건

- 카드의 완료 조건을 모두 체크했다.
- 품질 게이트 `계획`: 목표·범위·완료 조건이 문서와 카드 분해안에 있고 요청 원문과 맞는다.
- 모든 요구사항이 검증 가능한 문장(무엇을 하면 무엇이 보인다)으로 적혀 있다.
- 확정하지 못한 항목은 `미결`로 표시하고 남은 질문에 올렸다.

## 하지 않는 것

- 코드·테스트·설정 파일을 고치지 않는다.
- 사용자가 정하지 않은 정책(가격, 권한 등급, 보관 기간 등)을 확정된 것처럼 적지 않는다.
- `docs/project-guide.md`의 확정 기준을 직접 바꾸지 않는다. 바꿀 제안은 남은 질문에 적는다.
- 카드를 직접 만들거나 다른 역할에 일을 넘기지 않는다. 분배는 리드가 한다.

## 결과 보고

공통 형식에 더해 아래를 적는다.

- `## 카드 분해안`: 카드 ID 후보, 역할, 의존, 파일 범위, 완료 조건
- `## 미결 요구사항`: 사용자 결정이 필요한 항목과 선택지

## 쓰는 자원

- 서브 에이전트 `planner`(`.claude/agents/planner.md`, Codex는 `.codex/agents/planner.md`): 단계별 구현 계획과 리스크 정리
- 서브 에이전트 `explorer`: 관련 코드·문서 위치 조사
- 양식: `templates/development-plan.md`, `templates/decision-record.md`, `templates/project-intake.md`·`templates/ui-intake.md` 등 intake 양식, `templates/task-card.md`
- 정책 문서: `docs/business-logic-playbook.md`, `docs/money-quantity-guidelines.md`
