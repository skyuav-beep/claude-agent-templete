# Codex Runtime Guide

이 디렉터리는 Codex가 Claude Code 전용 자동화 없이 같은 운영 절차를 수행하도록 돕는 런타임 어댑터다. 작업별 자동 선택은 저장소 루트 `.agents/skills/`의 네이티브 Skill이 담당하고, 이 디렉터리는 승인·검증·호환 workflow를 담당한다.

## 경로 해석

- workflow와 agent guide가 지시하는 `templates/`, `agents/`, `docs/`, `designs/`, `DESIGN.md`는 프로젝트 루트를 먼저 찾는다.
- 프로젝트에 없고 루트 `rules/`가 있으면 `rules/` 아래 같은 경로를 읽는다.
- 프로젝트 로컬 파일이 공통본보다 우선이며, `rules/` 공통본을 대신 읽었으면 작업 보고에 한 줄로 밝힌다.

## 읽기 순서

1. `AGENTS.md`
2. `CLAUDE.md`의 `## 커뮤니케이션`, `## 답변 포맷`
3. `STATE.md`
4. `docs/project-guide.md`가 있으면 해당 문서와 현재 작업 영역의 하위 `AGENTS.md`
5. `.codex/checks/safety-checklist.md`
6. `.agents/skills/<작업유형>/SKILL.md` 또는 명시적 절차가 필요하면 `.codex/workflows/<작업유형>.md`
7. workflow가 가리키는 프로젝트 로컬 정본 또는 위 경로 규칙에 따른 `rules/` 공통본
8. `.codex/checks/finish-checklist.md`

## 작업 라우팅

- 새 프로젝트 시작: `workflows/start.md`
- 개발 세션 재개(PC 켜고 시작): `workflows/dev-start.md`
- 기술 스택 업그레이드: `workflows/stack-upgrade.md`
- 세션 충돌 조정: `workflows/session-coordination.md` (Claude는 `.claude/skills/session-coordination/`)
- 미완료 Git 작업 정리: `workflows/git-cleanup.md`
- 세션 종료와 인계 정리: `workflows/session-end.md`
- 토픽별 intake: `workflows/intake.md`
- 모호한 작업 요청 분류: `workflows/request.md`
- 기능 개발: `workflows/feature.md`
- 버그 수정: `workflows/bugfix.md`
- 리팩터링: `workflows/refactor.md`
- 리뷰: `workflows/review.md`
- 비즈니스 로직 변경: `workflows/business-logic.md`
- 디자인/UI 작업: `workflows/design.md`

## 종료 규칙

- 모든 workflow는 단순 사실 조회를 제외하고 `docs/approval-workflow.md`의 6단계 승인 절차와 한 턴 한 단계 원칙을 먼저 적용한다.
- 가능한 검증을 실행한다.
- 실행하지 못한 검증은 이유를 남긴다.
- 긴 답변과 최종 통합은 `CLAUDE.md ## 답변 포맷`을 따른다.
- 문서/운영 규칙 변경 시 `STATE.md`를 갱신한다. 진행된 작업의 사실 기록이므로 갱신 여부를 사용자에게 다시 묻지 않는다(`docs/approval-workflow.md ## 재확인하지 않는 작업`).
- 3단계에서 승인된 Git 수명주기는 6단계에서 `STATE.md` 기록부터 cleanup까지 완료한다.

## 단계 실행 계약

Codex는 Claude Code의 `PreToolUse` 훅을 자동 실행하지 않는다. 따라서 모든 비조회 작업에서 다음을 응답과 도구 실행의 시작점으로 사용한다.

1. `현재 단계`를 1~6 중 하나로 선언한다.
2. 1단계와 2단계에서는 읽기 전용 명령만 실행한다.
3. 3단계에서는 승인 범위와 Git 수명주기를 제시하고 멈춘다.
4. 승인 후에만 worktree·파일 수정·설치·검증·Git 쓰기를 수행한다.
   쓰기 전에는 `.codex/checks/safety-checklist.md ## 실행 전 공용 판정기`로 파괴·배포·비밀 파일 여부를 판정한다.
5. 구현이 끝나면 5단계 사후 감사 결과를 별도 응답으로 남긴다.
6. 6단계 승인 범위가 있을 때만 commit·push·PR·merge·cleanup을 수행한다.

사용자의 메시지 전체가 공백 제거 후 `>` 하나이면 직전 응답의 `다음 단계 진행해`와 동일하게 해석한다. 이 단축 입력은 직전 응답에서 제시한 범위 안에서만 적용하며, 위험 작업의 새 승인을 대신하지 않는다.

각 응답에 다음 봉투를 포함한다.

```text
현재 단계: <1~6>
이번 단계 산출물: <요약>
다음 단계: <사용자 승인 대기 또는 다음 단계>
쓰기 가능 여부: <읽기 전용 또는 승인 범위>
```

훅이 자동 실행되지 않는 대신, 가드레일 3종(`block-destructive.sh`, `block-deploy.sh`,
`block-secret-files.sh`)을 실행 전 판정 전용으로 호출한다. 종료 코드 `0`이면 진행하고 `2`면
실행하지 않는다. 판정 기준을 문서에 옮겨 적지 않고 Claude와 같은 스크립트를 그대로 쓰는 이유는
두 런타임의 차단 기준이 갈라지지 않게 하기 위해서다. 호출 형식은 안전 체크리스트에 있다.

이 계약은 Codex 호스트의 도구 권한을 대체하지 않는다. 호스트 수준의 PreToolUse/승인 API가 제공되면 이 계약의 단계 상태와 연결해야 하며, 제공되지 않는 동안에는 체크리스트·diff·최종 감사로 위반을 탐지한다.

## 작업 알림

- 턴이 끝나면 소리와 데스크톱 알림으로 알린다. 여러 창을 동시에 쓸 때 완료를 놓치지 않기 위한 것이다.
- `~/.codex/config.toml`에 `notify = ["<절대경로>/.codex/hooks/notify-codex.sh"]`를 등록한다.
- 어댑터가 Codex 페이로드를 Claude 훅 형식으로 바꿔 `.claude/hooks/notify-pending.sh`를 호출한다. 알림 로직은 두 런타임이 같은 스크립트를 쓴다.
- 확인(ACK)은 rollout 기록 파일이 갱신되면 성립한다. 즉 그 창에서 다음 작업을 진행하면 반복 알림이 멈춘다.
- 소리·간격 조정과 되돌리기는 `docs/notification-guide.md`를 참조한다.

## 동등성 기준

- `.agents/skills/*`는 Codex가 자연어 요청에서 선택하는 네이티브 작업 진입점이다.
- `.codex/workflows/*`는 네이티브 Skill이 참조하는 상세 절차와 명시적 실행 호환 문서다.
- `.codex/checks/*`와 `scripts/check-codex-skills.mjs`는 Skill을 넘어 결정론적으로 검증할 수 있는 항목을 담당한다.
- `.codex/agents/*`는 `.claude/agents/*`의 역할과 같은 책임을 수행하되, Codex 도구·승인·샌드박스 모델에 맞춰 실행한다.
- 모든 workflow와 agent guide는 `AGENTS.md ## 프로젝트 로컬 가이드 우선`을 선행 기준으로 적용한다.
- 상세 정책은 중복 정의하지 않고 `AGENTS.md`, `agents/*.md`, `templates/*.md`, `docs/*.md`, `DESIGN.md`를 공통 정본으로 사용한다.
