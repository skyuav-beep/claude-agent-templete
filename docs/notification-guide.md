# 작업 알림 가이드

여러 창에서 동시에 작업할 때 완료·응답 요청을 놓치지 않기 위한 알림 구성이다. 작업 파일 점유와 겹침 조정은 `docs/session-coordination-guide.md`를 따른다.
소리와 데스크톱 알림으로 알리고, 사용자가 확인할 때까지 반복 알린 뒤, 확인하면 자동으로 멈춘다.

## 구성 요소

| 파일 | 역할 |
| --- | --- |
| `.claude/hooks/notify-desktop.sh` | 알림 발사기. 플랫폼(WSL/Windows, macOS, Linux)을 감지해 토스트와 소리를 낸다 |
| `.claude/hooks/notify-pending.sh` | `Stop`·`Notification` 훅 진입점. 대기 상태 등록, 알림, 미확인 반복 |
| `.claude/hooks/notify-ack.sh` | `UserPromptSubmit`·`SessionEnd` 훅 진입점. 확인 처리와 정리 |
| `.claude/statusline-notify.sh` | 상태줄. 다른 창의 대기 현황을 상시 표시 |
| `.codex/hooks/notify-codex.sh` | Codex `notify` 어댑터. Codex 페이로드를 위 훅 형식으로 변환 |

상태 파일은 `~/.claude/notify-state/`에 세션 단위로 쌓인다(`<session_id>.pending`, `.watcher`, `.start`).
하루 이상 지난 찌꺼기는 `notify-ack.sh`가 실행될 때 자동 정리한다.

`.pending`은 탭으로 구분한 한 줄이다. 뒤쪽 네 칸은 확인(ACK) 판정에 쓰인다.

| 칸 | 값 | 쓰임 |
| --- | --- | --- |
| 1 | 작업 폴더 이름 | 상태줄 표시 |
| 2 | 종류(`done` / `attention`) | 상태줄 표시 |
| 3 | 표식을 남긴 시각 | 경과 시간 계산 |
| 4 | 세션 프로세스 PID | 그 창이 사라졌는지 판정 |
| 5 | 그 프로세스의 실행 파일명 | PID 재사용 오판 방지 |
| 6 | 기록 파일의 기준 mtime | 그 뒤로 진행됐는지 판정 |
| 7 | 기록 파일 경로 | 위 비교 대상. 탭이 섞여도 잘리지 않도록 맨 뒤 |

4칸 이후가 비어 있으면 판정 근거가 없다는 뜻이므로 검증을 건너뛰고 종전대로 표시한다.

## 알림 종류

| 종류(kind) | 언제 | 소리(Windows) | 제목 |
| --- | --- | --- | --- |
| `done` | 답변이 끝나고 다음 지시를 기다릴 때 | `tada.wav` | `작업 완료 · <폴더명>` |
| `attention` | 권한 승인, 질문, 유휴 대기 | `Alarm03.wav` | `승인 필요 / 응답 필요 / 대기 중 · <폴더명>` |
| `escalate` | 재알림이 `ESCALATE_AFTER`회에 도달했을 때 | `Ring06.wav` | 위 제목에 `(N분 대기)` 추가 |

제목의 `<폴더명>`은 그 창의 작업 디렉터리 이름이다. 여러 창을 띄워도 어느 프로젝트인지 바로 구분된다.

같은 소리를 여러 번 반복하면 귀가 익어 놓치게 되므로, 기본 3회째 재알림부터 가장 길고 강한 소리로 격상한다.
macOS는 `Glass` / `Sosumi` / `Basso`, Linux는 `notify-send` 긴급도 `normal` / `critical` / `critical`로 대응한다.

소리를 바꾸려면 `notify-desktop.sh`의 `case "$kind"` 블록에서 파일명을 교체한다.
Windows 기본 소리는 `C:\Windows\Media\`에 71개가 있고, 직접 준비한 wav 파일 경로를 써도 된다.

## 확인(ACK) 판정

대기 상태는 아래 중 하나가 감지되면 해제되고 반복 알림도 멈춘다.

1. 그 창에 사용자가 입력을 넣는다 (`UserPromptSubmit` 훅, 명시적)
2. transcript 파일이 갱신된다 — 권한 승인처럼 입력 없이 진행된 경우 (암묵적)
3. 세션이 종료된다 (`SessionEnd` 훅)
4. 그 창의 프로세스가 사라진다 — 확인해 줄 사람이 없으므로 표식을 거둔다

감시 주체는 시간에 따라 바뀐다. 이 인계가 없으면 표식이 하루 동안 상태줄에 유령으로 남는다.

| 구간 | 감시 주체 | 판정 |
| --- | --- | --- |
| 반복 알림이 진행 중 | `notify-pending.sh` 워처 | 2번·4번을 재알림 간격마다 확인 |
| 재알림을 모두 소진한 뒤 | 상태줄 | 워처가 없을 때만 2번·4번을 이어서 확인 |
| 언제든 | `notify-ack.sh` | 1번·3번. 훅이 있는 런타임(Claude Code)에서만 |

`UserPromptSubmit`·`SessionEnd`가 없는 런타임(Codex)에서는 1번·3번이 아예 발생하지 않는다.
워처가 수명을 다한 뒤 사용자가 그 창에서 작업을 이어가는 경우가 여기에 해당하며,
상태줄이 감시를 이어받지 않으면 회수할 수단이 남지 않는다.

## 설정값 조정

환경변수로 조정한다. 전역 설정 파일의 `env` 블록이나 셸 프로필에 넣는다.

| 변수 | 기본값 | 설명 |
| --- | --- | --- |
| `CLAUDE_NOTIFY_DISABLE` | `0` | `1`이면 알림 전체 비활성 |
| `CLAUDE_NOTIFY_MIN_SECONDS` | `60` | 완료 알림 최소 소요 시간. 이보다 짧은 턴은 조용히 넘어간다 |
| `CLAUDE_NOTIFY_REPEAT_SECONDS` | `90` | 미확인 재알림 간격 |
| `CLAUDE_NOTIFY_REPEAT_MAX` | `6` | 재알림 최대 횟수 |
| `CLAUDE_NOTIFY_ESCALATE_AFTER` | `3` | 이 횟수째 재알림부터 더 강한 소리로 격상 |
| `CLAUDE_NOTIFY_STATE_DIR` | `~/.claude/notify-state` | 상태 파일 위치 |
| `CLAUDE_NOTIFY_OWNER_PID` | (없음) | 세션 프로세스를 호출자가 알고 있을 때 명시. Codex 어댑터가 쓴다 |

재알림 총 지속 시간(`REPEAT_SECONDS × REPEAT_MAX`)이 async 훅 타임아웃 기본값 600초를 넘으면
훅 등록에서 `timeout`도 함께 늘려야 한다.

## 훅 등록

`Stop`과 `Notification`은 반드시 `"async": true`로 등록한다. 이 훅은 반복 알림을 위해 살아 있으므로
동기로 등록하면 턴 종료가 그만큼 지연된다.

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [ { "type": "command", "command": "<경로>/.claude/hooks/notify-pending.sh", "async": true, "timeout": 900 } ] }
    ],
    "Notification": [
      { "matcher": "permission_prompt|idle_prompt|agent_needs_input",
        "hooks": [ { "type": "command", "command": "<경로>/.claude/hooks/notify-pending.sh", "async": true, "timeout": 900 } ] }
    ],
    "UserPromptSubmit": [
      { "hooks": [ { "type": "command", "command": "<경로>/.claude/hooks/notify-ack.sh" } ] }
    ],
    "SessionEnd": [
      { "hooks": [ { "type": "command", "command": "<경로>/.claude/hooks/notify-ack.sh" } ] }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "<경로>/.claude/statusline-notify.sh",
    "refreshInterval": 5
  }
}
```

모든 창에서 알림을 받으려면 사용자 전역 설정(`~/.claude/settings.json`)에 등록한다.
특정 저장소에서만 받으려면 그 저장소의 `.claude/settings.local.json`에 등록한다.
양쪽에 모두 등록하면 알림이 두 번 울린다.

## Codex에서 쓰기

Codex도 같은 알림을 받는다. `~/.codex/config.toml`에 한 줄을 넣는다.

```toml
notify = ["/절대경로/claude-agent-template/.codex/hooks/notify-codex.sh"]
```

두 런타임의 호출 규약이 달라 어댑터를 거친다. Claude Code는 payload를 stdin JSON으로 주고 이벤트를
`hook_event_name`으로 구분하지만, Codex는 payload를 마지막 argv로 주고 `type`으로 구분한다.
어댑터가 이 차이만 흡수하므로 알림·반복·확인 로직은 두 런타임이 같은 스크립트를 공유한다.

| 기능 | Claude Code | Codex |
| --- | --- | --- |
| 완료 알림 | `Stop` 훅 | `notify` 설정 (`agent-turn-complete`) |
| 확인(ACK) | `UserPromptSubmit` 훅으로 즉시 해제 | 해당 훅 없음. rollout 기록 갱신으로 판정 |
| 턴 소요 시간 | `UserPromptSubmit`에서 시작 시각 기록 | rollout의 마지막 `task_started` 시각에서 계산 |
| 세션 종료 정리 | `SessionEnd` 훅 | 해당 훅 미등록. 세션 프로세스가 사라지면 상태줄이 회수 |
| 세션 프로세스 추적 | 훅이 부모를 거슬러 찾거나 세션 레지스트리로 확인 | 어댑터가 `setsid`로 분리하므로 `CLAUDE_NOTIFY_OWNER_PID`로 직접 넘김 |
| 대기 현황 표시 | 상태줄 | Codex TUI에 없음. Claude 창 상태줄이 함께 표시 |

상태 파일을 공유하므로 Claude Code 창을 하나라도 띄워 두면 그 상태줄에 **Codex 창의 대기까지 함께** 나온다.

Codex `notify`는 동기 호출이라 어댑터가 반복 알림을 백그라운드로 분리한다. 어댑터가 직접 대기하면
그 시간만큼 Codex가 멈춘다. 페이로드 형태를 직접 확인하려면 `CLAUDE_NOTIFY_DEBUG=1`을 켜고
`~/.claude/notify-state/codex-payload.log`를 본다.

Codex는 `PreToolUse`, `PostToolUse`, `PermissionRequest`, `SessionStart`, `SessionEnd`, `PreCompact`,
`PostCompact` lifecycle 훅도 지원한다. 승인 대기 알림이 필요하면 `PermissionRequest`에 훅을 걸 수 있지만,
`approval_policy = "never"` 설정에서는 승인 요청 자체가 발생하지 않는다.

## 되돌리기

전역 설정에서 위 `hooks`의 `Stop`·`Notification`·`UserPromptSubmit`·`SessionEnd` 항목과
`statusLine` 블록을 지우면 원래대로 돌아간다. 스크립트 파일은 남아 있어도 호출되지 않는다.
Codex는 `~/.codex/config.toml`의 `notify` 줄을 지운다.

일시적으로 끄려면 `CLAUDE_NOTIFY_DISABLE=1`을 설정한다.

## 요구 사항과 한계

- `jq`가 필요하다. 없으면 훅은 조용히 아무 일도 하지 않는다.
- WSL에서는 Windows PowerShell로 토스트를 띄운다. 알림 발사에 3초 정도 걸리지만
  async 훅이라 작업 진행에는 영향이 없다.
- Linux 데스크톱은 `notify-send`(libnotify), macOS는 `osascript`를 사용한다.
  어느 것도 없으면 터미널 벨로 대체한다.
- 확인 직후 재알림이 한 번 더 울릴 수 있다. 알림 직전에 다시 검사하지만
  타이밍이 겹치면 새어나온다. 간격을 늘리면 줄어든다.
- 상태줄은 자기 창을 대기 목록에서 제외한다. 눈앞의 창은 표시할 이유가 없다.
- 상태줄은 회수 조건을 만족한 표식을 지운다. 표시 전용이 아니라는 점에 유의한다.
  회수는 워처가 끝난 뒤에만 하므로 반복 알림 구간의 판정과 겹치지 않는다.
- 세션 프로세스를 특정하지 못하면 그 표식은 생존 검증 없이 종전대로 표시된다.
  잘못 짚어 살아 있는 창의 알림을 조기에 지우는 쪽이 더 나쁘기 때문이다.
