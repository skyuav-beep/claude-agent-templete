# Skills Layer 전환 TODO

Commands -> Skills 전환 작업의 미완성, 개선, 누락 항목을 난이도 순으로 정리한다.

## 미완성 기능

- [x] `refactor` SKILL.md 작성 (commands/refactor.md 내용 전환)
- [x] `review` SKILL.md 작성 (commands/review.md 내용 전환)
- [x] `business-logic` SKILL.md 작성 (commands/business-logic.md 내용 전환)
- [x] `intake` SKILL.md 작성 (commands/intake.md 내용 전환)
- [x] `CLAUDE.md` Skills Layer 섹션을 `.claude/skills/` 기준으로 업데이트
- [x] `AGENTS.md` Context Map의 Skills Layer 경로를 `.claude/skills/`로 변경
- [x] `STATE.md`에 Skills 전환 작업 이력 반영
- [x] `README.md`의 커스텀 커맨드 섹션을 Skills 구조 기준으로 업데이트
- [x] `.claude/plugins/manifest.json`에 skills 파일 목록 추가
- [x] 기존 `.claude/commands/` 파일 정리 방침 결정 (삭제 or 병존) — 결정: 병존 (skills=자동 활성화, commands=명시적 호출)

## 개선 필요

- [x] 완료된 SKILL.md 4개(`start`, `request`, `feature`, `bugfix`)의 description 키워드 보강 — 한국어+영문 트리거 키워드 병기 완료
- [x] `request` skill과 개별 skill(`feature`, `bugfix` 등) 간 우선순위 충돌 방지 규칙 명시 — `request`는 키워드 모호할 때만 활성화하도록 description 수정 + CLAUDE.md/SKILL.md에 규칙 명시
- [x] skill 간 연계 흐름 정의 — `start` 완료 후 `intake`/`request`/개별 skill로 이어지는 가이드를 CLAUDE.md와 start SKILL.md에 추가
- [x] `settings.local.json`에 skills 관련 설정 필요 여부 확인 — 별도 설정 불필요(SKILL.md 파일 존재만으로 자동 활성화)
- [x] `docs/subagent-guide.md`에 skills와 서브에이전트의 역할 구분 명시

## 에러/누락 처리

- [x] 기존 SKILL.md의 `$ARGUMENTS` 참조 — 자연어 파싱 방식("사용자 메시지에 ~ 있으면")으로 재설계
- [x] 작성된 SKILL.md 내 `/feature`, `/bugfix` 등 slash command 참조 링크 — "해당 skill이 활성화된다" 표현으로 대체
- [x] `start` SKILL.md의 "다음 액션"에 `/intake`, `/request` 등 command 참조 — skills 기반 안내로 변경 완료
- [x] `request` SKILL.md의 분류 결과가 command(`/feature`) 호출을 안내 — skills 매칭으로 전환 완료
- [x] `intake` skill의 토픽 매핑 12종이 실제 `templates/*-intake.md` 파일 존재와 일치하는지 검증 — 12종 모두 존재 확인
