# Skills Layer 전환 TODO

Commands -> Skills 전환 작업의 미완성, 개선, 누락 항목을 난이도 순으로 정리한다.

## 미완성 기능

- [x] `refactor` SKILL.md 작성 (commands/refactor.md 내용 전환)
- [x] `review` SKILL.md 작성 (commands/review.md 내용 전환)
- [x] `business-logic` SKILL.md 작성 (commands/business-logic.md 내용 전환)
- [x] `intake` SKILL.md 작성 (commands/intake.md 내용 전환)
- [x] `CLAUDE.md` Skills Layer 섹션을 `.claude/skills/` 기준으로 업데이트
- [x] `AGENTS.md` Context Map의 Skills Layer 경로를 `.claude/skills/`로 변경
- [x] `STATE.md`에 Skills 전환 작업 이력 반영
- [x] `README.md`의 커스텀 커맨드 섹션을 Skills 구조 기준으로 업데이트
- [x] `.claude/plugins/manifest.json`에 skills 파일 목록 추가
- [x] 기존 `.claude/commands/` 파일 정리 방침 결정 (삭제 or 병존) — 결정: 병존 (skills=자동 활성화, commands=명시적 호출)

## 개선 필요

- [x] 완료된 SKILL.md 4개(`start`, `request`, `feature`, `bugfix`)의 description 키워드 보강 — 한국어+영문 트리거 키워드 병기 완료
- [x] `request` skill과 개별 skill(`feature`, `bugfix` 등) 간 우선순위 충돌 방지 규칙 명시 — `request`는 키워드 모호할 때만 활성화하도록 description 수정 + CLAUDE.md/SKILL.md에 규칙 명시
- [x] skill 간 연계 흐름 정의 — `start` 완료 후 `intake`/`request`/개별 skill로 이어지는 가이드를 CLAUDE.md와 start SKILL.md에 추가
- [x] `settings.local.json`에 skills 관련 설정 필요 여부 확인 — 별도 설정 불필요(SKILL.md 파일 존재만으로 자동 활성화)
- [x] `docs/subagent-guide.md`에 skills와 서브에이전트의 역할 구분 명시

## 에러/누락 처리

- [x] 기존 SKILL.md의 `$ARGUMENTS` 참조 — 자연어 파싱 방식("사용자 메시지에 ~ 있으면")으로 재설계
- [x] 작성된 SKILL.md 내 `/feature`, `/bugfix` 등 slash command 참조 링크 — "해당 skill이 활성화된다" 표현으로 대체
- [x] `start` SKILL.md의 "다음 액션"에 `/intake`, `/request` 등 command 참조 — skills 기반 안내로 변경 완료
- [x] `request` SKILL.md의 분류 결과가 command(`/feature`) 호출을 안내 — skills 매칭으로 전환 완료
- [x] `intake` skill의 토픽 매핑 12종이 실제 `templates/*-intake.md` 파일 존재와 일치하는지 검증 — 12종 모두 존재 확인

---

# 문서 자기일관성 정리 TODO

Codex 분석(2026-05-14)과 본 에이전트 재검증으로 확인된 루트/하위 문서 간 드리프트와 빈 참조를 해소한다. 우선순위는 운영 영향도 기준(설치 경로 > 실행 산출물 > 표기 정합성).

## 미완성 기능

- [x] `docs/plugin-guide.md`의 `설치 내용` 섹션을 현재 `manifest.json` 구조에 맞춘다 — L2를 `L2 Skills: .claude/skills/ (8개 SKILL.md, 자동 활성화)` + `L2 Commands: .claude/commands/ (8개 slash command, 명시적 호출)`로 분리, L4를 5종(`explorer`, `code-reviewer`, `planner`, `test-runner`, `feature-dev`)으로 갱신.
- [x] `docs/plugin-guide.md`의 `커스텀` 섹션에 `.claude/skills/`와 `.claude/commands/`를 분리 항목으로 추가한다. — 설치 내용 섹션에서 함께 분리하면서 처리(커스텀 섹션은 기존 항목이 skills 분리 시점에 자연스럽게 호환됨).
- [x] `CLAUDE.md` Repo Map의 `.claude/agents/ — L4 서브에이전트 프롬프트 템플릿 3종` 표기를 5종으로 정정한다 — `CLAUDE.md:73`. 같은 파일 131-135라인의 5종 나열과 일치시킨다.
- [x] `manifest.json`의 `supporting.docs`에 `docs/development-process.html`, `docs/intake.html` 추가 — install.sh가 HTML UI를 함께 배포하도록 한다. 사전에 의도된 축소 배포가 아닌지 사용자 확인. (단순 누락으로 판단, 추가 진행)
- [x] HTML 두 파일이 설치 대상이 되면 `install.sh`가 정상 복사하는지 `--dry-run`으로 검증한다 — `/tmp/claude-template-dryrun-test`로 dry-run 실행, `docs/development-process.html`/`docs/intake.html` 모두 `[복사 예정]` 출력에 포함됨. 총 65개 설치 대상, 0개 건너뜀.

## 개선 필요

- [x] `AGENTS.md:117-122`의 `Constraint 1: 표(Table) 형식은 사용하지 않는다.` 적용 범위를 문장으로 명시한다 — 옵션 A 적용(Context Map 섹션 한정으로 재서술). 다른 문서의 표 사용은 유지. 전역화(옵션 B)가 필요하다면 별도 결정.
- [x] `docs/plugin-guide.md`의 `버전 확인` 예시 경로가 현재 저장소 디렉터리명(`claude-agent-templete`)과 일치하는지 검토 — 정본을 `claude-agent-templete`(GitHub 저장소명, manifest `name` 필드)로 결정. plugin-guide.md 3개 경로 + manifest.json `name` 필드 통일, 문서 첫 단락에 정본 표기 메모 추가.
- [x] `STATE.md` `다음 작업`의 `docs/ui-decisions.md 템플릿 추가` 항목이 실제 완료될 때 `development-process.md:89`의 참조도 함께 살아나는지 확인하고, 둘 중 한쪽이 변경되면 다른 쪽도 동기화하는 운영 메모 추가. — `development-process.md` Phase 3 단계 6에 동기화 운영 메모 추가, `STATE.md` 다음 작업 항목에 동기화 메모 inline 추가.

## 에러/누락 처리

- [x] `docs/development-process.md:89`의 `docs/ui-decisions.md로 별도 저장한다` 참조 해소 — 옵션 (b) 적용. "필요 시 작성"으로 약화 + 현재 파일 미존재 사실을 명시. 빈 템플릿 신규 작성은 보류.
- [x] `docs/plugin-guide.md`의 `L4 Subagents (3개)` 표기와 실제 5개 불일치 — manifest 기준 동기화 완료 (L2 skills/commands 분리, L4 5종 갱신). 추후 Layer 파일 추가 시 동기화 책임자 명시는 별도 작업으로 미분류.
- [x] `manifest.json`의 `supporting` 섹션에 누락 가능성이 있는 자산을 일괄 점검 — `docs/global-claude-md-template.md` 추가 완료. HTML 2종도 supporting.docs에 추가.
- [x] 위 정리 작업 완료 후 `STATE.md`의 `이번 세션에서 완료한 작업` 섹션에 변경 이력 추가, `다음 작업` 섹션에서 해소된 항목 제거. — 완료 이력 추가, 현재 기준 파일 섹션에 신규 자산 등록. `다음 작업` 섹션의 ui-decisions.md 항목은 약화로 해소.

---

# 디자인 시스템 통합 TODO

`DESIGN.md`(원티드 디자인 시스템 카탈로그)를 디자인/UI 작업의 1차 소스로 삼고, 에이전트가 UI 산출물을 만들거나 검토할 때 자동으로 참조하도록 5-Layer에 통합한다. DESIGN.md는 토큰(`{group.name}` 호출 형식), 컴포넌트 14종, Do/Don't, 다크 모드 alias까지 self-contained된 SSOT다.

## 미완성 기능

- [x] `.claude/skills/design/SKILL.md` 신규 작성 — 디자인 키워드 자동 활성화, DESIGN.md 강제 로드, 토큰 호출 형식 강제. 시스템에 design skill 등록 확인됨.
- [x] `CLAUDE.md` Repo Map에 `DESIGN.md — 디자인 시스템 카탈로그 (UI 작업 1차 소스)` 항목 추가.
- [x] `CLAUDE.md`에 `Design System` 섹션 신설 — Naming Conventions 위에 배치. 토큰 호출 규칙, Do/Don't 핵심, 카피 톤, 자동 활성화 흐름 명시.
- [x] `AGENTS.md` Context Map에 DESIGN.md 라우팅 추가 + Skills Layer 8→9종 갱신 + 서브에이전트 5→6종 갱신 + design-guidelines.md 라우팅 추가.
- [x] `docs/design-guidelines.md` 신규 작성 — 1차 소스 규칙, 토큰 호출 형식, alias/atomic 선택, dark alias 정책, 컴포넌트 추가 절차, Do/Don't 운영, 카피 톤, 자동 활성화 흐름.
- [x] `.claude/plugins/manifest.json`의 `L1_memory.files`에 `DESIGN.md` 추가, `supporting.docs`에 `docs/design-guidelines.md` 추가. JSON 유효성 통과.
- [x] `templates/ui-intake.md`에 `사용 디자인 시스템` 섹션 추가 — DESIGN.md를 그대로 쓸지, 프로젝트별 fork 버전을 둘지, 일부 토큰만 override할지 수집. 작성 예시에도 (a) 시나리오 반영.

## 개선 필요

- [x] `agents/executor-agent.md` 구현 체크리스트에 디자인 항목 4개 추가 (토큰 호출, 비-4 배수 금지, gradient 위치, gray-* 표면 금지).
- [x] `agents/executor-agent.md`에 `### Design` 작업 유형별 체크리스트 섹션 추가.
- [x] `agents/reviewer-agent.md`에 `### Design 리뷰 포커스` 섹션 추가.
- [x] `agents/researcher-agent.md`의 Feature/Refactor 조사에 DESIGN.md 확인 항목 추가.
- [x] `templates/feature-request.md`에 `## 디자인 토큰 참조` 섹션 추가.
- [x] `.claude/skills/feature/SKILL.md`, `.claude/skills/refactor/SKILL.md`, `.claude/skills/bugfix/SKILL.md`에서 UI 영향이 발견되면 design skill로 연계되는 흐름을 description/본문에 명시. — 3개 skill 본문에 `## 다른 skill과의 연계` 섹션 추가, 각 작업 유형별 트리거 조건과 design/design-reviewer 연계 시점 명시.
- [x] `templates/ui-intake.md`의 기존 항목 중 DESIGN.md와 중복되는 입력(색상 톤·radius·spacing 정책)은 "DESIGN.md를 기본값으로 사용" 분기를 제공해 중복 입력을 줄인다. — `## 토큰 정책` 섹션 신설(색·spacing·radius·typography·dark 모두 기본값 명시), `## 콘텐츠 원칙`에 카피 톤 기본값 추가, 작성 예시도 갱신.

## 에러/누락 처리

- [x] `.claude/agents/design-reviewer.md` 신규 서브에이전트 템플릿 작성 — Do/Don't 위반 자동 검출, 시그너처 패턴 누락, 다크 alias 누락. 출력 형식 및 도구 제한 명시.
- [x] `docs/subagent-guide.md`의 디스패치 기준에 `design-reviewer` 추가 — `code-reviewer`와 병렬 가능 명시.
- [x] DESIGN.md의 `[src:1]` 인용이 가리키는 외부 URL(`api.anthropic.com/v1/design/...`)에 대한 의존성 정책 명시 — DESIGN.md 상단에 boxed note 추가(self-contained 운영 가능 명시), `docs/design-guidelines.md`의 1차 소스 규칙에 외부 URL 재방문 조건 4종과 만료 시 보존 정책(`[src:N (archived)]`) 추가.
- [x] DESIGN.md의 frontmatter(`name: 원티드`, `slug: wanted`, `category: etc`, `last_updated`)가 다른 프로젝트에 install될 때의 정책 결정 — **옵션 B 결정**(그대로 복사 + 첫 단계 재작성 의무화). 이유: `.example` 분리는 다른 템플릿(STATE.md/AGENTS.md)의 "복사 후 수정" 패턴과 어긋남. `templates/startup-checklist.md` 섹션 3에 Q6(디자인 시스템 선택 A/B/C) + Q7(frontmatter 재작성) + Q8(STATE.md 기록) 추가, `docs/design-guidelines.md`의 메타 운영 섹션에 install 정책 명시.
- [x] `.claude/hooks/`에 디자인 토큰 외 값 사용 정적 경고 hook 도입 검토 — `.claude/hooks/warn-design-tokens.sh` opt-in 스크립트 작성(hex/비-4 px 검출, 항상 exit 0), `settings.local.json`에는 기본 미등록 결정. CLAUDE.md Hooks Layer 섹션 + manifest.json + design-guidelines.md에 활성화 방법 명시. 통합 동작 검증(hex+10px 입력 → 경고 출력 + exit 0 / md 파일 → 통과).
- [x] `templates/qa-intake.md`에 "디자인 토큰 외 값 사용 시 PR에서 경고 표시 여부" 항목 추가 — CI/CD 섹션에 없음/경고만/차단 3-옵션 항목 추가, 작성 예시에도 정책 라인 반영.
- [x] DESIGN.md 갱신 시 STATE.md `이번 세션에서 완료한 작업`에 토큰/컴포넌트 변경 이력을 남기는 운영 규칙을 `docs/design-guidelines.md`와 `AGENTS.md` 문서화 원칙 섹션에 명시. — AGENTS.md 문서화 원칙 마지막 항목으로 운영 규칙 추가, design-guidelines.md에 `## STATE.md 변경 이력 운영 규칙` 섹션 신설(3단계 절차 + 정본 명시).
- [x] 위 통합 완료 후 `STATE.md`의 `이번 세션에서 완료한 작업` + `현재 기준 파일` 섹션에 `DESIGN.md`, `docs/design-guidelines.md`, `.claude/skills/design/SKILL.md`, `.claude/agents/design-reviewer.md`를 추가한다. — 디자인 4종은 이전 세션에서 이미 등록됨. 오늘(2026-05-15) todo.md 12종 처리 이력을 새 세션 블록으로 추가하고, 신규 opt-in hook `warn-design-tokens.sh`를 hooks 섹션에 추가.
