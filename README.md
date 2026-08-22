# AI Agent Template

이 저장소는 `개발 프로젝트용 에이전트 운영규칙 템플릿`이다. 목적은 실제 애플리케이션 코드를 바로 제공하는 것이 아니라, 새 프로젝트를 시작할 때 에이전트가 일관된 방식으로 작업하도록 공통 규칙, 역할별 지침, 요청 템플릿을 제공하는 데 있다.

## 포함 내용

- `AGENTS.md`: 모든 에이전트가 따라야 하는 공통 운영 규칙
- `STATE.md`: 현재 상태와 다음 작업 인계를 위한 기록 파일
- `agents/`: 역할별 세부 지침
- `.claude/`: Claude Code 자동화 레이어(skills, commands, hooks, subagents, plugin installer)
- `.codex/`: Codex 실행 절차 레이어(workflows, checks, subagent prompt guides)
- `templates/`: 기능 개발, 버그 수정, 리뷰 요청 템플릿
- `docs/`: intake 답변을 바탕으로 작성할 프로젝트 가이드 템플릿
- `templates/i18n-intake.md`, `docs/i18n-guidelines.md`: 다국어 프로젝트용 초기 설문과 기준 문서
- `templates/business-logic-request.md`, `docs/business-logic-playbook.md`: 비즈니스 로직 변경용 요청 템플릿과 프로세스 가이드
- `templates/framework-structure-intake.md`, `docs/framework-structure-guide.md`: 초기 프레임워크/디렉터리/파일 분리 기준 문서
- `docs/knowledge-management-guide.md`, `templates/knowledge-entry.md`: 사용자 입력부터 개발계획까지의 문서 분류·명명·생명주기 기준
- `templates/whitepaper-note.md`, `templates/development-plan.md`, `templates/decision-record.md`: 개념·백서·개발계획·의사결정 기록 양식

## 다른 프로젝트에 설치

대상 상태에 맞는 모드를 명시한다.

```bash
TEMPLATE_ROOT=/path/to/your-template-folder
TARGET_ROOT=/path/to/my-project
# 빈 신규 프로젝트
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --new "$TARGET_ROOT"

# 기존 프로젝트에 최초 연결
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --adopt "$TARGET_ROOT"

# 연결된 프로젝트 업데이트
bash "$TEMPLATE_ROOT/.claude/plugins/install.sh" --update "$TARGET_ROOT"
```

모드를 생략하면 대상 상태를 진단하고 권장 명령만 안내한다. 실제 변경 전에는 `--dry-run`을 함께 사용한다. 자세한 내용은 `docs/plugin-guide.md`를 참조한다.

## 지원 런타임

- Claude Code: `.claude/*` 자동화 레이어로 skills, commands, hooks, subagents를 사용한다.
- Codex: `AGENTS.md`와 `.codex/*` workflow/check 문서로 같은 운영 절차를 재현한다.
- 공통 정본: `AGENTS.md`, `STATE.md`, `docs/project-guide.md`, 프로젝트 로컬 `templates/`, `docs/`, `DESIGN.md`.
- 런타임별 대응 관계는 `docs/agent-runtime-matrix.md`, Codex 실행 기준은 `docs/codex-guide.md`, Claude 실행 기준은 `docs/claude-guide.md`를 따른다.

## 사용 방법

1. 이 저장소를 새 프로젝트의 시작점으로 복제하거나, 대상 상태에 맞는 설치 모드로 연결한다.
2. Claude Code에서 자연어로 "새 프로젝트 시작하자"고 말하면 `start` skill이 자동 활성화되어 초기 설정 QnA를 진행한다.
3. Codex에서는 `.codex/README.md`를 진입점으로 삼고, 작업 전 safety checklist와 작업 유형에 맞는 `.codex/workflows/*.md`를 따라 같은 템플릿을 읽는다.
4. 특정 영역(예: UI, API)을 더 깊이 수집하려면 자연어로 토픽을 언급하면 `intake` skill이 활성화된다. 또는 `/intake tech` 같은 슬래시 커맨드로 명시 호출 가능.
5. 작업 요청 시 "기능 추가", "버그 수정" 같은 키워드를 쓰면 해당 개별 skill이 자동 활성화된다. 또는 `/feature`, `/bugfix` 등 슬래시 커맨드로 명시 호출 가능.
6. 유형이 모호하면 `request` skill이 자동으로 분류한다. 또는 `/request`로 명시 호출.
7. 프로젝트 성격에 맞게 `AGENTS.md`를 커스텀한다.
8. intake 결과를 `docs/project-guide.md`에 반영한다.
9. `agents/*.md`에서 필요한 역할만 남기고 세부 규칙을 조정한다.
10. `templates/*.md`를 팀 작업 방식에 맞게 수정한다.
11. 작업이 끝날 때마다 `STATE.md`를 업데이트한다.
12. 프로젝트에 들어오는 정보는 `docs/00-inbox/`에 기록한 뒤 지식 관리 가이드에 따라 주제별 문서로 승격한다.

## Skills Layer (자동 활성화)

`.claude/skills/<name>/SKILL.md`에 정의된 skill은 description의 트리거 키워드로 사용자 발화에서 자동 활성화된다.

- `start` — 새 프로젝트 초기 설정 QnA (startup-checklist 11섹션)
- `dev-start` — 개발 세션 재개 상태 브리핑 + dev 컨테이너 기동 + hot reload 점검
- `intake` — 개별 토픽 수집 (project, tech, ui, responsive, i18n, framework, api, error, form, format, routing, qa)
- `request` — 작업 유형이 모호할 때만 활성화, 자동 분류
- `feature` — 기능 요청 구조화
- `bugfix` — 버그 수정 요청 구조화
- `refactor` — 리팩터링 요청 구조화
- `review` — 코드 리뷰 요청 구조화
- `business-logic` — 비즈니스 로직 변경 요청 구조화
- `design` — UI/스타일/토큰 작업 시 `DESIGN.md` 강제 참조

각 skill은 `templates/`의 원본을 읽어서 대화형으로 진행하며, 사용자 메시지의 설명을 미리 파싱해 가능한 항목을 채운다.
우선순위 규칙과 skill 연계 흐름은 `CLAUDE.md`의 Skills Layer 섹션 참조.

## Slash Commands (명시적 호출)

`.claude/commands/`에 동일 이름의 slash command가 병존한다. 사용자가 직접 입력해 호출할 수 있다.

- `/start`, `/dev-start`, `/intake [토픽]`, `/request [설명]`, `/feature [설명]`, `/bugfix [설명]`, `/refactor [설명]`, `/review [대상]`, `/business-logic [설명]`, `/design [컴포넌트]`

`[설명]` 인수를 주면 가능한 항목을 미리 채운다. skills와 동일 templates를 참조한다.

## Codex Workflows

`.codex/workflows/`는 Claude skills를 Codex 실행 절차로 옮긴 레이어다.

- `start` / `dev-start` / `intake` — 초기 QnA, 개발 세션 재개, 토픽별 정보 수집
- `request` — 모호하거나 복합적인 작업 요청을 개별 workflow로 분류
- `feature` / `bugfix` / `refactor` / `review` / `business-logic` — 작업 요청 처리
- `design` — UI/디자인 작업 시 `DESIGN.md`와 디자인 가이드 강제 참조

Codex에서는 자동 hook이 없으므로 `.codex/checks/safety-checklist.md`와 `.codex/checks/finish-checklist.md`를 작업 전후 체크리스트로 사용한다. `.codex/agents/*`는 `.claude/agents/*`와 같은 책임을 Codex 도구·승인 모델에 맞춰 수행하는 prompt guide다.

## README 운영 규칙

- 현재 `README.md`는 템플릿 저장소의 목적과 사용법을 설명한다.
- 실제 프로젝트로 복제된 이후에는 프로젝트별 `README.md`로 교체하거나 재작성한다.
- 실제 프로젝트의 `README.md`에는 프로젝트 소개, 실행 방법, 설치, 환경 설정, 배포 또는 개발 흐름을 적는다.
- 템플릿 사용법을 계속 남겨야 한다면 `docs/template-usage.md` 같은 별도 문서로 분리한다.

## 브라우저 UI

문서 기반 운영을 보조하는 정적 HTML UI를 `docs/` 아래에 둔다. 모두 외부 의존성 없는 단일 파일이며, `file://` 또는 임의의 정적 서버에서 동작한다.

- `docs/guide-browser.html` — 저장소의 모든 Markdown 문서를 탐색·검색·열람하는 가이드 브라우저. 사이드바 그룹 트리, 제목·섹션 검색(본문 검색 토글), 문서 내 목차, 문서 간 링크 이동을 제공한다. `scripts/build-docs-index.mjs`가 만든 `docs/docs-index.json`을 읽는다.
- `docs/development-process.html` — 개발 프로세스 시각 가이드 + 단계별 체크리스트(`localStorage` 저장) + STATE 미니 대시보드.
- `docs/development-strategy.html` — UI Mock First 기본 경로와 Logic/DB First 예외 경로를 비교하는 개발 전략 매뉴얼.
- `docs/intake.html` — Startup QnA 11섹션 위저드 + 핵심 요청 템플릿 폼. 입력값을 Markdown으로 내보낸다.
- `docs/admin-fe-preview.html` — admin/dashboard 디자인 시안과 data-table/filter/tab 케이스를 확인하는 프리뷰.
- `docs/user-fe-preview.html` — User FE 반응형 컴포넌트와 화면 패턴 프리뷰.
- `docs/user-fe-mobile-preview.html` — 모바일 전용판 컴포넌트와 네이티브-like 인터랙션 프리뷰.

### 1차 소스 규칙

- 에이전트가 읽는 1차 소스는 항상 `*.md`다.
- HTML UI는 사람이 보는 보조 화면이며, md를 수정한 뒤 필요 시 HTML도 함께 갱신한다.
- 동기화가 어긋났다고 판단되면 md를 기준으로 HTML을 다시 맞춘다.
- HTML을 수정한 뒤에는 인라인 `<script>` 구문 검사를 실행한다. 외부 의존성 없이 Node 내장 모듈만 사용한다.

```bash
node scripts/check-html.mjs
```

### 로컬 서버로 열기

`file://`로 열면 브라우저가 fetch를 막아 가이드 브라우저와 STATE 패널이 동작하지 않고, 일부 환경에서는 `.md` 응답 인코딩이 OS 기본값으로 떨어져 한글이 깨진다. 저장소 루트에서 아래 명령을 실행한다.

```bash
node scripts/serve-docs.mjs            # 기본 8765 포트
node scripts/serve-docs.mjs --port 9000
node scripts/serve-docs.mjs --no-index # 문서 인덱스 재생성 없이 서버만
```

시작할 때 `docs/docs-index.json`을 다시 만들고 `127.0.0.1`에만 바인딩한다. GET/HEAD만 받는 **읽기 전용** 서버이며 저장소 밖 경로 요청은 거부한다. 외부 의존성 없이 Node 내장 모듈만 쓴다.

시작 주소는 `http://localhost:8765/docs/guide-browser.html`이고, 루트(`/`)로 접속해도 같은 화면으로 연결된다. 나머지 화면은 `http://localhost:8765/docs/<파일명>.html`.

문서 인덱스만 따로 다루려면:

```bash
node scripts/build-docs-index.mjs          # 인덱스 생성
node scripts/build-docs-index.mjs --check  # 갱신 필요 여부만 검사(쓰기 없음)
```

인덱스는 파생 산출물이라 git으로 추적하지 않는다. 다른 정적 서버를 쓰더라도 `.md`·`.json`에 `charset=utf-8`을 붙이고 저장소 루트를 문서 루트로 잡아야 한다.

## 권장 다음 단계

- 프로젝트 유형별 `agents/*.md` 세분화
- `templates/` 확장
- intake 답변 예시와 guide 작성 예시 추가
- 필요 시 `docs/` 아래에 템플릿 사용 예시 추가
- HTML UI(현재 7종) 확장 또는 md→HTML 자동 동기화 스크립트 도입
