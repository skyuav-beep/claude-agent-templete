#!/usr/bin/env bash
# PreToolUse/Write,Edit,Bash: 비밀 파일 쓰기 차단
# Golden Rule: "확인하지 않은 비밀값, API 키를 임의로 추가하지 않는다"

python3 - <<'PY'
import json
import os
import re
import shlex
import sys


def is_secret_name(path: str) -> bool:
    if not path:
        return False
    base = os.path.basename(path.strip("'\""))
    if base in {".env", "credentials.json", "secrets.json", "id_rsa", "id_ed25519"}:
        return True
    if base.startswith(".env."):
        return True
    if base.startswith("service-account") and base.endswith(".json"):
        return True
    return base.endswith((".pem", ".key", ".p12", ".pfx")) or base.startswith(("id_rsa.", "id_ed25519."))


def block(name: str) -> None:
    print(f"[Hooks L3] 차단: '{name}' 은 비밀/인증 파일로 판단됩니다. 직접 확인 후 수동으로 생성하세요.")
    sys.exit(2)


try:
    data = json.loads(os.environ.get("CLAUDE_TOOL_INPUT", "{}") or "{}")
except Exception:
    sys.exit(0)

file_path = data.get("file_path") or ""
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
