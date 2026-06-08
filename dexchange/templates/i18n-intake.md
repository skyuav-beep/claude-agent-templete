# I18n Intake Template

## 지원 언어

- 어떤 언어를 지원할지 적는다.
- 예: `ko`, `en`, `ja`

## 기본 언어

- 기본 locale은 무엇인지 적는다.
- 번역 누락 시 fallback locale은 무엇인지 적는다.

## 번역 범위

- UI 텍스트만 번역할지
- 에러 메시지, 이메일, 메타데이터, CMS 콘텐츠까지 포함할지 적는다.

## 라우팅 및 언어 전환 방식

- URL, subpath, query, user setting 중 어떤 방식을 쓸지 적는다.
- 언어 전환 시 현재 경로나 상태를 유지할지 적는다.

## 포맷 정책

- 날짜 포맷
- 시간 포맷
- 숫자 포맷
- 통화 포맷
- timezone 정책

## UI/레이아웃 고려사항

- 문자열 길이 증가에 대한 우려가 있는 화면이 있는지 적는다.
- 모바일에서 특히 주의해야 할 화면이 있는지 적는다.

## 운영 규칙

- 누가 번역 key를 관리하는지 적는다.
- 번역 검수 책임이 누구에게 있는지 적는다.

## 미정 사항

- 아직 결정되지 않은 i18n 관련 항목을 적는다.

## 작성 예시

```
## 지원 언어
- `ko`, `en`, `ja`

## 기본 언어
- 기본 locale: `ko`
- fallback: `en`

## 번역 범위
- UI 텍스트, 에러 메시지, 이메일 템플릿까지 번역.
- CMS 콘텐츠는 별도 모델로 locale 분리 저장.
- 메타데이터(SEO title/description)도 번역 포함.

## 라우팅 및 언어 전환 방식
- subpath 방식: `/ko/orders`, `/en/orders`, `/ja/orders`.
- 언어 전환 시 현재 경로와 query는 그대로 유지.
- 사용자 선택은 쿠키 + 계정 설정 둘 다 저장.

## 포맷 정책
- 날짜: `Intl.DateTimeFormat` locale 기본
- 시간: 24h (ko/ja), 12h (en)
- 숫자: `Intl.NumberFormat` locale 기본
- 통화: 사용자 통화 우선, 미설정 시 locale 기본
- timezone: 서버는 UTC, 표시 시 사용자 locale 기준 변환

## UI/레이아웃 고려사항
- 일본어 평균 길이가 한글의 1.4배. 카드 제목, 버튼 라벨이 좁은 영역 주의.
- 모바일 헤더 메뉴는 ja에서 줄바꿈 또는 ellipsis 처리.

## 운영 규칙
- 번역 key는 feature 담당자가 등록.
- 검수는 운영팀에서 매주 일괄 확인.
- 누락 key는 빌드 단계에서 경고로 노출.

## 미정 사항
- 번역 관리 도구 (Crowdin vs Lokalise) 선택.
- en 외 fallback 우선순위.
```
