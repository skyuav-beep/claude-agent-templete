#!/usr/bin/env bash
# 에이전트 이벤트 기록기: Claude·Codex 세션의 상태 변화를 파일 하나(JSONL)에 모으고,
# 그 파일로 여러 프로젝트의 세션 현황을 보여 준다. 감시 화면(TUI·GUI)은 이 파일만 읽으면 된다.
# 규칙·형식 정본: docs/claude-codex-collaboration.md ## 이벤트 기록과 현황 보기
#
# 사용 방식
#   (인자 없음)           Claude 훅. stdin의 훅 입력을 한 줄로 정규화해 기록한다. 반드시 "async": true로 등록한다
#   codex <payload>       Codex notify 어댑터(.codex/hooks/notify-codex.sh)가 턴 완료를 기록할 때 쓴다
#   status [--hours N]    세션별 현재 상태 표 (기본 최근 12시간)
#   status --short        tmux 상태줄용 한 줄 요약
#   watch [--interval S]  status를 S초(기본 2)마다 다시 그리는 터미널 화면. q 또는 Ctrl-C로 종료
#   path                  이벤트 파일 경로 출력
#
# 기록하지 않는 것: 프롬프트 본문, 응답 본문, 파일 내용. Bash 명령은 앞 120자만 남기고
# 비밀값으로 보이는 부분(키=값, 토큰, Bearer, URL 계정)은 *** 로 가린다.
#
# 조정 가능한 환경변수 (기본값)
#   AGENT_EVENTS_DISABLE   0     1이면 기록하지 않음
#   AGENT_EVENTS_FILE      ${XDG_STATE_HOME:-~/.local/state}/agent-events/events.jsonl
#   AGENT_EVENTS_MAX_MB    20    넘으면 events.jsonl.1로 넘기고 새로 시작
#   AGENT_EVENTS_STALE_MIN 30    실행 중인데 이 시간(분) 동안 이벤트가 없으면 '멈춤?'으로 표시
#   CODEX_HOME             ~/.codex  Codex 실행 로그(sessions) 위치

set -u

events_file="${AGENT_EVENTS_FILE:-${XDG_STATE_HOME:-$HOME/.local/state}/agent-events/events.jsonl}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 비밀값 가림 + 120자 자르기 (jq 함수)
JQ_MASK='def mask: tostring
  | gsub("(?i:bearer)\\s+[A-Za-z0-9._~+/=-]+"; "Bearer ***")
  | gsub("(?<k>(?i:password|passwd|pwd|secret|token|api[_-]?key|access[_-]?key|auth|authorization|cookie|session))(?<s>[\"'"'"']?\\s*[=:]\\s*[\"'"'"']?)[^\\s\"'"'"'&;|]+"; "\(.k)\(.s)***")
  | gsub("(sk|pk|rk)-[A-Za-z0-9_-]{8,}"; "***")
  | gsub("gh[pousr]_[A-Za-z0-9]{16,}"; "***")
  | gsub("xox[abprs]-[A-Za-z0-9-]{8,}"; "***")
  | gsub("AKIA[0-9A-Z]{16}"; "***")
  | gsub("eyJ[A-Za-z0-9_-]{8,}\\.[A-Za-z0-9_-]{8,}\\.[A-Za-z0-9_-]+"; "***")
  | gsub("://[^/\\s:@]+:[^/\\s@]+@"; "://***@")
  | gsub("[\\r\\n\\t]+"; " ")
  | if length > 120 then .[0:119] + "…" else . end;'

project_of() {
  local dir="$1" common
  [ -d "$dir" ] || { basename "$dir"; return; }
  common=$(git -C "$dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || { basename "$dir"; return; }
  basename "$(dirname "$common")"
}

append() {
  local line="$1" dir max
  dir=$(dirname "$events_file")
  mkdir -p "$dir" 2>/dev/null || return 0
  max=$(( ${AGENT_EVENTS_MAX_MB:-20} * 1024 * 1024 ))
  if [ -f "$events_file" ] && [ "$(stat -c %s "$events_file" 2>/dev/null || echo 0)" -gt "$max" ]; then
    mv -f "$events_file" "$events_file.1" 2>/dev/null
  fi
  printf '%s\n' "$line" >> "$events_file"
}

record_claude() {
  local payload cwd project branch line
  payload=$(cat)
  printf '%s' "$payload" | jq -e . >/dev/null 2>&1 || return 0
  cwd=$(printf '%s' "$payload" | jq -r '.cwd // empty')
  [ -n "$cwd" ] || cwd="$PWD"
  project=$(project_of "$cwd")
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || true)
  line=$(printf '%s' "$payload" | jq -c --arg project "$project" --arg branch "$branch" --arg cwd "$cwd" "$JQ_MASK"'
    . as $p
    | ($p.tool_input // {}) as $in
    | {
        ts: now | floor,
        provider: "claude",
        event: ($p.hook_event_name // "unknown"),
        session: ($p.session_id // ""),
        project: $project,
        branch: $branch,
        cwd: $cwd,
        tool: ($p.tool_name // null),
        target: (
          if $p.tool_name == "Bash" then ($in.command // "" | mask)
          else ($in.file_path // $in.notebook_path // $in.path // $in.pattern // $in.url // $in.description // null)
               | if . == null then null else mask end
          end),
        agent: ($p.agent_type // $in.subagent_type // null),
        kind: ($p.notification_type // null),
        note: (($p.task_subject // $p.message // $p.error // null) | if . == null then null else mask end)
      }
    | with_entries(select(.value != null and .value != ""))' 2>/dev/null) || return 0
  [ -n "$line" ] && append "$line"
}

record_codex() {
  local payload="$1" cwd project branch line
  printf '%s' "$payload" | jq -e . >/dev/null 2>&1 || return 0
  cwd=$(printf '%s' "$payload" | jq -r '.cwd // empty')
  [ -n "$cwd" ] || cwd="$PWD"
  project=$(project_of "$cwd")
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || true)
  line=$(printf '%s' "$payload" | jq -c --arg project "$project" --arg branch "$branch" --arg cwd "$cwd" '
    {
      ts: now | floor,
      provider: "codex",
      event: (if .type == "agent-turn-complete" then "Stop" else (.type // "unknown") end),
      session: (."thread-id" // ."session-id" // ""),
      project: $project,
      branch: $branch,
      cwd: $cwd
    } | with_entries(select(.value != null and .value != ""))' 2>/dev/null) || return 0
  [ -n "$line" ] && append "$line"
}

# 세션별 최신 상태. 출력: TSV(상태, 제공자, 프로젝트, 세션, 경과초, 최근 동작, 서브, 작업)
summarize() {
  local hours="$1" stale_min="${AGENT_EVENTS_STALE_MIN:-30}"
  [ -s "$events_file" ] || return 0
  tail -n 20000 "$events_file" | jq -rs --argjson hours "$hours" --argjson stale "$stale_min" '
    (now | floor) as $now
    | map(select(type == "object" and (.session // "") != ""))
    | group_by(.provider + ":" + .session)
    | map(
        . as $ev
        | ($ev | last) as $l
        | ($ev | map(select(.event == "UserPromptSubmit")) | last | .ts // 0) as $turn
        | ($ev | map(select(.ts >= $turn))) as $cur
        | (($cur | map(select(.event == "SubagentStart")) | length) - ($cur | map(select(.event == "SubagentStop")) | length)) as $subs
        | ($ev | map(select(.event == "TaskCreated")) | length) as $tc
        | ($ev | map(select(.event == "TaskCompleted")) | length) as $td
        | ($now - $l.ts) as $age
        | (if $l.event == "SessionEnd" then "종료"
           elif $l.event == "StopFailure" then "오류"
           elif $l.event == "PermissionRequest" then "응답 필요"
           elif $l.event == "Notification" and (($l.kind // "") | test("permission|idle|needs_input|elicitation")) then "응답 필요"
           elif $l.event == "Stop" then "완료"
           elif $age > ($stale * 60) then "멈춤?"
           else "실행 중" end) as $state
        | ($ev | map(select(.event == "PreToolUse")) | last) as $act
        | {
            state: $state,
            provider: $l.provider,
            project: ($l.project // "-"),
            session: $l.session,
            age: $age,
            last: (if $state == "실행 중" or $state == "멈춤?" then
                     (if $act then (($act.tool // "") + (if $act.agent then "(" + $act.agent + ")" else "" end) + " " + ($act.target // "")) else $l.event end)
                   elif $state == "응답 필요" then ($l.note // $l.kind // "확인 요청")
                   else ($l.branch // "") end),
            subs: (if $subs > 0 then $subs else 0 end),
            tasks: (if $tc > 0 then "\($td)/\($tc)" else "" end)
          })
    | map(select(.state != "종료" and .age <= ($hours * 3600)))
    | sort_by([({"응답 필요":0,"오류":1,"실행 중":2,"멈춤?":3,"완료":4}[.state] // 9), .age])
    | .[] | [.state, .provider, .project, .session, (.age|tostring), .last, (.subs|tostring), .tasks] | @tsv' 2>/dev/null
}

# 이벤트에 없는 최근 Codex 실행(대화형 세션 진행 중)을 실행 로그 갱신 시각으로 찾는다
codex_live() {
  local sessions="${CODEX_HOME:-$HOME/.codex}/sessions" known="$1"
  [ -d "$sessions" ] || return 0
  find "$sessions" -type f -name 'rollout-*' -mmin -5 2>/dev/null | while read -r f; do
    id=$(basename "$f" | grep -oE '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' | tail -1)
    [ -n "$id" ] || continue
    age=$(( $(date +%s) - $(stat -c %Y "$f") ))
    if printf '%s\n' "$known" | grep -q "^codex	.*	$id	"; then
      # 기록상 '완료'인데 로그가 그 뒤에 갱신됐으면 다음 턴이 진행 중이다
      printf 'UPDATE\t%s\t%s\n' "$id" "$age"
    else
      printf '실행 중\tcodex\t-\t%s\t%s\t실행 로그 갱신 중\t0\t\n' "$id" "$age"
    fi
  done
}

fmt_age() {
  local s="$1"
  if [ "$s" -lt 60 ]; then echo "${s}초"; elif [ "$s" -lt 3600 ]; then echo "$((s / 60))분"; else echo "$((s / 3600))시간"; fi
}

status() {
  local hours=12 short=0
  while [ "$#" -gt 0 ]; do
    case "$1" in --hours) hours="$2"; shift 2 ;; --short) short=1; shift ;; *) shift ;; esac
  done
  local rows extra
  rows=$(summarize "$hours")
  extra=$(codex_live "$(printf '%s\n' "$rows" | awk -F'\t' '{print $2"\t"$1"\t"$3"\t"$4"\t"}')")
  # 완료로 기록된 Codex 세션의 로그가 더 최근이면 실행 중으로 바꾼다
  if [ -n "$extra" ]; then
    while IFS=$'\t' read -r tag id age; do
      [ "$tag" = "UPDATE" ] || continue
      rows=$(printf '%s\n' "$rows" | awk -F'\t' -v OFS='\t' -v id="$id" -v age="$age" '$2=="codex" && $4==id && age+0 < $5+0 {$1="실행 중"; $5=age; $6="새 턴 진행 중"} {print}')
    done <<< "$extra"
    rows=$(printf '%s\n%s\n' "$rows" "$(printf '%s\n' "$extra" | grep -v '^UPDATE')" | sed '/^$/d')
  fi
  local mem
  mem=$(bash "$here/memory-gate.sh" status --short 2>/dev/null || true)
  if [ "$short" = 1 ]; then
    printf '%s\n' "$rows" | awk -F'\t' -v mem="$mem" '
      $1=="실행 중"{r++} $1=="응답 필요"{w++} $1=="오류"{e++} $1=="멈춤?"{s++} $1=="완료"{d++}
      END{ out=sprintf("실행 %d · 응답 %d", r, w); if (e) out=out sprintf(" · 오류 %d", e); if (s) out=out sprintf(" · 멈춤? %d", s); if (mem!="") out=out " · " mem; print out }'
    return 0
  fi
  printf '%s · 이벤트 %s\n\n' "${mem:-mem ?}" "$events_file"
  if [ -z "$rows" ]; then echo "최근 ${hours}시간 안에 기록된 세션이 없습니다."; return 0; fi
  printf '%-8s %-6s %-22s %-9s %-6s %-5s %-5s %s\n' "상태" "제공자" "프로젝트" "세션" "경과" "서브" "작업" "최근 동작"
  printf '%s\n' "$rows" | while IFS=$'\t' read -r state provider project session age last subs tasks; do
    printf '%-8s %-6s %-22.22s %-9.8s %-6s %-5s %-5s %s\n' "$state" "$provider" "$project" "$session" "$(fmt_age "$age")" \
      "$([ "$subs" != 0 ] && echo "$subs" || echo -)" "${tasks:--}" "$last"
  done
}

# 터미널 현황. 이벤트 파일이 바뀌었을 때만 다시 계산하고, 바뀌지 않아도 경과 시간이 맞도록
# 최대 AGENT_EVENTS_REFRESH_MAX(기본 15)초마다 한 번은 다시 계산한다. 키 입력이 없는 환경(파이프·백그라운드)에서는
# read가 즉시 끝나므로 sleep으로 간격을 지킨다(그러지 않으면 CPU 한 코어를 계속 쓴다).
watch_loop() {
  local every=2 max_stale="${AGENT_EVENTS_REFRESH_MAX:-15}" key="" out="" last_mtime="" last_calc=0 mtime now tty=0
  [ "${1:-}" = "--interval" ] && every="${2:-2}"
  [ -t 0 ] && tty=1
  trap 'tput cnorm 2>/dev/null; exit 0' INT TERM
  [ "$tty" = 1 ] && tput civis 2>/dev/null
  while :; do
    mtime=$(stat -c %Y "$events_file" 2>/dev/null || echo 0)
    now=$(date +%s)
    if [ "$mtime" != "$last_mtime" ] || [ $((now - last_calc)) -ge "$max_stale" ]; then
      out=$(status)
      last_mtime="$mtime"; last_calc="$now"
      printf '\033[H\033[2J%s\n\n%s초마다 확인 · 바뀐 경우에만 다시 계산 · q 종료\n' "$out" "$every"
    fi
    if [ "$tty" = 1 ]; then
      if read -rsn1 -t "$every" key 2>/dev/null && [ "$key" = "q" ]; then break; fi
    else
      sleep "$every"
    fi
  done
  [ "$tty" = 1 ] && tput cnorm 2>/dev/null
}

command -v jq >/dev/null 2>&1 || { [ "${1:-}" = "" ] && exit 0; echo "jq가 필요합니다" >&2; exit 1; }

case "${1:-}" in
  "") [ "${AGENT_EVENTS_DISABLE:-0}" = "1" ] && exit 0; record_claude ;;
  codex) [ "${AGENT_EVENTS_DISABLE:-0}" = "1" ] && exit 0; shift; record_codex "${1:-}" ;;
  status) shift; status "$@" ;;
  watch) shift; watch_loop "$@" ;;
  path) echo "$events_file" ;;
  *) echo "사용: agent-events.sh [codex <payload>|status [--hours N|--short]|watch [--interval S]|path]" >&2; exit 2 ;;
esac
exit 0
