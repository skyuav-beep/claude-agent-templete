# QA & Workflow Intake Template

## 테스트 강제 수준
- 에이전트가 새로운 기능을 구현할 때 반드시 작성해야 하는 테스트 수준 (Unit, E2E, 통합)
- 제외하거나 생략 가능한 영역

## Git 컨벤션
- 커밋 메시지 규칙 (Conventional Commits, 이슈 번호 태깅 등)
- 브랜치 전략 및 PR 템플릿 사용 여부

## CI/CD (로컬 CI 우선)
- CI는 git(GitHub Actions)에서 자동 실행하지 않고 **로컬에서 개발자 요청 시** 실행하는 것이 기본이다 (`docs/local-dev-ci-guide.md §6.2`). 로컬 CI 스위트 구성(lint/typecheck/test/build, Docker smoke 포함 여부)과 단일 진입점(예: `pnpm ci:local`) 정의
- GitHub Actions를 둘 경우: push/PR 자동 트리거를 끄고(`workflow_dispatch` 강등) `act` 로컬 재현용으로만 쓸지, 아니면 워크플로를 두지 않을지 (`§6.4`)
- 머지·브랜치 정리 정책 (squash 여부, 머지 후 로컬/원격 브랜치 삭제 — `§6.3/§6.5`)
- 디자인 토큰 외 값(hex 직접 사용, 비-4의 배수 px) PR에서 경고 표시 여부 — 없음 / 경고만 / 차단 중 선택
  - 경고만: `.claude/hooks/warn-design-tokens.sh`(opt-in) 또는 CI 단계의 lint rule로 PR 코멘트 형태 알림
  - 차단: stylelint/eslint 룰로 빌드 실패 처리

## 작성 예시

```
## 테스트 강제 수준
- 비즈니스 로직(서비스, 도메인 함수)에는 단위 테스트 필수.
- 핵심 사용자 흐름 3종(가입, 결제, 주문 취소)에는 e2e 테스트 필수.
- UI 스냅샷 테스트는 도입하지 않는다 (유지비 대비 효용 낮음).
- 외부 SDK 래퍼 단순 위임 코드는 테스트 면제.

## Git 컨벤션
- Conventional Commits 사용 (`feat:`, `fix:`, `refactor:`, `chore:` 등).
- 본문에 관련 이슈 번호 `Refs: #142` 표기.
- 브랜치: `feat/<scope>-<short>`, `fix/<scope>-<short>`.
- PR 템플릿은 `.github/pull_request_template.md` 사용.

## CI/CD
- CI는 GitHub에서 자동으로 돌리지 않는다. 개발자가 `CI 돌려`를 지시할 때 **로컬**에서 `pnpm ci:local`(= lint + typecheck + 단위 테스트 + build) 실행. green이 push·머지 게이트.
- e2e/Docker smoke는 환경 구성된 경우 로컬 CI 스위트에 포함.
- GitHub Actions 워크플로: 두지 않음(또는 `workflow_dispatch`로 강등해 `act` 로컬 재현용으로만).
- 머지: squash, 머지 후 로컬·원격 작업 브랜치 삭제 + `git fetch --prune`.
- 배포: production 반영은 수동.
- 디자인 토큰 외 값 정책: 경고만(stylelint custom rule). 차단까지는 false-positive 우려로 보류.
```
