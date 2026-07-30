# STATE.md

## 현재 상태

- 이 저장소는 `개발용 에이전트 운영 템플릿`이다.
- 어떤 프로젝트에서도 재사용할 수 있는 공통 운영 규칙, 역할별 지침, 요청 템플릿, intake/guide 문서를 제공한다.
- 공통 규칙은 `AGENTS.md`에 정의한다.
- 역할별 규칙은 `agents/` 아래에 둔다.
- 작업 요청 템플릿과 intake 양식은 `templates/` 아래에 둔다.
- 가이드 문서는 `docs/` 아래에 둔다.
- 본 템플릿을 소비하는 런타임 앱은 sibling 저장소 `../riderapp-runtime/`이다.

## 이전 세션까지 완료한 작업

- `AGENTS.md`를 개발용 에이전트 운영 템플릿 기준으로 재구성했다.
- 역할별 에이전트 문서(`agents/main-agent.md`, `agents/executor-agent.md`, `agents/researcher-agent.md`, `agents/reviewer-agent.md`)를 정리했다.
- 기능 개발, 버그 수정, 리뷰, 리팩터링, 비즈니스 로직 요청 템플릿을 추가했다.
- 템플릿 저장소용 `README.md`를 추가하고, 실제 프로젝트 `README.md`와의 역할 구분 규칙을 `AGENTS.md`에 반영했다.
- `AGENTS.md`의 `세부 규칙 위임` 섹션에 코딩 입력 분류 기준을, `작업 시작 전 프로토콜` 섹션에 intake -> guide -> development 흐름을 반영했다.
- `agents/executor-agent.md`, `agents/reviewer-agent.md`에 코딩 체크리스트를 추가했다.
- 루트 `AGENTS.md`에 `Core Philosophy`, `Execution Protocol`, `Project Context & Operations`, `Golden Rules`, `Context Map (Action-Based Routing)` 섹션을 반영했다.
- 프로젝트 시작 전 설문형 정보 수집을 위한 intake 템플릿(`templates/project-intake.md`, `templates/ui-intake.md`, `templates/responsive-intake.md`, `templates/tech-intake.md`)을 추가했다.
- intake 답변을 실제 개발 기준으로 바꾸기 위한 `docs/project-guide-template.md`를 추가했다.
- 다국어 프로젝트용 `templates/i18n-intake.md`, `docs/i18n-guidelines.md`를 추가하고 `AGENTS.md`, executor/reviewer agent 문서에 i18n 규칙을 반영했다.
- Codex가 어떤 규칙과 파일을 어떤 우선순위로 참조하는지 정리한 `docs/codex-reading-order.md`를 추가했다.
- 비즈니스 로직 개발 프로세스용 `docs/business-logic-playbook.md`와 `templates/business-logic-request.md`를 추가했다.
- 초기 프레임워크/디렉터리/파일 분리 기준용 `docs/framework-structure-guide.md`와 `templates/framework-structure-intake.md`를 추가했다.
- 에이전트 초기 시작 QnA 체크리스트 `templates/startup-checklist.md`(7개 섹션)를 추가했다.
- `AGENTS.md` 작업 시작 전 프로토콜에 새 프로젝트 / 기존 프로젝트 분기 기준을 추가했다.
- 런타임 에이전트 앱 `riderapp-runtime`을 sibling 저장소로 신규 생성했다. (`/home/skyua/projects/riderapp-runtime`, pnpm workspace, Claude Agent SDK 래퍼/비용 통제/SQLite/Next.js 대시보드)

## 이번 세션에서 완료한 작업

- Codex 세션 종료 상태를 정리했다. (2026-07-30)
  - 공통 템플릿 `3.0.0`과 6단계 승인 워크플로가 원격 `main`에 반영된 상태를 확인했다.
  - 승인 워크플로 작업은 PR #7로 squash merge됐고, 이후 상태 정리 커밋까지 포함한 로컬 `main`·로컬 `origin/main`·실제 원격 `main`이 `5595434`로 일치했다.
  - 미커밋 변경, 미푸시·미수신 커밋, 열린 PR, `agent/*`·`codex/*`·`docs/*` 원격 작업 브랜치, 추가 worktree가 모두 없음을 확인했다.
  - 이 종료 기록은 `agent/state-session-close` 전용 worktree에서 `STATE.md`만 수정하고, 전체 CI는 사용자 요청에 따라 제외했다.

- 공통 에이전트 템플릿 v3.0.0에 6단계 승인 워크플로를 도입했다. (2026-07-30)
  - 정본 `docs/approval-workflow.md`: 요청 정리 → 읽기 전용 분석과 branch/worktree/Git 수명주기 계획 → 명시 승인 → 구현 → 읽기 전용 사후 감사 → 빠른 검증과 STATE·commit·push·ready PR·merge·원격 base 검증·cleanup.
  - 3단계에서 2단계에 적은 전체 Git 수명주기를 승인하면 6단계까지 다시 묻지 않고 마무리하되, 범위 확대·보호 규칙 우회·배포·릴리스·원격 migration·데이터 삭제는 포함하지 않는다.
  - 전체 로컬 CI는 작업마다 돌리지 않고 3~5개 작업 누적·하루 종료·릴리스 전·사용자 요청 시 배치 실행한다. 6단계는 기본 5분 이내의 범위 검증만 수행하며 인증·권한·결제·정산·migration 검증은 미루지 않는다.
  - AGENTS/CLAUDE managed block, Claude skills/commands, Codex 진입점/checklist/workflow, 역할 문서, 개발·비즈니스 로직 가이드의 충돌 문구를 정리했다.
  - 배포 버전과 manifest를 `3.0.0`으로 올리고 신규 정본 문서를 설치 대상에 포함했다.

- 문서 탐색 UI(`guide-browser.html`) + 로컬 문서 서버 신설. (2026-07-30)
  - **발단**: "가이드를 서버로 띄워 UI로 확인하고 추가 내용도 작성할 수 있게 할 수 있나" 분석 요청. 1단계 진단 결과 **서버 실행·UI 확인은 이미 가능**했으나(README의 정적 서버 안내 + HTML 6종), 브라우저로 볼 수 있는 건 6개 화면뿐이고 문서 104개 대부분은 에디터로만 열 수 있었다. 작성·저장(write-back)은 전무. 사용자 선택에 따라 **읽기 전용 탐색 범위를 먼저 완성**하고 작성·저장은 다음 단계로 미뤘다.
  - **`scripts/build-docs-index.mjs` 신규**: 저장소의 md 전체를 훑어 `docs/docs-index.json`을 만든다. 문서별 제목·frontmatter description·헤딩(H2/H3)·줄수·바이트·수정일과 사이드바 그룹(루트/Skills/Commands/Subagents/Codex/역할 규칙/양식/가이드/시안/스크립트 11종)을 담는다. 코드펜스 안의 `#`은 헤딩으로 세지 않는다. `--check`는 쓰기 없이 갱신 필요 여부만 알린다. 루트 문서는 읽기 순서(`CLAUDE`→`AGENTS`→`STATE`→`DESIGN`→`README`→`todo`)로 정렬.
  - **`docs/guide-browser.html` 신규**: 단일 파일·외부 의존성 0. 사이드바 그룹 트리(접힘 상태 `localStorage` 유지), 제목·경로·섹션 검색 + **본문까지 검색 토글**(104개 지연 로드·동시 6개·진행 표시·메모리 캐시), 문서 내 목차(스크롤 위치 하이라이트), 문서 간 상대 링크를 뷰어 내부 이동으로 해석, 해시 라우팅(`#경로::앵커`), 검색어 본문 하이라이트, `/`·`Esc` 단축키, 원문 열기. 기존 HTML과 동일한 다크 토큰·Pretendard 스택을 따랐다.
  - **Markdown 렌더러 자체 구현**: 외부 라이브러리 없이 헤딩·표·코드펜스·중첩 목록·체크박스·인용·구분선·링크·위키링크·강조·frontmatter 박스를 처리한다. 모든 출력은 이스케이프 후 조립한다.
  - **`scripts/serve-docs.mjs` 신규**: 시작 시 인덱스를 재생성하고 `127.0.0.1`에만 바인딩하는 **읽기 전용** 정적 서버(GET/HEAD만, 그 외 405). 저장소 밖 경로는 거부하고 `.md`·`.json` 등에 `charset=utf-8`을 붙인다. README의 python3 한 줄 명령을 이 스크립트로 대체했다.
  - **검증**: 렌더러 문법 단위 15/15(이스케이프·코드펜스 내 `#` 무시·중첩 목록 균형·표·frontmatter 포함) + **실제 문서 104/104 렌더 성공**, 태그 불균형 0, 미이스케이프 스크립트 0. 서버 라이브 실측 — 주요 7경로 200 + 올바른 content-type, 경로 탈출 2종(`../`, `%2e%2e`) 404, POST 405, 없는 경로 404, 한글 정상. `node scripts/check-html.mjs` HTML 7개·인라인 스크립트 6개 통과.
  - **배선**: README 브라우저 UI 목록·서버 실행 절차 교체(6종→7종), `CLAUDE.md` Repo Map에 `scripts/` 항목 신설. 생성물 `docs/docs-index.json`은 파생 산출물이라 `.gitignore`에 추가했다. 설치 배포(`manifest.json`)에는 등록하지 않았다 — 이 저장소 문서를 인덱싱하는 유지보수 도구이므로 `check-html.mjs`와 같은 기준을 적용했다.
  - **사이드바 위계 보강(사용자 피드백)**: "대제목과 소제목 구분이 눈에 띄지 않고 카테고리 역할 설명이 없다"는 지적을 반영했다. 그룹 메타(아이콘·색·역할 설명)를 인덱스 생성기에 데이터로 정의해 UI가 하드코딩 없이 따라오게 했다. 대제목은 색 배지 아이콘 + 밝은 굵은 라벨 + 색상 카운트 + 좌측 컬러 바, 소제목은 세로 레일 들여쓰기 + 점 마커 + 낮은 톤으로 분리했고, 각 그룹 아래에 한 줄 역할 설명을 붙였다. 홈 화면에도 같은 아이콘·색을 쓰는 `카테고리` 안내 카드를 추가해 누르면 해당 그룹이 목록에서 펼쳐진다. 아이콘은 이모지가 아닌 단색 기호를 써서 CSS로 색을 통제하고, Codex 3종은 teal 계열로 묶어 소속을 드러냈다.
  - **결함 1건 발견·수정**: `guide-browser.html`에 인라인 코드 sentinel용 **원시 NUL 문자 4개**가 그대로 들어가 파일이 바이너리로 분류되고 `grep` 같은 텍스트 도구가 동작하지 않았다(파서가 U+FFFD로 치환하면 sentinel도 깨진다). 이스케이프 표기로 바꾸고, 재발 방지로 `scripts/check-html.mjs`에 **원시 제어 문자 검사**를 추가했다(탭·개행·CR 제외, 위치와 코드포인트를 알려주고 exit 1). 고의 손상 파일로 검출 동작을 확인했다.
  - **추가 검증**: 그룹 색 변수 변환 5/5(rgba 파생·잘못된 값 중립 처리 포함), 그룹 객체 필드 참조·마크업 클래스 구성 14/14, 제어 문자 가드 정상 검출, 렌더러 104/104 회귀 유지.
  - **리포트 2단계(구현 옵션 비교)**: 작성·저장을 구현하는 세 가지 — ⓐ 로컬 쓰기 서버 ⓑ 브라우저 파일 권한(File System Access API) ⓒ 현행 Markdown 내보내기 확장. ⓑ는 Chrome·Edge 전용이라 범용성이 없고 ⓒ는 실제 파일 반영이 안 된다. **ⓐ 권고**하되 안전장치 4종(기본 읽기 전용·대상을 저장소 안 md로 제한·열었을 때와 달라졌으면 저장 거부·저장 전 변경 확인)을 전제로 한다.
  - **리포트 3단계(제약·리스크·계획)**: 저장소 규칙과의 충돌은 회피 가능하다 — 유지보수 스크립트 자리에 두고 배포 목록에서 제외하면 "런타임 코드 없음" 원칙과 어긋나지 않고, 외부 의존성도 없으며, 편집 결과가 곧 md라 1차 소스 규칙도 유지된다. 단 6단계 승인 워크플로 적용 대상이다. 리스크는 덮어쓰기 충돌·대상 이탈·되돌리기 불가·접근 노출·동시 세션 5종으로 정리했고 각각 대응을 붙였다. 적용은 4단계(①읽기 전용 완료 ②편집 화면·파일 미변경 ③저장 기능 ④타 프로젝트 확장)로 쪼갠다.
  - **사용자 결정 대기 3건**: ① 편집 범위(이 저장소만 / 연결 프로젝트까지) ② 저장 방식(파일만 / 저장과 동시에 커밋) ③ 새 문서 생성 허용 여부. 권고는 **이 저장소만 · 파일만 저장 · 기존 문서 수정만**이다. 세션 종료 시점 기준 미결정이라 Phase 2는 착수하지 않았다.
  - **히스토리 참고**: 이 작업의 로컬 커밋 3건(`a3236e0` 보고 범위 규칙, `38b3bea` 가이드 브라우저, `2ad3eb2` 사이드바 보강)은 다른 세션이 `main`을 원격 기준으로 재설정하면서 히스토리에서 빠졌다. **내용은 `97f77f0`에 전부 포함**되어 손실이 없고 작업트리도 원격과 일치한다. 커밋 단위 이력이 필요하면 reflog에서 세 해시를 그대로 되살릴 수 있다.

- 답변 포맷에 `보고 범위 한정` 규칙 신설. (2026-07-30)
  - **발단**: 사용자가 이 저장소의 로컬/원격 상태를 물었는데 답변 말미에 다른 저장소(`mlm_v1.0`)의 push 대기 항목을 덧붙여, "혼동되니 언급하지 말고 필요하면 직접 요청하겠다"는 지적을 받았다.
  - **규칙**: 답변은 사용자가 지정한 대상으로 한정한다(미지정 시 현재 세션이 열린 저장소). 다른 저장소·연결 프로젝트의 미커밋·미푸시·대기 작업·열린 PR 상태는 요청 시에만 언급하고, 요약 말미에 "참고로 다른 저장소에는 …"을 덧붙이지 않는다. 범위 밖 후속 작업은 상태를 나열하지 말고 한 줄 질문으로만 연다.
  - **예외 3종(범위와 무관하게 보고)**: ① 이번 작업에서 범위 밖 파일을 실제로 변경한 경우 ② 다른 대상의 상태 때문에 요청이 막히거나 결과가 달라지는 경우 ③ 데이터·이력 유실 위험이 있는 경우. 연결 프로젝트 일괄 점검처럼 여러 대상이 본래 요청 범위인 작업은 규칙 대상이 아니며 대상별로 구분해 보고한다.
  - **배선**: 정본은 `CLAUDE.md ## 답변 포맷 > 보고 범위 한정`(심링크 공유라 연결 프로젝트에 즉시 반영). 유저 전역 `~/.claude/CLAUDE.md`에 `내부 식별자 절제`와 동일한 방식의 미러를 뒀다(`rules/` 미연결 프로젝트 대비).

- GoldLink 연결 가이드·공통 훅 보강 배포 버전 v2.0.2. (2026-07-30)
  - `rules/` 연결 프로젝트의 Claude subagent·Codex workflow/agent guide 경로 fallback과 `.env` 변형 보호, 파괴 명령의 비실행 텍스트 오탐 해소를 하나의 설치 배포 버전으로 묶었다.
  - `.claude/plugins/VERSION`과 manifest를 `2.0.2`로 맞췄다. symlink 연결 프로젝트는 즉시 반영되고 복사 설치 프로젝트는 `install.sh --update`에서 새 버전을 인식한다.

- `mlm_v1.0` 가이드 연결 완결 + `block-secret-files.sh` `.env` 변형 커버·오탐 2종 해소. (2026-07-30)
  - **발단**: `mlm_v1.0` 에이전트 가이드 연결 점검 요청. 심링크 6종(`rules`·`.codex`·`.claude/*` 5)은 전부 정상이었으나 **L1 문서 체인과 L3 훅 두 곳이 끊겨 있었다**. 어제(2026-07-29) 조치는 심링크 배선까지였고, 훅 `settings` 미등록은 "활성화는 별도 판단 사항"으로 남긴 상태였다(본 파일 `## 지난 세션 기록` 참조).
  - **mlm 쪽 수리 3건**: ① `.claude/settings.json` 신규 — 가드레일 3종을 root 탐색 래퍼로 등록(Bash 3·Write 1·Edit 1). ② `CLAUDE.md`에 `## 🔗 공통 규칙 연결` 신설 — 8단계 읽기 순서(`rules/CLAUDE.md`·`rules/AGENTS.md`·`rules/agents/*`)와 배선 구조·정본 fallback 명시. 연결 14곳 중 유일하게 `rules/` 참조가 0건이던 문제를 해소(0 → 14건). ③ `AGENTS.md`에 `## Rule Precedence` 신설 — 적용 순서와 확정 충돌 3건(커밋 정책·6단계 파이프라인·디자인 정본)을 표로 고정. `.claude/`는 해당 저장소 `.gitignore` 대상이라 커밋 영향 없음, 문서 2건은 미커밋으로 두었다(해당 저장소는 사용자 지시 없이 커밋하지 않는 규칙).
  - **공통 훅 결함(실측으로 발견)**: `block-secret-files.sh`가 비밀 파일을 `.env`·`.env.*` 정확 일치로만 판정해 `backend.env`(mlm의 DB 접속·JWT 서명키 보관 파일) 쓰기가 **통과**했다. 판정을 `.env` 자체 + `*.env` 접두 변형 + `*.env.*` 접미 변형으로 확장했다. 예시 파일 예외(`.example`/`.sample`/...)는 기존 로직이 선행 처리하므로 무변경.
  - **확장이 만든 오탐 2종 동시 해소**: ① glob 토큰(`find -name "*.env"`)을 파일명으로 오인 → 토큰에 `*?[` 포함 시 판정 제외. ② heredoc 본문(`python3 - <<'PY' ... PY`)을 셸 명령으로 스캔해 스크립트 안의 `".env"` 문자열에 반응 → 본문을 걷어내고 명령줄만 검사. 더불어 `2>/dev/null` 리다이렉션만으로 쓰기성 판정되던 것도 제외했다. 셋 다 이번 세션에서 실제로 도구 실행이 막혀 드러난 건이다.
  - **검증**: 회귀 52/52 통과(파일명 34·Bash 명령 17·2MB payload 1). 기존 보호 13종(`.env`·`id_rsa`·`*.pem`·`service-account*.json` 등) 전부 유지, 기존 예외 11종 전부 통과. `mlm_v1.0` 루트에서 실제 배선 래퍼 경유 라이브 실측 7/7(`backend.env` 차단 · `backend.env.example` 통과 · 파괴적 명령 2종 차단 · 정상 명령 통과).
  - **영향 범위**: 연결 14곳 전수 스캔 결과 새로 보호 대상이 된 실재 파일은 `mlm_v1.0/backend.env` **1건**뿐 — 나머지 13곳은 무영향. 보호 범위는 넓어지기만 했다.
  - **후속으로 이어서 처리**: 아래 `block-destructive.sh` 항목에서 같은 계열 오탐을 해소했다.

- `block-destructive.sh` 인용문·heredoc 오탐 해소 + `rm` 탐지 위치 제약 제거. (2026-07-30)
  - **발단**: 위 작업 중 검증 명령이 3회 오차단됐다. 훅이 명령 문자열 전체를 grep해서 **실행되지 않는 텍스트**(heredoc으로 넘기는 스크립트 본문, 인용부호 안 데이터, 문서 검색 패턴)에도 반응했다. 이전 세션에서 후속 과제로 기록만 해 둔 항목이다.
  - **수정 ① 데이터 문맥 제거**: 패턴 검사 전에 heredoc 본문과 인용부호 안 문자열을 걷어낸다. 단 **인용문이 곧 코드가 되는 경우**(`bash -c '...'`, `eval`, `xargs`, `ssh`)와 셸에 그대로 먹이는 heredoc(`bash <<'EOF'`)은 원문을 유지해 우회를 막는다. 셸 판정은 "셸이 실제 명령 위치에 오고 `-c` 계열 플래그가 붙은 경우"로 좁혀 `bash -n script.sh`나 `deploy.sh` 같은 **파일명에는 반응하지 않는다**(1차 구현이 너무 넓어 실측에서 걸러낸 케이스).
  - **수정 ② `rm` 탐지 확대**: 기존 규칙은 `rm`이 줄 시작이거나 `;`·`&&`·`||` 뒤에 있을 때만 봤다. `find ... -exec rm -rf {}`와 `sh -c "rm -rf /"`가 **통과하던 실제 공백**이다. 데이터 문맥이 제거된 덕에 위치 제약 없이 검사해도 안전해져 제거했고, `docker run --rm`처럼 `-`가 앞에 붙은 플래그만 제외한다. 차단 규칙 자체(`-r`+`-f` 동시 요구)는 무변경.
  - **검증**: 회귀 33/33. 실제 파괴 명령 12종 전부 차단 유지(플래그 분리형·체인 뒤·인용된 경로 인자·셸 래퍼 경유·셸 heredoc 포함), 텍스트 오탐 6종 통과, 기존 통과 6종 유지, 신규 탐지 1종(`-exec rm -rf`) 차단, `--rm` 오탐 방지 2종 통과, 2MB payload 통과. `block-secret-files.sh` 교차 회귀 52/52 무영향.
  - **라이브 실측**: 직전에 오차단됐던 것과 **동일한 명령**이 통과함을 이 세션에서 확인했고, 존재하지 않는 경로를 대상으로 한 안전 프로브(`rm -rf /tmp/.../nonexistent-probe-*`)는 실행 전 `exit 2` 차단됨을 확인했다. `mlm_v1.0` 배선 래퍼 경유 7/7 유지.
  - **남은 한계**: 주석(`# ...`) 안의 텍스트는 여전히 검사 대상이다. `#`이 URL·포맷 지정자 등에도 쓰여 일괄 제거가 위험해 보류했다.

- Codex 연결 프로젝트의 `rules/` 경로 fallback 완성 + 플러그인 v2.0.1. (2026-07-30)
  - **발단**: `goldlink` 적용 점검에서 Claude skills·commands·subagents는 프로젝트에 없는 `templates/`·`agents/`·`docs/`를 `rules/` 아래에서 찾지만, Codex workflows 10종·agent guides 6종은 프로젝트 루트 경로만 지시해 기준 문서를 놓칠 수 있음을 확인했다. 직전 기록에서 범위 밖으로 남긴 결함을 이번에 해소했다.
  - **변경**: 루트 경로 규칙 대상을 `skill·command·workflow·agent guide`로 확장하고 `designs/`도 포함했다. `.codex/README.md`·`docs/codex-guide.md`에 공통 해석 규칙을 추가했으며, workflow 10종과 agent guide 6종 각각에 프로젝트 우선 → `rules/` fallback → 공통본 사용 보고 규칙을 넣어 단독 로드 시에도 동작하게 했다. 디자인 문서는 프로젝트가 별도 정본이나 코드 토큰 정본을 지정한 경우 이를 우선하도록 명시했다.
  - **버전·정합**: `.claude/plugins/VERSION`과 manifest를 `2.0.1`로 올리고 `docs/plugin-guide.md`의 낡은 commands 9종 표기를 실제 10종으로 정정했다.
  - **연결 프로젝트 영향**: `.codex -> rules/.codex` 또는 `rules/` symlink를 쓰는 프로젝트에 즉시 반영된다. 프로젝트 로컬 파일이 있으면 종전대로 그쪽이 우선이다.

- 서브에이전트 정의 5종에 `rules/` 경로 fallback 문구 추가 — L2(skills·commands)에만 있던 규칙을 L4까지 확장. (2026-07-29)
  - **발단**: `signal2` 연결 점검에서 발견. 커밋 `8fbd515`가 링크 방식 프로젝트를 위해 fallback을 넣었지만 **`.claude/skills`·`.claude/commands` 20종에만 적용**됐고, `.claude/agents` 6종에는 `rules/` 언급이 0건이었다. 서브에이전트는 "상세 규칙은 `agents/reviewer-agent.md`를 따른다"처럼 프로젝트 루트 경로를 지시하는데, 링크 방식 프로젝트에는 `agents/`·`designs/`·`templates/`가 없어 **기준 문서를 못 찾은 채 작업**하게 된다.
  - **변경**: `code-reviewer`·`explorer`·`feature-dev`·`planner`에 skills와 동일한 경로 규칙 1줄을 추가했다. `design-reviewer`는 참조 경로가 5종(`DESIGN.md`·`docs/`·`designs/`·`agents/`·`templates/`)이라 별도 문구를 쓰고, `rules/DESIGN.md`가 템플릿 활성 시안이라는 점과 **프로젝트가 토큰 값의 정본을 코드로 지정한 경우 문서 카탈로그 대신 그 코드를 기준으로 검출**한다는 조건을 명시했다.
  - **제외**: `test-runner`는 참조하는 프로젝트 문서가 없어 대상이 아니다. Codex 레이어(`.codex/agents` 6종, `.codex/workflows` 9종)도 같은 결함이 있으나 이번 범위 밖으로 남겼다.
  - **검증**: 5종 모두 `rules/` 언급 1건 반영 확인 · frontmatter `name`/`description` 무손상(자동 등록 조건) 확인.
  - **연결 프로젝트 영향**: `.claude/agents`가 심링크라 14개 프로젝트에 즉시 전파된다. 프로젝트 루트에 파일이 있으면 종전대로 그쪽이 우선이므로 기존 동작은 바뀌지 않는다.

- `/design` slash command 신설 — skills 10종 대비 commands 9종이던 비대칭 해소. (2026-07-29)
  - **발단**: `riderwebapp` 연결 점검에서 발견. `design`은 skill(자동 활성화)과 Codex workflow(`.codex/workflows/design.md`)는 있는데 **명시 호출용 slash command만 없었다** — 사용자가 `/design`을 칠 수 없었다.
  - **신설**: `.claude/commands/design.md`. 다른 command와 동일하게 `description`·`argument-hint` frontmatter를 두고, `DESIGN.md` 로드 → 토큰 호출 형식 → Do/Don't 확인 절차를 기술했다. **세부 진행 규칙(gradient 허용 위치·비-4의 배수 금지·이모지 금지·모달 닫기)은 중복 정의하지 않고 `.claude/skills/design/SKILL.md ## 진행 규칙`을 정본으로 참조**한다.
  - **카운트 정합**: `CLAUDE.md` Repo Map, `AGENTS.md` Context Map, `README.md` Slash Commands 목록의 "9종" → "10종" + `/design` 등재. `manifest.json` `L2_commands`에도 추가.
  - **검증**: manifest JSON 파싱 OK · `L2_commands` 10종 = `.claude/commands/*.md` 실제 파일 10개 일치 · 저장소 전체 "slash command 9종" 잔여 0.
  - **연결 프로젝트 영향**: `.claude/commands`가 심링크라 13개 프로젝트에 즉시 전파된다. 각 프로젝트는 Claude Code 재시작 시 `/design`을 인식한다.
  - **함께 해소(이전 세션 후속 과제)**: "`riderwebapp/AGENTS.md`에 공용 머지 정책을 과거 기준으로 설명한 문장이 남아 있다"는 지적을 프로젝트 쪽에서 정리했다. 공용 규칙도 현재 "머지는 사용자 명시 지시 시 수행"이라 프로젝트 규칙이 **덮어쓰기가 아니라 정합**임을 명시하고, 저장소 한정 추가분(agent 작성 PR도 대상 포함)만 남겼다.

- 보류 항목 순차 정리 + 저장소명 정책 확인 + `intake.html` 12종 폼 확장. (2026-07-29)
  - **저장소명(사용자 질의)**: "PC마다 폴더명이 `claude-agent-template`/`claude-agent-templete`로 다른데 둘 다 못 쓰냐" → **둘 다 정상 동작**함을 실측 확인. hook은 폴더명을 하드코딩하지 않고 실행 시점 git 루트/상위 `.claude` 탐색으로 스크립트를 찾으며, 정본 식별자는 `manifest.json`의 `name`(`claude-agent-template`) 하나다. `docs/plugin-guide.md`에 "PC마다 다른 이름을 써도 된다"가 이미 명시돼 있었다. 즉 "표기 통일"은 폴더명 강제가 아니라 문서 지칭 표기 정리일 뿐. `todo.md` 아카이브(문서 자기일관성 TODO)에 "정본을 `templete`로 결정"이라 거꾸로 남은 오기록에 정정 메모를 덧붙였다(원문은 이력이라 보존).
  - **README**: 브라우저 UI "추가 폼(현재는 5종)" 노후 표현을 "HTML UI(현재 6종)"로 수정하고, 1차 소스 규칙에 HTML 수정 후 `node scripts/check-html.mjs` 실행 안내를 추가. 나머지(skills 10·commands 9·codex 10·HTML 6·intake 12·startup 11섹션)는 실측 대조 결과 이미 최신이었다.
  - **HTML 검증 스크립트 신규**: `scripts/check-html.mjs`(신규 `scripts/` 디렉터리). `docs/*.html`의 인라인 `<script>`만 추출해 `vm.Script`로 컴파일(구문)만 검사한다. 실행 부작용 없음, Node 내장 모듈만 사용. 배경은 Node 22에서 `node --check docs/*.html`이 확장자 때문에 즉시 실패하는 문제. 검증: 정상 6개 통과(인라인 5)·고의 손상 시 exit 1 검출.
  - **framework-structure-guide.md**: §4에 feature-first hybrid 예시 디렉터리 트리 + 승격 규칙(3회 반복 시 공용화)·경계 규칙(기능 간 `index.ts` 공개 표면만 import) 추가.
  - **intake.html 12종 폼 확장(항목 9, 사용자 승인)**: 요청 템플릿 5종과 별개로 "Intake 템플릿" 사이드바 그룹을 신설하고 `INTAKE` 객체(project/ui/responsive/tech/i18n/format/api/error/form/qa/routing/framework-structure)를 추가. 렌더링 4곳 수정(nav 컨테이너·`getForm`·`renderSidebar` 헬퍼화·초기 hash 해석). 서브에이전트가 12개 템플릿을 폼 스키마로 변환, 본 에이전트가 검토 후 삽입. 검증: HTML 구문 통과 + 폼 12·필드 129·폼 내 id 중복 0·type/choices 이상 0.
  - **todo.md**: 헤더 날짜 `2026-05-30` → `2026-07-29 기준`.
  - **후속(낮은 우선순위 보류, 사용자 판단)**: `docs/template-usage.md` 신설, codex/AGENTS 읽기순서 중복 축소, md→HTML 자동 동기화 — 현재 불필요로 보고 보류 유지.
  - **훅 미배선 5곳 과제 제거(사용자 지시)**: 연결 프로젝트 5곳(`aica2`·`riderapp-runtime`·`skim`·`trippass`·`vwallet`)의 `settings` 미등록 과제는 각 프로젝트 진행 시 처리하기로 하여 `## 다음 작업`·후속 과제에서 제거.

- L4 서브에이전트 6종 자동 등록 정상화 — frontmatter 부재로 인한 미등록 해소. (2026-07-29)
  - **발단**: `aiospace` 세션에서 서브에이전트 6종이 사용 가능 목록에 하나도 뜨지 않는다는 보고로 착수했다. 사전 분석은 "템플릿이 각 프로젝트에 전파를 못 하고 있다"로 요약돼 있었으나, 실측 결과 **전파 경로는 정상**이었고 문제는 파일 형식이었다.
  - **구조 확인**: 연결 프로젝트의 `.claude/agents`는 복사본이 아니라 `../rules/.claude/agents`를 가리키는 **심링크 디렉터리**다(`skills`·`commands`·`hooks`·`plugins`도 동일). 13개 프로젝트가 이 저장소 원본을 실시간으로 공유한다. inode 동일·git 추적 대상임을 확인했다.
  - **근본 문제**: 6개 파일 전부 YAML frontmatter 없이 `# 제목`으로 시작했다. Claude Code는 `.claude/agents/*.md`의 `name`·`description` frontmatter로 에이전트를 등록하므로, 파일이 정상 공유돼도 **등록 자체가 되지 않았다**. 템플릿 저장소 자체 세션에서도 6종이 뜨지 않아 심링크와 무관한 형식 문제임을 특정했다.
  - **수정**: 6개 파일 최상단에 `name`·`description`·`tools` frontmatter를 추가했다. `tools` 값은 각 파일의 기존 `## 도구 제한` 서술과 일치시켰다(읽기 전용 5종은 `Read, Glob, Grep, Bash`, `feature-dev`만 `Write, Edit` 포함). 본문은 무변경.
  - **검증**: frontmatter YAML 파싱 6/6 통과. headless 세션 실측으로 템플릿 저장소와 심링크 경유 프로젝트(`aiospace`) 양쪽에서 `code-reviewer`·`design-reviewer`·`explorer`·`feature-dev`·`planner`·`test-runner` 6종 전부 등록 확인 — **Claude Code가 심링크 디렉터리를 따라간다는 점도 함께 실증**됐다.
  - **후속 정리 ①(문서 서술)**: 자동 등록 이전 전제로 쓰인 서술 14곳을 정리했다. 각 에이전트 파일의 `## Agent 타입`(6곳)은 `subagent_type` 지정 방식으로, 호출 항목 리드 문장(6곳)은 템플릿 복사 전제를 뺀 표현으로 바꿨다. `CLAUDE.md`(서브 에이전트 정의 섹션·Repo Map), `AGENTS.md` Context Map, `docs/subagent-guide.md`(디스패치 기준 6항목 포함), `docs/claude-guide.md`, `docs/plugin-guide.md`도 함께 맞췄다. `STATE.md`·`todo.md`의 과거 기록은 이력이므로 유지한다.
  - **후속 정리 ②(연결 보완)**: `mlm_v1.0`은 `rules` 심링크는 있었으나 `.claude/` 내부 레이어 배선이 하나도 없었다(직전 보고의 "심링크 자체가 없다"는 오류였다). 사용자 승인으로 `agents`·`skills`·`commands`·`hooks`·`plugins` 5종 심링크를 걸어 다른 12곳과 동일 구성으로 맞췄다. headless 실측으로 서브에이전트 6종 등록을 확인했다. `hooks`는 심링크만 걸고 `settings.local.json` 등록은 하지 않아 아직 미작동이다 — 활성화는 별도 판단 사항이다. `.claude/`가 해당 저장소 `.gitignore` 대상이라 커밋 영향은 없다.

- L3 가드레일 훅 4종 정상화 — 입력 규약 교체와 후속 결함 3건 해소. (2026-07-28, 커밋 `085a2ab`·`21e62e9`·`35d91ef`)
  - **발단**: `signal2` 세션의 가이드 상태 점검에서 훅 미작동이 드러나 사용자 승인(`1,2번 업데이트 진행해`)으로 착수했다. 훅 파일은 13개 연결 프로젝트가 symlink로 공유하므로 어느 프로젝트에서 고쳐도 이 저장소 원본이 바뀐다.
  - **근본 문제**: 훅 4종 전부가 도구 입력을 `$CLAUDE_TOOL_INPUT` 환경변수에서 읽었다. 현행 CLI에 그 변수는 없고 stdin JSON(`tool_input` 중첩)이 전달된다. 즉 `settings`에 배선해도 **빈 입력으로 항상 통과** — 켜진 것처럼 보이면서 아무것도 막지 못했다. 구/신 비교 실행으로 실증(구버전 차단 0/5, 신버전 5/5).
  - **수정 1(입력 규약)**: stdin JSON을 1차로 읽고 `tool_input` 중첩을 우선 파싱한다. 구 규약(평면 JSON·환경변수)은 폴백으로 유지. 차단 메시지는 `exit 2`와 짝을 이루는 **stderr**로 옮겼다.
  - **수정 2(대용량)**: payload를 argv로 넘기면 `MAX_ARG_STRLEN`(128KB)에 걸려 512KB 이상 Write에서 훅이 `exit 126`으로 깨지고 검사가 무력화됐다. 파이썬 스크립트를 `python3 /dev/fd/3 3<<'PY'`로 fd 3에 주고 **stdin을 payload 전용으로 남겨** 크기 제한을 없앴다(4MB 확인). heredoc 가독성은 유지된다.
  - **수정 3(예시 파일 오탐)**: `.env.` 접두를 전부 비밀로 판정해 `.env.example`·`.env.sample`·`.env.template`까지 막아 프로젝트 부트스트랩이 깨졌다. 마지막 확장자가 `example`/`sample`/`template`/`dist`/`defaults`면 통과시킨다(`.env.local.example`·`config.key.sample` 포함). `.env`·`.env.local`·`.pem`·`.key`·`credentials.json` 차단은 유지.
  - **수정 4(구두점)**: 명령 문자열에서 뽑은 토큰에 구두점이 붙으면(`.env.example,` / `(.env.local)`) 예외·차단 판정이 모두 빗나갔다. 실제로 이 세션의 커밋 메시지가 오차단됐다. 파일명 판정 시 앞뒤 구두점을 벗기되 선행 `.`은 보존한다.
  - **수정 5(인젝션)**: `warn-design-tokens.sh`는 payload를 `json.loads('''$INPUT''')`로 **파이썬 소스에 문자열 삽입**했다. 파일 본문에 삼중따옴표가 있으면 문자열이 조기 종료되고 이어지는 텍스트가 표현식으로 평가된다 — **디자인 파일을 쓸 때마다 그 내용이 코드로 실행될 수 있었다.** `/tmp` 마커 생성으로 실행을 실증(구버전 실행됨·신버전 무해)했고 마커는 정리했다. 기본 미등록 opt-in이었던 점이 노출을 막았다. 나머지 3종과 같은 구조로 교체하고 MultiEdit `edits[].new_string`을 검사 대상에 포함했다(`docs/design-guidelines.md`의 활성화 안내와 동작 불일치 해소).
  - **검증**: 회귀 스위트 47/47(차단 5·통과 5·입력형식 4·대용량 5·파일명 15·리다이렉션 3·리마인더 3·구두점 7) + 디자인 훅 14/14(규약 4·제외 3·비차단 3·인젝션 1·대용량 2·MultiEdit 1). 실제 배선 래퍼(`bash -lc` + root 탐색)로 2MB payload 통과·파괴적 명령 `exit 2`·`.env.example` 생성 성공을 라이브 확인. 차단 규칙 자체는 무변경이라 보호 범위 축소 없음.
  - **정책 유지**: `warn-design-tokens.sh`의 기본 미등록은 그대로다. 정적 검출의 오탐 우려가 해소된 것은 아니므로 필요한 프로젝트만 명시 등록한다.
  - **후속 과제**: `block-destructive.sh`의 텍스트 기반 패턴 검사는 실행되지 않는 인용문(heredoc 본문·문서 인용)에도 반응한다. (연결 프로젝트 5곳의 `settings` 미배선 과제는 각 프로젝트 진행 시 처리하기로 하여 제거함 — 2026-07-29)

- 커밋·푸시 상태 점검 및 원격 동기화. (2026-07-28, 커밋 `6662068`)
  - 점검 시작 기준 워킹트리 클린·스테이징 없음·stash 없음. 미푸시 커밋을 사용자 요청으로 원격 반영했다.
  - 종료 점검: 열린 PR 없음, 로컬 브랜치 `main` 단일, `.github/workflows` 없음(원격 자동 CI 미보유 → `[skip ci]` 불필요).

- 슬래시 커맨드 메타데이터 + 연결 프로젝트 경로 해석 정상화. (2026-07-29)
  - **발단**: 슬래시 커맨드 설명과 디자인 정본 경로가 연결 프로젝트에서 실제로 해석되는지 점검 요청. 대상은 `rules/` symlink로 이 저장소를 참조하는 14개 프로젝트다.
  - **문제 1(경로 해석)**: skill·command 본문이 `templates/`·`agents/`·`docs/`를 **프로젝트 루트 기준 상대경로**로 지시하는데, symlink로 연결되는 것은 `.claude/*`뿐이라 그 디렉터리들이 프로젝트에 없다. `templates/` 보유는 14곳 중 `makeupshop` 1곳, `docs/local-dev-ci-guide.md` 보유는 `riderwebapp` 1곳뿐이었다. `dev-start`만 유일하게 `rules/` fallback을 명시하고 있었고 나머지는 없었다.
  - **문제 2(커맨드 메타)**: `.claude/commands/*.md` 9종 전부 frontmatter가 없어 `description`·`argument-hint`가 미정의였다. 등록·실행은 되지만 커맨드 목록에 본문 제목이 그대로 노출되고 인수 힌트가 뜨지 않았다.
  - **문제 3(디자인 정본)**: `design` skill이 `DESIGN.md`만 지시하는데 루트에 파일이 있는 곳은 6/14였다. `select-design.sh`는 `designs/`가 없는 프로젝트(13곳)에서 에러 종료해 시안 스위치가 불가능했다.
  - **수정**: ① command 9종에 `description`·`argument-hint` frontmatter 추가. ② command 9종 + skill 10종 본문에 `rules/` fallback 경로 규칙 블록 삽입, `design` skill은 실행 1·2단계에도 인라인 명시(공통본을 읽었으면 답변에 밝히도록). ③ `select-design.sh`의 라이브러리 소스와 산출물 경로를 분리 — 소스는 `프로젝트 designs/ > rules/designs/ > 스크립트 위치 추론`, 산출물(`DESIGN.md`·`.claude/.active-design`)은 항상 프로젝트 루트로 고정해 공통 템플릿 오염을 차단. ④ 원칙을 `AGENTS.md` 관리 블록(`project-guide-routing`)·`CLAUDE.md ## Design System`·`docs/design-guidelines.md`에 명문화. 관리 블록에 넣었으므로 이후 `install.py --update`로 각 프로젝트 `AGENTS.md`에 전파된다.
  - **검증**: frontmatter YAML 파싱 19/19 통과, 경로 규칙 삽입 19/19 확인. `select-design.sh`는 자체 `designs/` 보유 프로젝트(`makeupshop`)·미보유 프로젝트(`goldlink`)·템플릿 자체 3케이스 정상, 임시 fake 프로젝트에서 시안 활성화 E2E 실행해 소스=`rules/designs/`, 산출물=프로젝트 루트임을 확인했다. `bash -n` 문법 검사 통과.
  - **후속(프로젝트 쪽, 사용자 판단 필요)**: `aiospace`는 `.active-design=worknest` 마커만 있고 루트 `DESIGN.md`가 없다(AGENTS.md가 `rules/DESIGN.md`를 정본으로 지정 — 템플릿 활성 시안이 바뀌면 정본이 조용히 따라 바뀐다). `makeupshop`은 진입 문서가 `MAISON LUMÈ 브랜드 시스템`이라고 적었으나 실제 `DESIGN.md`는 `wanted` 시안이다. `design` skill은 있으나 대응 slash command는 없다(`commands` 9종 / `skills` 10종).

- 금액·수량 처리 기준 신규 정본 추가 — `docs/money-quantity-guidelines.md`. (2026-07-29)
  - **발단**: 금액·수량 표기 정책 존재 여부 질의 → 표시 규칙(`DESIGN.md`의 `tabular-nums`+천 단위, `i18n-guidelines.md`의 locale formatter, data-table 우측 정렬, `format-intake.md` 수집 양식)은 있으나 **계산·확정·저장 규칙이 전무**함을 확인했다. 비즈니스 로직 플레이북에도 "금액을 일관되게 처리한다" 한 줄뿐이었다.
  - **사용자 제안 검증**: "중간 계산에서는 라운딩하지 않고 표기만 절삭하면 합계-항목 1원 불일치가 없어지지 않겠는가"를 시뮬레이션으로 검증했다. **절반은 성립**(중간 절삭 시 단가 3,333.33×1,000개에서 330원 오차 누적 — 정밀도 유지가 맞다). **핵심 목표는 미달성**: 금액이 서로 다른 항목에서는 표시만 절삭해도 불일치가 남고, 무작위 100세트 전부 불일치(최대 21원)했다. 총액을 정확히 표시하면 항목합과 어긋나고, 항목합을 총액으로 쓰면 실제보다 적게 청구된다 — 표시 계층만으로는 화면 정합성과 금액 정확성 중 하나가 반드시 깨진다. 추가로 절삭 표기는 한 방향 편향(1,000건에 495원 vs 반올림 5원)이고, 실수 타입은 라운딩 없이도 부정확(0.1×10회=0.9999999999999999)함을 확인했다.
  - **채택 기준**: 정수화를 **확정 시점 한 곳**으로 옮기고 잔차 배분(largest remainder)을 적용하는 4계층 모델. 계산=정밀도 유지, 확정=최소 단위 정수화+잔차 배분, 표시=포맷만, 저장=십진/최소 단위 정수. 부가세 분리는 한쪽을 내림 확정 후 나머지를 총액에서 빼는 방식(각각 절삭 시 9,999원, 잔차 배분 시 10,000원).
  - **연결**: `AGENTS.md` Context Map, `CLAUDE.md` Repo Map, 실행·리뷰 에이전트 체크리스트 각 2항목, `templates/format-intake.md`(금액 계산·저장 / 수량 처리 절 + 작성 예시), `templates/startup-checklist.md` 섹션 8(Q4·Q5), `docs/business-logic-playbook.md`, `manifest.json` docs 목록.
  - **검증**: 문서에 기재한 잔차 배분 의사코드를 그대로 구현해 무작위 2,000세트 실행 — 합계 불일치 0건, 잔차는 항상 항목 수 미만, 배분값이 원값의 내림/내림+1 범위를 벗어나지 않음, 동일 입력 50회 결정론 통과. `manifest.json` JSON 파싱 정상, 상호 참조 7곳 확인.

## 지난 세션 기록

- 연결 프로젝트 최신 정책 전파 상태 점검 및 세션 종료. (2026-07-26)
  - 연결된 13개 프로젝트가 모두 `rules -> claude-agent-template` 링크로 공통 정본을 공유하며, 최신 머지 정책 가이드와 Codex 종료 체크리스트가 실제 경로에서 현재 버전과 일치함을 확인했다.
  - 복사 설치 상태 파일을 사용하는 프로젝트는 없어 이번 변경에는 별도 `--update` 실행이 필요하지 않다.
  - 후속 보완 사항: `riderapp-runtime`에는 Codex 자동 진입점인 루트 `AGENTS.md`가 없고, `riderwebapp/AGENTS.md`에는 공용 머지 정책을 과거 기준으로 설명한 문장이 남아 있어 각 프로젝트에서 정리해야 한다.

- Codex 최종 응답 체크리스트의 사용자 관점 명료성 기준 보강. (2026-07-26)
  - 최종 응답은 쉬운 결론을 먼저 제시하고, 일반 보고·비교·조사에서는 파일명·함수명·테이블명 같은 내부 식별자를 불필요하게 노출하지 않도록 확인 항목을 추가했다.

- 사용자 명시 요청 기반 PR 머지·브랜치 정리 정책 추가. (2026-07-26)
  - 대상 PR/base가 확정되고 open·비초안, 충돌 없음, 필수 검사 또는 프로젝트 로컬 검증 통과 조건을 충족하면 Claude와 Codex 모두 PR 머지를 수행할 수 있도록 공통 가이드와 workflow를 갱신했다.
  - 자발적 머지와 branch protection·필수 review/check 우회는 금지하고, 머지 후 원격 base 반영을 검증한 뒤에만 브랜치를 정리하도록 했다.
  - 배포·릴리스 workflow 실행과 `develop`/`production` migration은 계속 사용자 수동 영역으로 유지했다.

- 설치기 v2 모드·소유권·해시 기반 안전 업데이트 추가. (2026-07-26)
  - 기존 프로젝트 최초 연결과 후속 업데이트를 분리하기 위해 `--new`, `--adopt`, `--update` 명시 모드를 도입했다. 모드 생략 시 파일을 쓰지 않고 대상 상태에 맞는 명령만 안내한다.
  - manifest `install_policy`에 `merge-block`, `project-owned`, `seed-only`, `managed`, `customizable` 분류를 추가하고 설치기가 이를 단일 정본으로 사용한다.
  - `.claude/.template-install-state.json`에 파일별 템플릿/설치 해시와 상태를 기록한다. update는 이전 설치 해시와 같은 파일만 자동 갱신하고 로컬 수정 파일은 보존한 채 충돌로 보고한다.
  - `AGENTS.md`·`CLAUDE.md` 관리 마커는 모든 쓰기 전에 `0/0` 또는 `1/1`인지 검사한다. 손상·중복이면 중단하며, 정상 블록만 병합한다.
  - `.claude/settings.local.json`, 프로젝트 가이드, 상태, 디자인은 자동 덮어쓰지 않는다. `--force`는 `--update` 호환 alias로 유지하고 전체 프로젝트 파일 강제 교체 옵션은 폐기했다.
  - 템플릿과 로컬이 함께 바뀐 충돌 파일은 수동 검토·병합 후 반복 가능한 `--accept-local <경로>`로 새 로컬 기준선을 승인할 수 있다.
  - 설치 로직을 Python `install.py`로 분리하고 `install.sh`는 portable 실행 래퍼로 축소했다. plugin/manifest version을 `2.0.0`으로 올렸다.

- 프로젝트 로컬 가이드 우선 적용 및 안전 업데이트 구조 추가. (2026-07-26)
  - 표준 프로젝트 가이드 정본을 `docs/project-guide.md`로 확정하고, 모든 작업에서 해당 문서·하위 `AGENTS.md`·관련 로컬 문서를 템플릿 기본값보다 먼저 적용하도록 루트 규칙과 총괄 역할에 명시했다.
  - 우선순위는 상위 런타임 규칙과 사용자 최신 요청을 먼저 따르고, 그 범위 안에서 프로젝트 로컬 기준과 더 구체적인 하위 문서를 우선하도록 정리했다. 충돌 시 적용 기준을 작업 보고에 남긴다.
  - Claude skill·command·subagent와 Codex workflow·agent는 규칙을 복제하지 않고 루트 선행 규칙을 공통으로 적용하도록 런타임 가이드, 읽기 순서, 안전·종료 체크리스트를 연결했다.
  - 설치기의 `--force`는 공용 어댑터만 갱신하고 `AGENTS.md`, `CLAUDE.md`, `STATE.md`, `DESIGN.md`, `docs/project-guide.md`는 보호하도록 변경했다. 프로젝트 소유 파일 교체는 백업 후 `--force-project-files`를 명시해야 한다.
  - 기존 프로젝트에도 필수 로딩 규칙이 전달되도록 `--force` 실행 시 `AGENTS.md`와 `CLAUDE.md`의 `agent-template:project-guide-routing` 관리 블록만 삽입·갱신하고 나머지 프로젝트 내용은 보존하는 안전 병합을 추가했다.
  - 일부 파일이 건너뛴 일반 설치에는 최신 버전 스탬프를 기록하지 않도록 수정하고 plugin/manifest version을 `1.2.0`으로 올렸다.

- Codex 공통 응답 정책 필수 로딩 경로 보강. (2026-07-26)
  - 점검 결과 Claude Code는 루트 `CLAUDE.md`를 통해 단계별 응답 정책을 직접 적용하지만, Codex 기본 읽기 순서에는 해당 정본이 없어 간접 참조에 의존하는 문제가 확인됐다.
  - Codex가 자동 로드하는 `AGENTS.md`에 모든 런타임의 `CLAUDE.md ## 커뮤니케이션`, `## 답변 포맷` 필수 로딩 규칙을 추가하고 공통 시작 순서에 반영했다.
  - `.codex/README.md`, `docs/codex-reading-order.md`, `docs/agent-runtime-matrix.md`의 진입 순서와 공통 정본 정의를 같은 기준으로 맞췄다. Claude 전용 자동화는 Codex 기능으로 간주하지 않고 공통 응답 섹션만 공유한다.
  - 설치본에서 변경 버전을 식별할 수 있도록 plugin version과 manifest version을 `1.1.1`로 함께 올렸다.

- 단계별 응답 및 최종 통합 정책 추가. (2026-07-26)
  - 긴 분석·리포트·계획·결과 정리는 전체 구성을 먼저 안내한 뒤 한 번에 한 단계 또는 핵심 항목을 가급적 30행 이내로 제공하도록 `CLAUDE.md ## 답변 포맷`에 정본 규칙을 추가했다.
  - 단계별 질문·답변·수정·결정을 구분해 유지하고, `"다음 단계"`에서는 마지막 확인 내용을 이어받으며, 전체 검토·최종 정리에서는 최초 초안보다 후속 결정을 우선해 충돌을 해소하도록 명시했다.
  - 짧은 답변과 사용자가 처음부터 전체 결과를 요청한 경우는 불필요하게 분할하지 않는 예외를 두었다. 기존 표 강제 규칙은 비교·수치 확인에 유용한 경우로 범위를 좁혀 30행 권고와의 충돌을 해소했다.
  - 총괄 역할, Claude/Codex 실행 가이드, Codex 종료 체크리스트에 정본 참조와 검증 항목을 연결했다.

- Codex dev-start/review 어댑터와 비밀 파일 훅 보강. (2026-07-12)
  - 배경: riderwebapp 점검에서 Codex dev-start workflow가 공용 템플릿의 예전 고정 `docker compose up -d` 모델을 들고 있어, 프로젝트별 `docs/local-dev-ci-guide.md` 부트스트랩 절과 어긋날 수 있음이 확인됨. Claude `dev-start` skill은 이미 절 이름 기반 위임으로 중립화되어 있었고, Codex 어댑터만 뒤처진 상태였다.
  - 변경: `.codex/workflows/dev-start.md`를 섹션 번호/고정 명령 대신 `docs/local-dev-ci-guide.md`의 **개발 세션 부트스트랩** 절을 절 이름으로 찾아 따르도록 수정. `.codex/workflows/review.md`에는 프로젝트 `AGENTS.md`/가이드 override가 공용 reviewer 기준보다 우선임을 명시했다.
  - 훅 보강: `.claude/hooks/block-secret-files.sh`가 기존 Write/Edit `file_path`뿐 아니라 Bash `command`도 검사한다. `.env*`, credential/key 파일 대상 redirection, `tee`, `cp`, `mv`, `install`, `sed -i` 쓰기 패턴을 차단한다.
  - 검증: `bash -n .claude/hooks/block-secret-files.sh` 통과. 수동 프로브로 `echo SECRET > .env`, `file_path=/tmp/.env.local`, `printf x | tee .env.local`, `sed -i s/a/b/ credentials.json` 차단(exit 2) 확인. `sed -n 1,20p .env.example`, `echo ok > /tmp/not-secret.txt`는 통과(exit 0).

- WorkNest 시안 Primary 서체 교체 — `IBM Plex Sans KR` → `Pretendard Variable`. (2026-07-10)
  - 배경: aiospace 사용자가 "폰트가 깔끔하지 않고 약간 깨지듯 보인다"고 진단. 타이포 토큰 레이어를 먼저 도입해 크기·행간·자간을 정본에 맞췄으나(구조 문제 해소) 서체 인상은 그대로여서 "눈에 확 안 띈다"는 후속 요청. 서체 4종(IBM Plex Sans KR·Pretendard·Noto Sans KR·Gothic A1)을 같은 문구·같은 타입 램프로 렌더해 비교한 뒤 사용자가 Pretendard를 선택.
  - 변경 토큰: `--font-sans: "Pretendard Variable", system-ui, sans-serif`. `### 서체 선택`의 Primary 항목과 개요 문장(휴머니스트 산세리프 → 한글 UI 산세리프) 갱신. 굵기 표기 `300–700` → 가변 `45–920`(실사용 400–700). Mono(`IBM Plex Mono`)·색·간격·라운드 토큰은 무변경.
  - `DESIGN.md`와 정본 카탈로그 `designs/worknest.md` 동시 갱신(두 파일 동일 유지), frontmatter `last_updated` → `2026-07-10`.
  - 소비처 반영은 aiospace 저장소에서 수행: 자체 호스팅(`pretendard` 패키지의 동적 서브셋 92조각 + `unicode-range`)이라 화면에 쓰인 글자가 든 조각만 내려온다(실측 13조각). mock preview의 서체 전환 목록에도 Pretendard를 기본값으로 추가.
  - ⚠️ 사용자의 작업 범위는 aiospace로 한정돼 있으나, 이 건에 한해 정본 수정을 명시 승인받아 진행했다.

- 답변 포맷에 `내부 식별자 절제` 규칙 신설 — 설명·보고에서 소스/DB 명칭을 기본 생략. (2026-07-10)
  - 배경: 사용자가 "설명·리포트할 때 소스 및 DB 명칭을 웬만하면 사용하지 않고 쉽게 설명, 소스/DB 명은 요청할 때 알려주고 설명에 필요할 때만 언급"을 요청.
  - 규칙: `CLAUDE.md ## 답변 포맷` 아래 `### 내부 식별자 절제 (설명은 쉬운 말로)` 소절 추가. 기본은 생략하고 사용자 영향 중심으로 서술 · 언급 조건 3가지(직접 열거나 실행 / 동명이 둘 이상이라 지목 필요 / 재현·디버깅에 위치 필수) · 요청 시 즉시 정확히 제시 · 절제 대상 아님(커밋 해시·버전·테스트 카운트·실행 명령·서비스 URL·포트) · 예외(코드 리뷰·리팩터링·버그 원인 분석은 식별자가 설명의 본체).
  - 기존 `파일·심볼·명령은 inline code` 항목에 "언급할 때는"을 붙여 새 소절과의 충돌을 제거.
  - 전파 검증: `## 답변 포맷` 헤딩 보유 문서는 템플릿 하나뿐(로컬 사본 없음). 다만 템플릿 규칙은 프로젝트 읽기 순서에 `rules/CLAUDE.md`가 등재된 경우에만 로드됨 → 도달 11(`GoldFX` `aica2` `aiospace` `ccaa` `goldlink` `makeupshop` `riderwebapp` `signal2` `skim` `tokendtu` `trippass`), 미도달 12(`rules` symlink는 있으나 읽기 순서 미등재: `riderapp-runtime` `vwallet` / symlink 없음: `aeghash` `blockminer2` `bot-trading_v1.1` `dexchange` `hashdamlanding` `icp2p` `icwallet` `inventory-app` `mlm_v1.0` `tokengenerator`).
  - 빈틈 보강: 항상 로드되는 유저 전역 지침(`~/.claude/CLAUDE.md`, 이미 `## 답변 포맷`을 미러 중)에 동일 규칙을 반영하고, 정본이 템플릿임을 명시하는 안내문을 미러 상단에 추가. 규칙 본문 7줄 `diff` 일치 확인.
  - 후속: `riderapp-runtime`·`vwallet`의 읽기 순서에 `rules/CLAUDE.md` 등재(근본 해결). `riderapp-runtime`은 루트가 git repo가 아니라 커밋 대상이 아님.

- 세션 종료 점검 — 연결 프로젝트 Codex 런타임 연결 보강 및 선택 커밋 완료. (2026-07-02)
  - 배경: 사용자가 "Claude 가이드 및 에이전트 작동처럼 Codex도 각 프로젝트 연결되어 환경설정 및 제대로 구현되는지 리뷰 및 검토"를 요청. 점검 결과 템플릿 `.codex` 레이어 자체는 manifest/설치/가이드 정합성이 있으나, 여러 sibling 프로젝트 루트에 `.codex` 연결이 없어 Codex가 workflow/check를 바로 발견하기 어려운 상태였음.
  - 연결 보강: `GoldFX`, `aiospace`, `ccaa`, `goldlink`, `goldlink-wt-pointcharge-balance`, `makeupshop`, `riderapp-runtime`, `skim`, `tokendtu`, `trippass`, `vwallet`에 `.codex -> rules/.codex` symlink 추가. 기존 연결 확인: `aica2`, `signal2`, `riderwebapp`, `dexchange`.
  - 문서 보강: `GoldFX`, `aica2`, `aiospace`, `ccaa`, `goldlink`, `goldlink-wt-pointcharge-balance`, `makeupshop`, `signal2`, `skim`, `tokendtu`, `trippass`, `vwallet`의 `AGENTS.md`에 `Agent Runtime 연결` 섹션을 추가해 Codex가 `.codex/README.md`, safety checklist, workflow, finish checklist를 따르도록 명시.
  - 로컬 커밋 완료(분리 가능한 저장소만): `aica2` `63fd6e7`, `ccaa` `bde467e`, `makeupshop` `9247ba6`, `tokendtu` `b23a0f5`, `trippass` `7e8c22f`, `vwallet` `8e257c6` — 모두 `docs: connect codex runtime adapter`.
  - 커밋 보류/주의: `GoldFX`와 `riderapp-runtime`은 루트가 git repo가 아니라 symlink만 적용. `aiospace`와 `skim`은 기존 대량 미커밋 변경이 `AGENTS.md`와 섞여 있어 이번 Codex 블록만 안전하게 분리 커밋하지 않음. `goldlink`/`signal2`/`riderwebapp`/`dexchange`는 종료 점검 기준 추가 커밋 없음.
  - 검증: 모든 대상에서 `.codex/README.md`와 `.codex/checks/finish-checklist.md` 접근 확인, `AGENTS.md` Codex 연결 문구 확인, 관련 `AGENTS.md`/`.codex` 대상 `git diff --check` 통과. push/원격 작업은 사용자 명시 요청이 없어 수행하지 않음.

- 템플릿 전체 점검(업데이트 체크) — manifest 미등록 3건 + 카운트 노후 1건 수정. (2026-07-01)
  - 배경: 사용자 요청으로 5-Layer 전체 정합성 점검. JSON/shell/version/레이어 카운트/dangling/라이브 링크는 모두 정합 확인. 실질 이슈는 manifest 등록 누락 3건.
  - 결함: (1) `designs/worknest.md`가 `manifest.json designs.files`에 미등록 — 현재 활성 시안(`.active-design`=worknest·`DESIGN.md`=WorkNest)인데도 누락되어 `install.sh --design worknest` 시 시안 파일 미복사로 활성화 실패. (2) `docs/development-strategy.md`+`.html`가 `supporting.docs` 미등록(설치 대상에서 빠짐). (3) `docs/plugin-guide.md` "5개 시안" 표기 노후(실제 6종).
  - 수정: `manifest.json`에 worknest(designs.files)·development-strategy 2종(supporting.docs) 등록, `plugin-guide.md` 6개 시안으로 갱신.
  - 검증: `jq empty` 통과, 설치 대상 파일 미등록 0건(comm 대조), `designs.files` 9건(인프라 3+시안 6)·`supporting.docs` 25건 = 실제 `docs/` 25건 일치.
  - 미반영(정보성, 결함 아님): `manifest designs.default: wanted`는 신규 설치 권장 기본값이라 활성 worknest와 별개로 유지. STATE `## 다음 작업`·`todo.md`의 "시안 5종" 노후 문구와 `docs/index.html`·`docs/template-usage.md` 미래 후보 참조는 라이브 결함 아님(후속 정리 대상).

- 세션 종료 준비 — 템플릿 portable 경로 업데이트 후 커밋·push·브랜치/PR 상태 점검 완료. (2026-06-14)
  - 완료 커밋: `4633710`(`docs: make template paths portable across local folders`) — 로컬 폴더명/절대경로 의존 제거, `settings.template.json` 도입, 설치 시 `settings.local.json` 생성 흐름 반영.
  - 원격 반영: `git push origin main` 완료. 종료 점검 직전 기준 `main`과 `origin/main`은 `4633710`에서 동기화.
  - 브랜치 상태: 로컬 브랜치는 `main`만 확인, 별도 작업 브랜치 없음. `origin/main`도 동일 커밋.
  - PR 상태: 열린 PR 없음 확인. 머지할 PR이나 정리할 원격 작업 브랜치 없음.
  - 다음 점검: 기존 연결 프로젝트별 `.claude/settings*.json` portable hook 반영 여부는 각 해당 프로젝트에서 별도 진행한다.

- 템플릿 폴더명/경로 의존성 제거 방안 적용. (2026-06-14)
  - 결정: 로컬 폴더명은 정본으로 쓰지 않고, 고정 식별자는 `.claude/plugins/manifest.json`의 `name=claude-agent-template`로 둔다. 문서 예시는 `TEMPLATE_ROOT`/`TARGET_ROOT` 변수로 통일했다.
  - hook 설정: 전역 ignore 대상인 `.claude/settings.local.json` 대신 추적 가능한 `.claude/settings.template.json`을 추가하고, 설치 시 대상 프로젝트의 `.claude/settings.local.json`으로 생성하도록 `install.sh`를 보강했다.
  - 경로 안정성: hook 명령은 절대 경로 대신 실행 시점의 git 루트 또는 상위 `.claude/hooks` 탐색으로 스크립트를 찾는다. PC별 폴더명(`claude-agent-template`, `claude-agent-templete`, `rules` 등)이 달라도 동작하도록 정리했다.
  - 검증: `jq empty`(`settings.template.json`, `settings.local.json`, `manifest.json`), hook/install shell `bash -n`, manifest 등록 파일 누락 0건, 실제 설치 `/tmp/agent-template-install-check` 후 하위 `docs/`에서 `git reset --hard` 차단 hook `EXIT:2`, `install.sh --dry-run`의 `settings.template.json -> settings.local.json` 매핑 확인.

- 세션 종료 점검 — Codex parity 보강 및 audit 후속 정리 완료. (2026-06-13)
  - 템플릿 저장소 커밋 3개 누적: `17c3a8f`(Codex request workflow + agent guide parity), `86f2f36`(audit 후속 경로/문서 병기 정리), 본 세션 종료 기록 커밋 예정.
  - 검증: `manifest.json` JSON 검증, `install.sh --dry-run /tmp`, `git diff --check`, manifest 등록 파일 누락 0건 확인 완료.
  - 상태: 작업 전 기준 `main...origin/main [ahead 3]`, 워킹트리 변경은 본 종료 기록만. `.github/workflows` 없음(원격 자동 CI 워크플로 미확인).
  - 원격 push는 사용자 명시 요청 전까지 보류. 필요 시 사용자가 `git push origin main` 또는 별도 push 요청으로 진행.

- Codex parity 업데이트 — `rules/.codex` 소비 프로젝트가 Claude와 동등한 역할 라우팅/서브에이전트 절차를 수행하도록 루트 `.codex` 정본을 보강. (2026-06-13)
  - 신규 `.codex/workflows/request.md`: Claude `request` skill 대응. 모호하거나 복합적인 작업 요청을 feature/bugfix/refactor/review/business-logic/design/dev-start로 분류하는 절차 추가.
  - `.codex/README.md`, `docs/codex-guide.md`, `docs/agent-runtime-matrix.md`, `docs/codex-reading-order.md`: safety preflight, request 라우팅, dev-start/design/business-logic 읽기 순서, Claude/Codex 동등성 기준 반영.
  - `.codex/agents/*` 6종 보강: 공통 기준 문서, 입력 항목, 출력 형식, 도구 제한을 추가하고 Claude counterpart와 같은 책임을 Codex 도구·승인 모델로 수행하도록 명시. 특히 `design-reviewer`는 Claude A/B 상세 체크리스트를 동등 적용.
  - `.claude/plugins/manifest.json`, `README.md`, `AGENTS.md`, `CLAUDE.md`, `docs/plugin-guide.md`: Codex workflow 10종으로 카운트 및 설치 등록 정합.
  - audit 후속 보강: `.codex/workflows/request.md` 내부 경로를 `.codex/workflows/*`로 명확화하고, 디자인/서브에이전트 공통 문서에 Claude 자동화와 Codex 명시 절차를 병기.

- 신규 sibling 프로젝트 `../goldlink/` 풀 연결 셋업 + 제품 정의 + Phase 0 fork + 세션 종료 점검. (2026-06-12)
  - 셋업: `rules -> ../claude-agent-template` + `.claude/` 5종 symlink + hook 3종 `settings.json` + 진입 문서 3종 + git init(`13b1290`). 연결 프로젝트 10 → **11개**.
  - 제품 정의: **signal2 기반 + 채굴파워 게임 보너스 플랫폼**. `docs/prd-mining-power-game.md` v1.0(정책 D-1~D-10 + 브랜딩 전건 확정 — 방식 A 기본/하이브리드 추첨/소규모 진행/재화 조합/BSC 토큰 설정 등재/당첨 보너스율 가중/배치 시각 시세/수수료 미적용/취소 불가/제한 단위 설정형), `docs/development-plan.md`(Phase 0~7, 추정 11~12주).
  - Phase 0: signal2 main fork 반입(`e6bc4cf`, 1,503 files), 인프라 전환(명칭 goldlink·포트 5520~5523·DB명 goldlink, compose 검증 통과), GoldLink 브랜딩 전환(`2a99119`, 표시 문자열 261건·식별자 소문자 보존·signal2 잔여 0).
  - Phase 1 준비: `docs/phase1-data-model.md` 설계서(신규 모델 7종 + 기존 확장 3건) — §6 리뷰 포인트 4건 사용자 확인 대기. 루트 `.env` 작성(사용자) 후 Docker 기동·회귀 확인 예정.
  - 세션 종료 점검: goldlink 커밋 7개·working tree 클린·원격 미설정(백업 push 없음). 메모리 갱신(`project_goldlink.md` 신규, linked-projects 11개로). 템플릿 저장소 자체 변경 없음(본 기록만). 백업 push는 세션 권한 정책으로 보류 — 필요 시 사용자가 `git push origin main` 직접 실행.

- worknest 시안 반응형 정책 확정 + 모바일 컴포넌트 5종 등재 — `DESIGN.md` 변경 이력 기록. (2026-06-11, 커밋 `de0859e`)
  - `designs/worknest.md` + 활성 `DESIGN.md`: Responsive Behavior(브레이크포인트·PC 무회귀·셸 전환·card-row/시트 규칙·터치 기준) 확정, Components에 `bottom-sheet`/`mobile-nav`/`nav-drawer`/`fab`/`card-row` 5종 추가. aiospace Phase R(모바일 반응형) 구현과 연동.
  - 세션 종료 점검(2차): 양 저장소 working tree 클린. aiospace는 Phase R + W1+W2 커밋(`121e21b`·`35402b4`, STATE.md 포함) 완료·원격 미설정. 템플릿은 본 기록 커밋 후 백업 push 1회.

- 신규 sibling 프로젝트 `../aiospace/` 풀 연결 셋업 + 세션 종료 점검. (2026-06-11)
  - `~/projects/aiospace` 생성: `rules -> ../claude-agent-template` symlink + `.claude/{skills,commands,hooks,agents,plugins}` 5종 symlink + 진입 문서 3종(`CLAUDE.md`/`AGENTS.md`/`STATE.md`) + `settings.json`(hook 3종) + git init(초기 커밋 `9a4c4eb`). 연결 프로젝트 9 → 10개.
  - aiospace는 이후 별도 세션에서 WorkNest(AI Workspace OS) 방향으로 진행 중 — 템플릿 측 반영분(`designs/worknest.md` 추가·활성화)은 커밋 `0b8bd9c`. aiospace 자체 상태는 `../aiospace/STATE.md` 참조.
  - 세션 종료 점검: 미커밋으로 남아 있던 CI 실행 모델 재정의분(24파일, 2026-06-09 작업)을 커밋 `3366956`으로 보존. aiospace는 전부 커밋(클린)이나 원격 미설정이라 백업 push 없음. 템플릿 repo는 백업 push 1회 수행(원격 자동 CI 워크플로 없음 — `[skip ci]` 불필요).

- CI 실행 모델 재정의 — "CI = GitHub Actions(push 트리거)"에서 "로컬 CI(사용자 요청 시 로컬 실행)"로 전환 + 브랜치·머지·정리 절차 신설. (2026-06-09)
  - 배경: 사용자가 "CI를 git(GitHub Actions)에서 자동으로 돌리지 말고 로컬에서 개발자 요청 시 실행, push/머지/브랜치 정리는 올바른 절차로"를 요청. 기존 정본 `§1.1`의 "push 1회 = CI 1회" 커플링(2026-06-04 정책)이 이 요구와 정면 충돌했고, 브랜치 정리·머지 절차가 정본에 부재했음.
  - 결정: (1) CI 정의를 GitHub Actions → **로컬 CI 전체 스위트**(lint+typecheck+unit+build[+e2e/smoke] 또는 `act`)로 변경, 사용자 요청 시 로컬 실행. (2) push와 CI를 완전 분리 — push는 원격 백업·공유 수단이며 CI를 트리거하지 않음. (3) 머지·원격 브랜치 정리는 사용자 수동, 로컬 `git branch -d`는 agent 요청 시 가능(안전). (4) GitHub Actions 보유 시 `workflow_dispatch` 강등(권장) 또는 제거. "로컬 CI" 해석은 로컬 스크립트 스위트(기본) + `act`(옵션) 병기.
  - 정본 `docs/local-dev-ci-guide.md`: §1 기준선·경계 표(로컬 CI 행 신설·CI 트리거 표현 제거·브랜치 행 추가), §1.1 제목/본문 전면 재작성(3행위 분리), §3 인계 흐름(로컬 CI를 push 앞 단계로 재배치), §4 인계 요약(로컬 CI 여부), §5 금지사항(로컬 CI 검증 원칙) + **신규 §6 "브랜치·로컬 CI·머지·정리"**(6.1 네이밍 / 6.2 로컬 CI 실행법 / 6.3 머지 squash / 6.4 Actions 강등 / 6.5 cleanup).
  - 하위 정합: `docs/business-logic-playbook.md`(§5 경계·§5.1 흐름·§5.3 git 시나리오에 로컬 CI+cleanup·§5.4 실패), `templates/`(qa-intake·startup-checklist 예시 재작성, feature/bugfix/refactor/business-logic-request 검증 기준), `docs/development-process.md`·`development-strategy.md`.
  - 루트·레이어 배선: `CLAUDE.md` Golden Rules 2줄, `AGENTS.md`(Operational Commands·문서화 원칙·Context Map), `.claude/skills/`(feature/bugfix/refactor/dev-start), `agents/`(executor/reviewer), `.codex/workflows/`(bugfix/feature/refactor/review/dev-start) — 옛 "push·CI" 묶음 표현을 "로컬 CI·push" + "CI는 로컬 실행"으로 통일.
  - 검증: 활성 문서 전체에서 옛 표현("push·CI"/"push/CI"/"CI는 사용자 요청"/"push 1회=CI") 잔존 0건(STATE.md 과거 로그 제외). 전파: 정본+루트 갱신으로 9개 linked project가 `rules/` symlink로 자동 참조. 각 프로젝트 자체 `AGENTS.md`에 옛 모델을 복사한 부분은 별도 재동기화 필요(후속).
  - 미반영(사용자 판단 대기): `act` 도입 여부 최종 확정, 기존 워크플로 보유 프로젝트의 강등 vs 제거, `pnpm ci:local` 단일 진입점의 실제 스크립트화는 각 런타임 프로젝트에서 진행.

- 신규 DEX 거래소 개발용 sibling 프로젝트 `../dexchange/` 초기화. (2026-06-08)
  - 최초 생성 위치가 템플릿 저장소 내부였음을 확인하고 `/home/skyua/projects/dexchange` sibling 프로젝트로 이동했다.
  - Claude/Codex 에이전트 템플릿 v1.1.0 설치.
  - 프로젝트 전용 `AGENTS.md`, `CLAUDE.md`, `README.md`, `STATE.md` 작성 — DEX 보안 경계(private key/seed phrase/mainnet/실자금/contract deploy 자동 실행 금지), `local`/`develop`/`production` 환경 호칭, pnpm/Docker 기본 명령 반영.
  - DEX 초기 기준 문서 `docs/project-guide.md`, `docs/architecture.md`, `docs/security-model.md` 작성.
  - 기본 모노레포 골격 추가: `apps/web`, `apps/indexer`, `packages/contracts`, `packages/sdk`, `packages/shared`, `infra`.
  - 기본 설정 추가: `package.json`, `pnpm-workspace.yaml`, `.gitignore`, `.env.example`, `docker-compose.yml`, `scripts/check-docs.mjs`, `scripts/not-configured.mjs`.
  - 검증: `cd dexchange && pnpm check`, `node scripts/check-docs.mjs`, `docker compose config --quiet` 통과.

- 환경 호칭 3-tier 정책 신설 — `local`/`develop`/`production` 호칭 통일 + 마이그레이션 자동화 경계 명문화. (2026-06-07)
  - 배경: 마이그레이션 시 "dev"라는 표현이 (a) Prisma `migrate dev` 명령 모드와 (b) 원격 개발서버 환경을 동시에 가리켜 혼란. 사용자가 3개 환경(로컬 내 PC Docker / 개발서버 / 운영서버)의 호칭 정의 + "로컬만 자동, 개발·운영은 수동" 경계 명확화를 요청.
  - 결정: (1) 환경 호칭 `local`(내 PC Docker Desktop) / `develop`(원격 개발서버) / `production`(`prod`, 원격 운영서버) 3-tier, (2) "어디에(환경)"와 "어떻게(명령 모드)" 축 분리 — "dev" 단독 표기 금지·명령은 풀표기(`migrate dev`/`migrate deploy`), 개발서버 약어 `dev` 금지(`develop` 풀네임), (3) 자동화 경계는 명령명이 아니라 `DATABASE_URL` 연결 대상으로 판단 — `local`만 agent 자동, `develop`/`production`은 사용자 수동.
  - 정본 `docs/local-dev-ci-guide.md §0` 신설(§1 앞, 하위 번호 §1~§5 무손상) — 3-tier 호칭 표 + 용어 규칙 + 자동화 경계. §1 경계 표 2행(migration 로컬/원격)·§3 인계 흐름 11)·§5 금지사항을 호칭으로 정합(`DATABASE_URL` 대상 확인 한 줄 추가).
  - 루트 배선: `CLAUDE.md` Golden Rules migration 경계 줄에 3-tier 호칭+`DATABASE_URL` 판단+"dev 단독 금지" 반영(`§0` 포인터). `AGENTS.md` Operational Commands에 환경 호칭 1줄 신설 + 기존 경계 줄/사용자 확인 상황/Context Map 설명을 호칭으로 정합.
  - 하위 정합: `docs/business-logic-playbook.md` §5.1 흐름 7)·11), §5.2 migration 표행을 `local`/`develop`/`production`으로 통일. `.codex/checks/safety-checklist.md` 원격 migration 항목에 호칭+§0 포인터.
  - 전파: 정본+루트 갱신으로 9개 linked project가 `rules/` symlink로 자동 참조. 저장소 전체 `staging/prod` 리터럴 잔존 0 확인.
  - 후속 보강 후보(미반영, 사용자 판단 대기): `block-destructive.sh`에 `migrate reset`/`--force-reset`/`db push --accept-data-loss` 등 로컬 데이터 삭제 패턴 추가(현재 hook 미등록, 정책 문서만 커버).

- 레포 업데이트 상태 점검 및 전체 운영 문서 리뷰. (2026-06-05)
  - 상태: `main`은 `origin/main`과 일치했고, 점검 시작 시 미커밋 변경은 없었다.
  - 확인: 최근 HEAD는 `c8cd469`(개발 세션 부트스트랩 `dev-start` 흐름 신설). manifest 등록 파일 누락 없음, `.claude/plugins/manifest.json` JSON 유효성 통과, `install.sh --dry-run` 정상, hooks/plugin shell 스크립트 `bash -n` 통과.
  - 리뷰 결과: README 최신 구조 반영 누락(`dev-start`/`design`/preview HTML), 저장소명 표기 충돌(`claude-agent-template` vs `claude-agent-templete`), `STATE.md ## 현재 기준 파일`의 `dev-start` 누락, `todo.md` 헤더 날짜 노후화를 확인했다.
  - 추가 개선 후보: `.claude/commands/dev-start.md`에 push/CI 경계 보강, `docs/codex-reading-order.md`에 `dev-start`/`design` 라우팅 추가, HTML 내부 script 검증용 로컬 스크립트 도입, templates 카운트 표현 통일.
  - 검증 주의: 현재 Node 22에서는 `node --check docs/*.html`이 `.html` 확장자 문제로 바로 실패하므로, HTML 검증은 script 추출 방식으로 별도 정리 필요.

- 개발 세션 부트스트랩(PC 켜고 개발 재개) 흐름 신설 — "개발 시작" 트리거로 상태 브리핑 + dev 컨테이너 기동 + hot reload·UI/로직 점검을 자동 부팅. (2026-06-05)
  - 배경: PC 켜고 개발 시작 시 매번 STATE 상태 확인 + Docker hot reload 환경 기동 + UI/로직 점검을 한 번에 부팅하고 싶다는 요청. 트리거 표현과 자동 진행 정책을 함께 요구.
  - 결정(사용자 확인): (1) 트리거 대표 "개발 시작" + 동의어("이어서 개발"/"세션 시작"/"환경 셋팅해"/"다음 작업은"), (2) 세션 시작 시 컨테이너 기동은 항상 `docker compose up -d`(멱등), (3) Codex parity 포함.
  - 정본 `docs/local-dev-ci-guide.md §2.0` 신설(§2 도입과 §2.1 사이, 하위 번호 §2.1~2.4 무손상) — 3단계 절차(상태 브리핑 → `up -d` 기동+watcher 확인 → URL/preview 안내+hot reload 반영 확인) + 항상 `up -d` 정책 + 세션 시작 이유만으로 rebuild 금지(§2.4 결정 트리 위임).
  - 신규: skill `.claude/skills/dev-start/SKILL.md` + command `.claude/commands/dev-start.md` + Codex `.codex/workflows/dev-start.md`(parity).
  - 배선: `CLAUDE.md`(Skills Layer 목록 + 우선순위 규칙 dev-start vs feature 경계 + Repo Map skills 9→10·commands 8→9·codex workflow 8→9), `AGENTS.md`(Operational Commands + "개발 세션 재개 시" 프로토콜 분기 신설 + Context Map 로컬/CI 가이드 §2.0·Skills/Commands 카운트·목록), `.claude/plugins/manifest.json`(skills/commands/codex 등록), `docs/plugin-guide.md`(Skills 9→10·Commands 8→9·codex workflow 8→9종), `docs/agent-runtime-matrix.md`(대응표 행 추가), `.codex/README.md`(작업 라우팅 추가).
  - 검증: manifest JSON 유효성 통과, 신규 파일 3종 생성 확인, 현재형 문서 카운트 잔재 0.

- 로컬 Docker Desktop 개발 정책을 전 작업유형·전 레이어에 배선. (2026-06-04)
  - 배경: 정본 `local-dev-ci-guide.md`는 "전 작업유형 공통"을 선언하나 실제로는 business-logic 흐름만 정본을 참조 → feature/bugfix/refactor/review 흐름은 로컬 한정·개발 컨테이너 모델 안내 누락(감사로 확인).
  - 원칙: 정본은 1곳 유지, 나머지는 1줄 포인터만 추가(중복 금지). 14개 지점 배선:
    - Tier A codex workflows: `feature`/`bugfix`/`refactor`/`review`.md에 로컬 검증·재빌드·push/CI 경계 step 추가(business-logic.md step 5-6 미러).
    - Tier B 템플릿: `feature`/`bugfix`/`refactor-request.md` `## 검증 기준`에 "로컬 Docker Desktop(§2.1) + push/CI 사용자 요청 시" 포인터.
    - Tier C 공통 에이전트: `executor-agent.md`(로컬 검증·hot reload·push/CI 체크), `reviewer-agent.md`(로컬 한정 경계 체크) 공통 체크리스트에 추가.
    - Tier D skills: `feature`/`bugfix`/`refactor` SKILL `## 완료 후`에 구현·검증 단계 정본 포인터.
    - Tier E 보강: `development-process.md` Phase 4-4(executor) 로컬 검증 항목, `startup-checklist.md` 섹션2 Q8(로컬 Docker 개발 여부)+결과 예시.
  - review-request.md 템플릿은 build/deploy 비대상이라 제외.

- 개발 컨테이너 모델 정책 신설 — 로컬 Docker 빠른 반복(리빌드 최소화). (2026-06-04)
  - 배경: 매번 이미지 rebuild하지 말고 컨테이너 상시 기동 + 소스 bind mount + watch/hot reload로 즉시 반영되게 정책화 요청.
  - 정본 `docs/local-dev-ci-guide.md §2` 재구성: §2를 "개발 루프 전략"으로 개편하고 **§2.1 개발 컨테이너 모델(기본값)** 신설 — 상시 기동 / bind mount / hot reload / rebuild는 예외. compose 구성 패턴(`./:/app` + `/app/node_modules` 익명 볼륨 + `command` watch override + `compose watch`), WSL2/Docker Desktop 파일감지 폴링(`CHOKIDAR_USEPOLLING`/`WATCHPACK_POLLING`/vite usePolling/nodemon `-L`/uvicorn `--reload`), 반영 방법 결정표, 검증(logs로 HMR 확인). 기존 증분/강력은 §2.2/§2.3, 결정 트리는 §2.4(hot reload 0순위 분기 추가).
  - 정합 반영: `docs/business-logic-playbook.md §5.2`(rebuild 표 위 0순위 hot reload + §2.4 참조), `templates/tech-intake.md`(로컬 Docker 개발 루프 수집 항목 + 작성 예시), `AGENTS.md`(Operational Commands + Context Map 라우팅 설명), `docs/local-dev-ci-guide.md §3`(반영 단계 hot reload 우선).
  - 외부 §2 참조는 모두 bare "§2"라 하위 번호 재정렬에도 깨지지 않음(확인 완료).

- push/CI 사용자 요청 기반 정책 신설 — 커밋/푸시/PR/CI 과다 반복 통제. (2026-06-04)
  - 배경: 매 commit·매 사이클마다 push→CI→PR이 반복돼 개발 속도가 지체. 사용자가 "CI를 요청할 때만 돌리고 싶다"로 정책 확정.
  - 정본 `docs/local-dev-ci-guide.md §1.1`: 로컬 commit은 자유 누적·로컬 검증(lint/test/build/smoke)만으로 완료 보고. **push·PR·CI는 사용자 명시 지시(`push`/`올려`/`CI 돌려`) 시에만** 수행, agent는 스스로 push 안 함. CI 전용 검증이 필요하면 사용자에게 물어 요청받음.
  - 세션 종료 예외: 유실 방지 백업 push 1회 허용하되 commit 메시지 `[skip ci]`(GitHub Actions 등 인식)로 **CI는 트리거하지 않음**. skip 미지원 CI는 백업 생략/사용자 확인.
  - 원리: push 1회 = CI 1회로 커플링 → push를 요청 시에만 하면 CI도 요청 시에만. 머지는 agent 범위 밖 재확인.
  - 정합 반영: `docs/local-dev-ci-guide.md`(§1 표·§1.1·§3 흐름·§4 인계), `CLAUDE.md` Golden Rules, `AGENTS.md` 문서화 원칙, `docs/business-logic-playbook.md §5.1·5.3`, `templates/business-logic-request.md`, `docs/development-strategy.md`, `docs/development-process.md` Phase 5.
  - Codex 레이어(`.codex/`)는 정본 문서를 참조하므로 별도 수정 없음(parity 유지).

- 개발 전략 매뉴얼 신설. (2026-06-04)
  - 신규 `docs/development-strategy.md`: UI Mock First 기본 경로와 Logic/DB First 예외 경로의 선택 기준, 진행 순서, 전환 조건, commit slice를 문서화.
  - 신규 `docs/development-strategy.html`: 사람이 보는 보조 HTML 매뉴얼 추가. 기본값은 UI Mock First, 결제/정산/권한/재고/토큰/지갑/migration 위험 작업은 Logic/DB First 예외로 분리.
  - `docs/development-process.md`, `docs/development-process.html`: Phase 4 개발 전략 선택 기준과 HTML 상단 CTA/Context Map 링크 추가.
  - `AGENTS.md`, `README.md`: 신규 개발 전략 문서와 HTML 진입점 라우팅 반영.

- 브랜치 정리 — `origin/master` → `main` 머지 후 원격/로컬 추적 참조 삭제. (2026-05-31)
  - `origin/master` 6개 커밋(User FE 시안 인프라, admin density, rider 중립화 등)을 `main`에 머지 (`cd34770`).
  - `STATE.md`/`todo.md` 충돌 해결: 날짜순 통합 / `riderapp-runtime` 태스크 제거(master 버전 채택).
  - `origin/master` 원격 브랜치 삭제 + `git remote prune origin`으로 로컬 추적 참조 정리.
  - `origin/main` push 완료. 브랜치는 `main` 단일 구조로 정리됨.

- 템플릿 전체 검토 후 정합성 수정 3건. (2026-05-30)
  - 배경: 사용자 요청으로 5-Layer 템플릿 전체 점검(카운트·링크·hook 동작·런타임 parity·최신성). 레이어 카운트(skills 9/commands 8/hooks 4/claude·codex agents 6/templates 19/docs 19/designs 8/codex wf 8/checks 2)·루트 깨진 링크 0·hook 동작·manifest/install 동기화는 모두 정합 확인. 실질 이슈는 노후 `todo.md` 1건 + parity/버전 2건.
  - `todo.md`: 상단 라이브 섹션을 STATE.md `## 다음 작업` 기준으로 갱신(05-16→05-30 종료 시점). stale 참조 정리 — 삭제된 `rider-platform-docs`, 오타 `claude-agent-templete`→`claude-agent-template`, 옛 `riderapp` 경로. 05-16 "즉시 활용 산출물" 블록은 STATE 이력에 이미 있어 제거. 하단 archived 블록은 보존.
  - 런타임 parity: `.codex/agents/reviewer.md` → `.codex/agents/code-reviewer.md`로 rename(`.claude/agents/code-reviewer.md`와 1:1 정합). `manifest.json codex.files` 경로/설명 + 파일 heading(`# Code Reviewer Agent`) 동기화. 참조처는 manifest 1곳뿐이라 영향 최소.
  - 버전: `.claude/plugins/VERSION` + `manifest.json version` `1.0.0` → `1.1.0`(codex 어댑터 레이어 추가 반영, semver minor).

- Claude Code + Codex dual runtime 기반 설계 추가. (2026-05-30)
  - 공통 정본은 `AGENTS.md`/`STATE.md`/`templates/`/`docs/`/`DESIGN.md`로 유지하고, Claude 전용 자동화는 `.claude/*`, Codex 실행 절차는 `.codex/*`로 분리하는 보완형 구조를 채택.
  - 신규 `docs/agent-runtime-matrix.md` — Claude Code 자동화 기능과 Codex workflow/check/subagent guide 대응 관계, 공통 정본, 변경 규칙 정의.
  - 신규 `docs/claude-guide.md`, `docs/codex-guide.md` — 각 런타임의 진입점과 실행 기준 분리.
  - 신규 `.codex/` 레이어 — `README.md`, `workflows/` 8종(start/intake/feature/bugfix/refactor/review/business-logic/design), `checks/` 2종(safety/finish), `agents/` 6종(explorer/code-reviewer/planner/test-runner/feature-dev/design-reviewer).
  - `README.md`, `AGENTS.md`, `CLAUDE.md`, `docs/plugin-guide.md`, `docs/codex-reading-order.md`: Claude/Codex 지원 수준, Codex 진입점, 런타임별 어댑터 경계 반영.
  - `.claude/plugins/manifest.json`: compatibility를 Claude full automation + Codex workflow compatible 구조로 확장하고 `.codex/*` 및 신규 런타임 문서 등록. `install.sh`도 manifest `codex.files`를 설치 대상으로 포함하도록 갱신.

- 프로젝트 운영 점검 후 설치/디자인 동기화 리스크 수정. (2026-05-30)
  - `.claude/plugins/install.sh`: `--dry-run` 성공 출력 후 exit code가 1로 끝나던 문제를 `exit 0`으로 고정. 설치 시 `.claude/settings.local.json` 내부 hook 절대 경로를 템플릿 원본 경로에서 대상 프로젝트 경로로 자동 치환하도록 보강.
  - `docs/plugin-guide.md`: manifest 기준 설치 내용으로 갱신 — L1 `DESIGN.md`, L2 Skills 9개, L3 Hooks 4개, L4 Subagents 6개, design library/selector, `--design <slug>` 플래그, settings hook 경로 자동 치환 정책 반영.
  - `designs/wanted.md`: active `DESIGN.md`의 모달/scrim 및 wide table 정책 변경분을 wanted 라이브러리 원본에 동기화. active marker `wanted`와 라이브러리 원본 불일치 해소.

- 로컬/CI 실행 경계 + Docker 재빌드 2모드 가이드 신설. (2026-05-30)
  - 배경: 사용자 워크플로 = 로컬 테스트는 Docker Desktop, agent는 commit→push→CI까지만, GitHub Actions 배포·릴리스와 원격 migration 적용은 사용자 수동. 로컬 개발 루프에서 캐시 없는 강력 재빌드 vs 빠른 증분 재빌드 판단을 agent에 가이드 필요.
  - 결정(사용자 확인): (1) 적용=신규 공통 문서 신설(전 작업 유형 공통) + 헌법 경계 규칙, (2) migration 경계=로컬 Docker Desktop까지 agent 적용 OK·"GitHub 이상" 원격은 수동, (3) 강력 재빌드=조건 자동 판단.
  - 신규 `docs/local-dev-ci-guide.md` — §1 agent 실행 경계 표(로컬·migration(로컬)·commit·push·CI=agent / 배포 Action·원격 migration=수동), §2 Docker 2모드(증분 기본 / 강력 no-cache 자동 판단 조건)+결정 트리, §3 인계 흐름(9+경계+수동), §4 push 후 인계 요약, §5 금지 사항(원격 dispatch·원격 migration·`down -v`·force push).
  - `CLAUDE.md`: Golden Rules에 경계 규칙 1줄 + Repo Map docs에 신규 doc.
  - `AGENTS.md`: Operational Commands에 "로컬=Docker Desktop+경계" 1줄, 사용자 확인 상황에 "GitHub 이상 원격 작업·`down -v`" 2항목, Context Map에 라우팅.
  - `docs/business-logic-playbook.md §5`: 상단 정본 참조, §5.1 흐름을 9단계+경계선+수동 인계로 확장, §5.2 2모드 결정 트리 참조 + migration 행을 "로컬=agent·원격=수동"으로 보정, §5.3 끝에 agent 종료/인계 한 단락.
  - `templates/business-logic-request.md`: 검증 계획에 재빌드 모드+사유·로컬 migration 여부, Git 계획에 agent 종료=push/CI 항목.
  - `.claude/plugins/manifest.json supporting.docs`에 신규 doc 등록.

- 모달 닫기 정책 + 커스텀 모달 강제 코딩 가이드 신설. (2026-05-29)
  - 배경: 모달 SSOT 명세 부재(`docs/admin-fe-design-guide.md`가 `{component.modal}`을 호출하나 `DESIGN.md`에 정의 없음 = dangling reference) + 닫기/구현 방식이 intake·decision 템플릿마다 열린 옵션. 사용자 요구 = 배경 클릭 닫기 금지(닫기 버튼·X·ESC만) + 항상 커스텀 모달. bottom-sheet 동일 적용.
  - "항상 커스텀" 범위 분석 → **Headless 허용** 채택: 시각 표면은 항상 `DESIGN.md` 토큰으로 커스텀 구현, a11y 동작(focus-trap·scroll-lock·ESC·`aria-modal`)만 headless 라이브러리(Radix/Headless UI/React Aria) 위임 허용. native(`alert/confirm/prompt`)·pre-styled 라이브러리 모달 금지. (완전 직접 구현=a11y 버그·비용 과다, native만 금지=디자인 일관성 훼손이라 중간안 채택)
  - `DESIGN.md`: `## Components`에 `### modal / dialog` 신설(bg-elevated/border-subtle/radius-12/space-24/shadow-4·pop 재사용 + 닫기 3종 고정 + bottom-sheet 변형). `### Semantic alias`(Light `oklch(0 0 0 / 0.5)`·Dark `0.6`)와 CSS Variables 양 블록에 `bg-scrim` 신설(flat 반투명, blur 금지). `## Do's and Don'ts`에 Do 1종 + Don't 2종(배경 클릭/스와이프 닫기 금지, native/pre-styled 금지). `## Known Gaps`에 `bg-scrim` synthesized 항목.
  - `designs/_alias-contract.md ## 9b` fallback 표에 `--bg-scrim` 등재.
  - `docs/ui-decisions.md ## 6. 모달 정책`: 구현=커스텀(고정), 닫기=닫기/X/ESC(표준 고정, 배경 클릭은 비표준 예외)로 옵션 → 규칙 전환. 모바일 시트 동일 적용 한 줄.
  - `templates/startup-checklist.md ## 섹션 4`: Q1 커스텀 표준(B 완전 직접 구현, native/pre-styled 배제), Q3 배경 클릭 옵션 제거(닫기/X/ESC 표준 고정). 섹션 7 Q3 바텀 시트도 동일 닫기 정책 명시.
  - `.claude/skills/design/SKILL.md`: 자동 인용 컴포넌트 목록에 modal/dialog/bottom-sheet 추가 + 진행 규칙에 닫기/커스텀 정책 1줄.
  - `docs/admin-fe-design-guide.md`: `{component.modal}` 항목에 닫기 affordance(X/닫기/ESC, 배경 클릭 금지)+커스텀 구현 보강 → dangling reference 해소.
  - 범위 밖: `designs/` 개별 시안 동기화(toss-like bottom-sheet 등)는 후속 별건.

- `CLAUDE.md` `## 답변 포맷` 섹션 추가 + 구분선 `═══` 적용. (2026-05-28)
  - 답변 포맷 규칙(구조·이모지·표기·과정/결론 구분선·결론 형식·적용 범위 8개)을 `CLAUDE.md`에 직접 내장. 연결 프로젝트 6개(`rules/CLAUDE.md` 읽기 순서 포함)에 자동 반영.
  - Core Philosophy #2 참조 대상을 `~/.claude/CLAUDE.md` → `## 답변 포맷` 섹션으로 변경.
  - 과정/결론 구분선을 `---` → `═══════════════════════════════════════════════════════════════════════`(U+2550 이중선)으로 변경. 전역 `~/.claude/CLAUDE.md`도 동기화.

- 연결 프로젝트 7개 symlink 전환 및 커밋 가이드 일괄 적용. (2026-05-28)
  - `riderwebapp`, `aica2`, `skim`, `trippass`, `signal2`: 상대경로 방식 → `rules/` symlink 전환. CLAUDE.md 읽기 순서에 `rules/CLAUDE.md` 추가. AGENTS.md 경로 전체 치환.
  - `makeupshop`: 플러그인 설치 → symlink 전환. `.claude/` 하위 5개 디렉터리를 `../rules/.claude/*` symlink로 교체. CLAUDE.md 프로젝트 전용 진입 문서로 교체.
  - 전체 연결 프로젝트(`riderwebapp`, `aica2`, `skim`, `trippass`, `signal2`, `vwallet`, `makeupshop`) CLAUDE.md에 "STATE.md 갱신하고 커밋한다" 적용 완료.
  - `.claude/settings.local.json` 신규 생성 — hooks 3종(block-destructive, block-secret-files, state-reminder) 등록.

- `CLAUDE.md` Core Philosophy #2 이모지 규칙 스코프 명시. (2026-05-27)
  - 답변 포맷 가이드가 유저 전역 `~/.claude/CLAUDE.md`(`## 답변 포맷`)로 이전된 뒤, 프로젝트 `CLAUDE.md` Core Philosophy #2("이모지·수사 사용하지 않는다")가 스코프 미명시 상태여서 전역의 "채팅 답변 절제 이모지 마커 허용"과 해석 충돌 소지가 있었다.
  - Core Philosophy #2를 "루트 문서 본문 한정"으로 못박고, 채팅 답변 텍스트의 상태 마커는 전역 `## 답변 포맷`을 따른다고 명시(옵션 a). `AGENTS.md` Constraint 2(Context Map 한정), Design System(product UI 한정)과 스코프가 직교하도록 정리.

- 템플릿 예시의 rider 프로젝트 종속 제거 — 예시 7파일 + admin preview를 도메인 중립화. (2026-05-27)
  - 배경: 사용자가 "agent가 특정 프로젝트에 종속됐는지" 점검 요청. 규칙/구조 레이어(`CLAUDE.md`, `AGENTS.md`, `agents/`, skills, hooks, `DESIGN.md`)는 비종속이나, (a) `STATE.md`의 sibling 저장소 인계 정보와 (b) templates/docs 작성 예시의 "헬멧 세척 라이더 매칭 플랫폼" 시나리오가 rider 프로젝트에 결합돼 있음을 확인. 사용자가 (b)만 일반화 선택, 방식은 "추상 placeholder 중립화" 채택.
  - **A군 (full placeholder)**: `templates/project-intake.md`, `templates/startup-checklist.md`, `templates/framework-structure-intake.md`, `docs/project-guide-template.md`. 매핑: 주문→`<엔티티A>`/`entity-a`, 라이더→`<엔티티B>`/`entity-b`, 매장→`<엔티티C>`/`entity-c`, 배차/재배차→`<핵심 액션>`, 매장 매니저→`<2차 사용자>`, 도메인→`<프로젝트 한 줄 설명>`, KPI 3종→`<지표1~3>`, 라이더 앱→`<외부 연동 시스템>`, AI 매칭 추천→AI 추천 기능. 기술 스택/breakpoint/디렉터리 구조 등 범용 내용은 유지.
  - **B군 (rider 토큰만 제거, 범용 커머스 어휘 유지)**: `docs/i18n-guidelines.md`(`riders.json`→`products.json`, ns 배열 `riders`→`products`; orders·주문 JSON 샘플은 동작 코드라 유지), `templates/data-table-density.md`(14컬럼 중 `라이더`→`담당자`만 교체; 주문·배송·고객명·`/admin/orders`는 유지). 사유: orders/배송 등은 어느 admin 툴에나 있는 범용 어휘로 rider 프로젝트 식별성이 없음.
  - **`docs/ui-decisions.md`**: §9에 구체 data-table을 포함해 문서 내부 일관성을 위해 전체 concrete 유지 + rider 토큰만 제거(라이더 재배차→담당자 재배정, 신규 라이더 등록→신규 담당자 등록, `/admin/riders`→`/admin/staff`, 카피톤 어휘 예시 `라이더 → rider`→`운영자 → operator, 관리자 → admin`). 주문/orders 유지.
  - **`docs/admin-fe-preview.html`** (협의 7파일 밖이나 동일 rider 데모라 함께 정리): 주문 데모 테이블 2종의 `라이더` 컬럼 헤더→`담당자`, 샘플명 김/박/이라이더→김도현/박서준/정민호. 나머지 커머스 데모 데이터 유지.
  - **의도적 미변경**: `STATE.md`의 rider 언급은 실제 sibling 저장소(`../riderapp-runtime/`, `../rider-platform-docs/`) 인계 기록이라 유지. "매칭"이 든 `CLAUDE.md`/`manifest.json`/`plugin-guide.md`는 "키워드 매칭" 기술 용어 오탐(미변경).
  - 검증: 전체 저장소 sweep(`라이더|배차|재배차|헬멧|매칭|매장 매니저|riders.json|/admin/riders`)에서 rider 식별 토큰은 STATE.md/todo.md에만 잔존, 나머지는 오탐임을 확인.
  - 후속(같은 세션, 사용자 요청): `todo.md` §A의 `riderapp-runtime/README.md` 경로 갱신 태스크(sibling 저장소 cross-repo 작업)를 제거하고, `STATE.md ## 다음 작업 > 기존 보류 항목`의 동일 태스크 미러도 함께 제거(두 파일 정합). 템플릿 저장소가 특정 소비 프로젝트의 태스크를 추적하지 않도록 정리 — 해당 작업이 여전히 필요하면 `riderapp-runtime` 저장소에서 관리. `STATE.md`의 나머지 rider 언급(`현재 상태`/`현재 기준 파일`의 sibling 저장소 경로·실행 명령)은 인계 사실이라 유지.

- STATE.md 커밋 정책 명문화 + `rider-platform-docs` 잔재 정리. (2026-05-25)
  - `CLAUDE.md`, `AGENTS.md`, `agents/main-agent.md` 3곳의 "`STATE.md` 갱신" 문구를 "갱신하고 커밋"으로 동기화. `AGENTS.md`에 커밋 순서 한 줄(STATE.md 갱신 → 스테이징 → commit, 미포함 시 hook 경고) 추가.
  - 삭제된 sibling 저장소 `rider-platform-docs` 참조 7곳 정리: 현재형/기준 섹션(현재 상태·현재 기준 파일·주의 사항·다음 작업)은 제거·수정, 과거 dated 로그는 "(이후 삭제됨)" 표기로 이력 보존.

- preview 검수 결과 반영 #1 — Admin Surface Density Cases row ladder 재배치(B 44→40, C 40→36). (2026-05-20)
  - 배경: 사용자가 admin-fe-preview `#density` 검수 중 **Case B(컴팩트) row 44가 너무 크다**고 판단. 4의 배수 ladder + 하한 36 제약상 B를 40으로 내리면 C(40)와 충돌 → C·D를 36으로 합쳐 해소(B 40 / C·D 36 안 채택). C/D는 row 36 공유하되 padding(16/12/8 vs 8/8/8)으로 구분.
  - **DESIGN.md `#### Admin Surface Density Cases`** 표: B `44 (compact)`→`40 (compact)`, C `40 (tight)`→`36 (tight)`. 운영 규칙 typography-down 항목을 case-기반("C/D에서")에서 값-기반("row 40 이하 케이스(B/C/D)에서")으로 일반화 — B가 40이 되며 임계에 포함됨. 시안별 디폴트 `minimal-mono` 비고 `row 44`→`row 40`. frontmatter `last_updated` 2026-05-19→2026-05-20.
  - **Wide Table Cases(컬럼 수 축)는 미변경** — 별도 매트릭스로 B=44 유지. Surface Density와 독립.
  - `.claude/agents/design-reviewer.md A-8`: typography-down 경고 항목 `Case C/D에서 row 40 이하` → `row 40 이하 케이스(B/C/D)`.
  - `templates/data-table-density.md §1` Surface Density 체크리스트: B `row 44`→`row 40`, C `row 40`→`row 36`. (§3/§4/작성예시의 Wide Table row 44는 미변경)
  - `docs/admin-fe-preview.html`: `.density-mini.compact --m-row 44px`→`40px`, `.minimum --m-row 40px`→`36px`. specimen 라벨 B `row 44`→`row 40`, C `row 40`→`row 36`. (JS 미변경)
  - 후속 검토(미반영, 사용자 판단 대기): (a) `linear-like` Surface Density 디폴트가 C인데 C가 36(=D 모니터 밀도)로 내려가 "compact 시그너처"와 결이 어긋남 — B(40)로 올릴지 검토. (b) **DESIGN.md(1643줄)는 designs/wanted.md(1093줄)와 이미 분기** — admin/User-FE 섹션 전부 DESIGN.md에만 존재. Surface Density도 라이브러리 원본에 없어 이번 수정은 DESIGN.md에만 반영. select-design.sh 재실행 시 admin 콘텐츠 유실 위험은 기존부터 존재(`.bak` 백업 의존).

- User FE 모바일 전용판 디자인 시안 인프라 신설 — DESIGN.md 모바일 인터랙션 패턴 절 + 가이드 + preview HTML + design-reviewer A-13. (2026-05-19)
  - **DESIGN.md `### bottom-sheet` 끝에 `#### 모바일 전용 인터랙션 패턴` 절 신설** — segmented-control(in-page tab, height 36, radius-full, 2~3개 토글), list-row swipe-action(width 72 액션, 위험은 confirm 단계), pull-to-refresh(80px 임계, spinner), native-like toast(하단 sticky, 단일, swipe-down-dismiss), sticky bottom CTA(height 64, safe-area-inset-bottom 합산).
  - **`docs/user-fe-mobile-design-guide.md` 신설** (반응형판 가이드와 차이점 중심, 360줄대) — 적용 범위(360~430 고정 + 데스크탑 미지원 + 네이티브-like) + 반응형판과의 차이 역방향 표 + 1차 원칙 추가(hover 금지/gesture 우선/sticky CTA 표준/single-page-flow/keyboard 미사용/back-button 일관성) + 단일 breakpoint(360~430) + 화면 골격(status-bar safe-area + app-bar + content + sticky CTA + bottom-nav + home-indicator safe-area) + 컴포넌트 5종 모바일 전용 로컬값 + 모바일 전용 인터랙션 5종(segmented/swipe-action/pull-to-refresh/toast/sticky CTA) + 7 화면 mobile-only 변형 + 시안별 모바일 디폴트.
  - **`docs/user-fe-mobile-preview.html` 신설** (반응형 preview cp 후 mobile-only 변형, 2995줄) — viewport switcher 3종 phone model(iPhone SE 360 / Pixel 7 390 / iPhone 14 Pro Max 430), `.phone-frame` 클래스(8px black bezel + radius 36 + notch 120×24 + shadow) 7 화면 specimen에 적용, 인터랙션 specimen 4종 신설(`#segmented`/`#swipeaction`/`#pull`/`#toast`), JS swipe-row 클릭 토글 + segmented active 토글 + BNAV/SEARCH 디폴트 메시지 모바일 강조본으로 갱신, localStorage prefix `user-fe-mobile-*`로 분리. JS `node --check` 통과.
  - **`.claude/agents/design-reviewer.md A-13` 신설** — 모바일 전용판 적용 시(또는 PR 본문 "모바일 전용"·"viewport 360~430"·"네이티브-like" 명시 시)에 한해 추가 검증. viewport/breakpoint(데스크탑 breakpoint 차단), 인터랙션(hover 금지·우클릭 차단·swipe affordance·위험 swipe confirm), sticky CTA/nav(상세/폼 sticky CTA 표준·stacking 충돌 차단·safe-area-inset-bottom), Toast/Modal(우측 corner 차단·single toast·위험 액션 modal), pull-to-refresh, segmented(4+ 차단·height 36), keyboard(linear-like ⌘K·material-3 keyboard nav 차단), phone 환경(iOS swipe-back 충돌·Material You dynamic color 우선순위).
  - `manifest.json supporting.docs`에 `docs/user-fe-mobile-design-guide.md`, `docs/user-fe-mobile-preview.html` 등록(반응형판 쌍 직후). JSON 유효성 통과.

- User FE 반응형판 디자인 시안 인프라 신설 — DESIGN.md synthesized 컴포넌트 5종 + 가이드 + preview HTML + design-reviewer A-12/B-7. (2026-05-19)
  - **DESIGN.md `### User FE surface 컴포넌트 (synthesized)` 신설** (admin 5종 다음, `### logo` 직전) — `app-bar (mobile)`(height 52, safe-area-inset-top, 좌/중/우 cluster 변형), `bottom-nav`(height 56, 3~5탭, safe-area-inset-bottom, FAB variant + #### Bottom Nav Cases 4종 A/B/C/D + 시안별 디폴트), `feed-card`(vertical/horizontal/compact 3변형, thumbnail aspect ladder), `search-bar`(48 height, 4 Cases A inline / B 풀스크린 / C voice+filter / D sunken pill), `bottom-sheet`(handle + max-height 85vh + sticky action-bar + backdrop + animation spec). last_updated 2026-05-18 → 2026-05-19.
  - **`docs/user-fe-design-guide.md` 신설** — 반응형(mobile/tablet/desktop) 운영 가정. 1차 원칙(mobile-first + touch target 44 + nav 분기 + safe-area-inset) + Breakpoints 4단(640/1024/1280) + 화면 골격 3종(mobile/tablet/desktop) + 7종 화면 패턴(splash/login/home/list/detail/form/mypage) + 시안별 화면 조립 차이 매트릭스(hero/카드/CTA/입력 비교) + 카피 톤 3종 + preview 시각 확인 + 모바일 전용판과의 차이 표.
  - **`docs/user-fe-preview.html` 신설** — `admin-fe-preview.html` cp 후 본문 교체. 상단 셀렉터 3축(시안 dropdown + viewport dropdown `mobile 360 / tablet 768 / desktop 1280` + light/dark) → `data-design` + `data-viewport` + `data-theme` cascade. `.uf-frame` viewport simulator(`:root[data-viewport=...] .uf-frame { width: ... }`). 6 컴포넌트 specimen(app-bar 3변형 / bottom-nav 4 케이스 / feed-card 3변형 / search-bar 4 케이스 / bottom-sheet 2변형) + 7 화면 specimen(splash/login/home/list/detail/form/mypage). `BNAV_DEFAULT`/`SEARCH_DEFAULT` 시안별 디폴트 매핑 + `renderBnavDefault`/`renderSearchDefault`로 우측 hint 자동 갱신. bottom-nav 활성 탭 클릭 토글 + chip-row 활성 토글 데모. JS `node --check` 통과. 2742줄.
  - **`.claude/agents/design-reviewer.md A-12 + B-7` 신설** — A-12: User FE 반응형 컴포넌트 정합(app-bar height 52 / bottom-nav 데스크탑 노출 차단 + 탭 3~5개 + 라벨 명사형 + safe-area / feed-card thumbnail aspect ladder + click area 분리 / search-bar height 48 + 접근성 라벨 / bottom-sheet 위험 액션 차단 + max-height 85vh / 반응형 일반 touch target 44 + breakpoint 사다리). B-7: User FE 시안별 정책(Bottom Nav 시안별 디폴트 표 정합 + Search Cases 시안별 디폴트 + toss-like 모바일 height 48 미만 차단 + material-3 FAB shadow-2 + linear-like 텍스트 only 시그너처 + wanted/minimal-mono shadow_on_cards 정책 정합).
  - `manifest.json supporting.docs`에 `docs/user-fe-design-guide.md`, `docs/user-fe-preview.html` 등록(admin 쌍 직후, ui-decisions 직전). JSON 유효성 통과.

- admin surface 4종 케이스 매트릭스 추가 — Surface Density / Filter Bar / Column Filter / Tab Page. (2026-05-18)
  - **DESIGN.md `#### Admin Surface Density Cases`** (admin 영역 소개 글 직후) — 4-케이스(A 표준 32/24/16·row 56 / B 컴팩트 24/16/12·row 44 / C 미니멈 16/12/8·row 40 / D 모니터링 8/8/8·row 36) + 화면 단위 한 케이스 적용 원칙 + 시안 디폴트(wanted·toss-like·material-3=A / minimal-mono=B / linear-like=C).
  - **DESIGN.md `### filter-bar (admin)` 신설 + `#### Filter Bar Cases`** — 마케팅 `### filter-bar`와 별개 admin용 컴포넌트. 4-케이스(A 기본 chip / B 일시범위+엑셀 / C 다중 패널+저장된 뷰 / D 검색만) + yaml 사양(date-range 단일 트리거 + List Toolbar §2 엑셀 호출 + counter `필터 (N)` + saved-views + column-toggle).
  - **DESIGN.md `### data-table > #### Column Filter Cases`** — 4-케이스(A 정렬만 / B 헤더 popover + brand dot 활성 표기 / C 인라인 row + Excel 필터 패턴 / D 듀얼 전역+컬럼). popover 사양(240/280/320) + 활성 표기 정책(텍스트 'filtered' 금지).
  - **DESIGN.md `### tab (admin)` 신설 + `#### Tab Page Cases`** — 4-케이스(A line underline / B pill 채움 / C segmented / D vertical 좌측). yaml 사양(height 40, counter badge sm, overflow). 운영 규칙(혼용 금지·이모지/gradient 금지·탭 ≥7 시 D 승격·라벨 명사 단문).
  - **admin-fe-preview.html 5d~5g 4 섹션 신설** (TOC 4 항목 추가) — `#density` 4행 비교 specimen(spacious/compact/minimum/monitor 클래스로 CSS variable 전환), `#filterbar` 4 케이스(date-trigger + chip + counter + 엑셀 dropdown + panel-trigger), `#colfilter` 4 케이스(mini-table 4컬럼 + h-control sort/funnel + colf-inline-row select), `#tabs` 4 케이스(line underline + pill + segment + vertical-frame indicator). `ADMIN_DEFAULT` 매핑 + `renderAdminDefault(slug)`로 4 섹션 우측 hint 동기. JS `node --check` 통과. 116KB → 144KB.
  - **`.claude/agents/design-reviewer.md A-8~A-11`** 신설 — Surface Density(케이스 혼재/비-4 ladder/row 36 미만/Case D 일반 화면 적용 차단 등), Filter Bar(일시 분리 금지·List Toolbar §2 호출 필수·필터 0 카운터 숨김·6+ chip 패널 승격 등), Column Filter(text 'filtered' 차단·Case C input ≥32·sort+filter 분리 등), Tab Page(혼용·이모지·gradient·텍스트 카운터·탭 ≥7·라벨 명사형 등).
  - **`templates/data-table-density.md`** §1 화면 컨텍스트에 density 케이스 선택 4종 + §9 Filter Bar + §10 Column Filter + §11 Tab Page 신설(기존 §9 합의/기록 → §12). 14컬럼 주문 리스트 작성 예시도 §9/§10/§11 항목 추가.
  - DESIGN.md frontmatter `last_updated` 2026-05-18 유지.

- `### data-table` 아래 `#### List Toolbar Cases` 신설 + admin-fe-preview specimen + design-reviewer A-7 + density intake §8 확장. (2026-05-18)
  - **DESIGN.md ### data-table > #### List Toolbar Cases** 신규 — 검색 입력 X(clear) 3종(A 항상 / B 호버·포커스 / C 없음) + 엑셀 다운로드 4종(A 단일 버튼 / B 아이콘 only / C 옵션 dropdown / D 비동기 progress) + 페이지 크기 3종(A dropdown / B segmented / C auto-fit) 매트릭스. 각 컴포넌트 yaml 토큰 사양(slot/size/color/component/keyboard/a11y) + 시안별 디폴트 표 5종.
  - `templates/data-table-density.md` 섹션 재편: 기존 §8 합의/기록 → §9로 밀고 §8 List Toolbar 신설(8.1 검색 clear / 8.2 엑셀 / 8.3 페이지 크기). 작성 예시도 14컬럼 주문 리스트 시나리오에 §8 답변 추가.
  - `.claude/agents/design-reviewer.md A-7` 신설 — 3 컴포넌트 차단/경고 항목 18종(검색: hit area / 색 alias / Case A 노출 / Case C 접근성 / aria-label, 엑셀: 두 버튼 통합 / Case D 승격 / gradient 정책 / disabled 중복호출 / 동사형 카피 / tooltip, 페이지 크기: ladder 외 옵션 / 100+ virtual / reset / segmented 강조색 / auto-fit info / aria-label) + 공통 시안 디폴트 정합.
  - `docs/admin-fe-preview.html` 5c 섹션 `#toolbar` 신설(TOC 추가) — 9개 케이스 row 모두 인터랙티브 specimen으로 렌더, 시안 dropdown에 연동되는 `TOOLBAR_DEFAULT` 매핑(`renderToolbarDefault(slug)`)으로 우측 hint에 활성 시안 디폴트 자동 표기. CSS는 `.toolbar-grid`/`.toolbar-row`/`.search-input` (.case-a/b/c) + `.segmented` + `.auto-fit-tag` + `.export-progress` 스피너 신설. JS `node --check` 통과.
  - DESIGN.md frontmatter `last_updated` 2026-05-16 → 2026-05-18.

- `docs/business-logic-playbook.md` §5 확장 + `templates/business-logic-request.md` 작성 예시 보강 — build/docker/git 단계별 시나리오. (2026-05-16)
  - **§5.1 단계별 실행 흐름**: 6단계 순서(`git status` → lint → unit test → build → e2e → docker rebuild 판단) + 각 단계 통과 기준.
  - **§5.2 Docker rebuild 판단 기준**: 6종 변경 위치 매트릭스(src만 / package.json·lock / Dockerfile / .env / migration / nginx config) + rebuild 필요 여부 + 명령. PR 본문 사유 기록 정책.
  - **§5.3 Git 작업 흐름 시나리오**: 5단계 표준 흐름(base 정렬 → 브랜치 생성 → commit → push 전 점검 → push/PR) 실제 bash 명령 + push 전 6종 체크리스트 + rebase 충돌 대응 + `--force-with-lease` 정책(main/develop 금지).
  - **§5.4 실패 케이스 대응**: 7종 실패 유형(lint/test/build 타입/build 번들/docker/push 거부/CI) 별 근본 원인 해결 가이드. skip/우회 코드 금지 정책.
  - `templates/business-logic-request.md` 작성 예시의 `## 검증 계획` 한 줄(`pnpm test && pnpm build`)을 5단계 흐름 + Docker rebuild 판단 사유로 확장. `## Git 작업 계획`도 시작/작업 중/push 전 점검/PR 본문 필수 항목으로 세분화.
  - 156줄 → 244줄 playbook, 86줄 → 114줄 template.
  - STATE.md `## 다음 작업`에서 비즈니스 로직 build/docker/git 시나리오 항목 제거.

- `docs/i18n-guidelines.md`에 구현 예시 §10~§13 추가 — 디렉터리 배치 / 키 네이밍 / fallback 코드 / CI 체크리스트. (2026-05-16)
  - **§10 디렉터리 배치 패턴**: namespace-split(권장, 중대형) / locale-flat(MVP) / feature-co-located(monorepo) 3종 + 각 트레이드오프.
  - **§11 키 네이밍 구조**: dot-nested + snake_case + 깊이 4 한도 / plural(i18next suffix or ICU) / interpolation 정책.
  - **§12 fallback 코드 샘플** 3종: (a) Next.js App Router + next-intl(`getRequestConfig` + middleware subpath), (b) react-i18next(`fallbackLng` chain per locale + missing key handler + CI 키 diff 스크립트), (c) vanilla Intl(라이브러리 없는 fallback chain 함수).
  - **§13 CI 운영 체크리스트** 5종: 키 diff 0 / 하드코딩 검출 / namespace 갱신 / subpath 라우팅 정합 / interpolation 변수명 일치.
  - 58줄 → ~280줄. 기존 1~9 추상 정책은 그대로 유지하고, 10번부터 실행 가능한 구현 예시로 확장.
  - STATE.md `## 다음 작업`에서 i18n 항목 제거.

- `docs/ui-decisions.md` 템플릿 신설 + `development-process.md` 단계 6 동기화. (2026-05-16)
  - 신규 `docs/ui-decisions.md` — 11개 섹션(디자인 시스템 선택 / UI 톤 / 핵심 흐름 / 화면 상태 / 접근성 / 모달 / 반응형 / 폼 / 데이터 테이블 / 컴포넌트 변형 / 카피 톤) + 변경 이력 + 작성 예시. `templates/startup-checklist.md` 섹션 3~5 + `data-table-density.md` 등 UI 결정 일괄 통합.
  - `docs/development-process.md` 단계 6 문구 갱신: "현재 파일이 존재하지 않으며 필요할 때만 신설" → "본 템플릿 사용". 동기화 운영 메모 삭제(템플릿 존재로 해결됨).
  - `AGENTS.md ## Context Map`의 디자인 라우팅에 UI Decisions 템플릿 한 줄 추가.
  - `CLAUDE.md ## Repo Map` 갱신: templates 13종 → 14종(`data-table-density.md` 포함), docs 라우팅에 `ui-decisions.md` 추가.
  - `.claude/plugins/manifest.json supporting.docs`에 `docs/ui-decisions.md` 등록 (admin-fe-preview.html 다음, plugin-guide.md 이전).
  - STATE.md `## 다음 작업`의 ui-decisions.md 항목 제거.

- design-reviewer 서브에이전트에 Wide Table 위반 검출 항목 추가. (2026-05-16)
  - **A-6 (시안 무관 일반 규칙)** 신설 — `### data-table` 밀도와 Wide Table Cases 정합. 11종 검사 항목:
    - 차단: cell padding ≤ space-8, 비-4의 배수 padding(6/10/14), row < 36, 컬럼 ≥13에서 좌측 sticky 누락 + 가로 스크롤, Case C/D 스크롤 단서 누락, Case D에서 컬럼 가시성 토글 누락, zebra striping 도입.
    - 경고: 컬럼 ≥9에서 padding 미축소, row ladder 외 값(40/46/50), compact 채택 시 caption1 다운 미테스트, density intake 양식 미작성.
  - **B-6 (시안별 정책 규칙)** 신설 — Wide Table 시안별 스크롤 affordance 정합. `policy.gradient_locations`에 `"table-fade-edge"` 없는 시안(wanted/minimal-mono/material-3)에서 fade-edge gradient mask 사용 시 차단. 시안별 대체 affordance(border, inset shadow, state-layer) 호출 검증. linear-like alpha 강도 light/dark 분기 검증.
  - 본 추가로 design-reviewer는 PR diff에서 Wide Table Cases 양식 미준수와 시안 정책 외 fade-edge 사용을 자동 검출 가능.

- admin-fe-preview.html에 Wide Table Cases specimen 추가 — Case B(컴팩트 11컬럼) + Case C(와이드 13컬럼 + sticky 좌2/우1 + 가로 스크롤) 비교 카드 신설. (2026-05-16)
  - `#widetable` 섹션 신설(TOC 등록), data-table과 dashboard 사이에 배치.
  - CSS: `.table.compact`(row 44 + padding `{spacing.space-12}`), `.wide-frame` + `.wide-scroll`(max-height 280, overflow-x auto), `.table-wide`(min-width 1280, white-space nowrap), `.sticky-l1`(40px checkbox) + `.sticky-l2`(주문번호) + `.sticky-r1`(액션) sticky 위치 + z-index 매트릭스(thead 4, tbody 3).
  - 5개 시안별 affordance를 `[data-design]` 셀렉터로 분기:
    - `wanted`: box-shadow 1px border-default
    - `minimal-mono`: box-shadow 1px border-strong + 4px blur inset shadow
    - `toss-like`: ::after pseudo 8px linear-gradient mask (oklch 0 0 0 / 0.12)
    - `material-3`: ::after pseudo 4px brand alpha overlay (oklch 0.460 0.155 295 / 0.12)
    - `linear-like`: ::after pseudo 8px linear-gradient mask, light(0.28)/dark(0.20) 분기
  - JS: `CASE_C_AFFORDANCE` 매핑 + `renderCaseCAffordance(slug)` 함수 추가, `setDesign()`에 호출 연결. specimen 하단 `#case-c-affordance` 텍스트가 시안 변경 시 affordance 설명을 자동 갱신.
  - 검증: JS 구문 `node --check` 통과. HTML 102KB → 104KB(+2KB).

- wide data-table fade-edge 정책 5개 시안 일괄 합의 + DESIGN.md 시안별 affordance 매트릭스 + preview policy chip 동기화. (2026-05-16)
  - 정책 매트릭스: `toss-like`/`linear-like` 2개 시안만 fade-edge gradient mask 허용(`gradient_locations`에 `"table-fade-edge"` 추가), `wanted`/`minimal-mono`/`material-3` 3개 시안은 시안별 정책에 정합한 대체 affordance 채택.
    - `wanted`: sticky 컬럼 경계 1px `{colors.border-default}` 강조 (chrome 외 grad 금지 정책 유지)
    - `minimal-mono`: 1px `{colors.border-strong}` + 우측 inset shadow-1 4px (`gradient_locations: []` 정책 유지)
    - `material-3`: state-layer 8% brand alpha overlay 좌/우 4px 정적 (M3 state layer 정합, `gradient_locations: []` 유지)
    - `toss-like`: `gradient_locations: ["hero", "table-fade-edge"]` 4px 좌/우 mask
    - `linear-like`: `gradient_locations: ["accent", "hero", "table-fade-edge"]` 4px 좌/우 mask (다크 캔버스 친화)
  - `DESIGN.md ### data-table > #### Wide Table Cases` 매트릭스 갱신: Case C/D 운영 규칙에서 fade-edge 단일 옵션을 시안별 분기 표(5종)로 확장. 케이스 매트릭스의 affordance 문구를 "시안별 분기, 아래 표 참조"로 일반화.
  - `designs/wanted.md`, `designs/minimal-mono.md`, `designs/material-3.md` Known Gaps에 fade-edge 정책 항목 신설(대체 affordance 명시).
  - `designs/toss-like.md`, `designs/linear-like.md` Brand & Style 단락에 fade-edge 허용 사유 추가.
  - `docs/admin-fe-preview.html DESIGNS` 객체의 toss-like/linear-like `gradient_locations` 동기화 → 활성 시안 전환 시 policy chip이 새 키워드 자동 노출.
  - 5개 시안 frontmatter `last_updated` 일괄 2026-05-16 갱신.

- data-table Wide Table Cases 매트릭스 + density intake 템플릿 신설. (2026-05-16)
  - `DESIGN.md ### data-table` 끝에 `#### Wide Table Cases` 신설 — 컬럼 수/밀도 기준 4-케이스(A 표준 ≤8 / B 컴팩트 9~12 / C 와이드+sticky 13~18 / D 초과밀도 19+) 매트릭스 + 운영 규칙(`{spacing.space-8}` 이하 금지, 36px 미만 row 금지, 좌측 sticky 최소 1컬럼, 시각 단서 필수) + 5개 시안별 디폴트 케이스 매핑(linear-like만 B 디폴트, 나머지 A).
  - `templates/data-table-density.md` 신규 — 8개 섹션 양식(화면 컨텍스트, 컬럼 구성, 밀도/행 정책, 케이스 선택, 가로 스크롤 정책, 컬럼 가시성/저장, 빈/오류/로딩, 합의·기록) + 14컬럼 주문 리스트(Case C) 작성 예시.
  - `docs/admin-fe-design-guide.md ## 리스트 페이지 패턴`에 Wide Table Cases 링크 한 줄 추가(컬럼 ≥9 또는 "여백 과다" 호소 시 4-케이스 매트릭스 호출).
  - `DESIGN.md` frontmatter `last_updated` 2026-05-15 → 2026-05-16.
  - `.claude/plugins/manifest.json supporting.templates`에 `data-table-density.md` 등록(qa-intake와 feature-request 사이).
  - 배경: 사용자가 admin 페이지 여백 과다 + 컬럼 다수 케이스에서 어떻게 요구사항을 확인할지 케이스 사례 선택 양식이 필요하다고 요청. 임의 padding 축소 방지를 위해 사다리(`space-16/12`)만 사용 + 시안별 디폴트와 케이스 선택을 분리.

- v2-3 + v2-4: 시안별 시그너처 시각화 + 화면 조립 비교 가이드. (2026-05-15)
  - `docs/admin-fe-preview.html`에 `## 시안 시그너처` 섹션 신설(`#signature`). 시안별 차별화를 활성 시안 dropdown에 연동된 specimen으로 시각화.
    - wanted: 채용보상금 잡카드(우측 하단 fg-brand 강조)
    - minimal-mono: 색 없는 size+weight+underline 타이포 위계
    - toss-like: hero gradient banner + amount input(tabular-nums, 32/700)
    - material-3: 5종 button variant(filled/tonal/elevated/outlined/text, radius-full + +0.10em letter-spacing) + elevated card(shadow-2)
    - linear-like: kbd 단축키(⌘K/⇧⌘P/Esc) + gradient accent(CTA + 강조 텍스트 background-clip)
  - CSS `[data-design]` 속성 분기로 활성 시안 시그너처만 표시. HTML 74KB.
  - `docs/admin-fe-design-guide.md`에 `## 시안별 화면 조립 차이` 섹션 신설. login/dashboard/list/상세/폼 5개 화면 패턴별 5개 시안 비교 매트릭스 + 시안 선택 가이드(프로젝트 유형 5종 매핑) + 시안 변경 안전 범위 4종 점검 항목.

- v2-5/v2-6/v2-7/v2-8 + 검수 후속: preview/가이드/fallback/카탈로그 정합 보강. (2026-05-15)
  - **v2-5**: `admin-fe-preview.html`에 `## atomic 7종` 섹션 신설. button(5 variant × 4 size) / input(4 state) / badge / chip / avatar / icon-button / icon 시안별 차이 한 페이지 비교.
  - **v2-6**: `admin-fe-design-guide.md` 본문 prose 일반화. 1차 원칙을 "시안 무관" + "시안 정책에 따라 분기" 2 그룹으로 재구성. 카피 톤 체크리스트를 ko-friendly / ko-formal / en-sentence 3종 매트릭스로 확장.
  - **v2-7**: `_alias-contract.md ## 9b` 섹션 신설(시안 전용 토큰 fallback 매핑 표 + ladder 변수 정책). `admin-fe-preview.html` `:root` 공통 블록에 catalog-only fallback 변수(`--radius-6/20/28`, `--shadow-3/4/cta`, `--font-mono`) 추가.
  - **v2-8**: `design-reviewer` 서브에이전트(general-purpose) 호출하여 5개 카탈로그 self-review 실행. 핵심 결함 6종 검출(catalog-only 토큰 CSS Variables surface 누락, alias 카운트 표기 오류 32→25, dark synthesized 마커 누락, wanted catalog-only ladder Known Gaps 누락).
  - **v2-8 후속**: 검출된 critical 이슈 일괄 수정.
    - alias 카운트 32→25 정정 (`_alias-contract.md`, `STATE.md`, `startup-checklist.md`, `design-reviewer.md`, `design-guidelines.md` 5개 파일).
    - `_alias-contract.md ## 9b` fallback 표에 wanted catalog-only 토큰(`--radius-6/10/20/24/32`, `--shadow-3/4`, `--border-inverse`, `--fg-link`) 추가, ladder 변수 ship 방식(a) 시안별 자체 정의 vs (b) 공통 root 의존 정책 명시.
    - `wanted.md` Known Gaps에 catalog-only ladder + color/border + shadow-3/4 명시 + CSS Variables 블록에 누락 토큰 8종 surface.
    - 4개 카탈로그(`minimal-mono`, `toss-like`, `material-3`, `linear-like`) CSS Variables 블록에 spacing 14종 + radius ladder + 각 시안의 catalog-only 토큰 일괄 surface. dark 블록의 `fg-success/warning/danger` 등 합성 alias에 `/* synthesized */` 마커 명시.
    - 재검수 자동화: 5개 카탈로그 모두 `--space-16`, `--radius-8`, 각 catalog-only 토큰 surface 검증 통과. select-design.sh 활성화/복귀 정상.
  - 라이브러리 v2 인프라 + 시각화 + 정합 보강 완료. preview HTML 86KB, 카탈로그 평균 1100줄.

- v2-2.4: linear-like 시안 라이브러리 추가. (2026-05-15)
  - `designs/linear-like.md` 신규 — productivity/issue tracker 톤. **dark 1차** + gradient accent 적극(`policy.gradient_locations: ["accent", "hero"]`) + 카드 그림자 금지(`policy.shadow_on_cards: false`) + 컴팩트 밀도(button md 32, input 32, body1 14, sidebar 220) + en-sentence 영문 카피.
  - brand는 gradient pair(violet→teal). accent gradient는 CTA hover/강조 텍스트/selection에 적극 사용, hero gradient는 마케팅 1곳.
  - 시안 전용 추가 토큰: `radius-6`(input/button md 디폴트), `mono` typography variant(JetBrains Mono/SF Mono), `kbd` 컴포넌트(키보드 단축키 표기). alias 계약 외 항목으로 Known Gaps에 명시.
  - CSS 변수 단일 값으로는 gradient 표기 불가 → preview HTML은 solid brand로 fallback, accent gradient는 prose 명시.
  - 라이브러리 v1 시드 5종 완성(wanted, minimal-mono, toss-like, material-3, linear-like). 5개 시안 모두 select-design.sh로 활성화·복귀 검증 통과.

- v2-2.3: material-3 시안 라이브러리 추가. (2026-05-15)
  - `designs/material-3.md` 신규 — Google Material Design 3 공식 사양 매핑. tonal palette seed(`#6750A4` ≈ oklch(0.460 0.155 295)) 기반 light/dark 시맨틱 alias. elevation 5단(shadow-1~shadow-pop + level 3/4 추가) + button `radius-full` 시그너처 + positive letter-spacing(`+0.03em` ~ `+0.10em`).
  - 영문 sentence case copy tone(`policy.copy_tone: "en-sentence"`) — 본 라이브러리에서 첫 en-sentence 시안.
  - 시안 전용 추가 토큰: `radius-28`(extra-large modal/FAB), `shadow-3`/`shadow-4`(M3 elevation level 3/4), Roboto/Material Symbols 서체. alias 계약 외 항목으로 Known Gaps에 명시.
  - dynamic color seed 변환·ripple motion·state layer는 prose로만 surface(host 앱 구현 영역).
  - `admin-fe-preview.html` 변수 두 블록 inline + DESIGNS 항목 추가. `manifest.json` 등록. select-design 활성화/복귀 검증.

- v2-2.2: toss-like 시안 라이브러리 추가. (2026-05-15)
  - `designs/toss-like.md` 신규 — 한국 핀테크 톤. 단일 강조 파랑(`bg-brand: oklch(0.620 0.180 245)`) + 큰 라운드(`radius-12`~`radius-16`) + 카드 그림자 허용(`policy.shadow_on_cards: true`) + 마케팅 hero gradient(`policy.gradient_locations: ["hero"]`).
  - 시안 전용 추가 토큰: `radius-20`(modal/xl 카드), `shadow-cta`(brand color glow), `amount` typography variant(tabular-nums + 32/700/1.0). alias 계약 외 항목으로 Known Gaps에 명시.
  - 모바일 우선 — 컴포넌트 height 한 단계 큼 (button md 44, input 52, avatar 40, icon-button 40). touch target 48 권장.
  - `admin-fe-preview.html`에 toss-like 변수 두 블록 + DESIGNS 객체 항목 추가. dropdown에서 wanted/minimal-mono/toss-like 토글 동작.
  - `manifest.json designs.files` 등록.

- v2-2.1: minimal-mono 시안 라이브러리 추가. (2026-05-15)
  - `designs/minimal-mono.md` 신규 — self-contained 합성 catalog. 흑백 단색 + 평면 표면 + 헤어라인 보더 + 단색 brand(가장 진한 neutral). gradient 전면 금지(`policy.gradient_locations: []`). 4의 배수 정규화(button sm radius 4, lg 8 — Wanted의 6/10 로컬값 제거).
  - 필수 7종 컴포넌트 + admin 5종 시그너처 + Do/Don't + light/dark CSS Variables 32+14+6+elevation 정의.
  - alias 계약 검수 체크리스트 8종 통과(색 32종, ladder 누락 없음, 컴포넌트 7종, policy 5종 frontmatter, last_updated, STATE 기록 포함).
  - `admin-fe-preview.html`에 minimal-mono CSS 변수 두 블록 inline + DESIGNS 객체에 항목 추가. dropdown에서 wanted ↔ minimal-mono 토글 동작. policy chip이 "gradient: 전면 금지"로 정상 표시.
  - `manifest.json designs.files`에 minimal-mono 등록. install dry-run에 포함.
  - 검증: `select-design.sh minimal-mono` 활성화 → DESIGN.md == designs/minimal-mono.md 일치, `--list`에서 wanted/minimal-mono 모두 노출, 다시 wanted로 복귀 정상.

- v2-1: admin-fe-preview.html 일반화 + 시안별 CSS Variables 섹션 도입. (2026-05-15)
  - `designs/_alias-contract.md`에 `## 10 CSS Variables 표기 규칙` 섹션 신설. alias→CSS 변수 명명 규칙, `data-design`+`data-theme` 2축 cascade 셀렉터, md fenced css 블록 형식, preview 정합 검증 정책.
  - `designs/wanted.md` 와 `designs/_template.md`에 `## CSS Variables` 섹션 추가. wanted.md frontmatter에 `policy:` 블록 5종(shadow_on_cards/gradient_locations/copy_tone/dark_mode/non_4_spacing) 명시.
  - `docs/admin-fe-preview.html` 리팩터:
    - 기존 `:root[data-theme]` 하드코딩 블록을 `:root[data-design="wanted"][data-theme="light|dark"]` 분기로 교체.
    - 상단 preview-bar에 시안 dropdown(`<select id="design-select">`) 추가. localStorage `admin-fe-preview-design` 키로 선택 유지.
    - preview-bar 아래 `policy-strip` 신설. 활성 시안의 frontmatter policy 5종을 chip으로 자동 렌더링(success/danger/info variant).
    - JS `DESIGNS` 객체에서 dropdown 자동 populate, 시안 변경 시 `data-design` 속성 + policy strip 동기 갱신.
    - JS 구문 `node --check` 통과. HTML 50KB.
  - `docs/admin-fe-design-guide.md`에 preview 시각 확인 섹션 + 시안 추가 절차(3단계) 명시.
  - `docs/design-guidelines.md`에 preview 시각 검증 섹션 추가.

- 디자인 시안 라이브러리 도입(`designs/` 폴더 + select-design.sh + install.sh --design 플래그). (2026-05-15)
  - 신규: `designs/README.md`, `designs/_alias-contract.md`(alias 25종 + 컴포넌트 7종 + policy 5종 계약), `designs/_template.md`(빈 골격), `designs/wanted.md`(기존 DESIGN.md 이전).
  - 신규 스크립트: `.claude/plugins/select-design.sh` — `--list`/`--current`/`<slug>` 모드. DESIGN.md가 라이브러리와 다른 직접 편집 상태면 `DESIGN.md.bak` 자동 백업 후 덮어쓰기.
  - `install.sh` 확장: `--design <slug>` 플래그 (기본 wanted). 설치 마지막에 designs/<slug>.md → DESIGN.md 활성화 + `.claude/.active-design` 마커 생성.
  - manifest.json에 신규 `designs` 섹션(default+files+selector) 추가. 라이브러리 4종 파일 + selector가 install dry-run 73개 대상에 포함됨.
  - `docs/design-guidelines.md`에 라이브러리 사용 흐름 섹션 + install 정책 갱신.
  - `templates/startup-checklist.md` 섹션 3 Q6~Q8을 라이브러리 기반 흐름으로 단순화(목록 확인/활성화 검증/STATE 기록).
  - `templates/ui-intake.md` 사용 디자인 시스템 섹션을 (a) 라이브러리 기본/(b) fork/(c) `_template`에서 신규/(d) override 4분기로 갱신.
  - `CLAUDE.md` Repo Map + Design System 섹션, `AGENTS.md` Context Map에 라이브러리/active 정본 구분 명시.
  - `.claude/agents/design-reviewer.md` 일반화: 점검 항목을 A(시안 무관 일반 — alias 계약/ladder/다크 누락)와 B(시안별 정책 — frontmatter `policy:` 블록과 `## Do's and Don'ts` 자동 적용)로 분리. Wanted 고유 규칙(잡카드 채용보상금, blue-800 focus ring, gray-* 패밀리 차단)은 B 섹션의 시안별 예시로 격하.
  - 로컬 검증: `select-design.sh --list/--current/wanted/_template/nonexistent` 5개 모드 동작 확인. `install.sh --dry-run --design wanted /tmp` 73개 대상 + 활성화 단계 출력 확인. 실설치(`/tmp/test-install-real`) 후 `DESIGN.md == designs/wanted.md` 일치 검증.

- DESIGN.md에 admin/dashboard 표면 컴포넌트 5종(synthesized) 추가 + admin FE 디자인 가이드 작성. (2026-05-15)
  - DESIGN.md `## Components` 섹션 끝에 `### Admin / Dashboard surface 컴포넌트 (synthesized)` 블록 추가.
  - 신규 컴포넌트 5종: `login-layout`, `sidebar-nav`, `top-bar (admin)`, `stat-card (KPI)`, `data-table` — 모두 토큰 호출 형식 + 평면 표면/1px 헤어라인/단일 강조색 정책 준수.
  - DESIGN.md frontmatter `last_updated`를 2026-05-15로 갱신.
  - `docs/admin-fe-design-guide.md` 신규 작성 — 화면 단위 조립 패턴(login, dashboard, 리스트, 상세, 폼, 알림) + 카피 톤 체크리스트 + 데이터 밀도 + 다크 모드 + design skill 연계.
  - `docs/admin-fe-preview.html` 신규 작성 — DESIGN.md 토큰(oklch CSS 변수)을 직접 매핑한 단일 파일 시각화. 색 토큰 swatch + admin 5종 컴포넌트 + 대시보드/리스트 페이지 조립뷰. 라이트/다크 토글, 사이드바 collapse 토글, checkbox 토글 동작. 외부 CDN 의존성 없음. JS 블록 `node --check` 통과.

- todo.md 미완료 12종 일괄 처리. (2026-05-15)
  - install.sh `--dry-run` 검증 — HTML 2종(development-process.html, intake.html) 정상 복사 확인.
  - plugin-guide 디렉터리명 정본을 `claude-agent-templete`(GitHub 저장소명)로 결정. plugin-guide.md 3개 경로 + manifest.json `name` 필드 통일.
  - `docs/development-process.md` Phase 3 단계 6에 `docs/ui-decisions.md` 동기화 운영 메모 추가, STATE.md 다음 작업 항목에도 inline 메모.
  - `templates/ui-intake.md`에 `## 사용 디자인 시스템` + `## 토큰 정책` 섹션 추가 (DESIGN.md 그대로/fork/override 분기, 토큰 기본값 호출).
  - `.claude/skills/{feature,refactor,bugfix}/SKILL.md`에 `## 다른 skill과의 연계` 섹션 추가 (UI 영향 발견 시 design skill로 연계).
  - `templates/qa-intake.md` CI/CD 섹션에 디자인 토큰 외 값 PR 경고 정책 항목 추가.
  - `DESIGN.md` 상단에 외부 인용 의존성 정책 boxed note 추가, `docs/design-guidelines.md` 1차 소스 규칙 보강(외부 URL 재방문 조건 4종 + `[src:N (archived)]` 보존).
  - DESIGN.md frontmatter install 정책: 옵션 B(그대로 복사 + 첫 단계 재작성) 결정. `templates/startup-checklist.md` 섹션 3에 Q6~Q8(디자인 시스템 선택, frontmatter 재작성, STATE.md 기록) 추가.
  - `.claude/hooks/warn-design-tokens.sh` opt-in 가드레일 신규 작성 (hex/비-4 px 검출, 항상 exit 0). `settings.local.json` 기본 미등록, 활성화 방법 `docs/design-guidelines.md`에 명시.
  - `AGENTS.md ## 문서화 원칙`과 `docs/design-guidelines.md ## STATE.md 변경 이력 운영 규칙`에 DESIGN.md 갱신 시 운영 규칙 명시 (last_updated + STATE 변경 이력).

- 문서 자기일관성 정리 + 디자인 시스템 통합을 진행했다. (2026-05-14)
  - 자기일관성 정리:
    - `CLAUDE.md` Repo Map의 서브에이전트 3종 표기를 5종(explorer, code-reviewer, planner, test-runner, feature-dev)으로 정정.
    - `docs/plugin-guide.md` 설치 내용 섹션을 manifest 기준으로 동기화 — L2를 skills/commands로 분리, L4를 5종으로 갱신, supporting 영역 명시.
    - `.claude/plugins/manifest.json` supporting.docs에 누락 자산 3종 추가(`docs/development-process.html`, `docs/intake.html`, `docs/global-claude-md-template.md`).
    - `AGENTS.md` Context Map의 `Constraint 1: 표 금지` 적용 범위를 Context Map 섹션 한정으로 명시 (다른 문서의 표 사용 허용).
    - `docs/development-process.md` Phase 3의 `docs/ui-decisions.md` 빈 참조를 "필요 시 작성"으로 약화.
  - 디자인 시스템 통합:
    - `CLAUDE.md`에 `## Design System` 섹션 신설 (토큰 호출 규칙, Do/Don't 핵심, 카피 톤, 자동 활성화 흐름) + Repo Map에 `DESIGN.md` 추가.
    - `AGENTS.md` Context Map에 `DESIGN.md`, `docs/design-guidelines.md` 라우팅 추가 + Skills Layer를 9종으로 갱신.
    - `.claude/skills/design/SKILL.md` 신규 작성 — UI/디자인 키워드 자동 활성화, DESIGN.md 강제 로드, 토큰 호출 형식 강제.
    - `docs/design-guidelines.md` 신규 작성 — 1차 소스 규칙, alias/atomic 선택 기준, 다크 alias 정책, 새 컴포넌트 추가 절차, Do/Don't 운영, 카피 톤.
    - `agents/executor-agent.md`에 디자인 공통 체크리스트 4종 + `### Design` 작업 유형 체크리스트 추가.
    - `agents/reviewer-agent.md`에 `### Design 리뷰 포커스` 섹션 추가.
    - `agents/researcher-agent.md`의 Feature/Refactor 조사에 DESIGN.md 확인 항목 추가.
    - `.claude/agents/design-reviewer.md` 신규 서브에이전트 — code-reviewer와 직교(병렬 실행 가능)한 디자인 일관성 전용 리뷰어.
    - `docs/subagent-guide.md` 디스패치 기준에 design-reviewer 추가.
    - `templates/feature-request.md`에 `## 디자인 토큰 참조` 섹션 추가.
    - `.claude/plugins/manifest.json`에 디자인 자산 4종 등록(L1 DESIGN.md, L2 design SKILL, L4 design-reviewer, supporting design-guidelines.md). JSON 유효성 검증 통과.

- Layer 4 서브에이전트를 이미지 비전 기준 5종 체제로 확장했다. (2026-05-13)
  - `test-runner.md` 신규: 테스트 실행/실패 분석 위임 (general-purpose 타입)
  - `feature-dev.md` 신규: end-to-end 기능 구현 위임 (general-purpose 타입)
  - `reviewer.md` → `code-reviewer.md` 이름 변경: 역할 명확화 (repo conventions 검토)
  - 참조 문서 갱신: `CLAUDE.md`, `AGENTS.md`, `manifest.json`, `docs/subagent-guide.md`
  - 최종 구성: explorer, code-reviewer, planner, test-runner, feature-dev (5종)

- Skills Layer를 `.claude/commands/`(slash command)에서 `.claude/skills/<name>/SKILL.md`(자연어 자동 활성화) 구조로 전환했다. (2026-05-13)
  - 8개 skill 디렉터리에 SKILL.md 작성: `start`, `request`, `feature`, `bugfix`, `refactor`, `review`, `business-logic`, `intake`.
  - 각 SKILL.md의 description 필드에 한국어+영문 트리거 키워드 병기.
  - 우선순위 규칙: 명확한 유형 키워드는 개별 skill, 모호하면 `request` skill 활성화.
  - skill 연계 흐름: `start` → `intake` 또는 개별 작업 skill로 자연스러운 전환.
  - `$ARGUMENTS` 참조 제거 → "사용자 메시지에 ~ 있으면" 자연어 파싱 방식으로 재설계.
  - SKILL.md 내 slash command 참조(`/feature`, `/intake` 등)를 "해당 skill이 활성화된다" 표현으로 대체.
  - `.claude/commands/` 8종은 명시적 호출용으로 병존 유지 (역할 분리).
  - 루트 문서 4종(`CLAUDE.md`, `AGENTS.md`, `README.md`, `STATE.md`)과 `manifest.json`, `docs/subagent-guide.md`에 변경 반영.
  - intake 토픽 매핑 12종이 실제 `templates/*-intake.md` 파일 존재와 1:1 일치함을 검증.
  - `settings.local.json`은 skills 관련 별도 설정 불필요(SKILL.md 파일 존재만으로 자동 활성화)임을 확인.
  - `docs/subagent-guide.md`에 Skills vs 서브에이전트 역할 구분 섹션 추가.

- Skills Layer (L2) 구현: `.claude/commands/`에 커스텀 slash command 8개를 추가했다. (2026-05-12)
  - 오케스트레이터 3종: `start.md` (프로젝트 QnA), `intake.md` (12종 intake 라우터), `request.md` (작업 유형 라우터)
  - 개별 요청 5종: `feature.md`, `bugfix.md`, `refactor.md`, `review.md`, `business-logic.md`
  - 각 커맨드는 `templates/`의 원본을 읽어서 대화형으로 진행. 템플릿 내용을 중복하지 않음.
  - `CLAUDE.md`에 Skills Layer 섹션 추가, `AGENTS.md` Context Map에 커맨드 라우팅 추가.
  - `README.md` 사용 방법을 커맨드 중심으로 업데이트하고 커스텀 커맨드 섹션 추가.

- Hooks Layer (L3) 구현: `.claude/hooks/`에 가드레일 스크립트 3개를 추가했다. (2026-05-12)
  - `block-destructive.sh`: `rm -rf`, `git reset --hard`, `git push --force`, `git clean -f`, `git checkout .` 차단
  - `block-secret-files.sh`: `.env`, `*.pem`, `*.key`, `credentials.json` 등 비밀 파일 쓰기 차단
  - `state-reminder.sh`: `git commit` 시 STATE.md 미갱신 경고 (차단하지 않음)
  - `.claude/settings.local.json`에 PreToolUse hooks 등록 완료.
  - `CLAUDE.md`에 Hooks Layer 섹션 추가, `AGENTS.md` Context Map에 hooks 라우팅 추가.

- L1 CLAUDE.md 재구조화: "에이전트 헌법" 패턴으로 개편했다. (2026-05-13)
  - AGENTS.md에서 Core Philosophy, Golden Rules, 커뮤니케이션, 검증 원칙을 CLAUDE.md로 이동.
  - CLAUDE.md에 Architecture Rules, Naming Conventions, Test Expectations, Repo Map 신규 섹션 추가.
  - AGENTS.md에 헌법 역참조 추가, Context Map 설명 업데이트.
  - `docs/global-claude-md-template.md` 생성 (글로벌 `~/.claude/CLAUDE.md` 템플릿).

- Plugins Layer (L5) 구현: `.claude/plugins/`에 배포 도구를 추가했다. (2026-05-13)
  - `manifest.json`: 전체 레이어 파일 목록과 메타데이터 (name, version, layers, supporting)
  - `VERSION`: 1.0.0
  - `install.sh`: 대상 프로젝트에 파일 복사 스크립트 (--force, --dry-run 지원)
  - `docs/plugin-guide.md`: 설치/업데이트/커스텀/버전 관리 가이드
  - `CLAUDE.md`에 Plugins Layer 섹션 추가, `AGENTS.md` Context Map에 라우팅 추가.
  - `README.md`에 "다른 프로젝트에 설치" 섹션 추가.

- Subagents Layer (L4) 구현: `.claude/agents/`에 서브에이전트 프롬프트 템플릿 3개를 추가했다. (2026-05-13)
  - `explorer.md`: 조사/탐색 위임용 (Explore 타입, researcher-agent.md 참조)
  - `reviewer.md`: 리스크 점검 위임용 (general-purpose 타입, reviewer-agent.md 참조)
  - `planner.md`: 구현 계획 위임용 (Plan 타입, main-agent + executor-agent 참조)
  - `docs/subagent-guide.md`에 디스패치 테이블 섹션 추가.
  - `CLAUDE.md`에 서브에이전트 템플릿 섹션 추가, `AGENTS.md` Context Map에 라우팅 추가.

- `templates/` 18개 파일에 작성 예시 섹션을 일괄 추가했다. (2026-05-06)
  - request 5종(`feature`, `bugfix`, `refactor`, `review`, `business-logic`): 각 파일 말미에 시나리오형 작성 예시 추가.
  - 짧은 intake 6종(`api`, `error`, `form`, `qa`, `routing`, `format`): 답변 예시 추가.
  - 중간 intake 5종(`ui`, `responsive`, `project`, `tech`, `i18n`): 답변 예시 추가.
  - `framework-structure-intake.md`: feature-first hybrid 구조 예시 추가.
  - `startup-checklist.md`: "결과 요약 작성 예시" 섹션을 11개 섹션 답변이 채워진 형태로 추가.
  - 결정: 프로젝트 유형(rider 운영 대시보드)을 기본 시나리오로 통일해 templates 간 일관성 유지.

- `docs/project-guide-template.md`에 작성 예시(Worked Example)와 변환 절차 요약을 추가했다. (2026-05-06)
  - "rider 운영 대시보드 MVP" 시나리오로 1~12 섹션 전체를 채운 산출물 형태 예시.
  - intake 템플릿(`project-intake`, `startup-checklist`, `ui-intake`, `responsive-intake`, `tech-intake`, `i18n-intake`, `framework-structure-intake`)과 본 가이드 섹션 간 매핑 표.
  - 비어 있는 입력은 "미정"으로 두지 말고 `## 3. Open Questions`로 옮기는 규칙 명시.

- `agents/*.md`를 작업 유형 축으로 구체화했다. (2026-05-06)
  - `main-agent.md`: `## 작업 유형 식별 가이드` 섹션 추가. feature/bugfix/refactor/business-logic/review 5종 templates와 1:1 매핑 표 + 복합 요청 처리 규칙.
  - `executor-agent.md`: `## 작업 유형별 체크리스트` 섹션 추가 (feature, bugfix, refactor, business-logic 4종).
  - `reviewer-agent.md`: `## 작업 유형별 리뷰 포커스` 섹션 추가 (feature, bugfix, refactor, business-logic + review 요청 자체 처리).
  - `researcher-agent.md`: `## 작업 유형별 조사 포커스` 섹션 추가 (feature, bugfix, refactor, business-logic, review).
  - 결정: 프로젝트 유형 축(A/B안) 대신 작업 유형 축(C안)으로 분기. `templates/*-request.md` 5종과 1:1 매칭되어 신규 개념 도입 없이 진행 가능.

- 브라우저 보조 UI를 3단계로 확장했다. (2026-05-04)
  - A: `README.md`에 "브라우저 UI" 섹션과 1차 소스 규칙을 추가했다. `AGENTS.md`에 `HTML UI 운영 규칙` 섹션을 신설하고 Context Map에 `docs/intake.html` 라우팅을 추가했다.
  - B: `docs/development-process.html`에 진행률 카드(`localStorage` 저장, 초기화/모두 펼치기 버튼), 운영 규칙 안내 배너, intake CTA, STATE 미니 대시보드(STATE.md fetch 또는 텍스트 붙여넣기로 H2 섹션 파싱)를 추가했다. Phase 펼침 상태도 `localStorage`에 저장한다.
  - C: `docs/intake.html`을 신규 작성했다. Startup QnA 11섹션 위저드와 feature/bugfix/refactor/review/business-logic 5종 요청 템플릿을 폼으로 채우고 Markdown으로 다운로드/복사한다. 입력값은 폼별 `localStorage` 키에 저장된다.
  - 외부 의존성 없이 단일 HTML 파일로 동작한다. `node --check`로 두 페이지의 JS 블록 구문 검증을 통과했다.
- 기존 `~/projects/riderapp` 폴더를 두 개로 분리했다.
  - `~/projects/claude-agent-template/` (현재 저장소): 범용 에이전트 운영 템플릿
  - `~/projects/rider-platform-docs/`: rider platform 비즈니스 설계 문서 (이후 삭제됨)
- `riderapp-runtime/rules` 심볼릭 링크를 신규 템플릿 저장소로 갱신했다.
- 메모리(`project_riderapp_runtime.md`)를 새 경로 기준으로 갱신했다.
- 루트 `AGENTS.md`를 관제탑 중심 구조로 슬림화했다.
- 루트 `AGENTS.md`에 빠른 읽기 순서 섹션을 추가했다.
- 루트 `AGENTS.md`의 `Context Map`에 `CLAUDE.md`, `docs/codex-reading-order.md`, `docs/subagent-guide.md`, `docs/development-process.md`, `docs/development-process.html` 라우팅을 추가했다.
- 분리본과 원본 파일 무결성 검증 후 원본 `~/projects/riderapp/`을 삭제했다. (2026-05-04)
- 운영 문서 자기일관성 정리 (2026-05-04):
  - `CLAUDE.md`를 65줄에서 22줄로 축소했다. AGENTS.md와 중복되던 Golden Rules/커뮤니케이션/Operational Commands/Context Map을 제거하고, Claude Code 고유 내용(서브 에이전트 사용 원칙, 공통 규칙 참조 라우팅)만 남겼다.
  - `AGENTS.md` 커뮤니케이션 섹션의 "확인되지 않은 사항은 사실처럼 단정하지 않는다" 항목을 제거했다. 동일 의미 문장이 Golden Rules에 이미 존재한다.
  - `STATE.md`의 과거 기록 중 실제 AGENTS.md 섹션명과 어긋나던 표현을 정정했다. (`Standards & References` 삭제, `공통 코딩 원칙` -> `세부 규칙 위임`으로 보정)
- 워크스페이스 3개 폴더 기준 실행 셋팅을 재확인했다. (2026-05-04)
  - 당시 워크스페이스 폴더는 `claude-agent-template`, `rider-platform-docs`, `riderapp-runtime`이었다. (`rider-platform-docs`는 이후 삭제, 현재는 2-저장소 구조)
  - `claude-agent-template`은 에이전트 운영 규칙/템플릿 저장소이며 실행 앱이 아니다.
  - 실제 실행 대상은 `riderapp-runtime`이다.
  - `riderapp-runtime/rules` 심볼릭 링크가 `/home/skyua/projects/claude-agent-template`을 가리키는 것을 확인했다.
  - `riderapp-runtime`에서 `pnpm typecheck`와 `pnpm build`가 통과했다.
  - 웹 대시보드 실행 명령은 `cd /home/skyua/projects/riderapp-runtime && pnpm dev:web`이며 기본 주소는 `http://localhost:3030`이다.
  - CLI 시뮬레이션 명령은 `pnpm dev:cli simulate simple`이다.
  - 실제 Claude Agent SDK 작업 실행에는 `riderapp-runtime/.env`의 `ANTHROPIC_API_KEY`가 필요하다.

## 전체 CI 배치 대기열

- 공통 템플릿 v3와 연결 프로젝트 적용 작업의 전체 로컬 CI는 사용자 요청에 따라 이번 세션에서 실행하지 않았다.
- 템플릿 자체의 빠른 검증(manifest JSON, managed marker, 신규 설치, 문서 참조, `git diff --check`)은 통과했다. 전체 CI가 필요하면 다음 명시 요청에서 누적 변경 기준으로 별도 실행한다.

## 다음 작업

### L3 가드레일 후속 (2026-07-28)
- ~~**패턴 검사 정확도**: `block-destructive.sh`가 실행되지 않는 인용문·heredoc 본문에도 반응해 오차단된다~~ → 해소 (2026-07-30). 데이터 문맥(heredoc 본문·인용문)을 걷어낸 뒤 검사하고, 인용문이 코드가 되는 셸 호출은 원문을 유지한다. 같은 작업에서 `rm` 탐지 위치 제약도 제거해 `-exec rm -rf`·`sh -c "rm -rf /"` 공백을 메웠다. 회귀 33/33. **남은 한계**: 주석(`#`) 안의 텍스트는 여전히 검사 대상이다(`#`이 URL·포맷 지정자에도 쓰여 일괄 제거가 위험).

### 문서 편집·저장 기능 (2026-07-30, 사용자 결정 대기)

- 가이드 브라우저의 읽기 전용 탐색까지 완료했다. 다음은 편집 화면(파일 미변경) → 저장 기능 순서다.
- 착수 전 결정 필요: ① 편집 범위(이 저장소만 / 연결 프로젝트까지) ② 저장 방식(파일만 / 저장과 동시에 커밋) ③ 새 문서 생성 허용 여부. 권고는 가장 좁은 조합(이 저장소만 · 파일만 저장 · 기존 문서 수정만).
- 근거와 리스크 분석은 위 `## 이번 세션에서 완료한 작업`의 문서 탐색 UI 항목에 정리돼 있다.
- ~~**연결 프로젝트 배선**: `aica2`·`riderapp-runtime`·`skim`·`trippass`·`vwallet` 5곳 `settings` 미등록~~ → 각 프로젝트 진행 시 처리하기로 하여 제거 (2026-07-29)
- **STATE.md 분량**: 700줄 규모로 `CLAUDE.md Core Philosophy`의 500줄 목표를 넘는다. `## 지난 세션 기록`을 별도 아카이브 문서로 분리할지 사용자 판단 필요.

### 디자인 라이브러리 후속 (사용자 검수 대기)
- **2026-05-19 추가**: User FE 반응형판 + **모바일 전용판** 두 세트 모두 시안 검수 대기.
  - 반응형판: `docs/user-fe-preview.html` 브라우저 확인. 상단 셀렉터 시안 5종 × viewport(mobile 360 / tablet 768 / desktop 1280) × light/dark 토글하며 6 컴포넌트 + 7 화면 specimen 점검.
  - 모바일 전용판: `docs/user-fe-mobile-preview.html` 브라우저 확인. 상단 셀렉터 시안 5종 × phone model(iPhone SE 360 / Pixel 7 390 / iPhone 14 Pro Max 430) × light/dark 토글. 7 화면 specimen은 `.phone-frame`(bezel + notch) 적용. 추가 인터랙션 specimen 4종(segmented/swipe-action/pull-to-refresh/native toast).
  - 의도와 다른 부분 발견 시 DESIGN.md `### User FE surface 컴포넌트` 또는 `#### 모바일 전용 인터랙션 패턴` 절, 또는 카탈로그·preview 조정.
- **사용자가 `docs/admin-fe-preview.html` 브라우저 시각 검수 진행 중**. 활성 시안 = `wanted`. dropdown으로 5개 시안 토글하며 의도와 다른 부분 발견 시 토큰값/fallback/시그너처 spec 조정 예정. 검수 결과 받으면 해당 카탈로그 갱신 + STATE 변경 이력 기록.
- 2026-05-18 추가 결과: `검색창 X / 엑셀 다운로드 / 페이지 크기` 3 컴포넌트도 케이스별 선택 가능하게 추가 요청 → `List Toolbar Cases`로 일괄 반영 완료. 검수자는 `#toolbar` 섹션에서 5개 시안 × 9개 케이스 row 확인.
- 2026-05-18 추가 검수 요청: 대시보드/KPI/data-table `여백 최소화 포함` + `검색 필터에 일시 + 엑셀` + `컬럼 필터` + `탭 페이지` 4 매트릭스로 확장 → 모두 반영. preview `#density`/`#filterbar`/`#colfilter`/`#tabs` 4 신규 섹션에서 시안 dropdown 토글로 케이스 비교 가능.
- preview HTML fetch 모델 마이그레이션은 시안 5종 단계에서 보류. 시안 10+ 시점에 재검토(현재 inline 모델 86KB는 충분히 가벼움).
- 라이브러리 v1 시드 5종 완성: `wanted`, `minimal-mono`, `toss-like`, `material-3`, `linear-like`. 추가 시안 요청 시 `designs/_template.md`에서 시작.

### 기존 보류 항목

2026-07-29 세션에서 7건 완료: README 최신화 · 저장소명 표기 정책 확인 · `dev-start`/codex 라우팅(이미 반영) · HTML 검증 스크립트 도입 · `todo.md` 헤더 날짜 · 프레임워크 디렉터리 트리 예시 · `intake.html` 12종 폼. 아래는 낮은 우선순위로 보류 유지.

- 필요하면 `docs/template-usage.md` 또는 예시 프로젝트 문서를 추가한다.
- 필요하면 `docs/codex-reading-order.md`와 루트 `AGENTS.md`의 빠른 읽기 순서 중복을 더 줄인다.
- md → HTML 자동 동기화 스크립트 또는 단일 진입점(`docs/index.html`) 도입을 검토한다. (HTML 인라인 `<script>` 구문 검증은 `scripts/check-html.mjs`로 확보됨.)

## 현재 기준 파일

- 공통 규칙: `AGENTS.md`
- 템플릿 사용 안내: `README.md`
- 상태 인계: `STATE.md`
- Claude Code 운영 설정: `CLAUDE.md`
- 역할별 지침: `agents/main-agent.md`, `agents/executor-agent.md`, `agents/reviewer-agent.md`, `agents/researcher-agent.md`
- Skills (자동 활성화): `.claude/skills/start/SKILL.md`, `.claude/skills/dev-start/SKILL.md`, `.claude/skills/intake/SKILL.md`, `.claude/skills/request/SKILL.md`, `.claude/skills/feature/SKILL.md`, `.claude/skills/bugfix/SKILL.md`, `.claude/skills/refactor/SKILL.md`, `.claude/skills/review/SKILL.md`, `.claude/skills/business-logic/SKILL.md`, `.claude/skills/design/SKILL.md`
- Slash Commands (명시적 호출): `.claude/commands/start.md`, `.claude/commands/dev-start.md`, `.claude/commands/intake.md`, `.claude/commands/request.md`, `.claude/commands/feature.md`, `.claude/commands/bugfix.md`, `.claude/commands/refactor.md`, `.claude/commands/review.md`, `.claude/commands/business-logic.md`
- 가드레일 hooks: `.claude/hooks/block-destructive.sh`, `.claude/hooks/block-secret-files.sh`, `.claude/hooks/state-reminder.sh`, `.claude/hooks/warn-design-tokens.sh` (opt-in)
- hooks 설정: `.claude/settings.local.json`
- 서브에이전트 정의(frontmatter 자동 등록): `.claude/agents/explorer.md`, `.claude/agents/code-reviewer.md`, `.claude/agents/planner.md`, `.claude/agents/test-runner.md`, `.claude/agents/feature-dev.md`, `.claude/agents/design-reviewer.md`
- 플러그인: `.claude/plugins/manifest.json`, `.claude/plugins/VERSION`, `.claude/plugins/install.sh`
- 플러그인 가이드: `docs/plugin-guide.md`
- 요청 템플릿: `templates/feature-request.md`, `templates/bugfix-request.md`, `templates/review-request.md`, `templates/refactor-request.md`, `templates/business-logic-request.md`
- intake 템플릿: `templates/project-intake.md`, `templates/ui-intake.md`, `templates/responsive-intake.md`, `templates/tech-intake.md`, `templates/i18n-intake.md`, `templates/framework-structure-intake.md`, `templates/startup-checklist.md`, `templates/api-intake.md`, `templates/error-intake.md`, `templates/form-intake.md`, `templates/format-intake.md`, `templates/qa-intake.md`, `templates/routing-intake.md`
- 프로젝트 가이드 정본: `docs/project-guide.md`
- guide 템플릿: `docs/project-guide-template.md`, `docs/i18n-guidelines.md`, `docs/business-logic-playbook.md`, `docs/framework-structure-guide.md`, `docs/design-guidelines.md`, `docs/admin-fe-design-guide.md`, `docs/user-fe-design-guide.md`, `docs/user-fe-mobile-design-guide.md`, `docs/ui-decisions.md`
- 디자인 시스템 카탈로그(active): `DESIGN.md`
- 디자인 시안 라이브러리: `designs/README.md`, `designs/_alias-contract.md`, `designs/_template.md`, `designs/wanted.md`, `designs/minimal-mono.md`, `designs/toss-like.md`, `designs/material-3.md`, `designs/linear-like.md`
- 디자인 시안 selector: `.claude/plugins/select-design.sh`
- 운영 아티팩트: `docs/codex-reading-order.md`, `docs/subagent-guide.md`, `docs/development-process.md`, `docs/development-process.html`, `docs/intake.html`, `docs/admin-fe-preview.html`, `docs/user-fe-preview.html`, `docs/user-fe-mobile-preview.html`
- 검증 스크립트: `scripts/check-html.mjs` (HTML 인라인 `<script>` 구문 검사, Node 내장 모듈만)
- Codex 레이어: `.codex/README.md`, `.codex/workflows/start.md`, `.codex/workflows/dev-start.md`, `.codex/workflows/intake.md`, `.codex/workflows/feature.md`, `.codex/workflows/bugfix.md`, `.codex/workflows/refactor.md`, `.codex/workflows/review.md`, `.codex/workflows/business-logic.md`, `.codex/workflows/design.md`, `.codex/checks/safety-checklist.md`, `.codex/checks/finish-checklist.md`
- 런타임 앱: `../riderapp-runtime/` (sibling 저장소)

## 주의 사항

- 이 저장소의 목적은 `런타임 멀티 에이전트 앱` 구현이 아니라 `개발 프로젝트용 에이전트 운영규칙 템플릿` 정리다.
- rider platform 비즈니스 도메인 설계 문서는 이 저장소에 두지 않는다.
- 이후 코드 파일을 추가하더라도 공통 규칙과 템플릿 문서의 목적을 흐리지 않도록 유지한다.

## 알려진 TODO

- 프로젝트별 커스텀 항목 체크리스트 추가
- 세션 종료 시 상태 업데이트 예시 추가
- 필요 시 역할별 금지 사항 섹션 강화
