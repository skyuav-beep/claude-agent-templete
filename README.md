# AI Agent Template

이 저장소는 `개발 프로젝트용 에이전트 운영규칙 템플릿`이다. 목적은 실제 애플리케이션 코드를 바로 제공하는 것이 아니라, 새 프로젝트를 시작할 때 에이전트가 일관된 방식으로 작업하도록 공통 규칙, 역할별 지침, 요청 템플릿을 제공하는 데 있다.

## 포함 내용

- `AGENTS.md`: 모든 에이전트가 따라야 하는 공통 운영 규칙
- `STATE.md`: 현재 상태와 다음 작업 인계를 위한 기록 파일
- `agents/`: 역할별 세부 지침
- `templates/`: 기능 개발, 버그 수정, 리뷰 요청 템플릿
- `docs/`: intake 답변을 바탕으로 작성할 프로젝트 가이드 템플릿
- `templates/i18n-intake.md`, `docs/i18n-guidelines.md`: 다국어 프로젝트용 초기 설문과 기준 문서
- `templates/business-logic-request.md`, `docs/business-logic-playbook.md`: 비즈니스 로직 변경용 요청 템플릿과 프로세스 가이드
- `templates/framework-structure-intake.md`, `docs/framework-structure-guide.md`: 초기 프레임워크/디렉터리/파일 분리 기준 문서

## 사용 방법

1. 이 저장소를 새 프로젝트의 시작점으로 복제한다.
2. `templates/project-intake.md`, `ui-intake.md`, `responsive-intake.md`, `tech-intake.md`에 프로젝트 정보를 먼저 작성한다.
3. 다국어 프로젝트라면 `templates/i18n-intake.md`도 함께 작성한다.
4. intake 답변을 바탕으로 `docs/project-guide-template.md`를 프로젝트 전용 가이드로 복제하고 내용을 채운다.
5. 다국어 프로젝트라면 `docs/i18n-guidelines.md`를 프로젝트 기준에 맞게 채운다.
6. 초기 구조 설계가 중요하면 `templates/framework-structure-intake.md`와 `docs/framework-structure-guide.md`를 함께 사용한다.
7. 비즈니스 로직 중심 프로젝트라면 `templates/business-logic-request.md`와 `docs/business-logic-playbook.md`를 함께 사용한다.
8. 프로젝트 성격에 맞게 `AGENTS.md`를 커스텀한다.
9. `agents/*.md`에서 필요한 역할만 남기고 세부 규칙을 조정한다.
10. `templates/*.md`를 팀 작업 방식에 맞게 수정한다.
11. 작업이 끝날 때마다 `STATE.md`를 업데이트한다.

## README 운영 규칙

- 현재 `README.md`는 템플릿 저장소의 목적과 사용법을 설명한다.
- 실제 프로젝트로 복제된 이후에는 프로젝트별 `README.md`로 교체하거나 재작성한다.
- 실제 프로젝트의 `README.md`에는 프로젝트 소개, 실행 방법, 설치, 환경 설정, 배포 또는 개발 흐름을 적는다.
- 템플릿 사용법을 계속 남겨야 한다면 `docs/template-usage.md` 같은 별도 문서로 분리한다.

## 브라우저 UI

문서 기반 운영을 보조하는 정적 HTML UI를 `docs/` 아래에 둔다. 모두 외부 의존성 없는 단일 파일이며, `file://` 또는 임의의 정적 서버에서 동작한다.

- `docs/development-process.html` — 개발 프로세스 시각 가이드 + 단계별 체크리스트(`localStorage` 저장) + STATE 미니 대시보드.
- `docs/intake.html` — Startup QnA 11섹션 위저드 + 핵심 요청 템플릿 폼. 입력값을 Markdown으로 내보낸다.

### 1차 소스 규칙

- 에이전트가 읽는 1차 소스는 항상 `*.md`다.
- HTML UI는 사람이 보는 보조 화면이며, md를 수정한 뒤 필요 시 HTML도 함께 갱신한다.
- 동기화가 어긋났다고 판단되면 md를 기준으로 HTML을 다시 맞춘다.

### 정적 서버로 열기

`file://`로 열면 STATE 패널 fetch가 막히고, 일부 환경에서는 `.md` 응답 인코딩이 OS 기본값으로 떨어져 한글이 깨질 수 있다. 저장소 루트에서 아래 명령을 실행하면 charset 명시된 정적 서버가 뜬다.

```bash
python3 -c "
import http.server
H = http.server.SimpleHTTPRequestHandler
H.extensions_map.update({
    '.md': 'text/markdown; charset=utf-8',
    '.html': 'text/html; charset=utf-8',
    '.txt': 'text/plain; charset=utf-8',
    '.js': 'application/javascript; charset=utf-8',
    '.css': 'text/css; charset=utf-8',
    '.json': 'application/json; charset=utf-8',
})
http.server.test(HandlerClass=H, port=8765, bind='127.0.0.1')
"
```

접속 주소는 `http://localhost:8765/docs/development-process.html`, `http://localhost:8765/docs/intake.html`.

## 권장 다음 단계

- 프로젝트 유형별 `agents/*.md` 세분화
- `templates/` 확장
- intake 답변 예시와 guide 작성 예시 추가
- 필요 시 `docs/` 아래에 템플릿 사용 예시 추가
- HTML UI 추가 폼(현재는 5종) 확장 또는 md→HTML 자동 동기화 스크립트 도입
