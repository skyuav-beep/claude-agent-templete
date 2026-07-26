# Claude Guide

이 문서는 Claude Code에서 이 템플릿을 사용할 때의 실행 기준이다.

## 자동화 레이어

- `CLAUDE.md`: Claude Code가 우선 읽는 프로젝트 운영 설정이다.
- `.claude/skills/*/SKILL.md`: 자연어 트리거 기반 자동 활성화 레이어다.
- `.claude/commands/*.md`: 사용자가 직접 호출하는 slash command 레이어다.
- `.claude/hooks/*.sh`: PreToolUse 가드레일이다.
- `.claude/agents/*.md`: Claude `Agent` 도구 호출 시 쓰는 서브에이전트 프롬프트 템플릿이다.
- `.claude/plugins/*`: 다른 프로젝트에 템플릿 파일을 설치하는 도구다.

## 공통 정본

Claude 전용 레이어는 실행 어댑터이며, 질문과 정책의 정본은 다음 파일에 둔다.

- `AGENTS.md`: 공통 운영 규칙과 라우팅
- `CLAUDE.md ## 답변 포맷`: 단계별 응답, 최종 통합, 내부 식별자 절제를 포함한 공통 응답 정책
- `templates/`: intake 및 요청 양식
- `docs/`: 개발/검증/운영 가이드
- `DESIGN.md`: active 디자인 시스템 카탈로그
- `STATE.md`: 현재 상태와 인계

## Codex와의 관계

Codex 지원을 위해 `.codex/`가 존재하더라도 Claude Code는 기존 `.claude/` 자동화 레이어를 계속 사용한다. 두 레이어가 같은 내용을 중복 정의하지 않도록 공통 정책은 `templates/`와 `docs/`로 올리고, 런타임별 파일은 실행 절차만 담는다.
