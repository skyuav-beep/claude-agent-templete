#!/usr/bin/env bash
# Claude/Codex 공용 세션 등록·파일 점유 충돌 점검기.
# 저장소 내부가 아닌 사용자 런타임 디렉터리에 상태를 둬 worktree와 충돌하지 않는다.

set -u

command -v jq >/dev/null 2>&1 || exit 0

mode="${1:-hook}"

# CLI 모드에서 stdin을 읽으면 터미널 실행이 EOF를 기다리며 멈춘다.
# hook 모드이면서 stdin이 파이프로 연결됐을 때만 payload를 읽는다.
payload=""
if [ "$mode" = "hook" ] && [ ! -t 0 ]; then
  payload=$(cat 2>/dev/null || true)
fi

# GNU sha256sum과 macOS shasum을 모두 지원한다. 둘 다 없으면 경로를 파일명 안전
# 문자열로 환원해 레지스트리가 조용히 비활성화되지 않게 한다.
hash_hex() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum | cut -d' ' -f1
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 | cut -d' ' -f1
  else
    tr -c '[:alnum:]' '-' | cut -c1-64
  fi
}

root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
common=$(git rev-parse --git-common-dir 2>/dev/null || printf '%s/.git' "$root")
common=$(cd "$root" && realpath "$common" 2>/dev/null || printf '%s' "$common")
repo_key=$(printf '%s' "$common" | hash_hex)
state_base="${SESSION_COORD_STATE_DIR:-${XDG_RUNTIME_DIR:-$HOME/.cache}/claude-agent-sessions}"
state_dir="$state_base/$repo_key"
mkdir -p "$state_dir" 2>/dev/null || exit 0

# flock이 없는 환경(기본 macOS 등)에서는 락 없이 진행한다. 같은 사용자 계정의
# 짧은 갱신이라 경합 확률은 낮고, 조용히 종료하는 것보다 조정이 동작하는 편이 낫다.
if command -v flock >/dev/null 2>&1; then
  if exec 9>"$state_dir/.lock" 2>/dev/null; then
    flock 9
  fi
fi

json_get() { printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null; }

sid="${SESSION_COORD_SESSION_ID:-$(json_get '.session_id')}"
if [ -z "$sid" ]; then
  # POSIX 세션 ID는 같은 터미널·같은 셸 세션에서 호출 간 불변이라
  # register/claim/release가 하나의 레코드를 공유한다. PPID는 명령마다
  # 새 셸을 띄우는 실행기에서 갈라지므로 최후 수단으로만 쓴다.
  posix_sid=$(ps -o sid= -p $$ 2>/dev/null | tr -d ' ')
  case "$posix_sid" in
    ''|*[!0-9]*) sid="pid-$PPID" ;;
    *) sid="sess-$posix_sid" ;;
  esac
fi
sid_file=$(printf '%s' "$sid" | hash_hex)
record="$state_dir/$sid_file.json"

# 세션이 비정상 종료되면 SessionEnd가 실행되지 않아 레코드가 남는다. PID 검증은
# owner PID를 아는 경우에만 가능하므로 TTL이 실질적인 정리 기준이다.
ttl="${SESSION_COORD_TTL_SECONDS:-28800}"
case "$ttl" in
  ''|*[!0-9]*) ttl=28800 ;;
esac

canon() {
  local p="$1"
  case "$p" in
    /*) ;;
    *) p="$PWD/$p" ;;
  esac
  realpath -m "$p" 2>/dev/null || realpath "$p" 2>/dev/null || printf '%s' "$p"
}

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
    [ "$started" -gt 0 ] && [ $((now - started)) -gt "$ttl" ] && { rm -f "$f" 2>/dev/null; continue; }
    pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
    comm=$(jq -r '.pid_comm // empty' "$f" 2>/dev/null)
    [ -n "$pid" ] && [ -n "$comm" ] || continue
    actual=$(ps -p "$pid" -o comm= 2>/dev/null | tr -d ' ' || true)
    [ "$actual" = "$comm" ] || rm -f "$f" 2>/dev/null
  done
}

# 등록에 pid 가 없으면 cleanup_stale 이 생존 검사를 못 해 TTL(기본 8시간) 까지
# 유령 등록이 남는다. 환경변수가 없을 때 부모를 거슬러 올라가 실행기 프로세스를
# 찾아 둔다. 못 찾으면 종전대로 비워 두고, 그 경우 TTL 로만 정리된다.
detect_owner_pid() {
  local p="$PPID" depth=0 comm parent
  while [ "$depth" -lt 12 ]; do
    case "$p" in ''|0|1|*[!0-9]*) return ;; esac
    comm=$(ps -p "$p" -o comm= 2>/dev/null | tr -d ' ')
    case "$comm" in
      claude|claude-code|codex|cursor) printf '%s' "$p"; return ;;
    esac
    parent=$(ps -p "$p" -o ppid= 2>/dev/null | tr -d ' ')
    [ "$parent" = "$p" ] && return
    p="$parent"
    depth=$((depth + 1))
  done
}

register() {
  local owner_pid="${SESSION_COORD_OWNER_PID:-}"
  case "$owner_pid" in ''|*[!0-9]*) owner_pid="" ;; esac
  [ -n "$owner_pid" ] || owner_pid=$(detect_owner_pid)
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

# 다른 세션이 같은 저장소에 등록돼 있을 때만, 남의 브랜치·worktree·원격 ref 를
# 없앨 수 있는 git 명령을 확인 대상으로 돌린다. 한쪽이 만든 브랜치를 다른 창이
# 정리해 버리면 커밋을 되짚을 단서가 reflog 밖에 남지 않는다.
# 혼자 쓰는 저장소에서는 아무것도 하지 않는다.
#
# 이 세션이 만든 브랜치·worktree(`git worktree add -b`, `checkout -b`, 새 원격
# 브랜치 push)는 세션 레코드에 적어 두고, 지우는 대상이 전부 이 세션 것이면
# 묻지 않는다. 대상을 읽을 수 없거나(`$VAR` 등) 하나라도 이 세션 것이 아니면
# 종전대로 확인한다. 이력 덮어쓰기와 `worktree prune`은 대상과 무관하게 확인한다.
guard_git() {
  local cmd="$1" rc pysrc
  case "$cmd" in *git*) ;; *) return ;; esac
  command -v python3 >/dev/null 2>&1 || { guard_git_legacy "$cmd"; return; }
  # Python 본문은 임시 파일로 넘긴다. Windows(MSYS)에서 /dev/fd 경로는 네이티브
  # Python이 열 수 없다(phase-approval.sh와 같은 이유).
  pysrc=$(mktemp) || { guard_git_legacy "$cmd"; return; }
  cat >"$pysrc" <<'PY'
import glob
import json
import os
import re
import shlex
import subprocess
import sys

cmd = os.environ["SC_CMD"]
cwd = os.environ.get("SC_CWD") or os.getcwd()
record = os.environ["SC_RECORD"]
state_dir = os.environ["SC_STATE_DIR"]
SEP = {";", "&&", "||", "|", "&", "|&", ";;", "(", ")"}


def load(path):
    try:
        with open(path, encoding="utf-8") as fh:
            return json.load(fh)
    except Exception:
        return {}


def canon(base, p):
    return os.path.realpath(os.path.join(base, os.path.expanduser(p)))


def opaque(token):
    # 셸이 실행 시점에 바꾸는 값은 대상을 알 수 없다.
    return any(c in token for c in "$`*?")


def short(ref):
    return ref[len("refs/heads/"):] if ref.startswith("refs/heads/") else ref


def git_ok(base, *args):
    try:
        return subprocess.run(["git", "-C", base, *args], capture_output=True, timeout=5).returncode == 0
    except Exception:
        return False


# 리다이렉션(2>&1, >/dev/null)은 인자가 아니므로 먼저 걷어 낸다.
text = re.sub(r"\d*(?:<<-?|>>|<|>)&?\s*(?:'[^']*'|\"[^\"]*\"|[^\s;&|()'\"]+)?", " ", cmd.replace("\n", " ; "))
try:
    lex = shlex.shlex(text, posix=True, punctuation_chars=";&|()")
    lex.whitespace_split = True
    tokens = list(lex)
except ValueError:
    sys.exit(3)

segments, cur = [], []
for t in tokens:
    if t in SEP:
        segments.append(cur)
        cur = []
    else:
        cur.append(t)
segments.append(cur)

vcwd = cwd
made_b, made_w = set(), set()
del_b, del_w, always = [], [], []
for seg in segments:
    while seg and re.match(r"^[A-Za-z_][A-Za-z0-9_]*=", seg[0]):
        seg = seg[1:]
    if not seg:
        continue
    if seg[0] == "cd":
        if len(seg) > 1 and not opaque(seg[1]):
            vcwd = canon(vcwd, seg[1])
        continue
    if seg[0] != "git":
        continue
    base, j = vcwd, 1
    while j < len(seg) and seg[j].startswith("-"):
        if seg[j] == "-C" and j + 1 < len(seg):
            base = canon(base, seg[j + 1])
            j += 2
        elif seg[j] in ("-c", "--git-dir", "--work-tree", "--namespace") and j + 1 < len(seg):
            j += 2
        else:
            j += 1
    if j >= len(seg):
        continue
    sub, args = seg[j], seg[j + 1:]
    flags = [a for a in args if a.startswith("-")]
    names = [a for a in args if not a.startswith("-")]

    if sub == "branch":
        if any(f in ("-d", "-D", "--delete") or re.match(r"^-[A-Za-z]*[dD][A-Za-z]*$", f) for f in flags):
            remote = "-r" in flags or "--remotes" in flags
            for n in names:
                del_b.append(n.split("/", 1)[-1] if remote else n)
        elif not flags and names and not opaque(names[0]) and not git_ok(base, "rev-parse", "--verify", "-q", "refs/heads/" + names[0]):
            made_b.add(names[0])
    elif sub in ("checkout", "switch"):
        for k, a in enumerate(args):
            if a in ("-b", "-B", "-c", "-C") and k + 1 < len(args) and not opaque(args[k + 1]):
                made_b.add(args[k + 1])
    elif sub == "worktree" and args:
        act, rest = args[0], args[1:]
        if act == "add":
            pos, k = [], 0
            while k < len(rest):
                a = rest[k]
                if a in ("-b", "-B") and k + 1 < len(rest):
                    if not opaque(rest[k + 1]):
                        made_b.add(rest[k + 1])
                    k += 2
                    continue
                if a == "--reason":
                    k += 2
                    continue
                if not a.startswith("-"):
                    pos.append(a)
                k += 1
            if pos and not opaque(pos[0]):
                made_w.add(canon(base, pos[0]))
        elif act == "remove":
            for p in (a for a in rest if not a.startswith("-")):
                del_w.append(p if opaque(p) else canon(base, p))
        elif act == "prune":
            always.append("git worktree prune")
    elif sub == "update-ref" and ("-d" in flags or "--delete" in flags):
        always.append("git update-ref -d")
    elif sub == "push":
        delete, force, pos, k = False, False, [], 0
        while k < len(args):
            a = args[k]
            if a in ("--delete", "-d"):
                delete = True
            elif a in ("-f", "--force", "--mirror") or a.startswith("--force-with-lease") or a.startswith("--force-if-includes"):
                force = True
            elif a in ("-o", "--push-option", "--repo", "--receive-pack", "--exec"):
                k += 1
            elif a.startswith("-") and not a.startswith("--"):
                force = force or "f" in a[1:]
                delete = delete or "d" in a[1:]
            elif not a.startswith("-"):
                pos.append(a)
            k += 1
        if force:
            always.append("git push (이력 덮어쓰기)")
        remote = pos[0] if pos else "origin"
        for r in pos[1:]:
            if delete or r.startswith(":"):
                del_b.append(r if opaque(r) else short(r.lstrip(":")))
            elif r.startswith("+"):
                always.append(r)
            elif not opaque(r):
                dst = short(r.split(":", 1)[1] if ":" in r else r)
                # 원격에 아직 없는 브랜치를 올리는 경우만 이 세션 것으로 본다.
                if dst != "HEAD" and not git_ok(base, "rev-parse", "--verify", "-q", f"refs/remotes/{remote}/{dst}"):
                    made_b.add(dst)

mine = load(record)
if made_b or made_w:
    mine["branches"] = sorted(set(mine.get("branches") or []) | made_b)
    mine["worktrees"] = sorted(set(mine.get("worktrees") or []) | made_w)
    tmp = f"{record}.tmp.{os.getpid()}"
    try:
        with open(tmp, "w", encoding="utf-8") as fh:
            json.dump(mine, fh, ensure_ascii=False)
        os.replace(tmp, record)
    except Exception:
        pass

if not (del_b or del_w or always):
    sys.exit(0)
others = [load(f) for f in glob.glob(os.path.join(state_dir, "*.json")) if f != record]
if not others:
    sys.exit(0)

their_b, their_w = set(), set()
for o in others:
    their_b.update([o.get("branch") or ""] + list(o.get("branches") or []))
    their_w.update([o.get("worktree") or ""] + list(o.get("worktrees") or []))
my_b = set(mine.get("branches") or [])
my_w = set(mine.get("worktrees") or [])
problems = list(always)
problems += [b for b in del_b if opaque(b) or b not in my_b or b in their_b]
problems += [w for w in del_w if opaque(w) or w not in my_w or w in their_w]
if not problems:
    sys.exit(0)

o = others[-1]
label = f"{o.get('session_id') or 'unknown'} / {o.get('branch') or '?'} @ {o.get('worktree') or '?'}"
reason = (
    f"이 세션이 만들지 않았거나 대상을 알 수 없는 브랜치·worktree·원격 ref 를 지우거나 덮어쓰려 합니다: {', '.join(problems)}. "
    f"이 저장소에 다른 세션 {len(others)}개가 등록돼 있습니다(예: {label}). "
    "그쪽 작업이면 되돌릴 수 없게 됩니다. 해당 브랜치가 본인 것인지 확인한 뒤 진행하세요."
)
print(json.dumps({"hookSpecificOutput": {"hookEventName": "PreToolUse", "permissionDecision": "ask", "permissionDecisionReason": reason}}, ensure_ascii=False))
PY
  [ -f "$record" ] || register
  SC_CMD="$cmd" SC_CWD="${hook_cwd:-$PWD}" SC_RECORD="$record" SC_STATE_DIR="$state_dir" python3 "$pysrc"
  rc=$?
  rm -f "$pysrc"
  # 명령을 셸 문법으로 읽지 못하면 종전 규칙으로 판정한다.
  [ "$rc" -eq 3 ] && guard_git_legacy "$cmd"
  return 0
}

# Python이 없거나 명령을 해석하지 못할 때의 종전 판정. 지우는 대상과 무관하게,
# 다른 세션이 있으면 확인한다.
guard_git_legacy() {
  local cmd="$1" f others=0 label=""
  local risky=0
  case "$cmd" in
    *"branch -D"*|*"branch -d"*|*"branch --delete"*|\
    *"worktree remove"*|*"worktree prune"*|\
    *"push --force"*|*"push -f"*|*"push --mirror"*|*"force-with-lease"*|\
    *" :refs/"*|*"update-ref -d"*) risky=1 ;;
  esac
  # `git push origin --delete <ref>` 처럼 remote 이름이 사이에 끼는 형태는 위의
  # 연속 패턴으로 잡히지 않는다. push 와 삭제 플래그의 공존으로 따로 본다.
  case "$cmd" in
    *push*) case "$cmd" in *--delete*|*" -d "*) risky=1 ;; esac ;;
  esac
  [ "$risky" -eq 1 ] || return
  for f in "$state_dir"/*.json; do
    [ -f "$f" ] || continue
    [ "$f" = "$record" ] && continue
    others=$((others + 1))
    label=$(jq -r '(.session_id // "unknown") + " / " + (.branch // "?") + " @ " + (.worktree // "?")' "$f" 2>/dev/null)
  done
  [ "$others" -gt 0 ] || return
  jq -n --arg n "$others" --arg label "$label" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"ask",permissionDecisionReason:("이 저장소에 다른 세션 " + $n + "개가 등록돼 있습니다(예: " + $label + "). 브랜치·worktree·원격 ref 를 지우는 명령은 그쪽 작업을 되돌릴 수 없게 만들 수 있습니다. 해당 브랜치가 본인 것인지 확인한 뒤 진행하세요.")}}'
}

status() {
  cleanup_stale
  for f in "$state_dir"/*.json; do
    [ -f "$f" ] || continue
    jq -r '[.session_id, .status, .branch, .worktree, ((.paths // []) | join(","))] | @tsv' "$f" 2>/dev/null
  done
}

# TTL과 PID 검증으로 정리되지 않는 유령 점유를 수동으로 지운다.
# 인자 없이 쓰면 stale 정리만 하고, 세션 ID를 주면 그 레코드를 삭제한다.
prune() {
  local target="${1:-}" f found removed=0 left
  cleanup_stale
  if [ -n "$target" ]; then
    for f in "$state_dir"/*.json; do
      [ -f "$f" ] || continue
      found=$(jq -r '.session_id // empty' "$f" 2>/dev/null)
      if [ "$found" = "$target" ]; then
        rm -f "$f" 2>/dev/null && removed=$((removed + 1))
      fi
    done
  fi
  left=$(ls "$state_dir"/*.json 2>/dev/null | wc -l | tr -d ' ')
  printf 'prune: %s개 삭제, %s개 남음\n' "$removed" "$left"
}

resource() {
  local safe_root key safe_sid port_offset
  safe_root=$(basename "$root" | tr -c '[:alnum:]' '-' | sed 's/-*$//')
  key=$(printf '%s' "$sid" | hash_hex | cut -c1-8)
  safe_sid=$(printf '%s' "$sid" | tr -c '[:alnum:]' '-' | sed 's/-*$//' | cut -c1-24)
  port_offset=$((16#${key:0:4} % 1000))
  printf 'export SESSION_COORD_SESSION_ID=%q\n' "$sid"
  printf 'export COMPOSE_PROJECT_NAME=%q\n' "${safe_root}-${safe_sid}-${key}"
  printf 'export SESSION_COORD_DOCKER_NETWORK=%q\n' "${safe_root}-${key}-net"
  printf 'export SESSION_COORD_DB_NAME=%q\n' "${safe_root}_${key}"
  printf 'export SESSION_COORD_PORT_OFFSET=%q\n' "$port_offset"
}

cleanup_stale
case "$mode" in
  register) register ;;
  release) release ;;
  claim) [ -n "${2:-}" ] && claim "$2" ;;
  status) status ;;
  prune) prune "${2:-}" ;;
  resource) resource ;;
  hook)
    event=$(json_get '.hook_event_name')
    case "$event" in
      SessionStart) register ;;
      SessionEnd) release ;;
      PreToolUse)
        file_path=$(json_get '.tool_input.file_path')
        if [ -n "$file_path" ]; then
          claim "$file_path"
        else
          command_text=$(json_get '.tool_input.command')
          hook_cwd=$(json_get '.cwd')
          [ -n "$command_text" ] && guard_git "$command_text"
        fi
        ;;
    esac
    ;;
esac
