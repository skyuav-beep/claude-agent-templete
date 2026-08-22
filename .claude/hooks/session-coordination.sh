#!/usr/bin/env bash
# Claude/Codex 공용 세션 등록·파일 점유 충돌 점검기.
# 저장소 내부가 아닌 사용자 런타임 디렉터리에 상태를 둬 worktree와 충돌하지 않는다.

set -u

command -v jq >/dev/null 2>&1 || exit 0
command -v flock >/dev/null 2>&1 || exit 0

payload=$(cat 2>/dev/null || true)
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
common=$(git rev-parse --git-common-dir 2>/dev/null || printf '%s/.git' "$root")
common=$(cd "$root" && realpath "$common" 2>/dev/null || printf '%s' "$common")
repo_key=$(printf '%s' "$common" | sha256sum | cut -d' ' -f1)
state_base="${SESSION_COORD_STATE_DIR:-${XDG_RUNTIME_DIR:-$HOME/.cache}/claude-agent-sessions}"
state_dir="$state_base/$repo_key"
mkdir -p "$state_dir" 2>/dev/null || exit 0
exec 9>"$state_dir/.lock" 2>/dev/null || exit 0
flock 9

json_get() { printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null; }
sid="${SESSION_COORD_SESSION_ID:-$(json_get '.session_id')}"
[ -n "$sid" ] || sid="pid-$PPID"
sid_file=$(printf '%s' "$sid" | sha256sum | cut -d' ' -f1)
record="$state_dir/$sid_file.json"

canon() { realpath -m "$1" 2>/dev/null || printf '%s/%s' "$root" "$1"; }
now=$(date +%s)
branch=$(git -C "$root" branch --show-current 2>/dev/null || true)
worktree=$(pwd -P)

write_record() {
  local tmp="$record.tmp.$$"
  printf '%s' "$1" > "$tmp" 2>/dev/null && mv -f "$tmp" "$record" 2>/dev/null
}

cleanup_stale() {
  local f pid comm actual started
  for f in "$state_dir"/*.json; do
    [ -f "$f" ] || continue
    started=$(jq -r '.started_at // 0' "$f" 2>/dev/null)
    case "$started" in
      ''|*[!0-9]*) started=0 ;;
    esac
    [ "$started" -gt 0 ] && [ $((now - started)) -gt 86400 ] && { rm -f "$f" 2>/dev/null; continue; }
    pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
    comm=$(jq -r '.pid_comm // empty' "$f" 2>/dev/null)
    [ -n "$pid" ] && [ -n "$comm" ] || continue
    actual=$(ps -p "$pid" -o comm= 2>/dev/null | tr -d ' ' || true)
    [ "$actual" = "$comm" ] || rm -f "$f" 2>/dev/null
  done
}

register() {
  local owner_pid="${SESSION_COORD_OWNER_PID:-}"
  case "$owner_pid" in ''|*[!0-9]*) owner_pid="" ;; esac
  write_record "$(jq -n \
    --arg sid "$sid" --arg repo "$root" --arg common "$common" \
    --arg branch "$branch" --arg worktree "$worktree" \
    --arg pid "$owner_pid" --arg pid_comm "$( [ -n "$owner_pid" ] && ps -p "$owner_pid" -o comm= 2>/dev/null | tr -d ' ' || true )" \
    --argjson started "$now" \
    '{session_id:$sid, repository:$repo, git_common_dir:$common, branch:$branch, worktree:$worktree, pid:(if $pid == "" then null else ($pid|tonumber) end), pid_comm:$pid_comm, started_at:$started, status:"active", paths:[]}')"
}

release() { rm -f "$record" 2>/dev/null; }

claim() {
  local path="$1" f other_sid other_label
  path=$(canon "$path")
  cleanup_stale
  for f in "$state_dir"/*.json; do
    [ -f "$f" ] || continue
    [ "$f" = "$record" ] && continue
    if jq -e --arg path "$path" '.paths // [] | index($path) != null' "$f" >/dev/null 2>&1; then
      other_sid=$(jq -r '.session_id // "unknown"' "$f")
      other_label=$(jq -r '(.branch // "") + " @ " + (.worktree // "")' "$f")
      jq -n --arg sid "$other_sid" --arg label "$other_label" --arg path "$path" \
        '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"ask",permissionDecisionReason:("다른 세션이 이미 같은 파일을 점유하고 있습니다. 세션=" + $sid + ", 작업=" + $label + ", 파일=" + $path + ". 기존 세션 완료를 기다리거나 사용자 확인 후 진행하세요.")}}'
      return 0
    fi
  done
  [ -f "$record" ] || register
  local tmp="$record.tmp.$$"
  jq --arg path "$path" '.paths = ((.paths // []) + [$path] | unique)' "$record" > "$tmp" 2>/dev/null && mv -f "$tmp" "$record" 2>/dev/null
}

status() {
  cleanup_stale
  for f in "$state_dir"/*.json; do
    [ -f "$f" ] || continue
    jq -r '[.session_id, .status, .branch, .worktree, ((.paths // []) | join(","))] | @tsv' "$f" 2>/dev/null
  done
}

resource() {
  local safe_root key safe_sid port_offset
  safe_root=$(basename "$root" | tr -c '[:alnum:]' '-' | sed 's/-*$//')
  key=$(printf '%s' "$sid" | sha256sum | cut -c1-8)
  safe_sid=$(printf '%s' "$sid" | tr -c '[:alnum:]' '-' | sed 's/-*$//' | cut -c1-24)
  port_offset=$((16#${key:0:4} % 1000))
  printf 'export SESSION_COORD_SESSION_ID=%q\n' "$sid"
  printf 'export COMPOSE_PROJECT_NAME=%q\n' "${safe_root}-${safe_sid}-${key}"
  printf 'export SESSION_COORD_DOCKER_NETWORK=%q\n' "${safe_root}-${key}-net"
  printf 'export SESSION_COORD_DB_NAME=%q\n' "${safe_root}_${key}"
  printf 'export SESSION_COORD_PORT_OFFSET=%q\n' "$port_offset"
}

cleanup_stale
case "${1:-hook}" in
  register) register ;;
  release) release ;;
  claim) [ -n "${2:-}" ] && claim "$2" ;;
  status) status ;;
  resource) resource ;;
  hook)
    event=$(json_get '.hook_event_name')
    case "$event" in
      SessionStart) register ;;
      SessionEnd) release ;;
      PreToolUse)
        file_path=$(json_get '.tool_input.file_path')
        [ -n "$file_path" ] && claim "$file_path"
        ;;
    esac
    ;;
esac
