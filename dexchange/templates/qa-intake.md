# QA & Workflow Intake Template

## 테스트 강제 수준
- 에이전트가 새로운 기능을 구현할 때 반드시 작성해야 하는 테스트 수준 (Unit, E2E, 통합)
- 제외하거나 생략 가능한 영역

## Git 컨벤션
- 커밋 메시지 규칙 (Conventional Commits, 이슈 번호 태깅 등)
- 브랜치 전략 및 PR 템플릿 사용 여부

## CI/CD 
- 코드가 반영된 이후 실행되는 자동화 파이프라인 (린트 검사, 자동 배포 등)의 존재 여부와 조건
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
- PR 생성 시: lint + typecheck + 단위 테스트 자동 실행.
- main 머지 시: 빌드 + e2e 테스트 + staging 자동 배포.
- production 배포는 수동 승인.
- 디자인 토큰 외 값 정책: 경고만(stylelint custom rule + PR 코멘트). 차단까지는 false-positive 우려로 보류.
```
