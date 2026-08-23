# Safety Checklist

Codex는 Claude Code hooks를 자동 실행하지 않으므로 작업 전에 아래 항목을 직접 확인한다.

## 사용자 확인 필요

- 파일 삭제, 대규모 이동, 구조 재편
- `rm -rf`, `git reset --hard`, `git clean -f`, 강제 push
- `docker compose down -v`처럼 로컬 데이터를 삭제하는 명령
- 배포·릴리스 계열 전반. 아래 `## 실행 전 공용 판정기`로 먼저 판정한다.
  - CI/릴리스 트리거: `gh workflow run`, `gh run rerun`, `gh release`, 릴리스 태그 push
  - PaaS/클라우드 배포: `vercel`, `fly`, `netlify`, `render`, `serverless`, `eb`, `gcloud`, `aws`, `az`
  - 컨테이너/패키지 배포: `docker push`, `npm`/`pnpm`/`yarn`/`bun`/`cargo`/`poetry` publish, `twine upload`
  - 오케스트레이션: `kubectl apply`/`rollout`, `helm install`/`upgrade`, `terraform apply`/`destroy`, `pulumi up`
  - 배포 스크립트와 환경 지정: `npm run deploy`, `make deploy`, `--env staging|production`
- 원격(`staging`/`production`) migration 적용 (호칭 정의: `docs/local-dev-ci-guide.md §0`)
  - `prisma migrate deploy`, 원격 대상 `drizzle-kit`/`alembic`/`rails db:migrate`, `DATABASE_URL`이 원격을 가리키는 명령
- 비밀 파일(`.env`, `*.pem`, `*.key`, `credentials.json`) 생성 또는 수정

## 사용자 확인 불필요

3단계 승인 안에 이미 포함된 사실 기록이므로 매번 다시 묻지 않는다. 상세는 `docs/approval-workflow.md ## 재확인하지 않는 작업`.

- `STATE.md`의 완료 이력, 다음 작업, 알려진 TODO, 전체 CI 대기열 갱신
- `DESIGN.md`나 가이드 문서 변경에 따른 `STATE.md` 변경 이력 기록

## 실행 전 공용 판정기

Codex는 Claude Code hooks를 자동 실행하지 않는다. 대신 같은 스크립트를 판정 전용으로 호출해
두 런타임이 같은 기준으로 판단한다. 알림 어댑터가 `notify-pending.sh`를 공유하는 방식과 같다.
경로는 프로젝트 루트를 먼저 찾고, 없으면 `rules/.claude/hooks/` 아래 같은 파일을 쓴다.

Bash 명령 실행 전:

```bash
echo '{"command":"<실행할 명령>"}' | bash .claude/hooks/block-destructive.sh
echo '{"command":"<실행할 명령>"}' | bash .claude/hooks/block-deploy.sh
```

파일 쓰기 전:

```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"<경로>"}}' | bash .claude/hooks/block-secret-files.sh
```

- 종료 코드 `0`이면 그대로 진행한다.
- 종료 코드 `2`면 실행하지 않는다. 출력된 사유와 필요한 명령을 사용자에게 전달하고 사용자가 직접 실행하도록 둔다.
- 스크립트를 찾을 수 없으면 위 `## 사용자 확인 필요` 목록으로 직접 판단한다.
- 차단 패턴의 정본은 스크립트다. 이 문서에 패턴 목록을 복제하지 않는다.

## 기본 방침

- 단순 사실 조회 외 작업은 `docs/approval-workflow.md`의 현재 단계와 3단계 승인 여부를 먼저 확인한다.
- 응답에 `현재 단계`, `이번 단계 산출물`, `다음 단계`, `쓰기 가능 여부`를 먼저 선언한다.
- Step 1~2에서는 읽기 전용 명령만 실행하고, Step 3 승인 전에는 파일 수정·설치·worktree·브랜치·commit·push를 실행하지 않는다.
- 작업 전에 `docs/project-guide.md`와 현재 작업 영역의 하위 `AGENTS.md`를 확인하고 프로젝트 로컬 기준을 템플릿 기본값보다 우선한다.
- 의도가 불명확한 파괴적 명령은 실행하지 않는다.
- 파괴·배포·비밀 파일 판단은 기억이 아니라 위 공용 판정기 호출 결과를 근거로 삼는다.
- Codex 승인 요청이 필요한 명령은 승인 절차를 사용한다.
- 불필요한 우회 명령으로 sandbox를 피하지 않는다.
