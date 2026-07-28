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
    if base in {".env", "credentials.json", "secrets.json", "id_rsa", "id_ed25519"}:
        return True
    if base.startswith(".env."):
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
    if is_secret_name(candidate):
        block(os.path.basename(candidate.strip("'\"")))

sys.exit(0)
PY
