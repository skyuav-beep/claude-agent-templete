# 작업 알림 가이드

여러 창에서 동시에 작업할 때 완료·응답 요청을 놓치지 않기 위한 알림 구성이다.
소리와 데스크톱 알림으로 알리고, 사용자가 확인할 때까지 반복 알린 뒤, 확인하면 자동으로 멈춘다.

## 구성 요소

| 파일 | 역할 |
| --- | --- |
| `.claude/hooks/notify-desktop.sh` | 알림 발사기. 플랫폼(WSL/Windows, macOS, Linux)을 감지해 토스트와 소리를 낸다 |
| `.claude/hooks/notify-pending.sh` | `Stop`·`Notification` 훅 진입점. 대기 상태 등록, 알림, 미확인 반복 |
| `.claude/hooks/notify-ack.sh` | `UserPromptSubmit`·`SessionEnd` 훅 진입점. 확인 처리와 정리 |
| `.claude/statusline-notify.sh` | 상태줄. 다른 창의 대기 현황을 상시 표시 |

상태 파일은 `~/.claude/notify-state/`에 세션 단위로 쌓인다(`<session_id>.pending`, `.watcher`, `.start`).
하루 이상 지난 찌꺼기는 `notify-ack.sh`가 실행될 때 자동 정리한다.

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

## 되돌리기

전역 설정에서 위 `hooks`의 `Stop`·`Notification`·`UserPromptSubmit`·`SessionEnd` 항목과
`statusLine` 블록을 지우면 원래대로 돌아간다. 스크립트 파일은 남아 있어도 호출되지 않는다.

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
