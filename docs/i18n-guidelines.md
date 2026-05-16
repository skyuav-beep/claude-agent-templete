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

## 10. 디렉터리 배치 패턴

프로젝트 규모와 팀 운영 방식에 맞춰 다음 3가지 패턴 중 하나를 채택한다.

### 10.1. namespace-split (권장, 중대형 프로젝트)

```
locales/
├─ ko/
│  ├─ common.json        # 공통 UI (버튼, 라벨, 빈 상태)
│  ├─ errors.json        # 에러 메시지 + HTTP status
│  ├─ admin.json         # admin 도메인
│  ├─ orders.json        # 주문 도메인
│  └─ riders.json        # 라이더 도메인
├─ en/
│  └─ ...  (ko와 동일 namespace 구조)
└─ ja/
   └─ ...
```

- 장점: 코드 분할(`useTranslation('orders')`로 namespace만 로드)에 친화적, 번역가가 도메인 단위로 작업 분담 가능.
- 단점: namespace 경계 결정 필요 (도메인 vs 화면 vs 컴포넌트).
- 적합: 도메인이 명확하고 번역 인력이 분담되는 프로젝트.

### 10.2. locale-flat (소형, MVP)

```
locales/
├─ ko.json   # 모든 키를 단일 파일로
├─ en.json
└─ ja.json
```

- 장점: 단순, fallback 구현이 직관적.
- 단점: 파일이 커지면 머지 충돌 빈발, 초기 번들 크기 증가.
- 적합: 키 < 300개, 단일 팀 운영.

### 10.3. feature-co-located (대형, monorepo)

```
src/features/orders/
├─ OrdersPage.tsx
├─ OrdersList.tsx
└─ locales/
   ├─ ko.json
   ├─ en.json
   └─ ja.json
```

- 장점: 기능 폴더 단위로 i18n이 함께 이동/삭제됨. dead-key 감소.
- 단점: 빌드 시 locale 파일을 수집·병합하는 단계 필요(`vite-plugin-i18n`, `webpack glob` 등).
- 적합: feature-first 디렉터리 + monorepo 또는 대규모 plugin/microfrontend.

## 11. 키 네이밍 구조

### 11.1. dot-nested (권장)

```json
// locales/ko/orders.json
{
  "list": {
    "title": "주문 목록",
    "empty": "조회된 주문이 없어요. 필터를 조정해 보세요",
    "filter": {
      "status": "상태",
      "date_range": "주문일"
    }
  },
  "detail": {
    "title": "주문 #{orderId}",
    "actions": {
      "cancel": "주문 취소",
      "refund": "환불 처리"
    }
  },
  "errors": {
    "not_found": "주문을 찾을 수 없어요",
    "already_cancelled": "이미 취소된 주문이에요"
  }
}
```

호출:

```ts
const { t } = useTranslation('orders');
t('list.title');                        // "주문 목록"
t('detail.title', { orderId: 1023 });   // "주문 #1023"
t('errors.not_found');                  // "주문을 찾을 수 없어요"
```

규칙:
- 키는 snake_case (`date_range`, `not_found`). camelCase 혼용 금지.
- 깊이 4 이하 유지. 5 이상 깊어지면 namespace 분리 검토.
- 값에 HTML 마크업 직접 삽입 금지. 강조는 `<strong>{value}</strong>` 같은 컴포넌트 보간(`<Trans>`)으로 처리.
- 동일 의미 키 중복 방지 — `common.json`에 둘지 도메인 namespace에 둘지 한 곳만 결정.

### 11.2. plural 처리 (ICU 또는 i18next plural suffix)

```json
// i18next 방식
{
  "orders_count_one": "주문 1건",
  "orders_count_other": "주문 {{count}}건"
}
```

```ts
t('orders_count', { count: 1 });   // "주문 1건"
t('orders_count', { count: 24 });  // "주문 24건"
```

한국어는 단/복수 구분이 약해서 `_other`만 정의하고 `_one`은 생략해도 무방하다. en/ja는 명시적으로 양쪽 정의.

### 11.3. interpolation 정책

- `{name}` 같은 plain placeholder를 권장. HTML escape는 라이브러리 기본값 사용(react-i18next는 기본 `escapeValue: true`).
- 날짜·통화는 키 안에서 직접 처리하지 않고 `Intl.DateTimeFormat`/`Intl.NumberFormat` 결과를 보간한다.

## 12. fallback 코드 샘플

### 12.1. Next.js (App Router) + next-intl

```ts
// i18n/config.ts
export const locales = ['ko', 'en', 'ja'] as const;
export const defaultLocale = 'ko';
export type Locale = typeof locales[number];
```

```ts
// i18n/request.ts (next-intl 표준)
import { getRequestConfig } from 'next-intl/server';
import { locales, defaultLocale } from './config';

export default getRequestConfig(async ({ requestLocale }) => {
  const requested = await requestLocale;
  const locale = locales.includes(requested as any) ? requested : defaultLocale;

  let messages;
  try {
    messages = (await import(`../../locales/${locale}/index.json`)).default;
  } catch {
    messages = (await import(`../../locales/${defaultLocale}/index.json`)).default;
  }
  return { locale, messages };
});
```

```ts
// middleware.ts (subpath 라우팅 + 자동 redirect)
import createMiddleware from 'next-intl/middleware';
import { locales, defaultLocale } from './i18n/config';

export default createMiddleware({
  locales,
  defaultLocale,
  localePrefix: 'as-needed',  // ko는 prefix 없이 /, en/ja는 /en, /ja
});

export const config = { matcher: ['/((?!api|_next|.*\\..*).*)'] };
```

라우팅 결과: `/orders` → ko, `/en/orders` → en, `/ja/orders` → ja. 잘못된 locale은 middleware가 defaultLocale로 redirect.

### 12.2. react-i18next + 키 누락 fallback

```ts
// i18n.ts
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';
import HttpApi from 'i18next-http-backend';

i18n
  .use(HttpApi)
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    supportedLngs: ['ko', 'en', 'ja'],
    fallbackLng: {
      'ja': ['en', 'ko'],   // ja 누락 시 en → ko 순으로 fallback
      'default': ['ko'],
    },
    ns: ['common', 'orders', 'riders', 'errors'],
    defaultNS: 'common',
    backend: { loadPath: '/locales/{{lng}}/{{ns}}.json' },
    interpolation: { escapeValue: false },  // React가 이미 escape함
    saveMissing: process.env.NODE_ENV === 'development',
    missingKeyHandler: (lng, ns, key) => {
      console.warn(`[i18n] missing: ${lng}/${ns}:${key}`);
    },
  });
```

빌드 시 누락 키 차단:

```ts
// scripts/check-i18n.ts (CI에서 실행)
import fs from 'fs';
import path from 'path';

const locales = ['ko', 'en', 'ja'];
const base = JSON.parse(fs.readFileSync('locales/ko/orders.json', 'utf8'));
const flatten = (obj: any, prefix = ''): string[] =>
  Object.entries(obj).flatMap(([k, v]) =>
    typeof v === 'object' ? flatten(v, `${prefix}${k}.`) : [`${prefix}${k}`]
  );
const baseKeys = new Set(flatten(base));

const missing: Record<string, string[]> = {};
for (const loc of locales) {
  if (loc === 'ko') continue;
  const data = JSON.parse(fs.readFileSync(`locales/${loc}/orders.json`, 'utf8'));
  const keys = new Set(flatten(data));
  missing[loc] = [...baseKeys].filter(k => !keys.has(k));
}
const broken = Object.entries(missing).filter(([_, ks]) => ks.length > 0);
if (broken.length) {
  console.error('Missing keys:', broken);
  process.exit(1);
}
```

### 12.3. vanilla Intl (라이브러리 없음, 소형)

```ts
// i18n.ts
type Locale = 'ko' | 'en' | 'ja';
const FALLBACK_CHAIN: Record<Locale, Locale[]> = {
  ko: ['ko'],
  en: ['en', 'ko'],
  ja: ['ja', 'en', 'ko'],
};

const dictionaries: Record<Locale, any> = {
  ko: require('./locales/ko.json'),
  en: require('./locales/en.json'),
  ja: require('./locales/ja.json'),
};

export function t(locale: Locale, key: string, params: Record<string, unknown> = {}): string {
  for (const loc of FALLBACK_CHAIN[locale]) {
    const value = key.split('.').reduce<any>((acc, k) => acc?.[k], dictionaries[loc]);
    if (typeof value === 'string') {
      return value.replace(/\{(\w+)\}/g, (_, k) => String(params[k] ?? `{${k}}`));
    }
  }
  if (process.env.NODE_ENV !== 'production') console.warn(`[i18n] missing key: ${key}`);
  return key;
}
```

호출:

```ts
t('en', 'orders.list.title');                           // "Orders"
t('ja', 'orders.detail.title', { orderId: 1023 });      // "注文 #1023" or fallback to en
```

### 12.4. fallback 동작 검증 체크

- 모든 locale에서 keystroke로 `__MISSING__` 보내는 mock dictionary를 만들어 fallback 체인이 올바른 순서로 동작하는지 확인.
- 의도적으로 한 키만 빠뜨린 테스트 케이스를 작성. `expect(t('ja', 'orders.list.title')).toBe('Orders')` 같은 fallback 결과 검증.
- `process.env.NODE_ENV === 'development'`에서만 missing key 콘솔 경고 출력. production은 silent fail + 키 자체 반환.

## 13. 운영 체크리스트 (CI 단계)

PR 머지 전 자동 검증 항목:

- [ ] 기본 locale(ko) 키 셋과 다른 locale 키 셋의 diff가 0
- [ ] 하드코딩된 한글/영문 UI 문자열 검출(eslint-plugin-i18next 또는 grep 정규식)
- [ ] 새 namespace 추가 시 `i18n/config.ts`의 `ns` 배열 갱신 여부
- [ ] subpath 라우팅을 쓴다면 `[locale]/` 폴더 구조와 middleware matcher 정합
- [ ] interpolation 변수명이 locale 간 일치 (`{orderId}`를 어떤 locale에서는 `{order_id}`로 쓰지 않음)
