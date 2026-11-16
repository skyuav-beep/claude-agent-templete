# Claude-Codex 협업 운영 가이드

Claude Code와 Codex를 함께 써서 여러 프로젝트를 병렬로 개발할 때의 역할 분담, 교차 리뷰, 작업 카드, 품질 게이트, 동시 실행 한도를 정한다.
개별 작업의 진행 절차는 `docs/approval-workflow.md`의 6단계 승인 절차가 정본이고, 이 문서는 그 위에 두 런타임을 나눠 쓰는 규칙만 더한다.

## 적용 범위

- Claude Code 세션과 Codex 세션이 같은 프로젝트나 여러 프로젝트를 동시에 다룰 때 적용한다.
- Claude Code 안에서 Codex를 부르는 방법은 OpenAI 공식 Claude Code 플러그인 `codex@openai-codex`(`openai/codex-plugin-cc`)를 기준으로 한다. 플러그인은 사용자 전역 설치 대상이며 이 저장소가 배포하지 않는다.
- 한 세션 안의 서브 에이전트 운영은 `docs/subagent-guide.md`, 세션 사이 파일·worktree 점유는 `docs/session-coordination-guide.md`를 따른다.
- 결정 배경: 2026-11-16 사용자 결정 — 동시 실행은 메모리 사용률 80% 미만에서만 시작하고 넘으면 대기, Codex 리뷰는 작업이 끝날 때만, 배포는 지금처럼 사용자 수동.

## 역할 분담

| 역할 | 기본 담당 | 하는 일 | 하지 않는 일 |
|---|---|---|---|
| 리드 | Claude | 요청 정리, 기획·설계, 작업 카드 작성·분배, 진행 판단, 사용자 보고 | 다른 담당의 작업 카드 범위 밖 수정 |
| 구현 | Claude 또는 Codex | 작업 카드 하나를 전용 worktree에서 구현하고 테스트 작성 | 카드에 없는 파일·범위 수정, 스스로 완료 판정 |
| 리뷰 | 구현하지 않은 쪽 | 작업이 끝난 diff를 독립적으로 검토 | 리뷰 중 직접 수정 |
| QA | Claude(브라우저 자동화) | 시나리오 테스트 실행, 스크린샷·로그 증거 저장 | 텍스트 판단만으로 통과 처리 |

- 단계별 기본 담당: 요청 정리·기획·설계·UI 구조·작업 분해·테스트 설계·문서는 Claude가 주도한다. 서버·DB·API·통합 구현·자동 테스트 작성·오류 수정은 Codex에 맡길 수 있다. 화면 구현은 둘 중 누구나 맡되 교차 리뷰를 지킨다.
- 이 배분은 출발점이다. 모델 성능은 버전·코드베이스·지시 방식에 따라 달라지므로, 프로젝트에서 결과가 더 좋은 쪽으로 `docs/project-guide.md`에 바꿔 적는다.
- Claude가 Codex에 일을 맡길 때는 플러그인의 `codex-rescue` 서브 에이전트(또는 사용자가 입력하는 `/codex:rescue`)를 쓴다. 쓰기 작업은 그 작업 카드 전용 worktree에서만 하게 한다. 메인 체크아웃에서 Codex가 쓰지 않는다.
- 에이전트가 셸에서 `codex exec`를 직접 실행할 때는 표준 입력을 닫는다(`codex exec ... </dev/null`). 입력이 터미널이 아니면 `codex exec`가 입력을 기다리며 끝나지 않는다(0.166.0에서 확인).

## 교차 리뷰

- 코드를 작성한 쪽이 자기 코드의 유일한 검증자가 되지 않는다. Claude가 쓴 변경은 Codex가, Codex가 쓴 변경은 Claude(`code-reviewer` 서브 에이전트)가 본다.
- Codex 리뷰는 **작업이 끝날 때 한 번만** 한다. 위치는 6단계 절차의 5단계(읽기 전용 사후 감사)다. 턴마다 리뷰하는 플러그인 기능(`/codex:setup --enable-review-gate`)은 사용량이 빨리 소모되므로 켜지 않는다.
- 실행 방법:
  - 사용자: `/codex:review --base <기준 브랜치> --wait`(설계까지 따지려면 `/codex:adversarial-review --base <기준 브랜치> <초점>`)
  - 에이전트: 플러그인 명령은 모델이 직접 호출할 수 없으므로 같은 스크립트를 실행한다 — `node <플러그인 폴더>/scripts/codex-companion.mjs review --wait --base <기준 브랜치>`. 플러그인 폴더는 `~/.claude/plugins/cache/openai-codex/codex/<버전>/`이다.
- 리뷰 결과의 중대 이슈는 고친 뒤 같은 리뷰를 한 번 더 돌린다. 리뷰어가 낸 지적은 그대로 믿지 않고 코드로 사실 여부를 확인한 뒤 반영한다.
- 문서만 바뀐 작업, 한두 줄의 사실 기록(`STATE.md`)은 Codex 리뷰를 생략할 수 있다. 인증·권한·결제·정산·migration이 걸린 변경은 생략하지 않는다.

## 작업 카드

- 병렬로 나누는 작업은 `templates/task-card.md`로 카드를 만든다. 한 사람(세션)이 한 번에 끝낼 수 있는 크기로 쪼갠다.
- 카드에는 고유 ID, 담당, 의존 카드, 수정 파일 범위, 완료 조건, 검증 증거를 적는다. 같은 파일을 두 카드가 동시에 수정하지 않게 범위를 나눈다.
- 여러 카드가 같은 API·DB를 쓰면 계약(API 명세·스키마)을 먼저 확정하는 카드를 만들고 나머지가 그 카드에 의존하게 한다.
- 진행률은 추정하지 않는다. 완료 조건 체크 수 / 전체 완료 조건 수로만 계산한다.
- 카드 위치는 프로젝트 `docs/tasks/<ID>.md`를 기본으로 한다. 끝난 카드는 지우지 않고 상태를 `완료`로 바꾼다. 장기 계획은 `templates/development-plan.md`, 결정은 `templates/decision-record.md`에 남긴다.

## 품질 게이트

작업 카드는 아래 게이트를 모두 통과해야 `완료`가 된다. 게이트는 6단계 절차의 각 단계에 붙는다.

| 게이트 | 통과 기준 | 6단계 위치 |
|---|---|---|
| 계획 | 목표·범위·완료 조건이 카드에 있고 사용자 요청과 맞음 | 1~3단계 |
| 구현 | 카드 범위 밖 수정 없음, 빌드·타입 검사·lint 통과 | 4단계, 6단계 빠른 검증 |
| 교차 리뷰 | 구현하지 않은 쪽의 리뷰에서 중대 이슈 0건 | 5단계 |
| 테스트 | 필수 테스트 통과. UI 변경은 실제 브라우저 실행과 스크린샷 증거 | 6단계 빠른 검증 |
| 승인 | 사용자 승인 범위 안의 merge와 `STATE.md` 기록 | 6단계 |

- 배포·릴리스·GitHub Actions 실행·원격 migration은 게이트에 넣지 않는다. 사용자가 수동으로 하며 `block-deploy.sh`가 막는다.

## 자동 수정 반복 한도

- 같은 실패(같은 테스트·같은 리뷰 지적)를 고치는 시도는 **2회**까지 자동으로 한다.
- 2회 뒤에도 실패하면 멈추고 사용자에게 원인, 시도한 수정, 선택지를 보고한다. 담당을 바꿔(Claude ↔ Codex) 한 번 더 시도하는 것도 선택지로 제시한다.
- 실패한 시도와 원인은 작업 카드의 `진행 기록`에 남긴다.

## 동시 실행과 메모리 한도

- 무거운 작업(Claude·Codex 세션, 개발 서버, 테스트 브라우저, Docker 빌드)을 **새로 시작하기 전에** 메모리 사용률을 본다.
- 사용률이 **80% 미만이면 시작**하고, **80% 이상이면 시작하지 않고 대기**한 뒤 다시 확인한다(기본 30초 간격). 이미 실행 중인 작업은 멈추지 않는다.
- 측정식(WSL2에서는 WSL 가상 머신 전체 기준):

  ```bash
  awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}END{printf "%d\n",(1-a/t)*100}' /proc/meminfo
  ```

- 오래 대기하면(기본 10분) 사용자에게 알리고, 끝난 개발 서버·브라우저·컨테이너처럼 정리할 수 있는 것을 제안한다. 다른 세션의 프로세스는 묻지 않고 끄지 않는다.

### 자동 대기 (`memory-gate.sh`)

`.claude/hooks/memory-gate.sh` 하나가 세 방식으로 위 규칙을 실행한다. 무거운 명령인지의 판정 정본은 이 스크립트다.

| 방식 | 명령 | 동작 |
|---|---|---|
| 훅 | `PreToolUse(Bash)`에 등록(`.claude/settings.template.json`, `timeout` 660초) | 에이전트가 무거운 명령(새 Claude·Codex 실행, 개발 서버, Playwright, Docker 기동·빌드, Codex 리뷰·작업 스크립트)을 실행하려 하면 한도 아래로 내려갈 때까지 기다렸다가 통과시킨다. 10분을 넘기면 사용자 확인(ask)으로 넘기고 많이 쓰는 프로세스를 정리 후보로 보여 준다 |
| 대기 후 실행 | `bash .claude/hooks/memory-gate.sh run -- <명령>` | 사람이 tmux 창에서 새 세션을 띄울 때 쓴다. 예: `... run -- claude`, `... run -- codex` |
| 상태 | `bash .claude/hooks/memory-gate.sh status` (`--short`는 tmux 상태줄용) | 현재 사용률·한도·많이 쓰는 프로세스 |

- 판정 확인: `bash .claude/hooks/memory-gate.sh check "<명령>"` → `heavy`/`light`
- 조정: `AGENT_MEM_LIMIT`(80), `AGENT_MEM_INTERVAL`(30초), `AGENT_MEM_MAX_WAIT`(600초), `AGENT_MEM_EXTRA`(추가 판정 정규식), `AGENT_MEM_DISABLE=1`(끄기)
- Codex는 Claude 훅을 실행하지 않으므로 무거운 명령 전에 `memory-gate.sh wait`를 직접 호출한다(`.codex/checks/safety-checklist.md`).
- 판정은 `node scripts/check-agent-ops.mjs`가 고정한다.

## 이벤트 기록과 현황 보기

여러 프로젝트의 Claude·Codex 세션 상태를 파일 하나에 모은다. 감시 화면(TUI·GUI)은 이 파일만 읽으면 되므로 화면 기술과 무관하게 유지된다.

- 기록기: `.claude/hooks/agent-events.sh`. Claude 훅 12종(`SessionStart`, `UserPromptSubmit`, `PreToolUse`, `Notification`, `PermissionRequest`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`, `TaskCreated`, `TaskCompleted`, `SessionEnd`)에 `async`로 등록해 작업을 늦추지 않는다. Codex는 `notify` 어댑터(`.codex/hooks/notify-codex.sh`)가 턴 완료를 같은 파일에 기록한다.
- Codex 훅: Codex 0.166은 Claude와 같은 형식의 훅을 지원한다(기능 `hooks` 안정, 2026-11-16 실측). 프로젝트 `.codex/hooks.json`에 Claude 설정과 같은 모양(`{"hooks": {"<이벤트>": [{"hooks": [{"type": "command", "command": "..."}]}]}}`)으로 적으면, 입력도 Claude와 같은 필드(`hook_event_name`, `session_id`, `cwd`, `tool_name`, `tool_input` 등)로 들어온다. 실측한 이벤트는 `SessionStart`·`UserPromptSubmit`·`PreToolUse`·`PostToolUse`·`Stop`이고, 실행 파일에는 `PermissionRequest`·`SubagentStart`·`SubagentStop`·`PreCompact`·`SessionEnd`도 있다. `session_id`는 notify의 thread ID와 같아서 한 세션으로 묶인다. 기록 명령은 `bash <템플릿>/.claude/hooks/agent-events.sh codex-hook`이다.
  - 훅은 **신뢰 확인을 거쳐야 실행된다.** 신뢰하지 않은 폴더의 훅은 경고 없이 건너뛴다. 실측은 사용자가 `--dangerously-bypass-hook-trust`를 한 번만 붙여 실행했다. 에이전트는 이 옵션을 쓰지 않는다(Claude Code 분류기가 감독 약화로 거부한다).
  - 등록 예(프로젝트 `.codex/hooks.json`, 같은 명령을 `SessionStart`·`UserPromptSubmit`·`PreToolUse`·`PermissionRequest`·`Stop`에 둔다):

    ```json
    {"hooks": {"PermissionRequest": [{"hooks": [{"type": "command", "command": "bash ~/projects/claude-agent-template/.claude/hooks/agent-events.sh codex-hook"}]}]}}
    ```

  - 등록·신뢰 처리는 사용자가 한다. 사용자 전역 `~/.codex/hooks.json`도 동작한다(2026-11-17 확인). 대화형 `codex` 시작 화면의 "Hooks need review"에서 신뢰하고, `/hooks`로 확인·관리한다. 비대화형 `codex exec`는 신뢰하지 않은 훅을 조용히 건너뛰므로 신뢰는 대화형에서 먼저 한다. 등록 후 Codex 세션에서 신뢰를 승인하고 `agent-events.sh status`에 `codex` 행의 도구 실행이 보이는지 확인한다.
- tmux 창 위치: tmux 안에서 실행된 세션은 `tmux`(`세션:창번호`)와 `pane`(`%번호`)을 함께 기록한다. Codex 대화 화면은 tmux 창 안에 있어도 작업·훅은 별도 Codex 서버 프로세스에서 돌아 창 정보가 넘어오지 않는다. 그래서 Codex는 같은 작업 폴더에서 `codex`가 떠 있는 창이 정확히 하나일 때만 그 창으로 기록한다. 한 폴더에 Codex 창을 둘 이상 띄우면 창 위치가 비고, 그 세션에는 화면에서 지시를 보낼 수 없다.
- 중복 방지: 사용자 전역 `~/.codex/hooks.json`에 `codex-hook`이 등록돼 있으면 턴 완료는 훅의 `Stop`이 기록하므로 notify 어댑터는 기록하지 않는다. 감시 화면은 이 값으로 그 창에 지시를 보내거나 이동한다(`## 화면에서 지시 보내기`).
- 위치: `${XDG_STATE_HOME:-~/.local/state}/agent-events/events.jsonl`(`AGENT_EVENTS_FILE`로 변경). 20MB를 넘으면 `events.jsonl.1`로 넘긴다. 모든 프로젝트가 같은 파일을 쓰므로 한 화면에서 함께 본다.
- 기록하지 않는 것: 프롬프트·응답 본문, 파일 내용. Bash 명령은 앞 120자만 남기고 비밀값처럼 보이는 부분(키=값, 토큰, `Bearer`, URL 계정)을 `***`로 가린다. 끄려면 `AGENT_EVENTS_DISABLE=1`.

한 줄 형식:

| 필드 | 뜻 |
|---|---|
| `ts` | 기록 시각(epoch 초) |
| `provider` | `claude` 또는 `codex` |
| `event` | 훅 이벤트 이름. Codex 턴 완료는 `Stop` |
| `session` | 세션 ID(Codex는 thread ID) |
| `project` / `branch` / `cwd` | 저장소 이름(worktree도 원래 저장소 이름), 브랜치, 작업 폴더 |
| `tool` / `target` | 도구 이름과 대상(파일 경로, 가린 명령 등) |
| `tmux` / `pane` | tmux 창 위치(`세션:창번호`)와 pane ID. tmux 밖이면 없음 |
| `agent` | 서브 에이전트 종류 |
| `kind` / `note` | 알림 종류, 작업 제목·알림 문구·오류(가림 적용) |

현황 보기:

| 명령 | 용도 |
|---|---|
| `bash .claude/hooks/agent-events.sh watch` | 터미널 화면. 2초마다 다시 그리고 `q`로 끝낸다 |
| `bash .claude/hooks/agent-events.sh status` | 표 한 번 출력. `--hours N`으로 범위 조정(기본 12시간) |
| `bash .claude/hooks/agent-events.sh status --short` | tmux 상태줄용 한 줄 (`실행 2 · 응답 1 · mem 41%/80`) |

- 상태는 마지막 이벤트로 정한다: `응답 필요`(권한·입력 요청) > `오류` > `실행 중` > `멈춤?`(실행 중인데 30분 이상 이벤트 없음) > `완료` > `대기`(세션을 열고 아직 지시가 없음). 끝난 세션은 숨긴다. 세션이 끝난 뒤 늦게 도착하는 서브 에이전트·작업 종료 기록은 상태 판정에 쓰지 않는다.
- `창`은 그 세션이 마지막으로 기록된 tmux 창이다. 지시를 보낼 대상이다.
- `서브`는 이번 턴에 실행 중인 서브 에이전트 수, `작업`은 완료/생성한 작업 수다. 진행률이 아니다 — 진행률은 작업 카드의 완료 조건으로만 계산한다.
- Codex 대화형 세션은 턴 완료 사이에 이벤트가 없으므로, 실행 로그(`~/.codex/sessions`)가 5분 안에 갱신됐으면 `실행 중`으로 본다.

## tmux 운영

여러 프로젝트를 터미널 하나에서 돌리는 기본 구성이다. 설정 파일은 바꾸지 않고 명령으로만 쓴다.

| 단위 | 규칙 |
|---|---|
| tmux 세션 | 프로젝트 1개. 이름은 저장소 이름 |
| 창(window) | 작업 카드 1개. 이름은 카드 ID. 작업 폴더는 그 카드의 worktree |
| 감시 창 | 세션마다 0번 창에 `agent-events.sh watch` |

```bash
H=~/projects/claude-agent-template/.claude/hooks          # 이 템플릿의 훅 위치
tmux new-session -d -s myapp -n watch -c ~/projects/myapp "bash $H/agent-events.sh watch"
tmux new-window -t myapp -n T-001 -c ~/projects/myapp-worktrees/T-001 "bash $H/memory-gate.sh run -- claude"
tmux new-window -t myapp -n T-002 -c ~/projects/myapp-worktrees/T-002 "bash $H/memory-gate.sh run -- codex"
tmux attach -t myapp
```

- 다른 창에 지시 보내기: `tmux send-keys -t myapp:T-001 "<지시>" Enter`. 실행 중인 에이전트에 보내는 입력이므로 내용과 대상 창을 확인하고 보낸다.
- 상태줄에 현황 띄우기(원하면 `~/.tmux.conf`에 직접 추가):

  ```
  set -g status-interval 10
  set -g status-right "#(bash ~/projects/claude-agent-template/.claude/hooks/agent-events.sh status --short)"
  ```

- 세션 목록 `tmux ls`, 전환 `prefix s`. 백그라운드 Claude 작업은 `claude agents`, Codex 백그라운드 작업은 `/codex:status`로 따로 본다.

## 화면에서 지시 보내기

감시 화면(TUI)에서 세션을 골라 지시를 보내는 기능의 규칙이다. 첫 구현은 tmux 창에 키 입력을 보내는 방식(`tmux send-keys`)이고, 대상은 이벤트 기록의 `tmux`/`pane` 값이다.

- 보내기 전에 대상(프로젝트·세션·창)과 보낼 내용을 화면에 보여 주고 사용자가 확정한 뒤 보낸다. 대상 창이 사라졌거나 기록과 다른 프로그램이 떠 있으면 보내지 않는다.
- 사람이 입력한 지시만 보낸다. 감시 화면이 지시를 스스로 만들거나, 이벤트·작업 카드·로그 내용을 지시로 바꿔 보내지 않는다.
- 권한·승인 요청(`응답 필요`)에 자동으로 답하지 않는다. 화면은 그 창으로 이동만 시키고 승인은 사용자가 그 창에서 한다.
- 배포·릴리스·원격 migration·강제 push를 지시하는 입력은 보내지 않는다. 받는 쪽 에이전트의 가드레일 훅도 그대로 적용되지만, 화면에서 먼저 막는다.
- 메모리 80% 이상이면 새 세션을 띄우는 지시는 보내지 않는다(`## 동시 실행과 메모리 한도`). 이미 실행 중인 세션에 보내는 지시는 막지 않는다.
- 보낸 지시는 본문 없이 이벤트로 기록한다(시각·대상·길이). 본문은 받는 세션의 기록에 남는다.

## 여러 프로젝트 운영

- 프로젝트마다 별도 터미널 세션(tmux 세션 1개 = 프로젝트 1개, 창 1개 = 작업 카드 1개, 위 `## tmux 운영`)을 쓰고, 작업 카드마다 전용 worktree를 쓴다.
- 세션 현황은 `agent-events.sh watch`로 한 화면에서 본다.
- 응답이 필요한 순간은 작업 알림 훅(`docs/notification-guide.md`)으로 받는다. 백그라운드 Claude 작업은 `claude agents`, 백그라운드 Codex 작업은 `/codex:status`로 본다.
- 감시 화면은 아래 `## 감시 화면 결정`을 따른다. 직접 만드는 감시 프로그램은 이 템플릿이 아니라 별도 저장소에서 개발한다.

## 감시 화면 결정

2026-11-16 평가. 기본은 추가 설치가 없는 `agent-events.sh watch`이고, 다른 도구는 필요할 때 사용자가 직접 시험한다.

| 후보 | 방식 | 리소스 | 판단 |
|---|---|---|---|
| `agent-deck` (별도 저장소) | 같은 이벤트 파일을 읽는 Rust TUI. 세션 상세, tmux 창 이동, 확인 후 지시 보내기 | 측정 전 | 2026-11-16 1차 버전. 입력이 필요할 때 쓴다. `cargo run --release` |
| `agent-events.sh watch` | 이벤트 파일 하나를 읽는 터미널 화면(bash + jq). 파일이 바뀔 때만 다시 계산 | RSS 약 24MB, 이벤트 20,000줄에서 CPU 약 2.6%(한 코어 기준) | **기본 채택.** Claude·Codex·여러 프로젝트를 한 화면에, 응답 필요를 맨 위에 |
| AgentHUD 0.19.0 | 각 에이전트의 세션 기록을 2초마다 읽는 TUI(Node, Ink) | 측정 못 함 | 선택 시험. 읽기 전용이고 대화 흐름 상세·일일 요약이 강점이다. 요약은 에이전트 CLI를 불러 사용량을 쓴다. 외부 패키지가 세션 기록을 읽으므로 에이전트가 대신 실행하지 않고(오토 모드에서 차단됨) 사용자가 직접 `npx agenthud@0.19.0`으로 실행한다 |
| ccdeck | 첫 실행 때 Claude 훅을 직접 등록, 웹 화면(127.0.0.1:4317) | 측정 안 함 | **권하지 않음.** 훅을 템플릿 밖에서 등록하고, 사용 통계를 보내며, 다른 기기의 Claude 로그인을 복사해 오는 기능이 있어 비밀값 규칙과 맞지 않는다(AGPL-3.0) |
| `claude agents` | Claude Code 공식 백그라운드 작업 관리 | 추가 없음 | 백그라운드 Claude 작업 확인용으로 함께 쓴다 |

Rust TUI(4단계)는 아래 중 하나가 실제로 생길 때만 시작한다. 2026-11-16 사용자가 화면 안 입력(지시 보내기)을 요청해 두 번째 조건이 생겼고, 같은 날 Rust(ratatui)로 별도 저장소 `mcmkr-dev/agent-deck`(로컬 `~/projects/agent-deck`)에서 시작했다. 템플릿 안에 두지 않은 이유: 연결 프로젝트 21곳이 `rules/`로 템플릿 폴더 전체를 보고, 헌법의 "런타임 코드 없음"과 맞지 않기 때문이다. 이벤트 형식과 지시 보내기 규칙의 정본은 이 문서이고 agent-deck이 따라간다. 시작하면 별도 저장소에서 만들고, 입력은 이벤트 파일(`events.jsonl`)과 작업 카드(`docs/tasks/`)만 쓴다.

- 현황 계산이 1초를 넘는다(세션 30개 이상, 이벤트 10만 줄 수준).
- 화면 안에서 세션을 골라 상세를 보거나 지시를 보내는 상호작용이 필요하다(tmux `send-keys`로 부족할 때).
- 여러 PC의 세션을 한 화면에 모아야 한다.

## 하지 않는 것

- 턴마다 Codex 리뷰를 강제하지 않는다.
- 배포·릴리스·GitHub Actions·원격 migration을 에이전트가 실행하지 않는다.
- 메모리 80% 이상에서 새 무거운 작업을 시작하지 않는다.
- 다른 세션이 점유한 파일·worktree를 확인 없이 수정하지 않는다.
- 리뷰어나 다른 에이전트의 보고를 확인 없이 사실로 전달하지 않는다.
