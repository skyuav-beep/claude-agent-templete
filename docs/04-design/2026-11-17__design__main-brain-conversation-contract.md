---
id: DSN-20261117-001
type: design
status: draft
created: 2026-11-17
updated: 2026-11-17
created_at: "2026-11-17T22:34:34+09:00"
created_at_source: authoring-time
updated_at: "2026-11-17T22:34:34+09:00"
source: planning
related:
  - DEV-20261117-003
  - ../05-development/2026-11-17__development__main-brain.md
  - ../claude-codex-collaboration.md
---

# 메인 Brain 프로젝트 ID·메시지·승인 연결 계약 (MB-01)

> 작성 기록: 2026-11-17 22:34:34 KST · 최종 수정: 2026-11-17 22:34:34 KST

[메인 Brain 개발계획](../05-development/2026-11-17__development__main-brain.md)의 MB-01 산출물이다. 계획이 MB-01로 미룬 프로젝트 ID 형식·경로 이동, 새 대화 저장 위치·스키마, 보관 기간을 확정한다. 구현은 agent-deck이 하고, 형식이 바뀌면 이 문서를 먼저 고친다(이벤트 형식과 같은 방식, [협업 운영](../claude-codex-collaboration.md)).

## 확정 사항 요약

| 항목 | 결정 |
|---|---|
| 프로젝트 ID | `prj_` + 소문자 16진수 16자(64비트 난수). 이름·경로에서 만들지 않는다 |
| 프로젝트 등록부 | `<AGENT_DECK_HOME>/conversations/projects.json` 하나. 경로·표시 이름·별칭·이전 Brain 키를 ID에 묶는다 |
| 경로 이동 | 자동 추적하지 않는다. 사용자가 이동을 등록하면 ID 유지, 이전 경로는 이력으로 남긴다 |
| 새 대화 저장 | `<AGENT_DECK_HOME>/conversations/v1/messages-YYYY-MM.jsonl`(UTC 월). 한 줄이 메시지 하나 |
| 시각 | `created_at` = Unix 초(UTC). 모르면 `null`이며 임의 생성하지 않는다. 화면은 Asia/Seoul |
| 정렬 | 같은 시각이면 저장소의 `sequence`, 이전 기록은 원본 줄 번호로 정한다 |
| 기존 기록 | `brains/*/brain.json`·`chat.jsonl`은 읽기만 한다. 변환해 다시 쓰지 않는다 |
| 보관 | 원본·통합 기록 모두 자동 삭제 없음. 정리는 사용자 명령으로 월 파일 단위만 |

`AGENT_DECK_HOME` 기본값은 `${XDG_STATE_HOME:-~/.local/state}/agent-deck`이다(작업 기록 `jobs/`, Brain `brains/`와 같은 위치).

## 프로젝트 ID와 등록부

- 등록 시 경로를 정규화한다(심볼릭 링크 해석, worktree면 원래 저장소). 같은 경로가 이미 있으면 기존 ID를 돌려준다.
- 등록할 때 그 경로의 이전 Brain 폴더 이름(`<이름>-<경로 FNV-1a 8자>`)을 `legacy_keys`에 넣는다. 이전 기록의 `project_id`는 이 값으로 복원한다.
- 경로 이동: `relocate(ID, 새 경로)`로만 반영한다. 이전 경로는 `path_history`로, 새 경로의 Brain 키는 `legacy_keys`에 더한다. 새 경로가 이미 다른 ID에 등록돼 있으면 거부한다.
- 이전 경로에 다른 저장소가 새로 생기면 새 ID를 받는다. 등록된 경로가 사라지면 `status: unavailable`로 표시하고 다른 프로젝트로 대체하지 않는다.
- 표시 이름은 중복을 허용한다. 화면은 같은 이름이 둘 이상이면 경로 끝부분을 함께 보인다. 은퇴한 ID는 재사용하지 않는다.
- 클라이언트가 보낸 경로·이름으로 실행하지 않는다. 서버는 `project_id`가 등록부에 있고 `active`인지 확인한다.

```json
{"schema_version": 1, "projects": [
  {"id": "prj_3f9a1c07b2e4d856", "label": "riderwebapp", "path": "/home/u/projects/riderwebapp",
   "aliases": ["rider"], "legacy_keys": ["riderwebapp-1a2b3c4d"],
   "path_history": [{"path": "/home/u/old/riderwebapp", "until": 1794884400}],
   "status": "active", "created_at": 1794268800}
]}
```

## 메시지 스키마 v1

계획의 필드 표를 그대로 쓰고 아래를 더한다. 없는 값은 `null` 또는 빈 목록이다.

| 필드 | 값 |
|---|---|
| `schema_version` | `1` |
| `message_id` | 새 기록 `msg_` + 16진수 16자, 이전 기록 `legacy:<Brain 키>:<줄 번호>` |
| `conversation_id` | 새 대화 `cnv_` + 16진수 16자, 이전 기록 `legacy-brain:<Brain 키>` |
| `request_id` | 사용자 요청마다 클라이언트가 만든다. 같은 값의 사용자 메시지는 한 번만 저장한다(재시도 중복 방지) |
| `reply_to`, `split_from` | 응답 대상 메시지, 다중 대상 요청에서 갈라진 원래 메시지 |
| `project_id`, `related_project_ids` | 실행 대상 하나 또는 `null`(공통·보류), 비교·참고 대상 |
| `project_label_snapshot` | 보낼 때 화면에 보인 이름 |
| `scope_source` | `selector` · `explicit` · `switch` · `common` · `legacy` |
| `created_at`, `sequence` | Unix 초(UTC) 또는 `null`, 저장소가 잠금 안에서 매기는 증가 번호(이전 기록은 `null`) |
| `sender` | `user` · `brain` · `system` |
| `kind` | `question` 질문 · `requirement` 요구사항 · `plan` 계획 · `policy` 정책 · `instruction` 작업 지시 · `progress` 진행 보고 · `review` 검토 결과 · `decision` 결정 · `unclassified` 미분류 |
| `action` | `null` · `switch_target` · `approve` · `reject` · `answer` · `cancel`. 상태를 바꾸는 사용자 동작만 쓴다 |
| `context_revision`, `job_ids`, `source_refs` | 사용한 문맥 버전, 작업 ID(`J<초>-<n>`), 근거 문서 경로 |
| `delivery_status` | `pending` · `held` · `processing` · `answered` · `failed` · `cancelled` · `null`(이전 기록) |
| `status_note` | 보류·실패 이유 |
| `origin` | 이전 기록만: `{"kind": "legacy-brain", "brain": "<Brain 키>", "line": 12, "who": "error"}` |

`kind`는 표시용이다. `decision`을 붙여도 정책 확정이나 실행 승인이 아니다. 실행 승인은 `action: approve`만 뜻한다.

## 대상 결정 규칙

우선순위: 메시지의 명시 대상 → 현재 선택 → 공통. `@이름`은 줄 맨 앞에 있을 때만 대상이며 인용·코드블록·본문 속 이름은 지시가 아니다.

| 상황 | `project_id` | `scope_source` | `delivery_status` · 기타 |
|---|---|---|---|
| 선택기로 A | A | `selector` | `pending` |
| A 선택 중 `@B` | B | `explicit` | `pending`. 다음 기본 대상은 A 유지 |
| "앞으로 B로 전환" | B | `switch` | `action: switch_target`. 이후 기본 대상 B |
| 미선택·전체 선택 | `null` | `common` | 공통 대화. 작업 지시면 `held`, `status_note`에 대상 필요 |
| 본문에 B를 언급 | 현재 선택 | `selector` | B는 `related_project_ids`에만 |
| `@이름` 동명이인·모르는 별칭·`@B @C` 상충 | `null` | `explicit` | `held`, 후보를 보여 주고 사용자가 고른 뒤 새 메시지로 보낸다 |
| 여러 프로젝트에 작업 요청 | `null` | `explicit` 또는 `common` | 원래 메시지는 `related_project_ids`=[A, B]. Brain 분해안 확정 뒤 프로젝트마다 `split_from`이 있는 메시지와 새 `request_id` |
| 대상이 `unavailable`·`retired` | 원래 대상 | 그대로 | `failed`, 다른 프로젝트로 대체하지 않음 |

전송 시 서버가 `project_id`·`context_revision`·`request_id`를 확정한다. 이후 화면 선택이 바뀌어도 응답·재시도·작업은 원래 값을 쓴다.

## 승인 연결

- 승인·거절·답(`approve`·`reject`·`answer`)은 `reply_to`로 원래 메시지를, `job_ids`로 정확히 작업 하나를 가리킨다.
- 서버는 그 작업의 `job.json` `project` 경로가 메시지 `project_id`의 등록 경로와 같을 때만 반영한다. 다른 프로젝트 작업이면 거부한다.
- 대상 없는 "진행해"는 승인 대기 작업이 정확히 하나일 때만 그 작업으로 제안하고, 둘 이상이면 `held`로 고르게 한다. 어느 경우든 사람이 확인한 뒤 반영한다.
- 기존 작업 탭 승인(`a`)과 Brain 경유 `job reply`는 그대로 동작한다. 통합 기록은 그 결과를 같은 형식의 메시지로 남긴다.

## 기존 형식 대응

| 기존 | 통합 메시지 |
|---|---|
| `brains/<키>/brain.json` `project` | 등록부 `legacy_keys`로 `project_id`. 등록 안 됐으면 `null`, 화면에 "미등록 프로젝트" |
| `chat.jsonl` `ts` | `created_at`. 없음·0·정수 아님이면 `null`(시각 미상) |
| `chat.jsonl` `who` | `user`→`user`, `brain`→`brain`, `error`·기타→`system`(원래 값은 `origin.who`) |
| `chat.jsonl` `text`, 줄 위치 | `text`, `message_id`의 줄 번호(빈 줄·깨진 줄도 번호에 포함) |
| 기존 메시지의 유형·대상 근거 | `kind: unclassified`, `scope_source: legacy` |
| `jobs/<id>/job.json` `project`, `answers.json` | `job_ids`와 승인 검증 경로, `answer` 메시지 |
| `events.jsonl` `project`·`job` | 메시지로 바꾸지 않는다(본문 없음). 상태 표시에만 `job`으로 연결한다. `project`는 저장소 이름뿐이라 ID 판정에 쓰지 않는다 |
| 웹 API `brains[].id` | Brain 키. 등록부 `legacy_keys`와 같은 값 |

## 읽기·정렬·중복 규칙

- 이전 기록은 매번 원본에서 읽고 `message_id`가 결정적이라 반복 로딩해도 같은 값이다. 통합 보기는 `message_id`로 합쳐 처음 것만 남긴다.
- 정렬 키: 표시 시각(자기 시각, 없으면 같은 파일의 바로 앞 알려진 시각, 그것도 없으면 0) → 이전 기록 먼저 → Brain 키 → 줄 번호 또는 `sequence`. 시각을 빌려 정렬해도 화면에는 "시각 미상"으로 보인다.
- 통합 저장소에 같은 `message_id`가 두 번 있으면 앞의 것만 읽는다. 모르는 `schema_version`과 깨진 줄은 건너뛰고 개수만 알린다(파일은 고치지 않는다).
- 쓰기는 잠금 파일(`v1/.lock`, 원자적 생성) 안에서 `sequence`를 매기고 한 줄을 덧붙인다. 잠금이 30초 넘게 남아 있으면 끊긴 것으로 보고 치운다.

## 버전·전환·보관

- 디렉터리가 스키마 큰 버전이다(`v1/`). 다음 버전은 `v2/`에 쓰고, 일회성 전환 도구가 `v1`을 읽어 `v2`를 만든 뒤 `v1`은 고치지 않고 보존한다. 정본은 항상 하나이며 두 버전에 동시에 쓰지 않는다.
- 원본 Brain 기록(`brain.json`, `chat.jsonl`, `turns/`)은 agent-deck이 지우지 않는다. 기존 화면의 최근 200개 제한은 화면 표시용이고 어댑터는 파일 전체를 읽는다.
- 통합 기록도 자동 삭제하지 않는다. 13개월 지난 월 파일은 화면에 정리 후보로만 표시하고, 사용자가 명령하면 `archive/`로 옮긴다.
- 대화 본문은 로컬에만 둔다. 이벤트 기록(`events.jsonl`)에 본문을 넣지 않는 원칙은 그대로다.

## 예시 자료

A(`prj_3f9a…`) 선택 중 `@B`로 보낸 요청과, 사용자가 선택을 A로 둔 채 늦게 도착한 B의 응답:

```json
{"schema_version":1,"message_id":"msg_0a1b2c3d4e5f6071","conversation_id":"cnv_9e8d7c6b5a493827","request_id":"req_51c2","reply_to":null,"split_from":null,"project_id":"prj_b71e04c2d9a35f10","related_project_ids":[],"project_label_snapshot":"agent-deck","scope_source":"explicit","created_at":1794897720,"sequence":41,"sender":"user","kind":"instruction","text":"@agent-deck 통합 대화창 목업을 만들어줘","action":null,"context_revision":"ctx-7","job_ids":[],"source_refs":[],"delivery_status":"answered","status_note":null}
{"schema_version":1,"message_id":"msg_7f6e5d4c3b2a1908","conversation_id":"cnv_9e8d7c6b5a493827","request_id":"req_51c2","reply_to":"msg_0a1b2c3d4e5f6071","split_from":null,"project_id":"prj_b71e04c2d9a35f10","related_project_ids":[],"project_label_snapshot":"agent-deck","scope_source":"explicit","created_at":1794898080,"sequence":44,"sender":"brain","kind":"plan","text":"분해안 2개를 정리했어요. 작업 탭에서 승인해 주세요.","action":null,"context_revision":"ctx-7","job_ids":["J1794898075-1"],"source_refs":["docs/05-development/2026-11-17__development__main-brain.md"],"delivery_status":"answered","status_note":null}
```

모르는 별칭으로 보류된 메시지와 이전 기록 한 줄의 변환 결과:

```json
{"schema_version":1,"message_id":"msg_1c2d3e4f5a6b7c8d","conversation_id":"cnv_9e8d7c6b5a493827","request_id":"req_51c9","reply_to":null,"split_from":null,"project_id":null,"related_project_ids":[],"project_label_snapshot":null,"scope_source":"explicit","created_at":1794898200,"sequence":45,"sender":"user","kind":"instruction","text":"@rider2 테스트 돌려줘","action":null,"context_revision":null,"job_ids":[],"source_refs":[],"delivery_status":"held","status_note":"알 수 없는 대상: rider2"}
{"schema_version":1,"message_id":"legacy:riderwebapp-1a2b3c4d:12","conversation_id":"legacy-brain:riderwebapp-1a2b3c4d","request_id":null,"reply_to":null,"split_from":null,"project_id":"prj_3f9a1c07b2e4d856","related_project_ids":[],"project_label_snapshot":null,"scope_source":"legacy","created_at":null,"sequence":null,"sender":"system","kind":"unclassified","text":"이전 차례가 끝나지 않고 멈춰 있어 치웠어요","action":null,"context_revision":null,"job_ids":[],"source_refs":[],"delivery_status":null,"status_note":null,"origin":{"kind":"legacy-brain","brain":"riderwebapp-1a2b3c4d","line":12,"who":"error"}}
```

## 이번에 정하지 않은 것

- 컨텍스트 길이·비용 예산: MB-06 착수 전 확정한다. 제안값은 프로젝트 문맥 요약 8,000자, 최근 대화 20차례.
- GUI/TUI 적용 순서: 제안은 웹 콘솔(MB-05 앞부분) → TUI. 세부 일정은 MB-04 완료 후 정한다.
- 자동 유형 분류 방식과 변경 이력 형식: MB-06에서 정한다. v1은 `kind` 현재 값만 저장한다.
