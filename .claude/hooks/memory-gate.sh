#!/usr/bin/env bash
# 메모리 한도 게이트: 메모리 사용률이 한도(기본 80%) 이상이면 무거운 작업을 새로 시작하지 않고
# 여유가 생길 때까지 기다렸다가 실행한다. 이미 실행 중인 작업은 건드리지 않는다.
# 규칙 정본: docs/claude-codex-collaboration.md ## 동시 실행과 메모리 한도
#
# 사용 방식
#   (인자 없음)            PreToolUse(Bash) 훅. 무거운 명령이면 한도 아래로 내려갈 때까지 대기 후 통과.
#                          최대 대기 시간을 넘기면 사용자 확인(ask)으로 넘긴다. settings의 timeout은 대기 시간보다 길게 둔다.
#   wait                   한도 아래로 내려갈 때까지 대기. 시간 초과면 종료 코드 1
#   run -- <명령...>       대기 후 명령 실행 (예: tmux 창에서 새 세션 시작)
#   status [--short]       현재 사용률과 한도. --short는 tmux 상태줄용 한 줄
#   check <명령 문자열>    그 명령이 무거운 작업으로 판정되는지(heavy/light) 출력
#
# 조정 가능한 환경변수 (기본값)
#   AGENT_MEM_DISABLE      0     1이면 게이트 전체 비활성
#   AGENT_MEM_LIMIT        80    시작 허용 한도(%). 이 값 이상이면 대기
#   AGENT_MEM_INTERVAL     30    재확인 간격(초)
#   AGENT_MEM_MAX_WAIT     600   최대 대기(초). 넘으면 훅은 ask, wait/run은 종료 코드 1
#   AGENT_MEM_EXTRA        (없음) 무거운 명령으로 추가 판정할 정규식(ERE)
#   AGENT_MEM_MEMINFO      /proc/meminfo  측정 원본 (검사용으로 바꿀 수 있다)
#   AGENT_MEM_TEST_SEQ     (없음) 검사용. 줄마다 사용률 숫자를 적은 파일. 측정할 때마다 첫 줄을 꺼내 쓴다

set -u

limit="${AGENT_MEM_LIMIT:-80}"
interval="${AGENT_MEM_INTERVAL:-30}"
max_wait="${AGENT_MEM_MAX_WAIT:-600}"
meminfo="${AGENT_MEM_MEMINFO:-/proc/meminfo}"

# 무거운 작업: 새 에이전트 세션, 개발 서버, 브라우저 테스트, 컨테이너 기동·빌드.
# 버전 확인·로그인·설정 같은 가벼운 하위 명령은 제외한다.
HEAVY_RE='(^|[;&|(]|&&|\|\|)[[:space:]]*(env[[:space:]]+[^;&|]*[[:space:]])?('
HEAVY_RE+='codex([[:space:]]+(exec|e|resume)([[:space:]]|$)|[[:space:]]*$)'
HEAVY_RE+='|claude([[:space:]]+(-p|--print)([[:space:]]|$)|[[:space:]]*$)'
HEAVY_RE+='|node[[:space:]]+[^;&|]*codex-companion\.mjs[[:space:]]+(task|review|adversarial-review)'
HEAVY_RE+='|(npm|pnpm|yarn|bun)([[:space:]]+(--filter|-F|-w|--workspace|-C|--dir|--prefix)[[:space:]=]+[^[:space:];&|]+)*[[:space:]]+(run[[:space:]]+)?(dev|start|preview|e2e|test:e2e|test:ui)([[:space:]]|$)'
HEAVY_RE+='|(npx[[:space:]]+|pnpm[[:space:]]+(exec|dlx)[[:space:]]+)?(next[[:space:]]+(dev|start)|vite([[:space:]]|$)|playwright[[:space:]]+test)'
HEAVY_RE+='|docker([[:space:]]+compose|-compose)[[:space:]]+([^;&|]*[[:space:]])?(up|build|run)([[:space:]]|$)'
HEAVY_RE+='|docker[[:space:]]+(build|run)([[:space:]]|$)'
HEAVY_RE+='|python3?[[:space:]]+[^;&|]*(with_server|playwright)[^;&|]*'
HEAVY_RE+=')'

is_heavy() {
  local cmd="$1"
  printf '%s' "$cmd" | grep -Eq -- "$HEAVY_RE" && return 0
  [ -n "${AGENT_MEM_EXTRA:-}" ] && printf '%s' "$cmd" | grep -Eq -- "$AGENT_MEM_EXTRA" && return 0
  return 1
}

mem_percent() {
  if [ -n "${AGENT_MEM_TEST_SEQ:-}" ] && [ -s "$AGENT_MEM_TEST_SEQ" ]; then
    local v; v=$(head -1 "$AGENT_MEM_TEST_SEQ")
    if [ "$(wc -l < "$AGENT_MEM_TEST_SEQ")" -gt 1 ]; then sed -i '1d' "$AGENT_MEM_TEST_SEQ"; fi
    printf '%s\n' "$v"; return 0
  fi
  awk '/^MemTotal:/{t=$2} /^MemAvailable:/{a=$2} END{ if (t>0) printf "%d\n", (1-a/t)*100; else print 0 }' "$meminfo" 2>/dev/null || echo 0
}

top_processes() {
  ps -eo rss=,comm= 2>/dev/null | awk '{s[$2]+=$1} END{for (k in s) printf "%d %s\n", s[k]/1024, k}' | sort -rn | head -5 \
    | awk '{printf "%s%s %dMB", (NR>1?", ":""), $2, $1}'
}

# 한도 아래로 내려갈 때까지 대기. 0 = 통과, 1 = 시간 초과. 마지막 측정값은 $last에 남는다.
last=0
wait_below() {
  local waited=0 announced=0
  last=$(mem_percent)
  while [ "$last" -ge "$limit" ]; do
    if [ "$waited" -ge "$max_wait" ]; then return 1; fi
    if [ "$announced" = 0 ] || [ "${1:-}" = "verbose" ]; then
      printf '메모리 %s%% (한도 %s%%) — %s초 뒤 다시 확인 (대기 %s/%s초)\n' "$last" "$limit" "$interval" "$waited" "$max_wait" >&2
      announced=1
    fi
    sleep "$interval"
    waited=$((waited + interval))
    last=$(mem_percent)
  done
  return 0
}

mode="${1:-hook}"
case "$mode" in
  status)
    p=$(mem_percent)
    if [ "${2:-}" = "--short" ]; then
      if [ "$p" -ge "$limit" ]; then printf 'mem %s%%>=%s 대기\n' "$p" "$limit"; else printf 'mem %s%%/%s\n' "$p" "$limit"; fi
    else
      state="시작 가능"; [ "$p" -ge "$limit" ] && state="대기 (새 작업 시작 안 함)"
      printf '메모리 사용률 %s%% · 한도 %s%% · %s\n' "$p" "$limit" "$state"
      printf '많이 쓰는 프로세스: %s\n' "$(top_processes)"
    fi
    exit 0 ;;
  check)
    shift
    if is_heavy "$*"; then echo heavy; else echo light; fi
    exit 0 ;;
  wait)
    [ "${AGENT_MEM_DISABLE:-0}" = "1" ] && exit 0
    if wait_below verbose; then exit 0; fi
    printf '메모리 %s%%가 %s초 동안 한도 %s%% 아래로 내려가지 않았습니다. 정리 후보: %s\n' "$last" "$max_wait" "$limit" "$(top_processes)" >&2
    exit 1 ;;
  run)
    shift
    [ "${1:-}" = "--" ] && shift
    [ "$#" -gt 0 ] || { echo "사용: memory-gate.sh run -- <명령...>" >&2; exit 2; }
    if [ "${AGENT_MEM_DISABLE:-0}" != "1" ] && ! wait_below verbose; then
      printf '메모리 %s%%가 %s초 동안 한도 %s%% 아래로 내려가지 않아 실행하지 않았습니다. 정리 후보: %s\n' "$last" "$max_wait" "$limit" "$(top_processes)" >&2
      exit 1
    fi
    exec "$@" ;;
  hook) ;;
  *) echo "사용: memory-gate.sh [wait|run -- <명령>|status [--short]|check <명령>]" >&2; exit 2 ;;
esac

# ── PreToolUse(Bash) 훅 ──
[ "${AGENT_MEM_DISABLE:-0}" = "1" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0
payload=$(cat)
cmd=$(printf '%s' "$payload" | jq -r '.tool_input.command // empty' 2>/dev/null)
[ -n "$cmd" ] || exit 0
is_heavy "$cmd" || exit 0

if wait_below; then exit 0; fi

reason=$(printf '메모리 사용률 %s%%가 %s초 동안 한도 %s%% 아래로 내려가지 않았습니다. 새 무거운 작업을 시작하면 다른 세션이 느려지거나 멈출 수 있습니다. 정리 후보(다른 세션 것은 끄지 마세요): %s. 그래도 실행하려면 승인하세요.' \
  "$last" "$max_wait" "$limit" "$(top_processes)")
jq -nc --arg r "$reason" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"ask",permissionDecisionReason:$r}}'
exit 0
