# Safety Checklist

Codex는 Claude Code hooks를 자동 실행하지 않으므로 작업 전에 아래 항목을 직접 확인한다.

## 사용자 확인 필요

- 파일 삭제, 대규모 이동, 구조 재편
- `rm -rf`, `git reset --hard`, `git clean -f`, 강제 push
- `docker compose down -v`처럼 로컬 데이터를 삭제하는 명령
- GitHub Actions 배포/릴리스 실행
- 원격(`staging`/`production`) migration 적용 (호칭 정의: `docs/local-dev-ci-guide.md §0`)
- 비밀 파일(`.env`, `*.pem`, `*.key`, `credentials.json`) 생성 또는 수정

## 사용자 확인 불필요

3단계 승인 안에 이미 포함된 사실 기록이므로 매번 다시 묻지 않는다. 상세는 `docs/approval-workflow.md ## 재확인하지 않는 작업`.

- `STATE.md`의 완료 이력, 다음 작업, 알려진 TODO, 전체 CI 대기열 갱신
- `DESIGN.md`나 가이드 문서 변경에 따른 `STATE.md` 변경 이력 기록

## 기본 방침

- 단순 사실 조회 외 작업은 `docs/approval-workflow.md`의 현재 단계와 3단계 승인 여부를 먼저 확인한다.
- 응답에 `현재 단계`, `이번 단계 산출물`, `다음 단계`, `쓰기 가능 여부`를 먼저 선언한다.
- Step 1~2에서는 읽기 전용 명령만 실행하고, Step 3 승인 전에는 파일 수정·설치·worktree·브랜치·commit·push를 실행하지 않는다.
- 작업 전에 `docs/project-guide.md`와 현재 작업 영역의 하위 `AGENTS.md`를 확인하고 프로젝트 로컬 기준을 템플릿 기본값보다 우선한다.
- 의도가 불명확한 파괴적 명령은 실행하지 않는다.
- Codex 승인 요청이 필요한 명령은 승인 절차를 사용한다.
- 불필요한 우회 명령으로 sandbox를 피하지 않는다.
