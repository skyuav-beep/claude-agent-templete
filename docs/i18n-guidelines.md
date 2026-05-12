# I18n Guidelines

이 문서는 다국어 기반 프로젝트를 초기부터 일관되게 개발하기 위한 기준 문서다.

## 1. Locale Policy

- 지원 언어 목록
- 기본 locale
- fallback locale
- locale detection 방식

## 2. Translation Scope

- 번역 대상: UI 텍스트, 에러 메시지, 이메일, 메타데이터, CMS 콘텐츠
- 번역 제외 대상이 있다면 명시한다.

## 3. String Rules

- UI 문자열 하드코딩을 금지한다.
- 번역 key 네이밍 규칙을 정의한다.
- interpolation 방식과 pluralization 정책을 정의한다.

## 4. Formatting Rules

- 날짜, 시간, 숫자, 통화는 locale formatter로 처리한다.
- timezone 정책을 정의한다.
- 사용자 locale과 시스템 locale이 다를 경우 처리 방식을 정한다.

## 5. Routing and Switching

- 언어 전환 방식
- locale별 URL 정책
- 언어 전환 시 유지해야 하는 경로와 상태

## 6. UI and Layout Rules

- 긴 문자열을 고려한 layout을 사용한다.
- 버튼, 탭, 카드, 테이블에서 overflow 위험을 점검한다.
- 모바일과 PC에서 모두 문자열 길이 차이를 검토한다.

## 7. Component Rules

- 공통 컴포넌트는 다국어 text length를 견딜 수 있어야 한다.
- placeholder만으로 의미를 전달하지 않는다.
- 상태 메시지와 빈 상태 메시지도 번역 범위에 포함한다.

## 8. Review Checklist

- 번역 누락 key가 보이지 않는가
- fallback이 의도대로 동작하는가
- locale별 formatting이 일관적인가
- 긴 문자열에서 UI가 깨지지 않는가

## 9. Change Policy

- 지원 언어 변경, fallback 변경, routing 변경은 이 문서를 먼저 갱신한다.
- i18n 구조가 실제 구현과 어긋나면 `AGENTS.md` 또는 관련 역할 문서 업데이트를 제안한다.
