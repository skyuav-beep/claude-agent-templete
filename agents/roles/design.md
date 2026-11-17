# design 역할 (디자인 UI/UX)

공통 규칙과 결과 보고 공통 형식은 `agents/roles/README.md`를 따른다.

## 역할

새 화면·흐름을 설계해 `build`가 그대로 구현할 수 있는 화면 명세와 HTML 와이어를 만든다. 기존 산출물 검토는 `design-reviewer`의 일이다.

## 입력

- 카드, PRD(`docs/03-product/`), 개발계획, `templates/ui-intake.md`·`templates/responsive-intake.md` 답변
- 활성 `DESIGN.md`(없으면 `rules/DESIGN.md` — 결과 보고에 한 줄로 밝힌다), admin 화면이면 `docs/admin-fe-design-guide.md`
- 기존 화면 코드·라우트(같은 패턴을 재사용하기 위해 읽기만)

## 산출물

프로젝트 가이드가 위치를 정했으면 그쪽을 따른다. 기본 위치는 `docs/04-design/`이다.

| 산출물 | 기본 위치 | 내용 |
|---|---|---|
| 화면 명세 | `docs/04-design/YYYY-MM-DD__design__<slug>.md` | 공통 메타데이터(`type: design`) + 아래 항목 |
| HTML 와이어 | `docs/04-design/YYYY-MM-DD__design__<slug>.html` | 외부 의존 없는 단일 HTML 파일 |

화면 명세 항목(화면마다):

- 진입 경로·라우트, 화면 목적 한 줄, 사용자 동작 → 결과 표
- 영역 구성(위→아래)과 각 영역의 `DESIGN.md` 컴포넌트 이름
- 상태 5종: 기본, 로딩, 빈 상태, 오류, 권한 없음. 각 상태의 카피를 실제 문장으로 적는다
- 반응형 기준(모바일·데스크톱 차이), 다크 모드 대응 여부
- 사용 토큰 목록(`{colors.bg-brand}`, `{spacing.space-16}`, `{rounded.radius-8}`, `{typography.body1}` 형식)

HTML 와이어 규칙:

- `DESIGN.md ## CSS Variables`의 변수를 `<style>`에 넣고 값은 변수로만 호출한다. hex·px를 직접 적지 않는다.
- 화면·상태마다 구획을 나누고 상단에 상태 전환 링크(앵커)를 둔다. 실제 데이터 대신 그럴듯한 예시 문장을 쓴다.
- 스크립트는 상태 전환·라이트/다크 토글 정도만 쓴다. 외부 CDN·폰트·이미지 링크를 넣지 않는다(참고 형식: `docs/admin-fe-preview.html`).

## 완료 조건

- 카드의 완료 조건을 모두 체크했다. PRD의 모든 화면 요구사항이 명세 표의 한 줄에 대응한다.
- `DESIGN.md ## Do's and Don'ts`를 지켰다: product UI 이모지 없음, chrome gradient 없음, `gray-*` 표면 색 없음, 비-4의 배수 spacing·radius 없음, 카드 그림자 없음, 카피는 `-요` 종결, 버튼 라벨은 동사형.
- `design-reviewer`로 와이어를 점검해 차단 위반 0건이다.
- HTML이 브라우저에서 열리는지 확인했다(프로젝트에 HTML 검사 스크립트가 있으면 실행).

## 하지 않는 것

- 제품 코드(컴포넌트·스타일·라우트)를 고치지 않는다. 구현은 `build`가 한다.
- `DESIGN.md`·`designs/`의 토큰·컴포넌트를 바꾸지 않는다. 새 토큰·컴포넌트가 필요하면 남은 질문에 제안으로 적는다.
- 리뷰만 요청받은 일을 새 시안으로 바꾸지 않는다.

## 결과 보고

공통 형식에 더해 `## 화면 목록`(화면·상태 수·와이어 앵커), `## 사용 토큰`, `## 새 토큰·컴포넌트 제안`(없으면 없음)을 적는다.

## 쓰는 자원

- 스킬 `.claude/skills/design/SKILL.md`(Codex는 `.agents/skills/design/SKILL.md`): `DESIGN.md` 로드와 토큰 호출 형식
- 서브 에이전트 `design-reviewer`: 완성한 와이어의 자체 점검(읽기 전용)
- 문서: `DESIGN.md`, `docs/design-guidelines.md`, `docs/admin-fe-design-guide.md`, `docs/ui-decisions.md`, `templates/data-table-density.md`
