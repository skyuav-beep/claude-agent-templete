#!/usr/bin/env bash
# Stop / Notification 훅 진입점: 대기 상태를 등록하고 알림을 보낸 뒤,
# 사용자가 확인할 때까지 일정 간격으로 다시 알린다.
#
# 반드시 async 훅으로 등록한다(settings.json의 "async": true).
# 이 스크립트는 반복 알림을 위해 수십 초~수 분 살아 있으므로,
# 동기 훅으로 등록하면 턴 종료가 그만큼 지연된다.
#
# 확인(ACK) 판정은 두 경로다.
#   1) 그 창에 사용자가 입력 -> notify-ack.sh가 대기 표식을 지운다(명시적)
#   2) transcript 파일이 갱신됨 -> 권한 승인처럼 입력 없이 진행된 경우(암묵적)
# 둘 중 하나라도 감지되면 반복 알림을 멈추고 대기 표식을 정리한다.
#
# 조정 가능한 환경변수 (기본값)
#   CLAUDE_NOTIFY_DISABLE        0    1이면 알림 전체 비활성
#   CLAUDE_NOTIFY_MIN_SECONDS    60   완료 알림 최소 소요 시간. 짧은 턴은 조용히 넘긴다
#   CLAUDE_NOTIFY_REPEAT_SECONDS 90   미확인 재알림 간격
#   CLAUDE_NOTIFY_REPEAT_MAX     6    재알림 최대 횟수
#   CLAUDE_NOTIFY_ESCALATE_AFTER 3    이 횟수째 재알림부터 더 강한 소리로 격상
#   CLAUDE_NOTIFY_STATE_DIR      ~/.claude/notify-state

set -u

[ "${CLAUDE_NOTIFY_DISABLE:-0}" = "1" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
send="$here/notify-desktop.sh"
[ -x "$send" ] || [ -r "$send" ] || exit 0

min_seconds="${CLAUDE_NOTIFY_MIN_SECONDS:-60}"
repeat_every="${CLAUDE_NOTIFY_REPEAT_SECONDS:-90}"
repeat_max="${CLAUDE_NOTIFY_REPEAT_MAX:-6}"
escalate_after="${CLAUDE_NOTIFY_ESCALATE_AFTER:-3}"
state_dir="${CLAUDE_NOTIFY_STATE_DIR:-$HOME/.claude/notify-state}"

payload=$(cat 2>/dev/null || true)
[ -n "$payload" ] || exit 0
echo "$payload" | jq -e . >/dev/null 2>&1 || exit 0

jget() { printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null; }

session_id=$(jget '.session_id')
cwd=$(jget '.cwd')
transcript=$(jget '.transcript_path')
event=$(jget '.hook_event_name')
notif_type=$(jget '.notification_type')
message=$(jget '.message')

[ -n "$session_id" ] || exit 0
mkdir -p "$state_dir" 2>/dev/null || exit 0

label=$(basename "${cwd:-$PWD}")
[ -n "$label" ] || label="claude"

pend="$state_dir/$session_id.pending"
pidf="$state_dir/$session_id.watcher"
startf="$state_dir/$session_id.start"

mtime_of() {
  [ -n "${1:-}" ] && [ -e "$1" ] || { printf '0'; return; }
  stat -c %Y "$1" 2>/dev/null || stat -f %m "$1" 2>/dev/null || printf '0'
}

fmt_dur() {
  local s="$1"
  if [ "$s" -lt 60 ]; then printf '%d초' "$s"
  elif [ "$s" -lt 3600 ]; then printf '%d분 %d초' "$((s / 60))" "$((s % 60))"
  else printf '%d시간 %d분' "$((s / 3600))" "$(((s % 3600) / 60))"; fi
}

# 같은 세션에 워처가 이미 떠 있으면 정리한다(중복 알림 방지).
if [ -f "$pidf" ]; then
  old_pid=$(cat "$pidf" 2>/dev/null)
  case "$old_pid" in
    ''|*[!0-9]*) : ;;
    *) [ "$old_pid" != "$$" ] && kill "$old_pid" 2>/dev/null ;;
  esac
  rm -f "$pidf" 2>/dev/null
fi

now=$(date +%s)

if [ "$event" = "Stop" ]; then
  kind="done"
  start=$(cat "$startf" 2>/dev/null || printf '0')
  case "$start" in ''|*[!0-9]*) start=0 ;; esac
  elapsed=0
  [ "$start" -gt 0 ] && elapsed=$((now - start))
  # 방금 눈으로 확인했을 짧은 턴까지 울리면 알림이 소음이 된다.
  if [ "$start" -gt 0 ] && [ "$elapsed" -lt "$min_seconds" ]; then
    exit 0
  fi
  title="작업 완료 · $label"
  if [ "$elapsed" -gt 0 ]; then
    body="$(fmt_dur "$elapsed") 걸린 작업이 끝났어요. 다음 지시를 기다리는 중이에요."
  else
    body="작업이 끝났어요. 다음 지시를 기다리는 중이에요."
  fi
else
  kind="attention"
  case "$notif_type" in
    permission_prompt)  head="승인 필요" ;;
    agent_needs_input)  head="응답 필요" ;;
    idle_prompt)        head="대기 중" ;;
    *)                  head="확인 필요" ;;
  esac
  title="$head · $label"
  body="${message:-확인이 필요해요.}"
fi

base_mtime=$(mtime_of "$transcript")
printf '%s\t%s\t%s\n' "$label" "$kind" "$now" > "$pend" 2>/dev/null || exit 0

bash "$send" "$kind" "$title" "$body"

# 여기서부터 미확인 감시. 확인되면 표식까지 정리하고 끝낸다.
printf '%s' "$$" > "$pidf" 2>/dev/null
i=0
while [ "$i" -lt "$repeat_max" ]; do
  sleep "$repeat_every"
  [ -e "$pend" ] || break
  [ "$(mtime_of "$transcript")" != "$base_mtime" ] && { rm -f "$pend" 2>/dev/null; break; }
  i=$((i + 1))
  waited=$(fmt_dur $((i * repeat_every)))
  # 여러 번 놓친 뒤에는 같은 소리를 반복해도 잘 들리지 않으므로 더 강한 소리로 바꾼다.
  nag_kind="$kind"
  [ "$i" -ge "$escalate_after" ] && nag_kind="escalate"
  bash "$send" "$nag_kind" "$title ($waited 대기)" "$body"
done
rm -f "$pidf" 2>/dev/null

exit 0
