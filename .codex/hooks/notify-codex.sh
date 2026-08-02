#!/usr/bin/env bash
# Codex `notify` 어댑터: Codex의 턴 완료 알림을 Claude용 알림 훅에 연결한다.
#
# 두 런타임의 호출 규약이 다르므로 여기서 형식을 맞춘다.
#   Claude Code  훅 payload를 stdin JSON으로 받는다. 이벤트 종류는 hook_event_name.
#   Codex        payload를 "마지막 argv"로 받는다. 이벤트 종류는 type.
#
# ~/.codex/config.toml 등록 예:
#   notify = ["/절대경로/.codex/hooks/notify-codex.sh"]
#
# Codex에는 Claude의 Stop/UserPromptSubmit에 해당하는 훅이 없다. 그래서
#   턴 완료      -> 이 어댑터가 notify로 받는다
#   확인(ACK)    -> rollout 기록 파일의 갱신을 감시해 판정한다(notify-pending.sh의 암묵적 경로)
#   턴 소요 시간 -> rollout의 마지막 task_started 시각에서 계산한다
# 즉 Claude 쪽 스크립트는 손대지 않고 입력만 만들어 준다.
#
# notify는 동기 호출이므로 반복 알림 워처를 이 프로세스로 붙들면 Codex가 그만큼 멈춘다.
# 반드시 백그라운드로 넘기고 즉시 빠져나온다.

set -u

[ "${CLAUDE_NOTIFY_DISABLE:-0}" = "1" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." 2>/dev/null && pwd) || exit 0
pending="$root/.claude/hooks/notify-pending.sh"
[ -r "$pending" ] || exit 0

state_dir="${CLAUDE_NOTIFY_STATE_DIR:-$HOME/.claude/notify-state}"
sessions_dir="${CODEX_HOME:-$HOME/.codex}/sessions"
mkdir -p "$state_dir" 2>/dev/null || exit 0

[ "$#" -gt 0 ] || exit 0
payload="${!#}"

# 페이로드 형태를 직접 확인하고 싶을 때 켠다: CLAUDE_NOTIFY_DEBUG=1
[ "${CLAUDE_NOTIFY_DEBUG:-0}" = "1" ] && printf '%s\n' "$payload" >> "$state_dir/codex-payload.log"

printf '%s' "$payload" | jq -e . >/dev/null 2>&1 || exit 0
jget() { printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null; }

# 필드명 표기가 바뀌어도 견디도록 후보를 나열해 받는다.
event=$(jget '.type')
case "$event" in
  agent-turn-complete|agent_turn_complete|"") : ;;
  *) exit 0 ;;
esac

thread=$(jget '.["thread-id"] // .thread_id // .threadId // .["session-id"] // .session_id')
cwd=$(jget '.cwd // .["working-directory"] // .workdir // .["current-directory"]')
last=$(jget '.["last-assistant-message"] // .last_assistant_message // .lastAssistantMessage')

[ -n "$thread" ] || thread="codex-unknown"
[ -n "$cwd" ] || cwd="$PWD"

# rollout 기록 파일. 파일명에 thread-id가 들어간다. 확인(ACK) 감지에 쓴다.
transcript=""
if [ -d "$sessions_dir" ] && [ "$thread" != "codex-unknown" ]; then
  transcript=$(find "$sessions_dir" -type f -name "*${thread}*.jsonl" 2>/dev/null | head -1)
fi

# 턴 시작 시각을 남겨 두면 notify-pending.sh가 짧은 턴을 조용히 넘긴다.
if [ -n "$transcript" ] && [ -r "$transcript" ]; then
  start_iso=$(tac "$transcript" 2>/dev/null \
    | jq -rs 'map(select(.type == "event_msg" and .payload.type == "task_started")) | .[0].timestamp // empty' 2>/dev/null)
  if [ -n "$start_iso" ]; then
    start_epoch=$(date -d "$start_iso" +%s 2>/dev/null || printf '')
    [ -n "$start_epoch" ] && printf '%s' "$start_epoch" > "$state_dir/$thread.start" 2>/dev/null
  fi
fi

# Claude 훅이 기대하는 Stop 페이로드로 변환한다.
converted=$(jq -n \
  --arg sid "$thread" \
  --arg cwd "$cwd" \
  --arg tp "$transcript" \
  --arg msg "$last" \
  '{session_id: $sid, cwd: $cwd, transcript_path: $tp, hook_event_name: "Stop", last_assistant_message: $msg}' 2>/dev/null)
[ -n "$converted" ] || exit 0

# setsid로 분리하면 부모를 거슬러 올라가는 경로가 끊기므로 여기서 세션 프로세스를 짚어 넘긴다.
# Codex가 이 어댑터를 직접 실행한 경우에만 부모가 codex다. 확인되지 않으면 넘기지 않는다
# (상태줄이 소유자 검증을 건너뛰고 종전대로 표시한다).
owner=""
case "$(ps -p "$PPID" -o comm= 2>/dev/null | tr -d ' ')" in
  codex) owner="$PPID" ;;
esac

printf '%s' "$converted" | CLAUDE_NOTIFY_OWNER_PID="$owner" setsid nohup bash "$pending" >/dev/null 2>&1 &

exit 0
