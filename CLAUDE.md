# CLAUDE.md

Claude Code CLI 전용 운영 설정 파일이다.
공통 운영 규칙, Golden Rules, 커뮤니케이션 원칙, Operational Commands는 `AGENTS.md`에 정의되어 있다. 이 파일은 Claude Code에 특화된 동작 기준만 다룬다.

## 공통 규칙 참조

- 모든 에이전트 공통 원칙: `AGENTS.md`
- 현재 상태 및 인계: `STATE.md`
- 역할별 세부 지침: `agents/`
- 작업 요청 템플릿: `templates/`
- 프로젝트 가이드: `docs/`
- 전체 라우팅: `AGENTS.md`의 `Context Map` 섹션

## 서브 에이전트 사용 원칙

Claude Code의 `Agent` 도구로 서브 에이전트를 실행할 수 있다.
서브 에이전트 역할과 사용 기준은 `docs/subagent-guide.md`를 참조한다.

- 단순하고 범위가 명확한 작업은 단일 에이전트로 처리한다.
- 역할 분리가 명확히 필요한 경우에만 서브 에이전트를 활용한다.
- 서브 에이전트 결과는 반드시 본 에이전트가 검토 후 사용자에게 전달한다.
