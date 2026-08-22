#!/usr/bin/env bash
# PreToolUse/Bash: 배포·릴리스 계열 명령 차단
# Golden Rule: "배포·릴리스, staging·production migration은 승인 범위에 포함하지 않으며 실행하지 않는다"
#
# 배포는 항상 사용자가 수동으로 실행한다. 문서 규칙만으로는 막히지 않으므로
# block-destructive.sh와 같은 방식으로 실행 문맥을 정제한 뒤 판정한다.
# 로컬 개발 명령(docker compose up, prisma migrate dev 등)은 차단하지 않는다.

VERDICT=$(python3 /dev/fd/3 3<<'PY' 2>/dev/null
import json, os, re, sys

SHELL_EVAL = re.compile(
    r"(?:^|[|;&]\s*)(?:ba|z|k|da)?sh\s+(?:-[A-Za-z]+\s+)*-[A-Za-z]*c\b"
    r"|\b(?:eval|xargs|ssh)\b",
    re.M,
)
SHELL_HEREDOC = re.compile(r"(?:^|[|;&]\s*)(?:ba|z|k|da)?sh\b|\b(?:eval|xargs)\b", re.M)


def strip_heredocs(cmd):
    lines = cmd.split("\n")
    kept, i = [], 0
    while i < len(lines):
        line = lines[i]
        kept.append(line)
        i += 1
        m = re.search(r"<<-?\s*['\"]?([A-Za-z_][A-Za-z0-9_]*)['\"]?", line)
        if not m or SHELL_HEREDOC.search(line):
            continue
        delim = m.group(1)
        while i < len(lines) and lines[i].strip() != delim:
            i += 1
        i += 1
    return "\n".join(kept)


def strip_comments(cmd):
    return re.sub(r"(?m)(?:(?<=^)|(?<=\s))#.*$", " ", cmd)


def strip_quoted(cmd):
    if SHELL_EVAL.search(cmd):
        return cmd
    return re.sub(r"'[^']*'|\"[^\"]*\"", " ", cmd)


# (정규식, 사용자에게 보여줄 이름). 로컬 실행과 구분되는 형태만 넣는다.
RULES = [
    # CI/릴리스 트리거
    (r"\bgh\s+workflow\s+run\b", "gh workflow run"),
    (r"\bgh\s+run\s+(?:rerun|cancel)\b", "gh run rerun"),
    (r"\bgh\s+release\s+(?:create|edit|delete|upload)\b", "gh release"),
    (r"\bgh\s+api\b[^\n]*\b(?:workflows|dispatches|deployments)\b", "gh api workflow dispatch"),
    (r"\bgit\s+push\b[^\n]*\brefs/tags/|\bgit\s+tag\s+-[a-zA-Z]*\s*v?\d[^\n]*&&[^\n]*push", "release tag push"),
    # PaaS/클라우드 배포
    (r"\bvercel\s+(?:deploy|--prod)\b|\bvercel\s+build\s+--prod\b", "vercel deploy"),
    (r"\b(?:fly|flyctl)\s+deploy\b", "fly deploy"),
    (r"\bnetlify\s+deploy\b", "netlify deploy"),
    (r"\brender\s+deploys?\s+create\b", "render deploy"),
    (r"\bserverless\s+deploy\b|\bsls\s+deploy\b", "serverless deploy"),
    (r"\beb\s+deploy\b", "elastic beanstalk deploy"),
    (r"\bgcloud\s+(?:app|run|functions)\s+deploy\b", "gcloud deploy"),
    (r"\baws\s+(?:deploy|cloudformation\s+deploy|ecs\s+update-service)\b", "aws deploy"),
    (r"\baz\s+webapp\s+(?:up|deployment)\b", "azure deploy"),
    # 컨테이너/패키지 배포
    (r"\bdocker\s+push\b|\bdocker\s+compose\s+push\b", "docker push"),
    (r"\b(?:npm|pnpm|yarn|bun)\s+publish\b", "package publish"),
    (r"\bcargo\s+publish\b|\btwine\s+upload\b|\bpoetry\s+publish\b", "package publish"),
    # 오케스트레이션
    (r"\bkubectl\s+(?:apply|rollout|set\s+image|delete)\b", "kubectl 배포"),
    (r"\bhelm\s+(?:install|upgrade|rollback)\b", "helm 배포"),
    (r"\bterraform\s+(?:apply|destroy)\b", "terraform apply"),
    (r"\bpulumi\s+up\b", "pulumi up"),
    # 원격 migration — 로컬 개발용 명령과 구분되는 형태만
    (r"\bprisma\s+migrate\s+deploy\b", "prisma migrate deploy"),
    (r"\bdrizzle-kit\s+(?:push|migrate)\b[^\n]*\b(?:staging|production|prod)\b", "drizzle 원격 migration"),
    (r"\b(?:alembic|flask\s+db|rails\s+db:migrate|php\s+artisan\s+migrate)\b[^\n]*\b(?:staging|production|prod)\b",
     "원격 migration"),
    (r"\bDATABASE_URL=[^\s]*(?:staging|production|prod)[^\s]*", "원격 DB 대상 명령"),
    # 환경 지정 배포
    (r"\bnpm\s+run\s+deploy(?::[a-z]+)?\b|\b(?:pnpm|yarn|bun)\s+deploy\b", "배포 스크립트"),
    (r"\bmake\s+deploy\b", "make deploy"),
    (r"--env(?:ironment)?[= ](?:staging|production|prod)\b", "staging/production 환경 지정"),
]

raw = sys.stdin.read()
if not raw.strip():
    raw = os.environ.get("CLAUDE_TOOL_INPUT", "")
if not raw.strip():
    sys.exit(0)
try:
    d = json.loads(raw)
except Exception:
    sys.exit(0)
if not isinstance(d, dict):
    sys.exit(0)
ti = d.get("tool_input")
ti = ti if isinstance(ti, dict) else {}
cmd = strip_quoted(strip_comments(strip_heredocs(ti.get("command") or d.get("command") or "")))
if not cmd.strip():
    sys.exit(0)

for pattern, label in RULES:
    if re.search(pattern, cmd):
        print(label)
        break
PY
)

[ -z "$VERDICT" ] && exit 0

echo "[Hooks L3] 차단: '$VERDICT'는 배포·릴리스 계열 명령입니다." >&2
echo "배포·릴리스와 staging/production migration은 항상 사용자가 직접 실행합니다." >&2
echo "필요한 명령을 그대로 알려 드릴 테니 사용자가 확인 후 실행해 주세요." >&2
exit 2
