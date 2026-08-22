# Git Cleanup Workflow

커밋·push·PR·머지·브랜치 정리가 덜 끝난 작업을 한 번에 점검하고 마무리할 때 이 절차를 따른다.

> 경로 규칙: 아래 `templates/`·`agents/`·`docs/`·`designs/`·`DESIGN.md`는 프로젝트 루트를 먼저 찾고, 없으면 `rules/` 아래 같은 경로를 읽는다. 프로젝트 로컬 파일이 우선이며 공통본을 사용했으면 작업 보고에 밝힌다.

## 절차

1. 점검(읽기 전용) — 아래를 확인하고 이 단계에서는 아무것도 바꾸지 않는다.
   - `git status`로 미커밋 변경
   - 브랜치별 원격 대비 ahead 커밋
   - 열린 PR의 draft 여부, 충돌, 필수 검사, 리뷰 상태
   - 머지가 끝났는데 남은 로컬·원격 브랜치와 worktree
   - `STATE.md`에 최근 작업이 기록되지 않았는지
2. 개발 내용 요약 — 변경 내용을 읽어 어떤 작업이 어디까지 진행됐는지 설명한다. 파일 목록 나열로 대신하지 않는다. 커밋 가능한 완결 변경과 미완성 변경을 구분해 표시한다.
3. 정리 계획 제시 — 항목별 처리 방안을 제안하고, 판단이 갈리는 것은 선택지를 준다.
4. 승인 후 실행 — `docs/approval-workflow.md` 3단계 승인 후 6단계 순서대로 수행한다. 빠른 검증 → `STATE.md` 기록 → commit → push → ready PR → 게이트 확인 → merge → 원격 base SHA 검증 → 브랜치·worktree 정리.

## 세션 겹침

여러 세션이 같은 저장소를 쓰고 있으면 정리 전에 다른 세션의 점유를 확인한다.

```bash
eval "$(bash .claude/hooks/session-coordination.sh resource)"
bash .claude/hooks/session-coordination.sh status
```

다른 세션이 작업 중인 브랜치나 worktree는 정리 대상에서 제외하고 사용자에게 알린다.

## 안전 경계

- 배포·릴리스 Action과 `staging`/`production` migration은 실행하지 않는다. 필요한 명령은 사용자에게 인계한다.
- 강제 push, 보호 규칙 우회, 원격 base 강제 갱신은 하지 않는다.
- 만들다 만 변경을 임의로 되돌리거나 버리지 않는다. 삭제는 항상 사용자 확인을 받는다.
- 머지되지 않은 브랜치는 삭제 대상으로 제안하지 않는다.
