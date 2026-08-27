# 세션 충돌 조정 가이드

Claude와 Codex가 같은 저장소에서 동시에 작업할 때 세션 상태와 파일 점유를 확인하는 기준이다.

## 지원 범위

- Claude는 `SessionStart`에서 세션을 등록하고 `SessionEnd`에서 해제한다.
- Claude가 파일을 수정하기 전에 공용 레지스트리에서 동일 파일을 점유한 다른 세션을 찾는다.
- 다른 세션이 등록돼 있을 때에 한해, 브랜치·worktree·원격 ref 를 지우는 git 명령도 확인 대상으로 돌린다. 혼자 쓰는 저장소에서는 개입하지 않는다.
- 겹침이 발견되면 자동 수정하지 않고 세션·worktree·파일을 사용자에게 보여 주며 확인을 요청한다.
- Codex는 lifecycle hook이 저장소 설정에 자동 연결되지 않으므로 workflow 시작/종료 시 같은 스크립트를 호출한다.

상태는 저장소의 `.git`이나 worktree에 기록하지 않고 `${XDG_RUNTIME_DIR:-$HOME/.cache}/claude-agent-sessions/` 아래에 저장한다. 따라서 상태 파일이 commit·merge 대상이 되지 않는다.

## 판단 규칙

1. 동일 파일을 다른 active 세션이 점유하면 대기 또는 사용자 확인을 요청한다.
2. 다른 파일을 사용하는 독립 작업은 별도 worktree에서 진행한다.
3. 같은 기능이지만 파일 교집합이 없다는 사실만으로 의미적 중복이 없다고 단정하지 않는다. 작업 제목·PR·기능 범위는 사용자가 조정한다.
4. worktree는 Git 파일과 index를 격리할 뿐 Docker 포트, DB, volume, 외부 API를 격리하지 않는다.
5. 세션이 비정상 종료되면 PID와 실행 파일명을 확인해 stale 등록을 정리한다. PID 는 등록 시 실행기(claude·codex 등) 프로세스를 거슬러 찾아 기록한다.

## Codex 사용

```bash
# 세션 식별자를 현재 셸에 고정한다. 반드시 먼저 실행한다.
eval "$(bash .claude/hooks/session-coordination.sh resource)"

bash .claude/hooks/session-coordination.sh register
bash .claude/hooks/session-coordination.sh status
bash .claude/hooks/session-coordination.sh claim src/example.ts
# 작업 종료
bash .claude/hooks/session-coordination.sh release
```

Codex workflow는 작업 시작 시 `register`와 `status`, 파일을 수정하기 직전에 `claim`을 수행하고, 세션 종료 시 `release`한다. 같은 파일 충돌이 나오면 기존 세션을 기다리거나 사용자의 확인을 받은 뒤에 진행한다.

`SESSION_COORD_SESSION_ID`가 없으면 helper는 셸의 POSIX 세션 ID로 대체한다. 같은 터미널에서 이어서 실행하면 값이 유지되지만, 명령마다 새 세션을 만드는 실행기에서는 갈라질 수 있으므로 위의 `eval`로 고정하는 경로를 기본으로 삼는다.

## 브랜치·worktree 를 지우는 명령

한쪽 창이 만든 브랜치를 다른 창이 정리해 버리면 커밋을 되짚을 단서가 reflog 밖에 남지 않는다. 다른 세션이 등록돼 있을 때 아래 형태는 실행 전 확인을 요청한다.

| 대상 | 예 |
|---|---|
| 브랜치 삭제 | `git branch -D`, `git branch --delete` |
| 원격 ref 삭제 | `git push origin --delete <ref>`, `git push origin :refs/heads/<ref>`, `git update-ref -d` |
| worktree 제거 | `git worktree remove`, `git worktree prune` |
| 이력 덮어쓰기 | `git push --force`, `--force-with-lease`, `--mirror` |

`git push origin main`, `git branch <new>`, `git worktree add` 처럼 남의 작업을 지우지 않는 명령은 그대로 통과한다. 등록된 다른 세션이 없으면 위 명령도 막지 않는다.

이 점검은 `Bash` 도구에 연결돼 있어야 동작한다. 이미 설치된 프로젝트는 `.claude/settings.json` 이 복사본이라 자동으로 갱신되지 않는다. `bash .claude/plugins/install.sh --link` 로 연결한 프로젝트라면 hook 스크립트는 즉시 반영되지만, `Bash` matcher 연결은 프로젝트의 `settings.json` 에 직접 추가하거나 `settings.template.json` 을 다시 복사해야 한다.

## 등록 정리

```bash
bash .claude/hooks/session-coordination.sh prune              # 만료·종료된 등록 정리
bash .claude/hooks/session-coordination.sh prune <session-id> # 특정 세션 등록 삭제
```

세션이 비정상 종료되면 `release`가 실행되지 않아 등록이 남는다. 기본 보존 시간은 8시간이며 `SESSION_COORD_TTL_SECONDS`로 조정한다. `status`에 남아 있는 유령 세션은 `prune`에 세션 ID를 넘겨 지운다.

## 개발 리소스 격리

Compose·DB를 사용하는 프로젝트는 세션별 이름을 먼저 계산할 수 있다.

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
docker compose -p "$COMPOSE_PROJECT_NAME" up -d
```

helper가 제공하는 값은 `COMPOSE_PROJECT_NAME`, `SESSION_COORD_DOCKER_NETWORK`, `SESSION_COORD_DB_NAME`, `SESSION_COORD_PORT_OFFSET`다. Compose 파일의 network/volume/container 이름과 애플리케이션 port mapping, local DB 이름에 프로젝트별 규칙으로 연결해야 실제 리소스가 분리된다. 기존 프로젝트 설정을 자동으로 덮어쓰지는 않는다.

`SESSION_COORD_PORT_OFFSET`는 세션마다 안정적으로 계산한 숫자일 뿐이므로, 실제 host port를 자동으로 바꾸려면 Compose 변수화와 포트 충돌 확인이 추가로 필요하다. 원격 DB나 `staging`/`production` 리소스에는 사용하지 않는다.

## 한계

- 자연어 작업 제목이나 기능 의도까지 자동 비교하지 않는다.
- Bash 명령이 내부적으로 수정하는 파일은 파일 hook만으로 완전히 알 수 없다.
- Docker/DB/port/volume 격리는 helper 값을 프로젝트별 Compose·환경 설정에 연결해야 하며 자동 적용되지 않는다.
- 레지스트리는 같은 사용자 계정과 PC 범위의 조정 장치이며 원격 팀 잠금이 아니다.
- 등록에 pid 가 남으면 실행기 프로세스가 사라진 시점에 자동으로 정리된다. pid 를 못 찾은 등록은 TTL(기본 8시간)까지 남으므로 즉시 지우려면 `prune`을 사용한다.
- `jq`가 없으면 조정이 동작하지 않는다. `flock`이 없는 환경에서는 잠금 없이 진행하므로 동시 갱신이 겹칠 수 있다.
