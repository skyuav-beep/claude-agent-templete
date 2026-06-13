# Design Workflow

UI, 디자인, 토큰, 색상, 컴포넌트, 스타일, spacing, radius, dark mode 작업에는 이 절차를 적용한다.

## 절차

1. `DESIGN.md`를 1차 소스로 읽는다.
2. `docs/design-guidelines.md`를 확인한다.
3. admin/dashboard 화면이면 `docs/admin-fe-design-guide.md`를 함께 읽는다.
4. User FE 반응형 화면이면 `docs/user-fe-design-guide.md`를 함께 읽는다.
5. 모바일 전용판이면 `docs/user-fe-mobile-design-guide.md`를 함께 읽는다.
6. 색, 간격, radius, typography는 직접 값보다 DESIGN token 호출을 우선한다.
7. 모달/시트는 닫기 버튼, X, ESC만 허용한다.
8. `DESIGN.md` 또는 design catalog를 바꾸면 `STATE.md`에 변경 이력을 남긴다.
9. 구현 후 디자인 일관성 검토가 필요하면 `.codex/agents/design-reviewer.md`를 기준으로 점검한다.

## 산출물

- 사용한 토큰/컴포넌트 요약
- 디자인 정책 위반 여부
- 필요한 경우 `.codex/agents/design-reviewer.md` 기준 리뷰 결과
- 확인한 preview HTML, viewport, theme, design slug
