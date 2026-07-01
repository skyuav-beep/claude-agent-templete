# Plugin Guide

이 문서는 Claude Agent Template을 다른 프로젝트에 설치하고 관리하는 방법을 설명한다.

## 폴더명/경로 정책

템플릿 저장소의 로컬 폴더명은 정본이 아니다. PC마다 `claude-agent-template`, `claude-agent-templete`, `rules` 같은 다른 이름을 써도 된다.

- 고정 식별자: `.claude/plugins/manifest.json`의 `name` 값인 `claude-agent-template`
- 로컬 위치: `<template-root>` 또는 환경변수 `TEMPLATE_ROOT`로 표현한다.
- 설치 대상: `<target-project>` 또는 환경변수 `TARGET_ROOT`로 표현한다.
- hook 설정: 추적 가능한 `.claude/settings.template.json`을 설치 시 `.claude/settings.local.json`으로 복사하고, 절대 경로가 아니라 현재 git 루트 기준 `.claude/hooks/*`를 찾아 실행한다.

문서와 스크립트는 폴더명을 기준으로 판단하지 않고, 실행 중 계산한 경로를 기준으로 동작해야 한다.

## 빠른 설치

```bash
TEMPLATE_ROOT=/path/to/your-template-folder
TARGET_ROOT=/path/to/my-project
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" "$TARGET_ROOT"
```

기존 파일이 있으면 건너뛴다. 덮어쓰려면 `--force` 플래그를 추가한다.

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

설치 후 대상 프로젝트에 `.claude/.plugin-version` 파일이 생성되어 설치된 버전을 기록한다. `.claude/settings.template.json`은 설치 시 대상 프로젝트의 `.claude/settings.local.json`으로 생성된다. hook 명령은 실행 시점의 git 루트를 기준으로 `.claude/hooks/*`를 찾으므로 템플릿 폴더명이나 설치 경로에 의존하지 않는다.

## 플래그

- `--force`: 기존 파일을 덮어쓴다.
- `--dry-run`: 실제 복사 없이 어떤 파일이 설치될지 미리보기한다.
- `--design <slug>`: 설치 후 활성화할 디자인 시안을 지정한다. 기본값은 `wanted`.

## 업데이트

1. 템플릿 저장소에서 최신 버전을 pull한다.
2. install.sh를 `--force`로 다시 실행한다.

```bash
cd "$TEMPLATE_ROOT" && git pull
bash .claude/plugins/install.sh --force "$TARGET_ROOT"
```

주의: `--force`는 대상 프로젝트에서 커스텀한 파일도 덮어쓴다. 커스텀 내용을 보존하려면 먼저 `--dry-run`으로 변경 범위를 확인한다.

## 커스텀

설치된 파일은 복사본이므로 대상 프로젝트에서 자유롭게 수정할 수 있다.

- `AGENTS.md`: 프로젝트별 Golden Rules, Context Map 수정
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
```
