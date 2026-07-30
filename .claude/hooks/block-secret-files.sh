#!/usr/bin/env bash
# PreToolUse/Write,Edit,Bash: 비밀 파일 쓰기 차단
# Golden Rule: "확인하지 않은 비밀값, API 키를 임의로 추가하지 않는다"
#
# 입력 규약: stdin JSON({"tool_name":"...","tool_input":{...}})이 1차,
# 구 규약 $CLAUDE_TOOL_INPUT는 폴백. 차단은 exit 2 + stderr.
#
# payload는 argv/환경변수가 아니라 stdin으로 받는다. Write의 tool_input에는 파일
# 본문 전체가 실려 MAX_ARG_STRLEN(128KB)을 넘기므로, 스크립트를 fd 3으로 주고
# stdin을 payload 전용으로 남긴다.

python3 /dev/fd/3 3<<'PY'
import json
import os
import re
import shlex
import sys


# 비밀값 없이 저장소에 커밋하는 공유용 예시 파일. 마지막 확장자로 판정하므로
# .env.example, .env.local.example, config.key.sample 같은 형태를 모두 통과시킨다.
SAMPLE_SUFFIXES = {"example", "sample", "template", "dist", "defaults"}


def is_sample_name(base: str) -> bool:
    parts = base.rsplit(".", 1)
    return len(parts) == 2 and parts[1].lower() in SAMPLE_SUFFIXES


def is_secret_name(path: str) -> bool:
    if not path:
        return False
    # 명령 문자열에서 뽑은 토큰에는 구두점이 붙어 있을 수 있다(예: 문장 안의
    # ".env.example," 또는 "(.env.local)"). 앞뒤 구두점을 벗겨야 예시 파일 예외와
    # 비밀 파일 판정이 모두 정확해진다. 선행 '.'은 벗기지 않는다(.env 자체가 대상).
    base = os.path.basename(path.strip("'\"")).lstrip("([{'\"").rstrip(".,;:!?)]}'\"")
    if is_sample_name(base):
        return False
    if base in {"credentials.json", "secrets.json", "id_rsa", "id_ed25519"}:
        return True
    # .env 계열은 이름 변형이 많다. `.env` 자체, `backend.env`처럼 접두어가 붙은 형태,
    # `.env.local`·`backend.env.production`처럼 접미어가 붙은 형태를 모두 비밀 파일로 본다.
    # 예시 파일(.example/.sample/...)은 위 is_sample_name에서 이미 걸러진다.
    if base == ".env" or base.endswith(".env") or ".env." in base:
        return True
    if base.startswith("service-account") and base.endswith(".json"):
        return True
    return base.endswith((".pem", ".key", ".p12", ".pfx")) or base.startswith(("id_rsa.", "id_ed25519."))


def block(name: str) -> None:
    print(
        f"[Hooks L3] 차단: '{name}' 은 비밀/인증 파일로 판단됩니다. 직접 확인 후 수동으로 생성하세요.",
        file=sys.stderr,
    )
    sys.exit(2)


raw = sys.stdin.read()
if not raw.strip():
    raw = os.environ.get("CLAUDE_TOOL_INPUT", "")
if not raw.strip():
    sys.exit(0)

try:
    payload = json.loads(raw)
except Exception:
    sys.exit(0)

if not isinstance(payload, dict):
    sys.exit(0)

# 현행 규약은 tool_input 중첩, 구 규약은 평면 구조였다. 둘 다 허용한다.
tool_input = payload.get("tool_input")
data = tool_input if isinstance(tool_input, dict) else payload

file_path = data.get("file_path") or data.get("notebook_path") or ""
if file_path and is_secret_name(file_path):
    block(os.path.basename(file_path))

command = data.get("command") or ""
if not command:
    sys.exit(0)


def strip_heredocs(cmd: str) -> str:
    """heredoc 본문(<<'PY' ... PY)은 셸 명령이 아니라 데이터다.

    python/node 스크립트를 heredoc으로 넘기면 본문 안의 `f == ".env"` 같은 문자열이
    파일명 토큰으로 잡혀 오차단된다. 본문을 걷어내고 실제 명령줄만 남긴다.
    """
    lines = cmd.split("\n")
    kept, i = [], 0
    while i < len(lines):
        line = lines[i]
        kept.append(line)
        i += 1
        m = re.search(r"<<-?\s*['\"]?([A-Za-z_][A-Za-z0-9_]*)['\"]?", line)
        if not m:
            continue
        delim = m.group(1)
        while i < len(lines) and lines[i].strip() != delim:
            i += 1
        i += 1  # 종료 구분자 라인도 건너뛴다
    return "\n".join(kept)


# /dev/null 리다이렉션은 파일 쓰기가 아니다. `find ... 2>/dev/null` 같은 조회 명령이
# 쓰기성으로 분류돼 뒤따르는 토큰 검사까지 도는 것을 막는다.
command = re.sub(r"\d?>>?\s*/dev/null", " ", strip_heredocs(command))

try:
    tokens = shlex.split(command, posix=True)
except ValueError:
    tokens = command.split()

# Bash 훅에서는 파일 경로가 없으므로 쓰기성 명령만 보수적으로 막는다.
writeish = bool(re.search(r"(^|[;&|]\s*)(touch|tee|cp|mv|install)\s", command))
writeish = writeish or bool(re.search(r"(^|[^<])>{1,2}\s*[^&\s]", command))
writeish = writeish or ("sed" in tokens and any(token == "-i" or token.startswith("-i.") for token in tokens))
if not writeish:
    sys.exit(0)

for token in tokens:
    candidate = token
    if candidate.startswith((">", ">>")):
        candidate = candidate.lstrip(">")
    # glob 패턴은 실제 파일명이 아니다. `find -name "*.env"`, `ls *.env` 같은 조회
    # 명령이 리다이렉션(2>/dev/null) 때문에 쓰기성으로 분류돼 오차단되는 것을 막는다.
    # 도구 경로(Write/Edit의 file_path)는 항상 리터럴이라 이 예외의 영향을 받지 않는다.
    if any(ch in candidate for ch in "*?["):
        continue
    if is_secret_name(candidate):
        block(os.path.basename(candidate.strip("'\"")))

sys.exit(0)
PY
