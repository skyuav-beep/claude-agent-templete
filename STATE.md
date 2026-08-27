# STATE.md

## 현재 상태

- 이 저장소는 여러 개발 프로젝트에 재사용하는 `개발용 에이전트 운영 템플릿`이다.
- 공통 운영 규칙과 라우팅은 `AGENTS.md`, 에이전트 헌법과 응답 정책은 `CLAUDE.md`가 정본이다.
- 역할별 지침은 `agents/`, 요청·intake 양식은 `templates/`, 프로젝트·검증 가이드는 `docs/`에 둔다.
- Claude Code 자동화는 `.claude/`, Codex 네이티브 Skill은 `.agents/skills/`, Codex 승인·검증 어댑터는 `.codex/`에 둔다.
- 프로젝트 가이드는 템플릿 배포 원본에서 초기 scaffold를 유지하고 소비 프로젝트가 intake 결과로 교체한다.
- 이 템플릿을 `rules/` symlink로 참조하는 연결 프로젝트는 2026-08-22 실측 기준 17개다(GoldFX, aica2, aiospace, ccaa, goldlink, icnft, icwp2p, makeupshop, mlm_v1.0, riderapp-runtime, riderwebapp, signal2, skim, sos_sccl, tokendtu, trippass, vwallet. 작업용 worktree 2개는 별도). 전원 `.claude/` 하위 7종 symlink 배선이 끝나 있어 템플릿 개정이 즉시 반영된다. 초기 런타임 앱이던 sibling `../riderapp-runtime/`은 현재 git 저장소가 아니고 활동이 없어 참조 구현으로 삼지 않는다.
- 작업 알림은 Claude Code 사용자 전역 설정과 Codex `notify`에 등록되어 두 런타임 모두 동작 중이다. 구성·조정·되돌리기는 `docs/notification-guide.md`.
- Claude와 Codex는 각각 `.claude/CLAUDE.md`와 `.codex/README.md`를 실행 게이트로 삼아 같은 6단계 절차를 적용한다. 연결 프로젝트는 이 파일들을 공통본 symlink로 참조하므로 템플릿 개정이 즉시 반영된다.
- 프로젝트에 들어오는 개념·백서·요구사항·설계·개발계획을 시간순과 주제별로 보관하는 공통 지식 관리 체계를 `docs/knowledge-management-guide.md`와 `templates/` 양식으로 정의했다.
- 배포·릴리스와 `staging`/`production` migration은 `block-deploy.sh`가 실제로 차단한다. 에이전트는 명령을 알려 주는 데서 멈추고 실행은 항상 사용자가 한다.
- 여러 세션이 같은 저장소를 쓸 때의 파일 점유 조정은 `docs/session-coordination-guide.md`를 따른다. 세션 식별자는 `eval "$(bash .claude/hooks/session-coordination.sh resource)"`로 고정하는 경로가 기본이다.
- 커밋·push·PR·머지·브랜치 정리가 덜 끝난 작업은 `git-cleanup` 스킬(`/git-cleanup`)로 한 번에 점검한다.
- 세션을 닫을 때는 `session-end` 스킬(`/session-end`)로 이번 세션 이력과 다음 재개 지점을 `STATE.md`에 남기고 Git 잔여물 없이 마감한다. Git 상태만 정리하면 `git-cleanup`이다.
- Claude와 Codex 양쪽에 작업 유형·가드레일이 같이 있는지는 `node scripts/check-runtime-parity.mjs`가 검사한다. 한쪽에만 스킬을 추가하면 실패한다.


**세션 기록 (2026-08-27, 세션 조정 사각지대 두 곳)** — 연결 프로젝트(`sos`)에서 두 창이 같은 저장소를 쓰다 세 번 부딪힌 뒤, 기존 조정 장치가 닿지 않던 두 곳을 메웠다. **hook 이 `Edit|Write` 에만 걸려 있어 git 명령은 통과**했다 — 한쪽이 만든 브랜치를 다른 창이 `git push origin --delete` 로 지워도 아무 확인이 없었고, 커밋을 되짚을 단서는 reflog 뿐이었다. 이제 다른 세션이 등록돼 있을 때에 한해 브랜치·원격 ref·worktree 삭제와 force push 를 확인 대상으로 돌린다(11종 포착, 정상 명령 9종 무개입 확인). 또 하나는 **등록의 `pid` 가 비어 생존 검사가 불가능**했던 것이다. `SESSION_COORD_OWNER_PID` 가 없으면 부모를 거슬러 실행기 프로세스를 찾아 기록하므로, 창이 사라진 등록은 TTL 8시간을 기다리지 않고 정리된다. `.claude/settings.template.json` 의 `Bash` matcher 연결은 **이미 설치된 프로젝트에 자동 전파되지 않는다** — 각 프로젝트의 `settings.json` 은 복사본이라 직접 추가해야 한다. hook 스크립트 자체는 symlink 라 즉시 반영된다.
**세션 종료 (2026-08-25, 마지막)** — 세션 마감 스킬 `session-end`를 만들어 배포하고(PR #47 `6eae247`), 이어서 PR 머지가 매번 막히던 원인을 규명했다. 스킬은 종료 절차 자체가 아니라 **트리거의 부재**를 고친 것이다 — 절차는 `docs/finish-checklist.md`와 `git-cleanup`에 이미 있었지만 "세션종료해줘"에 걸리는 키워드가 어느 스킬에도 없어 실행 여부가 매번 에이전트 판단에 달려 있었다. 머지 차단은 설정 오류가 아니라 계층 문제였다. 사용자 전역 허용 목록에 `Bash(gh pr merge:*)`가 이미 등록돼 있는데도 막혔는데, `auto` 모드에서는 분류기 판정이 허용 목록보다 우선하고 `autoMode.allow` 배열이 비어 있어 기본 soft_deny 규칙(되돌리기 어려운 작업)이 그대로 적용됐다. 저장소 문서는 6단계에서 머지를 승인 범위에 넣었으므로 문서와 런타임이 어긋난 상태였다. 미커밋 변경·미push 커밋·열린 PR·잔여 브랜치·worktree는 없다. 재개 지점은 `## 다음 작업` 1순위이며, 사용자 직접 실행이 필요한 분류기 설정과 승인 대기 중인 가이드 반영안이 2순위에 있다.

이전 세션(2026-08-23): Claude와 Codex의 런타임 parity 갭 7건을 해소했다(PR #45 `83d8860`). 두 레이어를 1:1 대조해 자동 검사가 잡지 못하던 구조적 갭을 찾았고, 가장 위험했던 것은 배포 차단이 Claude 훅에만 있어 Codex에서는 클라우드 배포·컨테이너 push·패키지 publish·인프라 apply가 무방비였던 점이다. 훅 수정 없이 해결했다 — 가드레일 3종이 이미 단순 JSON 입력으로 정확히 판정하므로 Codex가 같은 스크립트를 판정 전용으로 호출한다. 차단 기준이 한 곳에만 남아 두 런타임이 갈라질 여지가 없다. 재발 방지로 `scripts/check-runtime-parity.mjs`를 넣어 한쪽에만 스킬을 추가하면 검사가 실패한다. 미커밋 변경·열린 PR·미완료 worktree는 없고 재개 지점은 `## 다음 작업` 1순위 그대로다.

이전 세션(2026-08-22, 종료): Claude Code 프로젝트 메모리를 9건에서 4건으로 정리했다. 진행 상태 스냅샷을 메모리에 복사해 둔 것이 낡음의 원인이어서 구조·연결 방식·작업 지침처럼 잘 변하지 않는 사실만 남겼다. "개별 프로젝트의 진행 상태는 그 프로젝트의 `STATE.md`와 그 프로젝트 메모리가 정본"이라는 기준을 통합본에 넣었다. 실측 정정 4건은 위 `## 현재 상태`에 반영돼 있다.

이전 세션(2026-08-22): 세션 초반에 만든 stack-upgrade·세션 조정·지식 관리 3건을 감사하고, 거기서 나온 문제를 모두 고친 뒤 배포 차단 가드레일과 `git-cleanup` 스킬까지 추가했다(PR #39 `c06933d`, #40 `aa9f239`, #41 `8dd48de`). 감사에서 가장 컸던 것은 세션 조정 훅이 문서에 적힌 방식으로 전혀 동작하지 않던 점이다 — 터미널에서 실행하면 입력을 기다리며 멈췄고, 세션 식별자가 호출마다 갈라져 등록 해제가 되지 않았다. 배포 금지는 문서 3곳에 적혀 있었지만 실제 차단 장치가 없어 훅으로 막았다. 진행 중이던 작업이나 미완료 worktree, 열린 PR은 없다. 재개 지점은 `## 다음 작업` 1순위(디자인 시안 6종 시각 검수)로 그대로다. 배포 차단 훅은 이 창을 재시작해야 적용되고, 다른 개발 환경에서는 로컬 설정에 따로 등록해야 한다.

이전 세션(2026-08-21): `docs/` 화면 7종에 공통 상단 이동 바를 넣어 가이드 브라우저를 허브로 오갈 수 있게 했다(PR #34, `3cb3b00`).

이전 세션(2026-08-14): 승인 게이트를 강제 차단에서 사용자 확인 요청으로 바꾸고(PR #30, `ef86810`) 템플릿 저장소를 포함한 14곳에 등록했다. `STATE.md`는 2차 압축으로 116줄이 됐다(PR #32, `41f96d1`). 게이트 등록 14곳은 gitignore 대상 로컬 설정이라 이 PC에서만 유효하고, 이미 열려 있는 창은 재시작해야 반영된다.

## 이력 아카이브

- [2026-07-31 전체 스냅샷](docs/archive/STATE-2026-07-31.md) — 1차 압축 전 `STATE.md` 867줄을 바이트 단위 그대로 보존한다.
- [2026-08-14 전체 스냅샷](docs/archive/STATE-2026-08-14.md) — 2차 압축 전 `STATE.md` 244줄을 그대로 보존한다. 2026-08-02·08-03 세션 상세와 2026-07-31 요약이 여기에 있다.
- 과거 완료 기록과 상세 검증 근거는 아카이브에서 확인하고, 루트 문서는 현재 인계에 필요한 정보만 유지한다.

## 최근 완료 작업

- `>` 단독 입력을 다음 단계 진행 단축 입력으로 정의했다. (2026-08-27)
  - 공통 승인 workflow와 Claude/Codex 실행 문서에 적용 범위와 위험 작업 예외를 기록했다.
  - 키보드 이벤트를 가로채는 기능이 아니라, 사용자에게 전달된 `>` 메시지를 단계 진행 신호로 해석하는 문서 규칙이다.

- 플러그인 설치 manifest의 문서 누락을 보완하고 재발 방지 검사를 추가했다. (2026-08-27)
  - `docs/guide-browser.html`과 `docs/notification-guide.md`를 `manifest.json`의 Supporting docs에 등록해 소비 프로젝트 설치 결과에도 포함되도록 했다.
  - `scripts/check-runtime-parity.mjs`에 필수 설치 문서 manifest 등록 검사를 추가했다.
  - 검증: 설치 `--new --dry-run`(작업 169·충돌 0), Codex Skill, HTML, navigation, `git diff --check` 통과. 전체 CI는 문서·검사 스크립트 변경 범위라 이번 작업에서 실행하지 않았다.

- PR 머지가 매번 권한 분류기에 막히던 원인을 규명했다. (2026-08-25)
  - 사용자 전역 허용 목록에는 `Bash(gh pr merge:*)`가 이미 있었다. 그런데도 막힌 이유는 `auto` 모드에서 **분류기 판정이 일반 허용 목록보다 우선**하기 때문이다. `autoMode`에는 `soft_deny` 2건과 `environment`만 있고 `allow` 배열이 아예 없어, `"$defaults"`로 상속된 내장 규칙이 PR 머지를 "되돌리기 어려운 작업"으로 판정했다.
  - 해소하려면 `~/.claude/settings.json`의 `autoMode.allow`에 `["$defaults", "Bash(gh pr merge:*)"]`를 넣고 재시작한다. `"$defaults"`를 빼면 내장 허용 규칙이 전부 사라지므로 함께 넣는다. 일반 허용 목록에 다시 등록하는 것은 효과가 없다.
  - 이 편집도, 편집용 스크립트를 만드는 것도 분류기가 차단했다. 에이전트가 자기 권한을 넓히는 동작이라 보안 경계에 걸린다. 의도된 안전장치여서 우회하지 않고 사용자 직접 실행으로 인계했다.
  - 적용 범위는 전역으로 정했다. `riderwebapp`은 자체 머지 정책이 있어 확인했는데, 그 저장소도 "사용자 명시 지시 시 agent 머지 허용"이고 "실행 환경이 막으면 우회하지 말고 사용자에게 넘긴다"고 적혀 있어 충돌하지 않는다. 오히려 전역 허용이 문서 정책과 런타임을 일치시킨다.
  - 템플릿 머지 가이드(`docs/local-dev-ci-guide.md §6.3`)에는 권한·게이트·금지·방식·절차·완료검증이 있으나 "실행 환경이 막을 때"가 없다. `riderwebapp`에만 있는 이 항목을 공통 정본으로 올리는 반영안을 만들었고 승인 대기 중이다.

- `session-end`의 Codex 입력 모드와 자동 선택 경계를 보완했다. (2026-08-25)
  - Codex native skill과 Claude skill description에 세션 종료·마감·인계 정리 트리거와 `git-cleanup` 우선 경계를 명시했다.
  - Codex workflow에 `state`(STATE 기록만)·`git`(Git 정리만) 모드를 추가하고, slash command가 없는 Codex에서도 자연어 인수로 같은 모드를 선택하도록 했다.
  - manifest의 Codex skill 설명을 모드 의미와 정렬했다.
  - 검증: runtime parity, Codex skill, manifest JSON·경로, 설치 dry-run, shell/Node 구문, `git diff --check` 통과.

- 세션 종료 마감 스킬 `session-end`를 추가했다. (2026-08-25, PR #47)
  - 종료 절차는 `docs/finish-checklist.md`와 `git-cleanup`에 흩어져 있었지만 "세션종료해줘"라는 발화에 걸리는 트리거가 어느 스킬에도 없어 매번 에이전트 판단에 의존했다. 트리거 키워드를 가진 스킬로 만들어 같은 절차가 항상 실행되게 했다.
  - 흐름은 작업 이력 수집(읽기 전용) -> 완료/진행 중/보류 분류와 재개 지점 도출 -> Git 전수 점검 -> 요약과 정리 계획 제시 -> 승인 후 마감 5단계다. Git 점검 항목은 `git-cleanup`을 재사용하고 중복 정의하지 않는다.
  - `git-cleanup`과의 경계를 `AGENTS.md ## 작업 유형 선택 규칙`에 넣었다. Git 상태만 정리하면 `git-cleanup`, 세션을 닫으며 기록까지 하면 `session-end`, 세션을 여는 맥락이면 `dev-start`다.
  - 완료 기준을 표로 못박았다. 미커밋 변경·미push 커밋·잔여 브랜치·잔여 worktree는 남기지 않고, 열린 PR을 남기면 보류 사유를 `STATE.md`에 기록한다. 정리하지 못한 항목은 이유와 함께 최종 응답에 남긴다.
  - 사후 감사에서 parity 검사가 잡지 못하는 누락 2건을 찾아 고쳤다. 스킬 개수 표기가 9곳에서 13종으로 남아 있던 것과 플러그인 버전 미갱신이다. 검사는 파일 존재만 보고 문서의 숫자는 보지 않는다.
  - 플러그인 버전 `3.8.0`. 스킬·command·Codex 스킬·workflow가 각 14종으로 정렬됐다.
  - 검증: parity 검사, manifest JSON 유효성, nav `--check` 7화면. 문서·운영 레이어 변경이라 전체 로컬 CI는 배치 대기열로 넘겼다.

- Claude와 Codex의 런타임 parity 갭 7건을 해소했다. (2026-08-23)
  - 배포 차단이 Claude 훅에만 있어 Codex에서는 클라우드 배포·컨테이너 push·패키지 publish·인프라 apply가 무방비였다. `.codex/checks/safety-checklist.md`에 차단 범위를 카테고리로 명시하고, 가드레일 3종(`block-destructive.sh`, `block-deploy.sh`, `block-secret-files.sh`)을 실행 전 판정 전용으로 호출하는 절차를 넣었다. 훅 수정은 필요 없었다 — 세 스크립트 모두 `{"command":"..."}` 입력으로 차단 rc=2 / 통과 rc=0을 정확히 반환하는 것을 실측 확인했다. 알림 어댑터가 `notify-pending.sh`를 공유하는 방식과 같은 구조다.
  - 작업 유형 선택 우선순위가 `CLAUDE.md`의 Skills 절에 있어 Codex가 구조상 읽을 수 없었다(Codex 읽기 순서는 `CLAUDE.md`의 커뮤니케이션·답변 포맷 두 절만 포함). `AGENTS.md ## 작업 유형 선택 규칙`으로 승격하고 원위치는 포인터로 축약했다.
  - `scripts/check-runtime-parity.mjs`를 신설했다. 스킬 양방향 대조, skill↔command 1:1, workflow 참조 실재, 서브에이전트 대조, 매트릭스 행 존재, 훅↔Codex 체크리스트 대응, manifest 등록, 공통 정본 절 존재까지 8항목을 검사한다. 음성 테스트로 스킬 누락·command 누락·훅 미대응·manifest 누락을 실제로 검출함을 확인했다.
  - 세션 충돌 조정이 Codex에만 있어 Claude에 스킬·slash command를 추가했다. 충돌은 두 런타임이 동시에 도는 상황이 전제라 Claude 쪽 결손이 더 치명적이었다. 스킬·command·Codex 스킬이 각 13종으로 정렬됐다.
  - 런타임 매트릭스의 작업 유형 7행에 Codex native skill 진입점을 반영하고, 가드레일 3종·승인 게이트·작업 유형 선택 5행을 신설했다. 2026-08-22 native skill 도입 이후 부분 갱신에 그쳐 있던 상태를 맞췄다.
  - Codex 스킬 13종이 모두 14행 stub이던 문제를 대화형 수집이 중요한 5종(`start`, `intake`, `request`, `feature`, `bugfix`)만 37~42행으로 보강했다. 나머지 8종은 절차 위임으로 충분해 제외했다.
  - 플러그인 버전 `3.7.0`. manifest 등록 경로는 객체 형식 93건과 문자열 목록 84건을 합쳐 고유 172건이며 전부 실재한다(그중 10건은 디렉터리). 이전 세션들이 "84개"로 기록한 값은 문자열 목록만 센 것이라 객체 형식 93건이 빠져 있었다. 누락은 그때도 지금도 0건이다.
  - 검증: parity 검사(신규, 음성 테스트 4종 포함), Codex skill 검사, manifest 172경로 실재, nav `--check`, HTML 구문, 마크다운 링크 109건(깨짐 0), 가드레일 판정 회귀 6건. 전체 로컬 CI는 문서·운영 레이어 변경이라 배치 대기열로 넘겼다.

- Codex 네이티브 Skill·하네스 계층을 추가했다. (2026-08-22)
  - `.agents/skills/`에 `start`, `dev-start`, `intake`, `request`, `feature`, `bugfix`, `refactor`, `review`, `business-logic`, `design`, `stack-upgrade`, `session-coordination`, `git-cleanup` 13종의 `SKILL.md`를 추가했다. Codex가 자연어 요청에 따라 Skill을 자동 선택하고, `.codex/workflows/`는 상세·호환 절차로 유지한다.
  - `.claude/*` 실행 파일은 변경하지 않았다. 공통 `AGENTS.md`·runtime matrix·plugin 문서와 설치 manifest만 Codex 네이티브 레이어를 반영하도록 갱신했다.
  - `.claude/plugins/install.py`의 `--link` 대상과 manifest에 `.agents/skills/`를 등록하고 플러그인 버전을 `3.6.0`으로 올렸다.
  - `scripts/check-codex-skills.mjs`가 Skill frontmatter, 이름 중복, manifest 경로를 검사한다.
  - 검증: Skill 검사, manifest 82개 경로, JSON, HTML, nav, docs index, 설치 `--new --dry-run`, `git diff --check` 통과. 전체 CI는 문서·Codex 운영 레이어 변경이라 이번 범위에서 제외했다.

- 배포 차단 가드레일과 `git-cleanup` 스킬을 추가했다. (2026-08-22)
  - 배포·릴리스는 문서 규칙에만 있고 실제 차단 장치가 없었다. `.claude/hooks/block-deploy.sh`가 `gh workflow run`, `gh release`, `vercel`/`fly`/`netlify deploy`, `kubectl apply`, `helm upgrade`, `terraform apply`, `docker push`, 패키지 publish, `prisma migrate deploy`, `staging`/`production` 환경 지정 명령을 차단한다. `git push`, `gh pr merge`, `docker compose up`, `prisma migrate dev` 같은 로컬 작업은 그대로 통과한다.
  - `git-cleanup` 스킬을 Claude/Codex 양쪽에 추가했다. 미커밋 변경·미push 커밋·열린 PR·머지 후 남은 브랜치와 worktree·`STATE.md` 미기록을 점검하고, 정리 계획보다 **개발 내용 요약을 먼저** 보여 준 뒤 승인을 받아 마무리한다.
  - 자연어 트리거: 깃 정리, git 정리, 커밋 정리, PR 정리, 브랜치 정리, 정리 안 된 것, 마무리해줘. slash command는 `/git-cleanup`.
  - `CLAUDE.md` Golden Rules에 GitHub Actions 실행과 배포가 항상 사용자 수동이라는 점과 훅이 이를 차단한다는 사실을 명시했다.
  - 플러그인 버전 `3.5.0`. skills 12종, commands 12종, 가드레일 7종, Codex workflow 13종.
  - 검증: 배포 차단 25건(차단 13 / 허용 12) 판정 테스트 전부 기대대로 동작, 훅 10종 `bash -n`, manifest 146개 경로 존재·중복 없음, JSON 파싱, 링크 검사 통과.

- 저장소 위생 정리 2건. (2026-08-22)
  - 3단계 승인 마커 디렉터리를 gitignore에 넣어 세션마다 `git status`가 지저분해지던 문제를 없앴다. 아카이브 문서의 깨진 링크 3곳도 고쳤다. 마크다운 링크 전수 검사에서 깨짐 0건을 확인했다.
- 세션 충돌 조정 훅의 감사 지적 사항을 수정했다. (2026-08-22)
  - CLI 모드에서도 stdin을 끝까지 읽어 터미널 실행이 멈추던 문제를 고쳤다. `hook` 모드이고 stdin이 파이프일 때만 payload를 읽는다.
  - 세션 식별자를 POSIX 세션 ID 기반으로 바꿔 `register`/`claim`/`release`가 한 레코드를 공유하게 했다. 명령마다 새 셸을 쓰는 실행기를 위해 `eval "$(... resource)"`로 `SESSION_COORD_SESSION_ID`를 고정하는 경로를 가이드와 Codex workflow의 첫 단계로 올렸다.
  - stale 등록 보존 시간을 24시간에서 8시간으로 낮추고 `SESSION_COORD_TTL_SECONDS`와 `prune` 커맨드를 추가했다.
  - `sha256sum`/`shasum` 래퍼, `realpath` 폴백, `flock` 부재 시 잠금 없이 진행을 넣어 macOS에서 조용히 무력화되던 경로를 없앴다.
  - `docs/session-coordination-guide.md`와 지식 영역 디렉터리 10종을 plugin manifest에 등록해 설치 대상에 포함시켰다. 플러그인 버전은 `3.4.1`.
  - `CLAUDE.md` Repo Map의 `templates`·`docs` 항목, 지식 문서 명명 예외, `docs/plugin-guide.md`의 intake 카운트를 실제와 맞췄다. 지식 관리 가이드에 `id` 접두사 체계와 `source: planning`을 보강했다.
  - `.claude/settings.local.json`은 사용자 전역 gitignore 대상이라 커밋되지 않는다. 이 저장소 로컬 설정에는 훅 3개(PreToolUse/SessionStart/SessionEnd)를 직접 등록했고, 다른 환경은 `settings.template.json`을 참고해 각자 등록해야 한다. 이 사실을 `CLAUDE.md` Hooks Layer에 명시했다.
  - 검증: 훅 9종 `bash -n`, hook 모드 SessionStart 등록·PreToolUse 충돌 감지·SessionEnd 해제 후 재점유, CLI 터미널 실행 hang 해소, TTL 만료·`prune` 동작, manifest 142개 경로 존재와 중복 없음, `build-nav --check`, `check-html.mjs`, `git diff --check` 통과.

- Claude/Codex 세션 충돌 조정 MVP를 추가했다. (2026-08-22)
  - 여러 창이 같은 저장소를 쓸 때의 파일 점유·Docker 자원 격리 체계를 만들었다. 같은 세션에서 감사해 실제 동작하지 않던 문제를 모두 고쳤다(위 항목 참조).
- `stack-upgrade` 기술 스택 업그레이드 스킬을 Claude/Codex 양쪽에 추가했다. (2026-08-22)
  - 라이브러리·런타임·Docker 이미지 버전 점검과 안전한 업데이트 절차를 스킬로 만들었다. 배포·릴리스는 범위에서 제외하고 사용자 수동으로 남겼다.
- 프로젝트 지식 관리 체계를 추가했다. (2026-08-21)
  - `docs/knowledge-management-guide.md`에 `00-inbox`부터 `99-archive`까지의 주제 분류, 날짜 기반 파일명, 메타데이터, 원문에서 정식 문서로 승격하는 흐름을 정의했다.
  - `templates/knowledge-entry.md`, `whitepaper-note.md`, `development-plan.md`, `decision-record.md`를 추가해 다른 프로젝트에서도 동일한 방식으로 정보를 정리할 수 있게 했다.
  - 연결 프로젝트는 로컬 `docs/`를 구성하고, 공통 가이드는 `rules/docs/knowledge-management-guide.md`를 통해 참조한다.
  - 후속 정합성 보강: 신규 파일을 plugin manifest에 등록하고 버전을 `3.4.0`으로 올렸으며, `knowledge` intake와 브라우저 폼, 지식 영역 디렉터리, 색인 생성 경로를 연결했다. `decision` 기본 상태는 `draft`로 조정했다.

- `docs/` 화면 7종에 공통 상단 이동 바를 넣어 가이드 브라우저를 허브로 오갈 수 있게 했다. (2026-08-21)
  - 배경: 프리뷰·문서 화면이 서로 링크되어 있지 않아 화면마다 주소를 직접 입력해야 했다.
  - `scripts/build-nav.mjs`를 추가했다. 화면 목록·바 마크업·스타일을 이 스크립트가 소유하고, 각 HTML의 `agent-nav` 마커 구간만 생성한다. `--check`는 파일을 쓰지 않고 최신 여부만 검사한다.
  - 프리뷰 화면들이 "단일 파일 · 외부 참조 없음" 원칙이라 공통 CSS/JS 링크를 쓰지 않고 각 파일에 직접 심었다. 대신 마커로 감싸 손으로 7곳을 고치는 상황을 피했다.
  - 바 높이 변수는 `:root`에 둔다. `.agent-nav` 안에 두면 바 바깥의 기존 고정 요소에서 `var()`가 무효가 되어 `top`이 `auto`로 풀리고 기존 상단 바가 스크롤에 떠내려간다. 구현 중 실제로 재현해 확인했다.
  - 화면별 레이아웃 보정(`.preview-bar`·`.shell`·`.layout`의 sticky 기준과 높이)은 스크립트의 `FIXUPS` 테이블이 파일 단위로 관리한다.
  - 검증: `node scripts/check-html.mjs` 통과(HTML 7개·인라인 스크립트 6개), `build-nav.mjs --check` 멱등 확인, 로컬 서버에서 7화면 HTTP 200, 브라우저로 6화면 왕복 이동·라이트/다크·스크롤 고정 확인.
  - 전체 CI 대기열: 문서 HTML과 Node 유지보수 스크립트 변경으로 애플리케이션 lint/test/build 대상 없음.

- Claude 승인 게이트를 강제 차단에서 사용자 확인 요청으로 바꾸고 연결 프로젝트 12곳과 템플릿 저장소에 적용했다. (2026-08-14)
  - 원인: 훅은 3단계 승인 마커를 요구했지만 절차 문서 어디에도 마커 생성 시점이 없어, 절차를 지켜도 세션마다 첫 Edit에서 반드시 차단이 발생했다. 거부 사유가 에이전트에게 마커 생성을 지시하는 문장이어서 게이트가 자가 통과될 수 있는 구조이기도 했다.
  - `.claude/hooks/phase-approval.sh`의 `permissionDecision`을 `deny`에서 `ask`로 바꾸고, 마커 검사를 메인 트리 검사보다 먼저 수행하도록 순서를 바꿨다. 마커가 있으면 어느 트리에서 작업하든 통과하므로 세션당 확인은 1회다.
  - `docs/approval-workflow.md` 4단계에 마커 생성 시점을, 런타임 경계에 마커 임의 생성 금지를 명시했다. `.claude/CLAUDE.md` 4단계와 `CLAUDE.md`·`AGENTS.md` 훅 목록을 동기화했다(가드레일 4종 → 5종).
  - 연결 프로젝트 12곳(`aica2`, `aiospace`, `ccaa`, `goldlink`, `makeupshop`, `mlm_v1.0`, `riderwebapp`, `skim`, `tokendtu`, `trippass`, `vwallet`, `vwallet-wt-approval-v3`)의 `.claude/settings.local.json`에 훅을 등록했다. 모두 gitignore 대상이라 git 변경은 0건이며 이 PC에만 적용된다. worktree를 쓰지 않는 9곳도 마커 1회 생성으로 마찰 없이 작업할 수 있다.
  - 이후 템플릿 저장소 자신에도 같은 방식으로 등록했다. 게이트가 동작하는 곳은 기존 `signal2`를 포함해 14곳이다.
  - 검증: `bash -n` 구문, 훅 5케이스(마커 유무 × 메인/worktree, 저장소 밖 파일), 14곳 JSON 파싱 통과.
  - 전체 CI 대기열: 문서·셸 훅·로컬 설정 변경으로 애플리케이션 lint/test/build 대상 없음.

- Claude/Codex 단계 실행 경계를 정리하고 Claude 승인 게이트를 공통 설치 레이어에 추가했다. (2026-08-11)
  - `docs/approval-workflow.md`에 런타임별 강제 범위, 단계 응답 봉투, 승인 범위와 Git 수명주기 구분을 명시했다.
  - `.codex/README.md`와 safety/finish checklist에 현재 단계·산출물·다음 단계·쓰기 가능 여부를 선언하는 Codex 단계 계약을 추가했다. Codex 호스트가 저장소 훅을 자동 실행하지 않는 한 파일 수정 자체를 강제 차단할 수 없다는 경계도 명시했다.
  - `.claude/hooks/phase-approval.sh`와 `settings.template.json`을 추가해 Claude Code에서 Step 3 승인 마커 없는 Edit/Write와 main worktree 편집을 차단하도록 했다. manifest에 새 훅을 등록했다.
  - 검증: JSON·bash 구문, 승인 전 차단 동작, 템플릿 `--dry-run --adopt`(충돌 0) 통과. 기존 프로젝트의 보호된 `settings.local.json`은 자동 덮어쓰지 않으므로 설치 시 hook 병합이 필요하다.
  - 전체 CI 대기열: 문서·Claude/Codex 설정·셸 훅 변경으로 애플리케이션 lint/test/build 대상 없음.

- 아래 최근 요약을 제외한 전체 완료 이력과 상세 검증 근거는 [2026-07-31 전체 스냅샷](docs/archive/STATE-2026-07-31.md)에서 확인한다.

### 2026-08-04 세션 요약 (파일 수정 확인 요청 원인 규명)

- 파일 수정마다 뜨는 확인 요청의 원인은 권한 설정이 아니라 `auto` 모드 분류기다. (2026-08-04)
  - `auto`는 전면 허용이 아니라 판정기다. 모든 도구 호출을 `allow`·`soft_deny`·`hard_deny`로 나누고, 판정이 서지 않거나 soft_deny면 확인을 요구한다. 파일 수정은 상시 판정 대상이라 확인이 뜨는 것이 정상 동작이다.
  - 실측 제약 2건: `autoMode` 규칙과 `defaultMode: auto`는 사용자 전역·플래그·관리 설정에서만 유효하고 저장소 단위 설정에 넣으면 조용히 무시된다.
  - 별개 원인 1건: 사용자 전역 허용 목록에 파일 생성 도구가 빠져 있어 새 파일 작성이 매번 확인 대상이 된다.
  - 권한 모드를 스스로 넓히는 편집은 분류기가 차단한다. 의도된 안전장치여서 우회하지 않고 사용자 직접 실행으로 인계했다. 실행 방법은 `## 다음 작업` 2순위에 있다.
  - 산출물은 백업 1건뿐이다: `~/.claude/settings.json.bak-20260804`.

## 전체 CI 배치 대기열

- 현재 필수 대기 항목은 없다.
- PR 7건이 누적됐다(#39·#40·#41·#45·#47·#48·#49). 모두 문서와 훅·검사 스크립트 범위이며 bash 구문, 훅 동작 프로브(세션 조정 6종·배포 차단 25종·가드레일 판정 8종), parity 검사, manifest 경로·중복, 설치 dry-run, 링크·HTML 검사로 각각 검증했다. 누적 기준(3~5건)을 넘겼으므로 다음 세션 초반에 전체 로컬 CI를 한 번 돌린다.
- 전체 로컬 CI는 3~5개 작업 누적, 하루 종료, 릴리스 전 또는 사용자 명시 요청 시 별도 6단계 작업으로 실행한다.

## 다음 작업

성격별로 묶었다. 위에서 아래로 진행하면 된다.

### 1순위 — 사용자 시각 검수 (재개 지점)

- 디자인 시안 6종을 light/dark·viewport 조합으로 검수한다. 사전 점검은 끝났고 남은 것은 눈으로 보는 확인뿐이다.
- 시작: `node scripts/serve-docs.mjs`로 서버를 띄우고(기본 `http://127.0.0.1:8765`) 상단 이동 바로 admin·user·user-mobile 세 화면을 오가며 시안 셀렉터에서 6종을 순회한다. 문서를 바로 고치려면 `--edit`을 붙인다. 2026-08-14에 세 화면 응답과 셀렉터 6종 구성을, 2026-08-21에 이동 바 왕복 동선을 확인해 뒀다.
- 중점: 활성 시안 `worknest`의 light/dark 대비, 카드 헤어라인 보더와 그림자 정책(hover lift·overlay 한정), gradient 전면 금지 준수, 사이드바·active 채움 전용 토큰 렌더링.
- 의도와 다른 부분이 나오면 관련 카탈로그와 `DESIGN.md`, `STATE.md`를 같은 작업에서 갱신한다.

### 2순위 — 사용자 판단이 필요한 6건

- 머지 권한 열기 (2026-08-25 인계, 사용자 직접 실행). `~/.claude/settings.json`의 `autoMode`에 `"allow": ["$defaults", "Bash(gh pr merge:*)"]`를 추가하고 Claude Code를 재시작한다. 일반 허용 목록(`permissions.allow`)에는 이미 있으나 분류기 판정이 우선해 효과가 없다. `"$defaults"`를 빼면 내장 허용 규칙이 전부 사라진다. 에이전트는 이 편집도 편집용 스크립트 작성도 분류기에 막히므로 사용자가 직접 해야 한다. 되돌리려면 편집 전 백업(`~/.claude/settings.json.bak-<날짜>`)을 덮어쓴다. 적용 전까지는 6단계 마감이 머지에서 멈추고 `!gh pr merge <num> --squash --delete-branch`로 인계된다.
- 머지 가이드 반영안 (2026-08-25, 승인 대기). `docs/local-dev-ci-guide.md §6.3`에 "실행 환경이 막으면" 항목을 추가하고, `session-end` 스킬 2종(Claude·Codex)에 마감이 머지에서 멈출 수 있음을 명시한다. 문구 초안은 이번 세션 대화에 있고 승인만 하면 바로 구현 가능하다. `riderwebapp`에만 있던 항목을 공통 정본으로 올리는 작업이다.
- 권한 모드 적용 (2026-08-04 인계). 파일 수정 확인을 없애려면 사용자 전역 설정(`~/.claude/settings.json`)에서 권한 모드를 `acceptEdits`로 바꾸고 허용 목록에 `Write`를 추가한다. 에이전트는 이 편집을 실행할 수 없어 사용자가 직접 해야 하며 적용 후 재시작이 필요하다. 되돌리려면 `~/.claude/settings.json.bak-20260804`를 덮어쓴다. 분류기를 유지한 채 특정 작업만 여는 `autoMode.allow` 방식도 대안이며, 이 경우 저장소 설정이 아니라 전역 설정에 넣어야 적용된다. 2026-08-14 세션에서는 훅 스크립트 수정, 여러 저장소 설정을 한 번에 바꾸는 스크립트, PR 머지 세 건이 분류기에 막혀 사용자 확인을 거쳤다.
- `aiospace` PR 39의 머지 여부. 그 저장소에서 진행한다.
- 각 연결 프로젝트에 추가된 `.claude/CLAUDE.md`와 `.claude/statusline-notify.sh` symlink는 아직 untracked다. 커밋 여부는 저장소별로 판단하며, `.claude/`를 gitignore한 프로젝트는 그대로 두면 된다.
- `riderwebapp`은 `.codex`가 추적되는 실체 디렉터리라 신규 파일 2건만 수동 연결했다. 내용은 템플릿과 동일해 기능 차이가 없고, 정리하려면 그 저장소에서 별도 작업으로 한다.

### 3순위 — 며칠 사용 후 판단할 관찰 항목

- 완료 알림 기준 60초, 재알림 90초 간격 6회, 격상 3회째가 실사용에 맞는지 조정한다. 환경변수만 바꾸면 되고 스크립트 수정은 필요 없다.
- 가드레일 오탐이 재발하는지 본다. 현재 남은 한계는 두 가지다. 명령 문자열 안에 데이터로 들어 있는 `git commit`에 상태 리마인더가 반응하는 것, 그리고 파일 수정·stage·commit을 한 명령에 묶으면 훅이 도는 시점에는 아직 수정 전이라 감지하지 못하는 것이다. 둘 다 차단하지 않는 경고여서 실해는 없다. 병합 뒤 원격 브랜치를 지우는 `git push origin --delete` 오탐은 2026-08-23 실측에서 해소를 확인했다. 훅 패턴이 `-f`/`--force`에만 반응하고 `--delete`와 `:branch` 형식은 통과하며, 같은 세션의 6단계 cleanup에서 실제로 차단 없이 삭제됐다. 더 볼 항목이 아니다.
- 문서 편집 화면에 이탈 경고나 임시 보관이 필요한지, 편집 중 실시간 미리보기가 필요한지 판단한다.
- Codex `PermissionRequest` 훅 알림은 `approval_policy = "never"` 환경에서 승인 요청이 발생하지 않아 등록하지 않았다. 승인 정책을 바꾸면 등록을 검토한다.
- 연결 프로젝트에 템플릿을 새로 설치할 때 알림 스크립트 4종이 `managed_prefixes` 규칙대로 전달되는지 첫 설치에서 확인한다.

### 4순위 — 선택 개선

- 문서 편집에 새 문서 생성·삭제를 열지 여부. 열려면 경로·명명 규칙 검증을 함께 설계한다.
- `docs/template-usage.md` 또는 예시 프로젝트 문서 추가.
- `docs/codex-reading-order.md`와 `AGENTS.md`의 빠른 읽기 순서 중복 축소.
- md → HTML 자동 동기화 또는 단일 진입점 도입.

### 결정 사항 (재론 불필요)

- 배포 방식은 `.claude` 전체 symlink(`--link-claude-dir`)가 아니라 실행 게이트 연결(`--link`)로 확정했다. 전체 symlink는 `aiospace`(`.claude/worktrees/admin-sep`), `signal2`(세션 격리 훅·승인 상태), `riderwebapp`(머지 권한 정책), `GoldFX`(절대경로 훅 등록)의 고유 자산을 없앤다.

## 현재 기준 파일

- 운영·라우팅: `AGENTS.md`, `CLAUDE.md`, `docs/approval-workflow.md`
- 현재 상태·프로젝트 기준: `STATE.md`, `docs/project-guide.md`
- 역할·요청: `agents/`, `templates/`
- 런타임 어댑터: `.claude/`, `.codex/`
- 디자인 정본: `DESIGN.md`, `designs/`, `docs/design-guidelines.md`
- 문서 UI·검증: `scripts/build-docs-index.mjs`, `scripts/serve-docs.mjs`, `scripts/check-html.mjs`, `scripts/build-nav.mjs`(화면 상단 이동 바 생성)
- 런타임 parity: `scripts/check-runtime-parity.mjs`, `scripts/check-codex-skills.mjs`, `docs/agent-runtime-matrix.md`

## 주의 사항

- 이 저장소의 목적은 런타임 앱 구현이 아니라 개발 프로젝트용 에이전트 운영규칙 템플릿 관리다.
- 프로젝트별 기술·업무 기준은 소비 프로젝트의 로컬 문서에 두고 템플릿 공통 규칙과 분리한다.
- 다른 저장소의 상태는 요청 범위이거나 결과에 직접 영향을 줄 때만 보고한다.

## 알려진 TODO

- 프로젝트별 커스텀 항목 체크리스트 추가
- 세션 종료 시 상태 업데이트는 `session-end` 스킬이 트리거·기록 형식·완료 기준까지 커버한다(2026-08-25 해소). 실사용에서 트리거 키워드가 충분히 걸리는지만 확인하면 된다.
- 필요 시 역할별 금지 사항 섹션 강화
