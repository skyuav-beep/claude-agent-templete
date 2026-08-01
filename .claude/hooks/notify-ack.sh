#!/usr/bin/env bash
# UserPromptSubmit / SessionEnd 훅 진입점: "사용자가 그 창을 확인했다"를 기록한다.
#
# UserPromptSubmit  그 창에 입력이 들어왔다 = 확인함. 대기 표식을 지우고 반복 알림을 멈춘다.
#                   동시에 이번 턴의 시작 시각을 남겨 notify-pending.sh가 소요 시간을 계산한다.
# SessionEnd        세션이 끝났으므로 남은 표식과 워처를 정리한다.
#
# 출력 규약: UserPromptSubmit은 stdout이 모델 컨텍스트로 들어가므로 아무것도 출력하지 않는다.
# 매 프롬프트마다 실행되는 경로이므로 동기 훅으로 두되 하는 일을 최소로 유지한다.

set -u

command -v jq >/dev/null 2>&1 || exit 0

state_dir="${CLAUDE_NOTIFY_STATE_DIR:-$HOME/.claude/notify-state}"
[ -d "$state_dir" ] || mkdir -p "$state_dir" 2>/dev/null || exit 0

payload=$(cat 2>/dev/null || true)
[ -n "$payload" ] || exit 0
echo "$payload" | jq -e . >/dev/null 2>&1 || exit 0

session_id=$(printf '%s' "$payload" | jq -r '.session_id // empty' 2>/dev/null)
event=$(printf '%s' "$payload" | jq -r '.hook_event_name // empty' 2>/dev/null)
[ -n "$session_id" ] || exit 0

pend="$state_dir/$session_id.pending"
pidf="$state_dir/$session_id.watcher"
startf="$state_dir/$session_id.start"

# 반복 알림 워처를 먼저 멈춘다.
if [ -f "$pidf" ]; then
  pid=$(cat "$pidf" 2>/dev/null)
  case "$pid" in
    ''|*[!0-9]*) : ;;
    *) kill "$pid" 2>/dev/null ;;
  esac
  rm -f "$pidf" 2>/dev/null
fi
rm -f "$pend" 2>/dev/null

if [ "$event" = "SessionEnd" ]; then
  rm -f "$startf" 2>/dev/null
else
  date +%s > "$startf" 2>/dev/null
fi

# 비정상 종료로 남은 다른 세션의 찌꺼기를 정리한다(하루 이상 지난 것).
find "$state_dir" -maxdepth 1 -type f \( -name '*.pending' -o -name '*.watcher' -o -name '*.start' \) \
  -mtime +1 -delete 2>/dev/null

exit 0
