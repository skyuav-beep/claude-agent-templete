#!/usr/bin/env bash
# 상태줄: 다른 창이 응답을 기다리고 있는지 상시로 보여준다.
#
# 알림을 놓치거나 이미 닫아버렸을 때 마지막으로 남는 안전망이다.
# 지금 보고 있는 창(자기 세션)은 제외한다. 눈앞에 있는 창을 대기 목록에 넣어봐야 의미가 없다.
#
# settings.json 등록 예:
#   "statusLine": { "type": "command", "command": "<경로>/statusline-notify.sh", "refreshInterval": 5 }
# refreshInterval을 지정해야 다른 창의 대기 상태가 주기적으로 갱신된다.

set -u

state_dir="${CLAUDE_NOTIFY_STATE_DIR:-$HOME/.claude/notify-state}"

payload=$(cat 2>/dev/null || true)

jget() {
  command -v jq >/dev/null 2>&1 || return 0
  printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null
}

self_id=$(jget '.session_id')
cwd=$(jget '.workspace.current_dir')
[ -n "$cwd" ] || cwd=$(jget '.cwd')
model=$(jget '.model.display_name')

dim=$'\033[2m'; yellow=$'\033[1;33m'; reset=$'\033[0m'

fmt_ago() {
  local s="$1"
  if [ "$s" -lt 60 ]; then printf '%d초' "$s"
  elif [ "$s" -lt 3600 ]; then printf '%d분' "$((s / 60))"
  else printf '%d시간' "$((s / 3600))"; fi
}

now=$(date +%s)
waiting=""
count=0
shown=0

if [ -d "$state_dir" ]; then
  for f in "$state_dir"/*.pending; do
    [ -e "$f" ] || continue
    sid=$(basename "$f" .pending)
    [ -n "$self_id" ] && [ "$sid" = "$self_id" ] && continue

    IFS=$'\t' read -r label kind ts < "$f" 2>/dev/null || continue
    [ -n "${label:-}" ] || continue
    case "${ts:-}" in ''|*[!0-9]*) ts=$now ;; esac

    count=$((count + 1))
    [ "$shown" -ge 3 ] && continue
    shown=$((shown + 1))

    case "${kind:-}" in
      attention) mark="응답" ;;
      *)         mark="완료" ;;
    esac
    [ -n "$waiting" ] && waiting="$waiting · "
    waiting="$waiting$label $mark $(fmt_ago $((now - ts)))"
  done
fi

here=$(basename "${cwd:-$PWD}")

if [ "$count" -gt 0 ]; then
  extra=""
  [ "$count" -gt "$shown" ] && extra=" +$((count - shown))"
  printf '%s[대기 %d]%s %s%s %s· %s%s\n' \
    "$yellow" "$count" "$reset" "$waiting" "$extra" "$dim" "$here" "$reset"
else
  printf '%s%s%s%s\n' "$dim" "$here" "${model:+ · $model}" "$reset"
fi
