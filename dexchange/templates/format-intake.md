# Format & Localization Intake Template

## 세계시 및 타임존 (Timezone & Date)
- 데이터베이스/서버 통신 시 UTC 기준 일괄 적용 여부
- 클라이언트 화면 표시 시 현지 시간(Local Time)으로 자동 변환할 것인가, 아니면 고정 타임존을 사용할 것인가?
- 날짜/시간 표기 포맷 규칙 (예: YYYY-MM-DD HH:mm, ISO 8601 등)

## 화폐 단위 (Currency)
- 다중 통화 지원 여부 (KRW, USD, EUR 등) 및 기본 통화 설정
- 화폐 기호 위치 (금액 앞 vs 금액 뒤) 
- 소수점 표기 여부 (원화는 소수점 제외, 달러는 2자리 등)

## 숫자 표기 (Numbers)
- 천 단위 구분자(Thousands Separator) 사용 기준
- 큰 숫자 축약 표기 사용 여부 (예: 1M, 10K 등)

## 작성 예시

```
## 세계시 및 타임존 (Timezone & Date)
- 서버/DB는 UTC 일괄 저장.
- 클라이언트 표시는 사용자 locale의 현지 시간으로 변환 (`Intl.DateTimeFormat`).
- 표기 포맷: 기본 `YYYY-MM-DD HH:mm`, 상세 페이지는 `YYYY년 M월 D일 (요일) HH:mm`.

## 화폐 단위 (Currency)
- 다중 통화 지원: KRW, USD, JPY. 기본 통화는 사용자 locale 기준 자동 선택.
- 기호 위치: `Intl.NumberFormat` 기본값 사용 (KRW/USD는 앞, EUR은 locale별).
- 소수점: KRW/JPY는 0자리, USD는 2자리.

## 숫자 표기 (Numbers)
- 천 단위 구분자: 항상 사용 (`Intl.NumberFormat`).
- 대시보드 카드 등 좁은 영역에서만 축약 사용 (예: 1.2M, 10K). 본문은 전체 자릿수 노출.
```
