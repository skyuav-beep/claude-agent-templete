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

### 2.0.0 이전 설치 마이그레이션

`.claude/.plugin-version`은 있지만 `.claude/.template-install-state.json`이 없는 프로젝트는 한 번 `--adopt`로 연결 상태와 해시 기준선을 생성한다. 이후부터 `--update`를 사용한다.

```bash
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --dry-run --adopt "$TARGET_ROOT"
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --adopt "$TARGET_ROOT"
```

## 설치 내용

install.sh는 `manifest.json`에 등록된 파일을 대상 프로젝트에 복사한다.

- L1 Memory: `CLAUDE.md`, `AGENTS.md`, `STATE.md`, `DESIGN.md`
- L2 Skills: `.claude/skills/` (10개 `SKILL.md` — 자연어 키워드로 자동 활성화)
- L2 Commands: `.claude/commands/` (9개 slash command — 사용자가 직접 호출)
- L3 Hooks: `.claude/hooks/` (4개 가드레일 스크립트, opt-in 1개 포함) + `settings.template.json` -> 설치 대상의 `settings.local.json`
- L4 Subagents: `.claude/agents/` (6개 프롬프트 템플릿 — explorer, code-reviewer, planner, test-runner, feature-dev, design-reviewer)
- Design library: `designs/` (6개 시안 + alias contract + template) + `.claude/plugins/select-design.sh`
- Codex Layer: `.codex/` (workflow 10종 + checks 2종 + subagent prompt guide 6종)
- Supporting: `agents/` (4개 역할 지침), `templates/` (요청 5종 + intake 12종 + startup checklist + data-table density), `docs/` (가이드/플레이북/HTML UI/런타임 매트릭스)

L2의 skills와 commands는 병존한다. skills는 자연어 키워드 매칭으로 자동 활성화되고, commands는 사용자가 슬래시 입력으로 명시 호출한다.
Codex는 `.codex/README.md`와 `.codex/workflows/*.md`를 통해 같은 운영 절차를 명시적으로 수행한다. 모호한 요청은 `.codex/workflows/request.md`가 Claude `request` skill과 같은 라우팅 역할을 맡는다.

완료된 설치는 `.claude/.plugin-version`에 버전을 기록한다. `.claude/.template-install-state.json`에는 파일별 정책, 템플릿 해시, 설치 해시, 충돌 상태를 기록한다. 일부 충돌이 남으면 상태는 `partial`이며 완료 버전을 올리지 않는다.

`.claude/settings.template.json`은 최초 설치 시 `.claude/settings.local.json`으로 생성되며 이후 자동 덮어쓰지 않는다. hook 명령은 실행 시점의 git 루트를 기준으로 `.claude/hooks/*`를 찾으므로 템플릿 폴더명이나 설치 경로에 의존하지 않는다.

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
- `.claude/agents/`: 서브에이전트 템플릿 추가/수정
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
