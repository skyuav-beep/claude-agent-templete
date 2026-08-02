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

mtime_of() {
  [ -n "${1:-}" ] && [ -e "$1" ] || { printf '0'; return; }
  stat -c %Y "$1" 2>/dev/null || stat -f %m "$1" 2>/dev/null || printf '0'
}

alive() {
  case "${1:-}" in
    ''|*[!0-9]*) return 1 ;;
    *) kill -0 "$1" 2>/dev/null ;;
  esac
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

    IFS=$'\t' read -r label kind ts pid pcomm bmtime tpath < "$f" 2>/dev/null || continue
    [ -n "${label:-}" ] || continue
    case "${ts:-}" in ''|*[!0-9]*) ts=$now ;; esac

    # 소유 프로세스가 사라진 표식은 누구도 확인해 줄 수 없다. 그 창에 입력이 들어올 일이 없으니
    # 명시적 확인(notify-ack.sh)도 영영 오지 않는다. 여기서 걷어내지 않으면 하루 동안 유령으로 남는다.
    # PID가 없는 예전 형식의 표식은 판정 근거가 없으므로 종전대로 표시한다.
    if [ -n "${pid:-}" ] && [ -n "${pcomm:-}" ]; then
      if [ "$(ps -p "$pid" -o comm= 2>/dev/null | tr -d ' ')" != "$pcomm" ]; then
        rm -f "$f" 2>/dev/null
        continue
      fi
    fi

    # 반복 알림 워처가 살아 있는 동안은 그쪽이 확인 여부를 감시하므로 관여하지 않는다.
    # 워처는 재알림 횟수를 소진하면 끝나는데, 그 뒤로는 감시자가 없어 표식이 그대로 남는다.
    # 명시적 확인 훅이 없는 런타임(Codex)은 이 경로가 유일한 회수 수단이므로 상태줄이 이어받는다.
    if [ -n "${tpath:-}" ] && [ -n "${bmtime:-}" ] && ! alive "$(cat "$state_dir/$sid.watcher" 2>/dev/null)"; then
      if [ "$(mtime_of "$tpath")" != "$bmtime" ]; then
        rm -f "$f" 2>/dev/null
        continue
      fi
    fi

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
