---
description: "사용자가 UI, 디자인, 스타일, 토큰, 색상, 버튼, 카드, 폼, 타이포, spacing, radius, 다크 모드, 컴포넌트 같은 디자인 키워드를 언급할 때 활성화 (UI, design, style, token, color, component, dark mode, spacing, radius, typography)"
---

# 디자인 시스템 적용

UI/스타일 산출물을 만들거나 검토할 때 `DESIGN.md`를 강제 로드하고 토큰 호출 형식으로 답변을 구성한다.

## 실행 방법

1. `DESIGN.md` 파일을 먼저 읽는다. (1차 소스)
2. 운영 메타 규칙이 필요하면 `docs/design-guidelines.md`를 읽는다.
3. 답변에서 색·간격·라운드·타이포 값을 직접 hex/px로 적지 않고 다음 형식으로 토큰을 호출한다.
   - 색: `{colors.bg-brand}`, `{colors.fg-default}`, `{colors.border-subtle}` (시맨틱 alias 우선, atomic은 새 alias를 만들 때만)
   - 간격: `{spacing.space-16}`, `{spacing.space-24}`
   - 라운드: `{rounded.radius-8}`, `{rounded.radius-12}`, `{rounded.radius-full}`
   - 타이포: `{typography.body1}`, `{typography.title1}`
   - elevation: `{elevation.shadow-pop}`
4. `DESIGN.md`의 `## Do's and Don'ts`를 위반하지 않는지 답변 전 확인한다.

## 입력 처리

- 사용자 메시지에 구체 컴포넌트(button, card, header, chip, toggle, badge, toast, alert, modal, dialog, bottom-sheet, empty-state, job-card, hero-banner, filter-bar, avatar, icon-button, search 등)가 있으면 `DESIGN.md ## Components` 해당 섹션을 우선 인용한다.
- 색·간격·라운드 값이 직접 적혀 있으면 가장 가까운 토큰으로 변환해 제안한다.
- 다크 모드 관련 요청이 있으면 `### Semantic alias — Dark` 섹션을 우선 참조하고, 합성(synthesized) 표기 정책을 알린다.
- 카피·라벨 작성이 포함되면 `-요`/`-어요` 종결과 동사형 버튼 라벨 정책을 적용한다.

## 진행 규칙

- 새 컴포넌트가 필요해 보이면 먼저 `DESIGN.md`의 14개 기본 컴포넌트로 충족 가능한지 확인한다.
- 비-4의 배수(6, 10, 14, 18, 22) spacing/radius를 도입하지 않는다. 컴포넌트 로컬값이 필요하면 SSOT preview 관찰값임을 명시한다.
- gradient는 (1) 심볼 마크, (2) 아바타 circle, (3) 잡카드 thumb placeholder, (4) 마케팅 hero banner 네 자리에만 허용한다.
- 이모지를 product UI에 inline으로 넣지 않는다. 화살표·아이콘은 SVG로 그리도록 안내한다.
- `gray-*` 패밀리는 utility로만 쓰고, UI 표면 색은 `neutral-*` 패밀리에서 호출한다.
- 모달/시트는 닫기 버튼·헤더 X·`ESC`로만 닫고 배경(scrim) 클릭·스와이프 닫기를 도입하지 않는다. 항상 커스텀 표면(`{component.modal}`)으로 구현하도록 안내하고, native(`alert/confirm/prompt`)·pre-styled 라이브러리 모달을 제안하지 않는다(headless 동작 위임은 허용).

## 다른 skill과의 연계

- `feature`/`refactor`/`bugfix` 진행 중 UI 영향이 발견되면 본 skill이 추가로 활성화되어 디자인 일관성 항목을 보강한다.
- 구현 완료 후 디자인 일관성 검증이 필요하면 `code-reviewer`와 별개로 `.claude/agents/design-reviewer.md` 서브에이전트를 호출한다.

## 완료 후

- 답변에서 사용한 토큰 목록을 끝에 짧게 정리한다(예: `사용 토큰: {colors.bg-brand}, {spacing.space-16}, {rounded.radius-8}`).
- `DESIGN.md` 자체를 갱신했다면 `STATE.md`에 토큰/컴포넌트 변경 이력을 남기도록 사용자에게 알린다.
