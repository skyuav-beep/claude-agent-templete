# Plugin Guide

이 문서는 Claude Agent Template을 다른 프로젝트에 설치하고 관리하는 방법을 설명한다.

## 폴더명/경로 정책

템플릿 저장소의 로컬 폴더명은 정본이 아니다. PC마다 `claude-agent-template`, `claude-agent-templete`, `rules` 같은 다른 이름을 써도 된다.

- 고정 식별자: `.claude/plugins/manifest.json`의 `name` 값인 `claude-agent-template`
- 로컬 위치: `<template-root>` 또는 환경변수 `TEMPLATE_ROOT`로 표현한다.
- 설치 대상: `<target-project>` 또는 환경변수 `TARGET_ROOT`로 표현한다.
- hook 설정: 추적 가능한 `.claude/settings.template.json`을 설치 시 `.claude/settings.local.json`으로 복사하고, 절대 경로가 아니라 현재 git 루트 기준 `.claude/hooks/*`를 찾아 실행한다.

문서와 스크립트는 폴더명을 기준으로 판단하지 않고, 실행 중 계산한 경로를 기준으로 동작해야 한다.

## 설치 모드

```bash
TEMPLATE_ROOT=/path/to/your-template-folder
TARGET_ROOT=/path/to/my-project
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --new "$TARGET_ROOT"
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --adopt "$TARGET_ROOT"
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --update "$TARGET_ROOT"
```

- `--new`: `.git` 외에 파일이 없는 신규 프로젝트에 전체 설치한다.
- `--adopt`: 기존 프로젝트에 처음 연결한다. 없는 파일은 추가하고 기존 파일은 프로젝트 로컬 기준선으로 기록한다.
- `--update`: 설치 상태가 있는 프로젝트를 갱신한다. 이전 설치 이후 수정되지 않은 파일만 자동 갱신한다.

모드를 생략하면 파일을 변경하지 않고 대상 상태에 맞는 명령을 안내한다.

### symlink 연결 모드 (`--link`)

복사 대신 공통본을 가리키는 symlink로 연결한다. 템플릿 개정이 즉시 반영되고 git worktree에도 상속된다.

```bash
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --link --dry-run "$TARGET_ROOT"
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --link "$TARGET_ROOT"
```

- 연결 대상: `rules`, `.claude/CLAUDE.md`, `.claude/{skills,commands,agents,hooks,plugins}`, `.claude/statusline-notify.sh`, `.agents/skills`, `.codex`
- `.claude/settings.json`, `.claude/settings.local.json`, `.claude/.active-design`처럼 프로젝트가 소유하는 파일은 건드리지 않는다.
- 기존 실체 파일·디렉터리가 있으면 `.agent-template-backup-<타임스탬프>/`로 옮긴 뒤 연결한다. 백업에 프로젝트 고유 설정이 들어 있을 수 있으므로 확인 후 삭제한다.
- 같은 명령을 다시 실행해도 이미 올바른 링크는 `keep`으로 건너뛴다.
- `--link-claude-dir`를 함께 주면 `.claude` 디렉터리 전체를 하나의 symlink로 만든다. 개정 전파 범위가 가장 넓지만 그 프로젝트는 자체 `settings.json`, `.active-design`, 프로젝트 전용 훅을 둘 수 없다.

`--link`는 실행 레이어만 연결한다. `templates/`, `docs/`, `agents/` 같은 공통 문서는 `rules/` 경로 규칙으로 참조하므로 별도 복사가 필요 없다.

### 2.0.0 이전 설치 마이그레이션

`.claude/.plugin-version`은 있지만 `.claude/.template-install-state.json`이 없는 프로젝트는 한 번 `--adopt`로 연결 상태와 해시 기준선을 생성한다. 이후부터 `--update`를 사용한다.

```bash
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --dry-run --adopt "$TARGET_ROOT"
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --adopt "$TARGET_ROOT"
```

## 설치 내용

install.sh는 `manifest.json`에 등록된 파일을 대상 프로젝트에 복사한다.

- L1 Memory: `CLAUDE.md`, `AGENTS.md`, `STATE.md`, `DESIGN.md`
- L2 Skills: `.claude/skills/` (14개 `SKILL.md` — 자연어 키워드로 자동 활성화)
- L2 Commands: `.claude/commands/` (14개 slash command — 사용자가 직접 호출)
- L3 Hooks: `.claude/hooks/` (승인·파괴 명령·배포 명령·비밀 파일·STATE·세션 충돌 가드레일과 알림 훅) + `settings.template.json` -> 설치 대상의 `settings.local.json`
- L4 Subagents: `.claude/agents/` (6개 정의 파일 — explorer, code-reviewer, planner, test-runner, feature-dev, design-reviewer. frontmatter로 자동 등록)
- Design library: `designs/` (6개 시안 + alias contract + template) + `.claude/plugins/select-design.sh`
- Codex Layer: `.agents/skills/` (네이티브 Skill 14종) + `.codex/` (workflow 14종, checks 2종, subagent prompt guide 6종)
- Supporting: `agents/` (4개 역할 지침), `templates/` (요청 5종 + intake 12종 + 지식 관리 4종 + startup checklist + data-table density), `docs/` (가이드/플레이북/HTML UI/런타임 매트릭스 + 지식 관리·세션 조정 가이드 + `docs/00-inbox/`~`docs/99-archive/` 지식 영역)

L2의 skills와 commands는 병존한다. skills는 자연어 키워드 매칭으로 자동 활성화되고, commands는 사용자가 슬래시 입력으로 명시 호출한다.
Codex는 `.agents/skills/*/SKILL.md`를 자연어 요청에 따라 선택하고, `.codex/workflows/*.md`를 상세·호환 절차로 사용한다. 모호한 요청은 `request` Skill이 Claude `request` skill과 같은 라우팅 역할을 맡는다.

완료된 설치는 `.claude/.plugin-version`에 버전을 기록한다. `.claude/.template-install-state.json`에는 파일별 정책, 템플릿 해시, 설치 해시, 충돌 상태를 기록한다. 일부 충돌이 남으면 상태는 `partial`이며 완료 버전을 올리지 않는다.

`.claude/settings.template.json`은 최초 설치 시 `.claude/settings.local.json`으로 생성되며 이후 자동 덮어쓰지 않는다. hook 명령은 실행 시점의 git 루트를 기준으로 `.claude/hooks/*`를 찾으므로 템플릿 폴더명이나 설치 경로에 의존하지 않는다.

### Bash 명령 자동 실행 (`permissions.allow`)

템플릿은 Bash 명령을 확인 창 없이 바로 실행하도록 `permissions.allow`를 함께 배포한다. 파괴·배포·비밀 파일·세션 충돌 판정은 허용 규칙과 무관하게 `PreToolUse` 훅이 계속 차단하거나 확인을 요청한다.

- `Bash` (전체 허용): `default`·`acceptEdits` 모드에서 모든 셸 명령을 바로 실행한다.
- 좁은 규칙(`Bash(git status *)`, `Bash(gh pr view *)`, `Bash(node scripts/*)` 등): `auto` 모드용이다. `auto` 모드는 `Bash` 같은 전체 허용 규칙을 무시하고 분류기로 판정하지만, 좁은 규칙은 분류기보다 먼저 적용된다. 복합 명령(`a && b`)은 하위 명령마다 규칙이 맞아야 통과한다.
- `auto` 모드에서 분류기가 막는 작업(force push, 리뷰 전 머지 등)은 템플릿으로 풀 수 없다. `autoMode` 키는 사용자 전역 `~/.claude/settings.json`에서만 읽히며, 사용자가 `/permissions`의 `Auto mode` 탭에서 직접 조정한다.
- 이미 설치된 프로젝트의 `settings.local.json`은 자동 갱신되지 않는다. 템플릿의 `permissions` 블록을 직접 병합한다.

```bash
jq -s '.[0] * {permissions: {allow: ((.[0].permissions.allow // []) + .[1].permissions.allow | unique)}}' \
  .claude/settings.local.json "$TEMPLATE_ROOT/.claude/settings.template.json" > /tmp/settings.merged.json \
  && mv /tmp/settings.merged.json .claude/settings.local.json
```

### worktree 폴더 쓰기 허용 (`additionalDirectories`)

작업 worktree를 저장소 옆 형제 폴더(`<프로젝트>-worktrees/`)에 만들면, 세션을 연 저장소 폴더 밖이라 `auto` 모드에서도 새 파일 생성·수정마다 "Do you want to create ...?" 확인 창이 뜬다. 선택지에 "이 폴더 접근 항상 허용"이 보이면 이 경우다. 승인 게이트 훅의 확인(훅 사유가 함께 표시됨)과는 원인이 다르다.

- 기본 해결: 승인 게이트(`phase-approval.sh`)가 3단계 승인을 받은 세션의 같은 저장소 worktree 수정에 허용으로 답하므로, 게이트 훅을 등록한 프로젝트는 따로 설정하지 않아도 이 확인 창이 뜨지 않는다. 승인 전이거나 다른 저장소 파일이면 종전대로 확인한다.
- 게이트 없이도 없애려면: 사용자 전역 `~/.claude/settings.json`의 `permissions.additionalDirectories`에 worktree 상위 폴더를 등록한다. 등록한 폴더에는 기존 `Edit` 허용 규칙이 그대로 적용된다.
- 경로가 PC마다 다르므로 템플릿 `settings.template.json`에는 넣지 않는다. 설치한 PC마다 한 번 등록한다.
- 권한을 넓히는 설정이라 에이전트가 대신 편집하지 못한다. 사용자가 직접 편집하고 새 세션부터 적용된다.

```json
"permissions": {
  "additionalDirectories": ["/home/<user>/projects"]
}
```

- 상위 폴더 하나를 등록하면 모든 `*-worktrees`가 함께 허용된다. 좁히려면 `"/home/<user>/projects/<프로젝트>-worktrees"`처럼 폴더별로 적는다.
- 지금 세션에만 적용하려면 확인 창에서 "항상 허용"(`Shift+Tab`)을 고르거나 `/add-dir <worktree 상위 폴더>`를 입력한다.

## 플래그

- `--new`, `--adopt`, `--update`: 설치 모드
- `--force`: 이전 버전 호환 alias이며 `--update`로 동작
- `--force-project-files`: 2.0.0부터 지원하지 않는다. 프로젝트 파일은 diff 확인 후 수동 병합한다.
- `--dry-run`: 실제 복사 없이 어떤 파일이 설치될지 미리보기한다.
- `--design <slug>`: 설치 후 활성화할 디자인 시안을 지정한다. 기본값은 `wanted`.
- `--accept-local <경로>`: 수동 검토·병합한 충돌 파일을 새 로컬 기준선으로 승인한다. 여러 파일이면 옵션을 반복한다.

종료 코드는 완료 `0`, 보존된 충돌 존재 `1`, 사전검사·인수·상태 오류 `2`다.

## 업데이트

1. 템플릿 저장소에서 최신 버전을 pull한다.
2. `--dry-run --update`로 자동 갱신, 보호, 충돌 후보를 확인한다.
3. 문제가 없으면 `--update`를 실행한다.
4. 충돌 파일은 프로젝트 기준과 템플릿 변경을 비교해 수동 병합한다.

```bash
cd "$TEMPLATE_ROOT" && git pull
bash .claude/plugins/install.sh --dry-run --update "$TARGET_ROOT"
bash .claude/plugins/install.sh --update "$TARGET_ROOT"
```

`AGENTS.md`와 `CLAUDE.md`는 필수 라우팅 관리 블록만 병합한다. `STATE.md`, `DESIGN.md`, `docs/project-guide.md`, `.claude/settings.local.json`은 보호한다. 나머지 파일은 이전 템플릿 해시와 설치 해시를 비교한다. 로컬만 바뀌면 보존하고, 템플릿과 로컬이 모두 바뀐 경우에만 충돌 후보로 남긴다.

충돌 파일을 비교하고 수동 병합한 뒤 해당 결과를 프로젝트 기준으로 유지하려면 다음처럼 승인한다.

```bash
bash .claude/plugins/install.sh --update \
  --accept-local docs/local-dev-ci-guide.md \
  "$TARGET_ROOT"
```

## 커스텀

설치된 파일은 복사본이므로 대상 프로젝트에서 자유롭게 수정할 수 있다.

- `AGENTS.md`: 프로젝트별 Golden Rules, Context Map 수정
- `docs/project-guide.md`: 프로젝트 목표, 기술·업무·검증 기준의 정본
- `.claude/commands/`: 커맨드 추가/수정/삭제
- `.claude/hooks/`: 가드레일 스크립트 추가/수정
- `.claude/agents/`: 서브에이전트 정의 추가/수정 (frontmatter의 `name`·`description` 필수)
- `.codex/`: Codex workflow/check/subagent guide 추가/수정
- `agents/`: 역할별 체크리스트 프로젝트에 맞게 조정

## 템플릿 유지 관리

버전을 올릴 때:

1. `.claude/plugins/VERSION` 파일의 버전 번호를 수정한다.
2. `.claude/plugins/manifest.json`의 `version` 필드를 같은 값으로 맞춘다.
3. 새 파일을 추가했으면 `manifest.json`의 해당 layer에 등록한다.
4. 커밋한다.

## 버전 확인

```bash
# 템플릿 버전
cat "$TEMPLATE_ROOT/.claude/plugins/VERSION"

# 설치된 버전
cat "$TARGET_ROOT/.claude/.plugin-version"

# 설치 상태와 충돌
jq '{template_version, last_attempt_version, status, conflicts}' \
  "$TARGET_ROOT/.claude/.template-install-state.json"
```
