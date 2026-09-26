# STATE.md

## 현재 상태

- 이 저장소는 여러 개발 프로젝트에 재사용하는 `개발용 에이전트 운영 템플릿`이다.
- 공통 운영 규칙과 라우팅은 `AGENTS.md`, 에이전트 헌법과 응답 정책은 `CLAUDE.md`가 정본이다.
- 역할별 지침은 `agents/`, 요청·intake 양식은 `templates/`, 프로젝트·검증 가이드는 `docs/`에 둔다.
- Claude Code 자동화는 `.claude/`, Codex 네이티브 Skill은 `.agents/skills/`, Codex 승인·검증 어댑터는 `.codex/`에 둔다.
- 프로젝트 가이드는 템플릿 배포 원본에서 초기 scaffold를 유지하고 소비 프로젝트가 intake 결과로 교체한다.
- 이 템플릿을 `rules/` symlink로 참조하는 연결 프로젝트는 2026-08-22 실측 기준 17개다(GoldFX, aica2, aiospace, ccaa, goldlink, icnft, icwp2p, makeupshop, mlm_v1.0, riderapp-runtime, riderwebapp, signal2, skim, sos_sccl, tokendtu, trippass, vwallet. 작업용 worktree 2개는 별도). 전원 `.claude/` 하위 7종 symlink 배선이 끝나 있어 템플릿 개정이 즉시 반영된다. 이 17개는 POSIX 환경 실측치다. 주 개발 환경은 WSL이며 템플릿은 거기서 정상 동작한다. 2026-09-03 네이티브 Windows PC(`C: Projects`) 실측에서는 연결 프로젝트가 `sos_sccl` 릴리스 후보 1곳뿐이고, 템플릿이 네이티브 Windows에서 쓰인 것이 이날이 처음이라 그전까지 Windows 전용 결함이 드러나지 않았다. 초기 런타임 앱이던 sibling `../riderapp-runtime/`은 현재 git 저장소가 아니고 활동이 없어 참조 구현으로 삼지 않는다.
- 작업 알림은 Claude Code 사용자 전역 설정과 Codex `notify`에 등록되어 두 런타임 모두 동작 중이다. 구성·조정·되돌리기는 `docs/notification-guide.md`.
- Claude와 Codex는 각각 `.claude/CLAUDE.md`와 `.codex/README.md`를 실행 게이트로 삼아 같은 6단계 절차를 적용한다. 연결 프로젝트는 이 파일들을 공통본 symlink로 참조하므로 템플릿 개정이 즉시 반영된다.
- 프로젝트에 들어오는 개념·백서·요구사항·설계·개발계획을 시간순과 주제별로 보관하는 공통 지식 관리 체계를 `docs/knowledge-management-guide.md`와 `templates/` 양식으로 정의했다.
- 배포·릴리스와 `staging`/`production` migration은 `block-deploy.sh`가 실제로 차단한다. 에이전트는 명령을 알려 주는 데서 멈추고 실행은 항상 사용자가 한다.
- 여러 세션이 같은 저장소를 쓸 때의 파일 점유 조정은 `docs/session-coordination-guide.md`를 따른다. 세션 식별자는 `eval "$(bash .claude/hooks/session-coordination.sh resource)"`로 고정하는 경로가 기본이다.
- 커밋·push·PR·머지·브랜치 정리가 덜 끝난 작업은 `git-cleanup` 스킬(`/git-cleanup`)로 한 번에 점검한다.
- 세션을 닫을 때는 `session-end` 스킬(`/session-end`)로 이번 세션 이력과 다음 재개 지점을 `STATE.md`에 남기고 Git 잔여물 없이 마감한다. Git 상태만 정리하면 `git-cleanup`이다.
- Claude와 Codex 양쪽에 작업 유형·가드레일이 같이 있는지는 `node scripts/check-runtime-parity.mjs`가 검사한다. 한쪽에만 스킬을 추가하면 실패한다.


**세션 종료 (2026-09-19, 마지막)** — 머지 후 정리가 워크트리 환경에서 구조적으로 막히던 것을 절차 정본에 반영했다. 연결 프로젝트(goldlink)에서 `gh pr merge <num> --squash --delete-branch`가 `cannot delete branch '<br>' used by worktree at ...`로 끝났는데, 원격 머지는 이미 성공한 뒤였고 `--delete-branch`의 원격 삭제 단계만 건너뛰어 브랜치가 원격에 남았다. 원인은 설정이 아니라 **템플릿의 비대칭**이었다 — 워크트리를 만드는 절차는 §6.1·`AGENTS.md`·`approval-workflow.md`에 있는데 **푸는 절차가 어디에도 없었고**, §6.5 "브랜치 정리"에 `git worktree remove`가 빠진 채 §6.3이 `--delete-branch`를 권하고 있었다. git은 워크트리에 체크아웃된 브랜치의 삭제·체크아웃을 막으므로(2.5+), 권장 명령이 워크트리와 함께 쓰이면 항상 실패하는 상태였다. §6.5를 "브랜치·worktree 정리"로 넓혀 **worktree 제거 → 로컬 삭제 → 원격 삭제 → prune** 순서를 정본으로 두고, `--delete-branch` 금지와 실패 시 판정법(머지는 이미 끝났으니 재시도 금지, 잔존 확인은 `git branch -r`이 아니라 `git ls-remote --heads origin`)을 함께 적었다. 실행 위치에 따라 오류 문구가 둘로 갈리는 것(메인 저장소 = 브랜치 삭제 거부, 워크트리 안 = base 체크아웃 거부)도 같은 원인으로 묶어 기록했다. §6.3 예시에서 `--delete-branch`를 빼고, `business-logic-playbook.md`의 6번 블록에 worktree 제거 줄을 넣고, `approval-workflow.md` 6단계 8항의 나열 순서를 worktree 먼저로 바로잡았다. 스킬(`git-cleanup`·`session-end`·`session-coordination`)은 이미 §6을 참조하므로 손대지 않았다 — 정본을 한 곳에 둔다. `git-cleanup` 스킬의 "원격을 먼저 지우면 squash 머지 판정이 꼬인다"는 서술과는 근거만 다르고 방향이 같아 충돌하지 않는다. 검증은 `check-html`·`check-runtime-parity`·`check-phase-approval`·`check-destructive-guard`·`check-codex-skills` 5종 통과다(문서 변경이라 동작 검사는 해당 없음). `docs/docs-index.json`은 git 미추적 생성물이라 커밋에 포함되지 않는다 — 각 사용처에서 `node scripts/build-docs-index.mjs`로 재생성한다. 이번 변경은 `rules/` symlink로 연결된 전 프로젝트에 즉시 반영된다. 마감 시점에 미커밋 변경·미push 커밋·열린 PR·원격 작업 브랜치·worktree·승인 마커는 없다.

**세션 종료 (2026-09-17)** — 가드레일 훅 두 곳의 과한 확인을 풀고 전체 로컬 CI를 마쳤다(PR #61~#64). 출발점은 `git reset --hard`가 무조건 막힌다는 요청이었다. 사용자 결정은 모든 형태 허용·실행 직전 확인·남은 작업은 먼저 보존(에이전트가 Git 정리로)·"버려도 된다"고 명시하면 정리 없이 실행이었고, Codex도 같은 판정기를 쓰게 했다(#61). 5단계 감사에서 추적 안 되는 파일이 대상 커밋의 같은 경로에 있으면 reset이 경고 없이 덮어쓰는 것을 실험으로 확인해 보존 대상에 넣었고, 종전에 감지조차 안 되던 `git -C`·`reset -q --hard`도 막았다. 같은 흐름에서 STATE.md 수정 때 뜨는 확인창을 조사했더니 과거 32건 전부가 승인 게이트였다 — 작업 마무리에서 승인 마커를 지운 뒤 기록하면 뜬다. 게이트가 `STATE.md`·`docs/archive/`는 묻지 않게 했고(#62), 에이전트가 글로 "기록할까요?"라고 묻는 습관은 금지 예시로 규칙에 넣었다(#63). 이 수치는 처음 "약 20건"이라 보고했다가 재분류해 위반 6건(연결 프로젝트 3건)으로 바로잡았다. 전체 CI는 새 클론에서 16/16 통과했고(#64), 감사에서 배포·비밀 파일 차단 훅이 문법 검사만 받는 공백을 잡아 실제 판정을 보완했다. 판단 근거로 남길 것: 가드레일 훅 수정은 auto 모드 분류기가 `[Security Weaken]`·`[Self-Modification]`으로 두 번 거부해 사용자가 권한 모드를 바꾼 뒤 진행했다(우회하지 않음). 남은 위험은 각 PR 항목의 "남은 낮은 위험"에 있고, 새 확인창 두 개가 실사용에서 의도대로 뜨고 사라지는지는 아직 보지 못했다. 9/16 다른 창이 변경 없이 남긴 worktree `fix/relax-guardrail-hooks`는 사용자 요청으로 지웠다. 마감 시점에 미커밋 변경·미push 커밋·열린 PR·원격 작업 브랜치·worktree·승인 마커는 없다. 재개 지점은 `## 다음 작업` 1순위(디자인 시안 시각 검수) 그대로이며, 이번 세션에서 나온 관찰 2건은 3순위, 상시 검사 보강은 4순위에 올렸다.

**세션 종료 (2026-09-12)** — 가이드 제약도를 진단하고 완화안 2건을 적용했다. 에이전트 가이드가 과한지 물어 측정했다. 항상 로드되는 규칙은 542행이고 의무형 문장 170 대 재량형 24, 훅 10종 중 실제 차단은 3종뿐이었다. 결론은 **위험 통제는 느슨하고 절차·형식이 빡빡하다**였다 — 되돌릴 수 없는 작업만 막고 나머지는 확인에 그치는데, 쓰기가 없는 질의까지 6단계에 묶여 답 하나에 3턴이 들었다. 완화안 4건 중 사용자가 2건을 택했다. `AGENTS.md ## 작업 유형 선택 규칙`의 기능별 세부 구분 5개를 `### 유형이 갈릴 때만 적용하는 구분 기준`으로 내려 상위 규칙으로 유형이 정해지면 읽지 않도록 했다(문장 삭제 0, parity 유지). 읽기 전용 질의의 1·2단계 통합은 **사용자가 거부**해 절차는 그대로다. 범위 밖 변경 1건: 사용자 전역 `~/.claude/CLAUDE.md`의 미러 2절(36행)을 정본 참조로 축약했고(21행), 사후 감사에서 안전 3조항(범위 밖 변경·결과 변동·데이터 소실 보고)이 함께 사라지는 것을 잡아 그 항목만 복원했다. 이 파일은 git 관리 밖이라 커밋에 없다. 마감 시점에 미커밋 변경·미push 커밋·열린 PR·worktree는 없다. 다만 이번 세션과 무관하게 **원격 브랜치 3개가 남아 있었다** — `fix/session-coordination-git-guard`는 PR #52로 머지돼 삭제했고, `docs/2026-09-03-windows-portability`(상태 기록 5커밋)와 `fix/avatar-gradient-design-scope`(프리뷰 3화면 수정)는 **PR 없이 미머지 상태**라 손대지 않고 `## 다음 작업` 2순위에 올렸다. 9월 3일 작업이 main에 반영되지 않은 상태다. 재개 지점은 `## 다음 작업` 1순위이고, 이번 세션의 미결(라우팅 표 줄이기)은 2순위에 있다. 세션 마감 뒤 사용자 요청으로 `fix/avatar-gradient-design-scope`를 확인해 PR #57(`9f2ac1d`)로 머지하고 로컬·원격 브랜치를 정리했다 — 프리뷰 3화면의 아바타가 시안과 무관하게 gradient로 칠해져 활성 시안 `worknest`의 gradient 전면 금지를 위반하던 것을 단색 토큰 기본값 + `[data-design="wanted"]` 한정으로 고친 유효한 수정이었다. 확인 중 `docs/user-fe-preview.html` 1행의 오타 문자열을 발견했으나 별건이라 함께 고치지 않고 `## 다음 작업` 2순위에 남겼다. 최종 마감 시점에 미커밋·미push·열린 PR·worktree·승인 마커는 없고, 원격 `docs/2026-09-03-windows-portability`만 미머지로 남아 있다.
**세션 기록 (2026-09-03, Windows 첫 사용에서 드러난 이식성 결함 3건)** — `sos_sccl` 릴리스 후보에 템플릿을 처음 적용하다 Windows에서만 나타나는 결함 3건을 찾았다. 가장 위험했던 것은 **가드레일 훅 6종이 조용히 무력화**돼 있던 점이다. `python3 /dev/fd/3 3<<'PY'`로 Python 본문을 넘기는데 MSYS가 `/dev/fd/3`을 네이티브 Python이 열 수 없는 경로로 번역하고, `2>/dev/null`이 에러를 삼켜 판정이 비면 `exit 0`으로 통과한다. 실측에서 `vercel deploy --prod`·`terraform apply`·`gh release create`·`rm -rf /`가 전부 rc=0으로 통과했다. Python 본문을 임시 파일로 넘기고 stdin은 payload 전용으로 남겨 고쳤다 — `block-secret-files.sh`가 fd 3을 쓴 이유가 Write의 `tool_input`이 `MAX_ARG_STRLEN`(128KB)을 넘기기 때문이라, 환경변수나 argv로 넘기는 방식은 그 제약을 되살린다(300KB payload로 확인). 판정 로직은 한 줄도 바꾸지 않아 POSIX 동작에 차이가 없다. 둘째는 `install.py --link`가 만든 symlink가 Windows에서 전부 깨져 있던 것이다. `relative_link()`가 구분자를 `/`로 하드코딩하는데 Windows reparse point는 역슬래시만 해석한다. `rules` 하나만 살아 있던 건 그것만 `os.path.relpath()`를 쓰기 때문이고, Git Bash가 reparse point를 자체 해석해 `ls`/`cat`은 멀쩡해 보이는 것이 함정이다. 타깃 링크는 복구했으나 **`install.py` 자체는 아직 고치지 않았다**. 셋째는 `check-codex-skills.mjs`가 `core.autocrlf=true` 클론에서 rc=1로 실패하는 것이다(frontmatter 첫 줄이 CRLF라 13행의 LF 기대 검사가 Skill 14종을 전부 누락으로 판정한다). **세 결함 모두 네이티브 Windows 전용이고 WSL은 해당하지 않는다** — 성립 조건이 각각 MSYS의 경로 번역, NTFS reparse point, `autocrlf=true` 체크아웃이라 WSL에서는 어느 것도 성립하지 않는다. 이를 WSL2 Ubuntu에서 실측으로 확인했고, 수정한 훅이 Linux에서 동일하게 동작하는 것과 역슬래시 symlink가 WSL DrvFs에서 정상 해석되는 것도 같이 확인했다. 그래서 남은 2건(`install.py`, `check-codex-skills.mjs`)은 2순위가 아니라 `## 다음 작업` 4순위에 둔다. 네이티브 Windows를 쓸 계획이 생기면 그때 올린다.

**세션 기록 (2026-08-27, 세션 조정 사각지대 두 곳)** — 연결 프로젝트(`sos`)에서 두 창이 같은 저장소를 쓰다 세 번 부딪힌 뒤, 기존 조정 장치가 닿지 않던 두 곳을 메웠다. **hook 이 `Edit|Write` 에만 걸려 있어 git 명령은 통과**했다 — 한쪽이 만든 브랜치를 다른 창이 `git push origin --delete` 로 지워도 아무 확인이 없었고, 커밋을 되짚을 단서는 reflog 뿐이었다. 이제 다른 세션이 등록돼 있을 때에 한해 브랜치·원격 ref·worktree 삭제와 force push 를 확인 대상으로 돌린다(11종 포착, 정상 명령 9종 무개입 확인). 또 하나는 **등록의 `pid` 가 비어 생존 검사가 불가능**했던 것이다. `SESSION_COORD_OWNER_PID` 가 없으면 부모를 거슬러 실행기 프로세스를 찾아 기록하므로, 창이 사라진 등록은 TTL 8시간을 기다리지 않고 정리된다. `.claude/settings.template.json` 의 `Bash` matcher 연결은 **이미 설치된 프로젝트에 자동 전파되지 않는다** — 각 프로젝트의 `settings.json` 은 복사본이라 직접 추가해야 한다. hook 스크립트 자체는 symlink 라 즉시 반영된다.
**세션 종료 (2026-08-25)** — 세션 마감 스킬 `session-end`를 만들어 배포하고(PR #47 `6eae247`), 이어서 PR 머지가 매번 막히던 원인을 규명했다. 스킬은 종료 절차 자체가 아니라 **트리거의 부재**를 고친 것이다 — 절차는 `docs/finish-checklist.md`와 `git-cleanup`에 이미 있었지만 "세션종료해줘"에 걸리는 키워드가 어느 스킬에도 없어 실행 여부가 매번 에이전트 판단에 달려 있었다. 머지 차단은 설정 오류가 아니라 계층 문제였다. 사용자 전역 허용 목록에 `Bash(gh pr merge:*)`가 이미 등록돼 있는데도 막혔는데, `auto` 모드에서는 분류기 판정이 허용 목록보다 우선하고 `autoMode.allow` 배열이 비어 있어 기본 soft_deny 규칙(되돌리기 어려운 작업)이 그대로 적용됐다. 저장소 문서는 6단계에서 머지를 승인 범위에 넣었으므로 문서와 런타임이 어긋난 상태였다. 미커밋 변경·미push 커밋·열린 PR·잔여 브랜치·worktree는 없다. 재개 지점은 `## 다음 작업` 1순위이며, 사용자 직접 실행이 필요한 분류기 설정과 승인 대기 중인 가이드 반영안이 2순위에 있다.

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

- admin 콘텐츠 최대 너비를 화면 1920 기준 상한으로 정했다. (2026-09-26, PR #__PR__)
  - PR #71의 "content max-width 없음"을 바꿨다. 초광폭 화면에서 표 칼럼이 과하게 넓어지는 것을 막기 위해서다. 사용자는 "1920에서 폭을 멈춤" 안을 골랐고, 가운데 정렬과 사이드바 상태별 계산은 추천값으로 정했다.
  - `docs/admin-fe-design-guide.md`: 상한을 app shell이 아니라 content 안쪽 틀에 건다. 사이드바는 왼쪽 끝에 고정하고 `max-width: calc(1920px - <사이드바 폭> - 2 × space-16)` + 가운데 정렬로 정했다(펼침 1648 / 접힘 1824, 2560 화면은 좌우 320씩 남음). "max-width 없음" 4곳을 1920 상한 문구로 고쳤다.
  - `docs/user-fe-design-guide.md`: admin 너비 문장을 1920 상한으로 고쳤다. `docs/admin-fe-preview.html`: 조립 예시 폭을 `min(화면, 1920) - 32`로 제한하고 가운데 정렬했다. 미리보기는 사이드바를 포함한 예시 전체를 가운데 정렬하므로, 1920을 넘는 화면에서는 가이드의 방식(사이드바 왼쪽 고정)과 모양이 다르다. 견본이라 그대로 두었다.
  - 브라우저 실측(headless Chromium): 조립 예시 폭이 1440에서 1408(좌우 16), 1920에서 1888(좌우 16), 2560에서 1888(좌우 336)이다. 세 폭 모두 가로 스크롤이 없다.
  - 검증: `check-html`, `build-nav --check`, `check-runtime-parity` 통과.

- admin 미리보기와 사용자 화면 가이드를 PR #71의 밀도 우선 기준에 맞췄다. (2026-09-26, PR #72)
  - `docs/admin-fe-preview.html`: 화면 조립 예시 2개(대시보드·리스트)만 `.section.assembly`로 1280 틀 밖까지 넓혀 가용 폭을 채우게 했고, 조립 내부 여백·간격 16, KPI `stat-grid`는 `auto-fit` 최소 200·gap 12·카드 padding 16(767 이하 1열), 로그인 카드 padding 20·입력 간격 12로 바꿨다. 카탈로그 영역의 1280 틀과 밀도 비교(5d)는 유지했다.
  - `docs/user-fe-design-guide.md`: "admin은 1280"을 최대 너비 없음으로 고치고, 로그인 문장에 admin padding `space-20`을 병기했다(사용자 화면 값 32는 유지).
  - 브라우저 실측(headless Chromium, 폭 500·1024·1440·1920): 조립 예시가 폭에 맞춰 넓어지고 KPI는 1440 이상 1행, 1024 2행, 좁은 폭 1열이다. 가로 스크롤 폭은 변경 전과 같다(폭 500의 넘침은 기존 와이드 테이블 견본 때문). 일반 스크롤바 환경에서는 `100vw`가 스크롤바를 포함해 좌우 여백이 16이 아니라 약 9로 보인다.
  - 범위 밖으로 남긴 것: `designs/minimal-mono.md`의 admin max-content-width 1280 권장 문장.
  - 검증: `check-html`, `build-nav --check`, `check-runtime-parity` 통과.

- admin 화면 가이드를 여백 최소·밀도 우선 구성으로 바꿨다. (2026-09-26, PR #71)
  - 출발점은 admin 페이지가 여백이 과하고, 열을 많이 나눠 넓은 화면에서 오른쪽이 비는 문제였다. 원인은 콘텐츠 최대 너비 1280 권장, 상세 화면 좌 720 / 우 320 고정, 대시보드 열 수 고정이었다.
  - `docs/admin-fe-design-guide.md`에 `## 밀도 우선 레이아웃 원칙`을 신설했다: 위치별 여백 기본·상한·Mobile 표(콘텐츠 `space-16`, 카드 안쪽 `space-16` 상한 `space-20`, 카드 사이 `space-12`), `auto-fit` 최소 폭 기반 열 분할(`auto-fill` 금지), 내용 적은 카드 합치기(KPI `stat-card`는 예외), 페이지 분할 2열 상한, content max-width 제거.
  - 화면 골격·로그인·대시보드·리스트 빈 상태·상세·폼 패턴 수치를 새 상한에 맞췄고, 시안별 비교표 수치는 유지하되 상한이 우선한다고 명시했다.
  - 범위 밖으로 남긴 것: `docs/user-fe-design-guide.md`의 "admin은 1280" 문장, `docs/admin-fe-preview.html`의 max-width 1280 표시, 활성 시안 `DESIGN.md`(admin 표면 미정의).
  - 검증: `check-runtime-parity` 통과, `build-nav --check` 7화면 최신, 비-4의 배수 간격 0건.

- 파괴적 명령 차단 훅이 refspec 강제(`git push origin +main`)와 git 전역 옵션 뒤 강제 push(`git -C <dir> push -f`)도 막게 했다. (2026-09-26, PR #69)
  - #68 감사에서 범위 밖으로 남긴 구멍 2종이다. 기존 판정은 옵션(`-f`, `--force`)만 보고 `git` 바로 뒤에 `push`가 와야만 검사했다.
  - 변경: 강제 옵션 판정의 앞부분을 `reset --hard` 판정과 같은 `git\s+([^;&|]*\s)?push`로 바꾸고, push 구간에서 공백 뒤 토큰이 `+`로 시작하면 차단하는 줄을 추가했다. `feature+x`, `v1.0+build`, `main:+x`처럼 토큰 중간의 `+`와 `git fetch +main:main`은 통과한다.
  - `scripts/check-destructive-guard.mjs`에 사례 10건(차단 6, 통과 4)을 추가해 66/66이다. 기존·새 훅 16종 비교에서 회귀 0건이고, 와일드카드 refspec 강제(`+refs/heads/*:refs/heads/*`)도 새로 막힌다.
  - 남은 낮은 오탐(막는 쪽): `git push -o +ci`처럼 옵션 값이 `+`로 시작하는 경우, `git log --oneline push -f`처럼 push가 하위 명령이 아닌 인자로 오고 뒤에 `-f`가 붙는 경우.
  - 검증: `check-destructive-guard` 66/66, `bash -n` 통과.

- 파괴적 명령 차단 훅이 원격 브랜치 삭제 뒤의 `rm -f`를 강제 push로 오판하던 것을 고쳤다. (2026-09-26, PR #68)
  - 원인: `block-destructive.sh`의 push 판정이 `git\s+push\s+.*(-f|--force)\b`라 `.*`가 `;`·`&&`·`|`를 넘어 뒤 명령의 `-f`까지 읽었다. #67 마무리에서 `git push origin --delete <브랜치>; rm -f <승인 마커>`가 막혔다. `topic-f`처럼 `-f`로 끝나는 브랜치 이름도 같은 규칙에 걸렸다. `rm`·`reset --hard` 판정은 이미 `[^;&|]*`로 구간을 자르고 있었고 push만 빠져 있었다.
  - 변경: push 구간 안에서 공백 뒤 옵션 토큰(`-[a-zA-Z]*f[a-zA-Z]*`, `--force`, `--force-with-lease`, `--force-if-includes`, `=값`)만 보고, 옵션 뒤 경계는 이름에 쓰이지 않는 모든 문자로 본다.
  - 5단계 감사에서 첫 안(경계를 공백·줄 끝만 인정)이 `git push -f;ls`, `(git push -f)`, `bash -c "git push -f"` 등 5종을 새로 통과시키는 회귀를 기존·새 훅 비교로 잡아 경계를 넓혔다. 4단계 보고의 "기존 규칙도 `-fq`를 막았다"는 틀렸고, `-fq` 차단은 이번에 새로 생겼다.
  - `scripts/check-destructive-guard.mjs`에 push 사례 12건(차단 9, 통과 3)을 추가해 56/56이다.
  - 남은 범위 밖 구멍: refspec 강제(`git push origin +main`)와 `git -C <dir> push -f`는 기존·새 훅 모두 통과한다.
  - 검증: `check-destructive-guard` 56/56, `bash -n` 통과.

- Codex `dev-start`도 Claude처럼 상태 브리핑·로컬 기동·hot reload 점검을 6단계 없이 한 턴에 진행하게 했다. (2026-09-26, PR #67)
  - 원인: Claude `dev-start` skill에는 "기록·코드 변경부터 6단계 적용" 조항이 있지만 Codex skill·workflow에는 없었다. Codex는 `.codex/README.md`의 "단순 조회가 아닌 모든 작업은 6단계, 1·2단계는 읽기 전용" 계약을 그대로 따라 컨테이너 기동을 3단계 승인 뒤로 미뤘다. Claude는 승인 게이트 훅이 Edit/Write만 보므로 기동 명령이 막히지 않았다.
  - 변경: `.agents/skills/dev-start/SKILL.md`에 `## 승인 절차 연결`, `.codex/workflows/dev-start.md ## 정책`에 같은 예외, `.codex/README.md`의 `## 종료 규칙`과 `## 단계 실행 계약`에 `dev-start` 예외를 넣었다. 가드레일 판정은 예외 없이 유지한다.
  - 5단계 감사에서 예외 문구가 "증분 재빌드부터 6단계"라고 적어 같은 파일의 첫 부팅 증분 재빌드 허용과 Claude 기준에 어긋나는 것을 잡아 "재빌드"를 뺐다.
  - 공통 `docs/approval-workflow.md`에는 예외를 넣지 않았다. Claude도 skill에만 두는 구조와 같다.
  - 4단계 첫 편집 시도는 Claude Code auto mode 분류기가 `[Self-Modification]`으로 거부했고, 사용자가 권한 모드를 바꾼 뒤 재시도해 적용했다.
  - 검증: `check-codex-skills`, `check-runtime-parity` 통과. parity 검사는 승인 조항 문구는 비교하지 않는다.

- 응답에서 `STATE.md` 기록 여부를 묻지 않도록 금지 문구 예시를 규칙에 넣었다. (2026-09-17, PR #63)
  - 배경: 과거 대화에서 에이전트가 글로 "`STATE.md`에 반영할까요?"처럼 기록 여부만 물은 사례를 다시 분류했다. 21건 중 규칙 위반은 6건이고, 그중 이 템플릿의 연결 프로젝트에서 나온 것은 3건(goldlink, GoldFX, sccl)이다. 나머지는 Git 승인 질문 7건, 허용된 `다음 작업`·TODO 확인 2건, 질문이 아닌 문장 6건이었다. #62 보고에서 "약 20건"이라 한 것은 이 분류 전 수치라 과대였다.
  - `docs/approval-workflow.md ## 재확인하지 않는 작업`에 "묻지 않는다"의 뜻(기록 먼저, 보고에 한 줄)과 금지 예시 2종(기록 자체를 선택지로 두는 문장, Git 승인에 기록을 끼워 넣는 문장), 허용 2종(3단계 범위에 기록 단계를 적는 것, `다음 작업` 한 줄 확인)을 적었다.
  - 종료 점검에 같은 항목을 넣었다. Claude(`docs/finish-checklist.md`)와 Codex(`.codex/checks/finish-checklist.md`) 양쪽이다.
  - 사용자가 "묻지 말고 바로 적용"을 지시해 이 작업은 단계별 확인 없이 구현·감사·검증·머지까지 한 번에 진행했다.
  - 검증: parity, Codex skill 검사, 마크다운 공백 검사. 문서만 바뀌어 훅 판정 검사는 해당 없다.

- 승인 게이트가 `STATE.md`와 `docs/archive/` 기록 수정에는 확인창을 띄우지 않게 했다. (2026-09-17, PR #62)
  - 원인: `phase-approval.sh`가 파일을 가리지 않고 "세션 승인 마커가 없으면 확인"만 했다. 과거 기록 32건(5개 프로젝트, 8세션) 전부가 이 훅이었고, 작업 마무리에서 마커를 지운 뒤 기록하거나(17건) 마커 없이 기록만 하는 작업(6건)에서 떴다. 문서는 STATE 기록을 재확인 대상에서 빼는데 훅은 몰랐다.
  - 사용자 결정: 예외 범위는 `STATE.md`와 기록 보관 문서(1-B), main 체크아웃·worktree 구분 없이 적용(2-가).
  - 판정: 대상의 저장소 최상위 기준 경로가 `STATE.md`이거나 `docs/archive/` 아래면 마커 확인 전에 통과한다. `docs/99-archive/`(폐기·대체 문서 이동은 구조 변경), 하위 폴더의 `STATE.md`, 이름만 비슷한 폴더, `..`로 돌아가는 경로는 종전대로 확인한다.
  - `docs/approval-workflow.md`에 게이트 예외를 적고, `## 재확인하지 않는 작업`에 `docs/archive/`로 옮기는 기록을 추가했다. 5단계 감사에서 설명 문단이 "다음 작업 변경은 한 줄 확인" 예외 문단보다 앞에 끼어 오독될 수 있는 것을 잡아, 예외 뒤로 옮기고 "게이트가 묻지 않아도 그 확인은 에이전트가 한다"를 명시했다.
  - `scripts/check-phase-approval.mjs`를 추가했다. 임시 저장소와 worktree로 12가지 상황을 고정한다. 수정 전 훅에 돌리면 기록 파일 4건만 실패해 이번 수정을 정확히 잡는다.
  - 남은 낮은 위험: 다음 세션이 읽는 `다음 작업`을 포함한 `STATE.md` 전체가 훅 없이 바뀔 수 있어 규칙과 에이전트의 한 줄 확인으로만 지킨다. `docs/archive/` 예외는 파일 종류를 가리지 않는다. 경로 계산에서 예외가 나면(이론상 네이티브 Windows의 드라이브 차이) 훅이 멈춰 수정이 확인 없이 통과된다.
  - 에이전트가 글로 "STATE.md에 기록할까요?"라고 되묻던 약 20건은 훅이 아니라 응답 습관 문제라 이번 범위에서 뺐다.
  - 검증: 승인 게이트 12/12, 차단 판정 44/44, 훅 `bash -n`, parity, Codex skill 검사, manifest JSON.

- `git reset --hard`를 무조건 차단하던 것을 "보존 확인 후 실행 전 확인"으로 바꿨다. Codex도 같은 판정을 쓴다. (2026-09-17, PR #61)
  - 사용자 결정: 모든 형태 허용, 막지 않고 실행 직전 확인, 남은 작업은 에이전트가 Git 정리 절차로 먼저 보존, 사용자가 "버려도 된다"고 명시하면 정리 없이 실행.
  - 판정: 커밋하지 않은 변경, reset 뒤 원격 어디에도 남지 않는 커밋, 대상 커밋과 경로가 겹쳐 덮어써질 추적 안 되는 파일 중 하나라도 있으면 exit 2로 보류하고 개수·경로와 정리 순서를 알려 준다. 없으면 `permissionDecision: ask`로 확인받는다. 대상 저장소를 알 수 없거나 판정이 실패하면 보류한다.
  - 버리기: 일회용 폐기 확인 파일 `<메인 저장소>/.claude/.approval/<session_id>.reset-discard`(Codex는 `reset-discard`)가 있으면 읽는 즉시 지우고 사라질 작업을 경고하며 확인받는다.
  - 감지 범위를 넓혔다. `git -C 경로 reset --hard`, `git reset -q --hard`, `git reset <커밋> --hard`는 종전에 감지조차 안 됐다. `-C`와 앞선 `cd`를 따라 대상 저장소를 판정하고, `--git-dir`·`--work-tree` 지정은 보류한다.
  - 5단계 감사에서 추적 안 되는 파일이 대상 커밋의 같은 경로에 있으면 reset이 경고 없이 덮어쓰는 것을 실험으로 확인해 보존 대상에 넣었다. 파일 자리에 디렉터리가 생기는 경우도 포함한다.
  - Git 정리 절차(Claude 스킬·명령, Codex workflow·스킬)에 `## reset 전 보존 정리`를 추가했다. 순서는 머지 → 원격 SHA 확인 → fetch → reset → 브랜치·worktree 삭제다. 원격 브랜치를 먼저 지우면 squash로 머지된 커밋도 원격에 없는 것으로 판정된다.
  - Codex 공용 판정기 규약: exit 2는 실행 안 함, exit 0+출력 없음은 진행, exit 0+`ask` 출력은 Codex 승인 요청. 호출 JSON에 `cwd`를 넣는다.
  - 남은 낮은 위험: 넓힌 감지가 `git log --grep reset --hard` 같은 드문 명령에도 확인을 띄울 수 있다. 한 명령에 따옴표 속 reset 문구와 실제 reset이 함께 있으면 대상을 잘못 읽을 수 있다(대부분 보수적으로 판정). Codex 창끼리 폐기 확인 파일 이름을 공유한다. 실제 Claude Code 확인창과 네이티브 Windows 동작은 미확인이다.
  - 구현 중 auto 모드 분류기가 훅 수정을 `[Security Weaken]`·`[Self-Modification]`으로 두 번 거부했다. 우회하지 않고 사용자가 권한 모드를 바꾼 뒤 진행했다. 가드레일 훅을 고치는 작업은 auto 모드에서 막힌다고 보면 된다.
  - 검증: 회귀 검사 44/44(기존 26건 + `--soft` 통과 1건 + reset 상황 17건), 훅 `bash -n`, parity, Codex skill 검사, manifest JSON, 보류·경고·Codex 형식 사유 문구 직접 확인.
  - 같은 세션에서 STATE.md 수정 때 확인창이 뜨는 원인을 조사했다. 과거 기록 32건 전부가 `phase-approval.sh`였다. 승인 표시를 작업 마무리 때 지운 뒤나 애초에 만들지 않은 채 STATE.md를 기록하면 뜬다. 문서는 STATE 기록을 재확인 대상에서 빼지만 훅은 파일을 가리지 않는다. 사용자가 이번 PR에는 수정을 넣지 않기로 해 수정하지 않았다.
  - 2026-09-16 다른 세션이 변경 없이 남긴 worktree `fix/relax-guardrail-hooks`와 그 승인 표시를 사용자 요청으로 정리했다.

- 파괴적 명령 차단 훅의 오탐을 없애고 재귀 삭제 차단 범위를 넓혔다. (2026-09-10)
  - 플래그를 명령줄 전체가 아니라 `rm` 호출 구간에서만 찾는다. 종전에는 `grep -rn ... && docker compose -f x.yaml rm --force svc`처럼 서로 다른 명령의 `-r`과 `-f`를 `rm`의 것으로 오판해 무해한 명령을 막았다. 소비 프로젝트에서 실제로 두 번 막혔다.
  - 판정 기준을 "재귀 삭제인가" 하나로 바꾸고 `-r`·`-R`·`--recursive`를 모두 인식한다. 종전 규칙은 소문자 `r`과 `-f`를 함께 요구해 **`rm -Rf`와 `rm --recursive --force`가 그대로 통과했다.** 강제 없는 `rm -r`도 막지 못했다. 셋 다 되돌릴 수 없는 재귀 삭제다.
  - 범위를 넓히면서 `git rm -r`이 새로 걸린다. 작업 트리 파일을 실제로 지우므로 차단이 맞다. 다만 `git rm -r --cached`는 색인에서만 빼므로 예외로 통과시킨다. 예외는 `git` 접두어까지 확인한다. 그러지 않으면 `rm -rf dir --cached`처럼 무의미한 인자를 붙이는 것만으로 차단을 지나갈 수 있다.
  - 나머지 차단 규칙 4종과 따옴표·주석·heredoc 전처리는 바꾸지 않았다.
  - `scripts/check-destructive-guard.mjs`를 추가했다. 훅을 실제로 실행해 종료 코드로 판정하며, 차단 16건과 통과 11건을 고정한다.
  - 훅 설명이 적힌 세 곳(`CLAUDE.md`, Codex safety checklist, 플러그인 manifest)을 실제 판정에 맞춰 정정했다. manifest는 소비 프로젝트에 함께 배포된다.
  - 검증: 회귀 검사 27/27 통과, `check-runtime-parity.mjs` 회귀 없음, 소비 프로젝트에서 오탐 명령 실측 통과.

- 아바타 gradient를 시안 policy에 맞게 스코프 지정했다. (2026-09-03 작업, PR #57 `9f2ac1d`로 머지)
  - 프리뷰 3화면의 `.avatar`가 `[data-design]` 스코프 없는 규칙 하나뿐이라 시안 6종 전부 `wanted`의 gradient를 렌더링했다. 활성 시안 `worknest`는 "gradient 전면 금지 — 아바타·심볼·배너 모두 단색"(`designs/worknest.md:374`)이라 명시적 위반이었다.
  - `policy.gradient_locations` 기준으로 avatar gradient를 허용하는 시안은 `wanted` 하나뿐이다. 기본 규칙을 토큰 단색(`--bg-brand`/`--fg-on-brand`)으로 바꾸고 gradient를 `[data-design="wanted"]`로 한정했다. `minimal-mono`는 `bg-inverse`/`fg-on-brand`, `toss-like`·`material-3`은 `bg-brand-subtle`/`fg-brand`로 각 문서의 fallback을 반영했다.
  - 검증: 6시안 × light/dark 12조합 computed style 실측(`wanted`만 gradient, 나머지 10조합 0건), `check-html`·`check-runtime-parity`·`build-nav --check` 통과(WSL 기준).
  - `build-nav --check`는 네이티브 Windows에서 7화면 전부 stale로 오판한다. 손대지 않은 `guide-browser.html`·`intake.html`까지 포함되고 WSL에서는 전부 통과하므로 CRLF 아티팩트다(4순위 CRLF 항목과 같은 계열).

- Windows에서 무력화되던 가드레일 훅 6종을 복구했다. (2026-09-03, PR #53 `f3b8eb1`)
  - 대상: `block-deploy`, `block-destructive`, `block-secret-files`, `phase-approval`, `state-reminder`, `warn-design-tokens`.
  - `python3 /dev/fd/3 3<<'PY'` -> Python 본문을 `mktemp` 임시 파일로 넘기고 `trap`으로 정리한다. stdin은 payload 전용으로 남는다.
  - 셸 래퍼만 바뀌었다(42+/9-). Python 본문은 바이트 단위로 동일해 POSIX 동작에 차이가 없다.
  - 검증(Windows): `bash -n` 훅 10종, 차단 기대 8건 전부 rc=2·통과 기대 6건 전부 rc=0, 5회 호출 임시파일 누수 0, `check-runtime-parity.mjs` 통과, 타깃에서 symlink 경유 end-to-end 확인.
  - 검증(WSL2 Ubuntu, Python 3.12.3): LF로 정규화해 정상 WSL 클론을 재현한 뒤 차단 기대 5건 전부 rc=2·통과 기대 3건 전부 rc=0, 10회 호출 임시파일 누수 0. POSIX 동작 동일이 추론이 아니라 실측으로 확인됐다.
  - `rm -rf ./build` 차단은 `block-destructive.sh:96`의 의도된 동작이다(위치 제약을 두면 `find -exec rm -rf`를 놓쳐 일부러 뺐다고 주석에 명시). 회귀가 아니다.
  - PR #53으로 머지됐다(`f3b8eb1`, squash). 작업 브랜치 `fix/windows-hook-python-delivery`는 삭제됐다. `gh`가 미인증 상태라 PR 생성은 사용자가 브라우저로 했다.

- `sos_sccl` 릴리스 후보(`20260830_Coding_Agent_v1_Git_Release_Candidate`)에 템플릿을 연결했다. (2026-09-03)
  - `--adopt` 작업 169건·보호 1건(`STATE.md`)·충돌 0, 이어서 `--link`로 실행 레이어 9종과 `rules` 연결. 플러그인 `3.8.0`.
  - `--link`가 만든 symlink 9종이 Windows에서 전부 깨져 `os.path.join` 기반으로 다시 걸었다. skills 14·commands 14·hooks 10 전부 네이티브 해석 확인.
  - `.gitignore`에 실행 레이어 5종(`/.claude/`, `/.agents/`, `/.codex`, `/rules`, `/.agent-template-backup-*/`)을 추가했다. 저장소 밖 상대경로 symlink라 커밋하면 다른 환경에서 깨진다.
  - 공유 문서(`AGENTS.md`, `DESIGN.md`, `agents/`, `designs/`, `docs/`, `templates/`)는 ignore하지 않고 untracked로 남겼다. 커밋 여부는 그 저장소에서 판단한다.
  - 설치 중 다른 세션이 같은 저장소에서 `Dockerfile.runtime`·`tools/run_ci_quality_gates.py`를 수정하고 `tests/test_runtime_git_line_endings_contract.py`를 추가했다. 건드리지 않았다.

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

- **2026-09-26 WSL2 Ubuntu에서 전체 로컬 CI를 돌려 16/16 통과했다. 누적 대기열은 비었다.**
  - 대상: `main` `610f06c`. 해소한 누적분은 #65·#66·#67·#68·#69다(#64는 9/17 CI 기록 자체).
  - 실행 환경: 원격 `main`을 작업 임시 폴더에 새로 클론(LF 체크아웃, `core.autocrlf=input`). node v22.22.0 / Python 3.12.3 / git 2.43.0. 작업 저장소에는 생성물을 남기지 않았다.
  - 기본 검사 13건: 문서 인덱스 생성 후 `--check`(문서 142개), `build-nav --check`(7화면), `check-html`(HTML 7·스크립트 6), `check-runtime-parity`, `check-codex-skills`, 차단 판정 66/66, 승인 게이트 12/12, 셸 `bash -n` 14종, manifest 경로 169건(누락 0·중복 0), 설치 dry-run `--new`·`--adopt`(둘 다 작업 169·충돌 0·파일 생성 없음·rc 0), 마크다운 상대 링크 108건(깨짐 0).
  - 보완 검사 3건: 배포 차단 판정 15/15, 비밀 파일 차단 판정 11/11, 훅 내장 Python 본문 구문 7/7. 9/17 대비 바뀐 수치는 차단 판정(44 → 66, #68·#69)뿐이다.
  - 보완 사례를 임시로 다시 만들다 `NODE_ENV=production npm run migrate`를 차단 기대로 넣어 불일치가 났다. 배포 차단 훅은 `--env production`·`DATABASE_URL=…production…`·도구별 migrate로만 판정하도록 설계됐고 #53 이후 바뀌지 않아, 설계 범위 밖 사례로 분류해 제외했다. 빈틈 자체는 4순위에 남겼다.
  - 4단계에서 dry-run 종료 코드를 파이프 뒤 `tail`의 코드로 받은 것을 5단계에서 잡아 단독 재실행으로 rc 0을 확인했다.
  - 실행하지 않은 것: 세션 조정 훅과 STATE 리마인더 훅의 실제 판정, 참조형 마크다운 링크(9/17과 같음, 이번 누적분과 무관).
  - `build-docs-index.mjs --check`는 검증이 아니라 빌드 단계다. 산출물 `docs/docs-index.json`이 `.gitignore:10`에 등록돼 커밋되지 않으므로 fresh clone에서는 어느 브랜치든 항상 실패한다. 생성기를 한 번 돌린 뒤 검사해야 한다.
  - manifest 경로 검사는 `install.py`의 `manifest_files()`를 그대로 써야 한다. JSON을 직접 훑으면 경로가 아닌 문자열(command 설명 등)까지 주워 누락 오탐이 난다.
- 누적 대기: PR #71(admin 가이드 문서 변경), PR #72(admin 미리보기·사용자 화면 가이드), PR #__PR__(admin 1920 상한).
- 직전 실행: 2026-09-17 16/16(차단 판정 44, 승인 게이트 12, 보완 3건 포함).
- 전체 로컬 CI는 3~5개 작업 누적, 하루 종료, 릴리스 전 또는 사용자 명시 요청 시 별도 6단계 작업으로 실행한다.
- 네이티브 Windows에서 돌릴 때만 `check-codex-skills.mjs`가 CRLF 때문에 실패한다(4순위 참조). WSL에서는 그대로 읽으면 된다.

## 다음 작업

성격별로 묶었다. 위에서 아래로 진행하면 된다.

### 1순위 — 사용자 시각 검수 (재개 지점)

- 디자인 시안 6종을 light/dark·viewport 조합으로 검수한다. 사전 점검은 끝났고 남은 것은 눈으로 보는 확인뿐이다.
- 시작: `node scripts/serve-docs.mjs`로 서버를 띄우고(기본 `http://127.0.0.1:8765`) 상단 이동 바로 admin·user·user-mobile 세 화면을 오가며 시안 셀렉터에서 6종을 순회한다. 문서를 바로 고치려면 `--edit`을 붙인다. 2026-08-14에 세 화면 응답과 셀렉터 6종 구성을, 2026-08-21에 이동 바 왕복 동선을 확인해 뒀다.
- 중점: 활성 시안 `worknest`의 light/dark 대비, 카드 헤어라인 보더와 그림자 정책(hover lift·overlay 한정), gradient 전면 금지 준수, 사이드바·active 채움 전용 토큰 렌더링.
- 의도와 다른 부분이 나오면 관련 카탈로그와 `DESIGN.md`, `STATE.md`를 같은 작업에서 갱신한다.

### 2순위 — 사용자 판단이 필요한 8건


- 라우팅 표 줄이기 (2026-09-12 제안, 답변 대기). `AGENTS.md ## Context Map`은 45항목 74행이고 항상 로드된다. 별도 문서로 분리하는 안은 보류했다 — 색인을 읽어야 한다는 사실부터 알아야 해서 왕복만 늘고, 절감은 14%에 그치며, 연결 프로젝트 17곳에 파급된다. 대신 intake 설문 12종 묶음을 한 줄로 접고 항목별 설명을 다듬는 축약안을 제안했다. 승인하면 바로 구현 가능하다.

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
- 2026-09-17에 바꾼 확인창 두 개가 실사용에서 의도대로 동작하는지 첫 사용 때 확인한다. ① `git reset --hard`를 남은 작업 없이 실행하면 Claude Code 확인창이 뜨고, 남은 작업이 있으면 보류 사유가 나오는지 ② 승인 마커 없이 `STATE.md`를 기록할 때 확인창이 더는 뜨지 않는지. 둘 다 회귀 검사는 통과했지만 실제 확인창 표시는 보지 못했다.
- 강제 push 규칙 오탐 (2026-09-17 실제 발생). `block-destructive.sh`의 `git\s+push\s+.*(-f|--force)\b`가 `.*`로 체인 구분자(`&&`)를 넘어가, `git push origin --delete 브랜치 && ... && rm -f 파일`처럼 한 줄로 이어 쓴 명령 뒤쪽의 `rm -f`를 push 옵션으로 보고 막았다. 명령을 나눠 실행하면 통과한다. 재발이 잦으면 push 구간(다음 `;`·`&&`·`|` 전까지)에서만 플래그를 찾도록 `rm` 규칙과 같은 방식으로 좁힌다.

### 4순위 — 선택 개선

Windows 이식성 2건은 여기 있다. 주 개발 환경이 WSL이고 2026-09-03 실측에서 WSL은 두 결함 모두에 해당하지 않는 것이 확인됐다. 네이티브 Windows에서 템플릿을 쓸 계획이 생기면 그때 올린다.

- `install.py --link`의 symlink 구분자 (Windows 전용). `relative_link()`가 `"../" * n + "rules/" + rel`로 구분자를 `/`에 고정한다. Linux에서 만든 symlink는 지금도 정상이고, 네이티브 Windows에서만 reparse point가 해석하지 못해 깨진다. 고치려면 `os.path.join(*([".."] * rel.count("/")), "rules", *rel.split("/"))`로 바꾸고 `symlink_to(..., target_is_directory=...)`를 함께 넘긴다. 역슬래시 형태는 WSL에서도 정상 해석되는 것을 실측했으므로(WSL DrvFs가 구분자를 정규화한다) 양쪽 모두 안전한 유일한 형태다. `sos_sccl` 타깃은 이미 손으로 복구했다.
- `check-codex-skills.mjs`의 CRLF 처리 (Windows 전용). `core.autocrlf=true`로 클론하면 frontmatter 첫 줄이 CRLF로 끝나는데 13행의 `startsWith` 검사가 LF만 기대해 Skill 14종을 전부 누락으로 판정하고 rc=1로 실패한다. WSL 클론은 LF라 영향이 없다. 파서에서 CR를 허용하는 방법과 `.gitattributes`로 정규화하는 방법이 있고, 후자는 저장소 전체 체크아웃에 영향을 준다.

- `linear-like` 시안의 light 테마가 렌더링되지 않는다 (2026-09-03 발견, 기록만). 프리뷰 3화면 공통으로 `linear-like`+light 조합에서 `--bg-canvas`·`--bg-surface`·`--bg-brand`·`--fg-default`·`--border-subtle`이 0/5로 비어 body와 카드 배경까지 투명하다. dark는 5/5 정상이고 다른 시안의 light도 정상이다. `docs/admin-fe-preview.html:111`의 `:root[data-design="linear-like"][data-theme="light"]` 블록 안에 dark 블록이 중첩돼 있고 닫는 중괄호가 어긋난 것으로 보인다. 아바타 수정(`fix/avatar-gradient-design-scope`)에서 이 조합의 아바타가 비어 보이는데, 토큰 fallback으로 가리지 않고 원인을 남겼다. 활성 시안이 아니라 급하지 않다.

- 배포 차단 훅이 `NODE_ENV=production npm run migrate`처럼 환경 변수로 지정한 production migration은 판정하지 않는다 (2026-09-26 CI에서 발견, 기록만). 해당 형태를 쓰는 연결 프로젝트가 생기면 올린다.
- 전체 CI 보완 검사 3건을 저장소 상시 검사로 추가한다 (2026-09-17 CI에서 임시 스크립트로 실행). 배포 차단 판정(16건), 비밀 파일 차단 판정(11건), 훅 내장 Python 본문 구문 검사(7개)다. 훅의 Python 본문이 깨지면 판정이 비어 조용히 통과하는 구조라 `bash -n`으로는 못 잡는다. `check-destructive-guard.mjs`와 같은 형식으로 만들면 다음 CI부터 자동으로 포함된다.
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
