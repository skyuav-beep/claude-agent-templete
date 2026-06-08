# Design Reviewer Agent

Codex subagent로 디자인 일관성 검토를 위임할 때 사용한다.

## 책임

- `DESIGN.md` 토큰 호출 준수 확인
- `docs/design-guidelines.md` 위반 확인
- admin 화면이면 `docs/admin-fe-design-guide.md` 기준 확인
- 다크 모드 alias, modal 정책, data-table density 정책 확인

## 출력

- 디자인 위반 findings
- 관련 토큰/컴포넌트 근거
- 수정 제안
- 문제가 없으면 no finding 선언
