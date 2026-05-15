# Designs Library

프로젝트가 사용할 수 있는 디자인 시스템 카탈로그 라이브러리다. root `DESIGN.md`(active)는 이 디렉터리의 한 파일을 복사해 만들어진다.

## 구성

- `_alias-contract.md` — 모든 시안이 정의해야 하는 alias 토큰 계약. 이 계약을 지켜야 admin guide·preview·design-reviewer가 시안과 무관하게 동작한다.
- `_template.md` — 신규 시안 작성용 빈 골격. 섹션 헤딩과 frontmatter만 있는 스타터.
- `<slug>.md` — 사용 가능한 시안. 각 파일의 frontmatter `slug` 필드가 라이브러리 식별자.
- `custom-*.md` — 사용자가 만든 프로젝트 전용 시안 (gitignore 권장 또는 fork 후 commit).

## 사용 방법

### 라이브러리 목록 확인
```bash
bash .claude/plugins/select-design.sh --list
```

### 시안 활성화 (root DESIGN.md로 복사)
```bash
bash .claude/plugins/select-design.sh wanted
bash .claude/plugins/select-design.sh material-3
bash .claude/plugins/select-design.sh custom-myproject
```

활성화하면 `.claude/.active-design` 파일에 슬러그가 기록된다. root `DESIGN.md`가 직접 편집된 상태면 자동으로 `DESIGN.md.bak` 백업을 만든다.

### 신규 시안 추가
1. `cp designs/_template.md designs/<slug>.md` (또는 기존 시안 fork: `cp designs/wanted.md designs/<slug>.md`)
2. frontmatter `name`, `slug`, `category`, `last_updated` 갱신.
3. `_alias-contract.md`에 정의된 alias를 모두 채운다.
4. `select-design.sh <slug>`로 활성화.

### install 시 기본 시안 지정
```bash
bash .claude/plugins/install.sh --design wanted /path/to/my-project
```
`--design` 플래그가 없으면 기본값 `wanted`가 활성화된다.

## 정본 진입점

`.claude/skills/design/SKILL.md`, `.claude/agents/design-reviewer.md`, `docs/admin-fe-design-guide.md`, `docs/admin-fe-preview.html`은 모두 root `DESIGN.md` 한 파일만 본다. 라이브러리에서 어떤 시안을 활성화하든 이들 자산은 변경 없이 그대로 동작한다.

## 운영 메모

- 시안을 추가하거나 갱신하면 `STATE.md ## 이번 세션에서 완료한 작업`에 한 줄 기록한다 (운영 규칙).
- 시안 frontmatter `last_updated`는 같은 커밋에서 갱신한다.
- alias 계약 위반 시 admin guide와 preview가 깨진다. 신규 시안은 PR 단계에서 alias 누락을 검수한다.
