---
name: alias contract (라이브러리 호환 계약)
slug: _alias-contract
category: meta
last_updated: "2026-05-15"
---

# Alias Contract

`designs/`의 모든 시안 카탈로그가 반드시 정의해야 하는 토큰 alias 목록이다. 본 계약을 지키는 시안만 admin guide(`docs/admin-fe-design-guide.md`)·preview HTML(`docs/admin-fe-preview.html`)·`design-reviewer` 서브에이전트와 호환된다.

토큰 값(hex / oklch)은 시안마다 다르지만, **alias 이름은 동일**해야 한다. 시안의 시각 차별화는 값과 세부 정책(gradient 위치, 카드 그림자 허용 여부, 카피 톤)에서 발생한다.

## 1. 색 alias

### 1-1. Background (light + dark 양쪽 정의 필수)

| alias | 의미 |
|---|---|
| `bg-canvas` | 페이지 캔버스 (가장 바깥 배경) |
| `bg-surface` | 카드/시트/패널 표면 |
| `bg-subtle` | 페이지 보조 배경 (콘텐츠 영역) |
| `bg-muted` | hover 채움, 헤더 강조 |
| `bg-elevated` | dialog/popover/dropdown 표면 |
| `bg-inverse` | 반전 표면 (다크 영역) |
| `bg-brand` | 브랜드 강조 표면 (primary CTA) |
| `bg-brand-subtle` | 브랜드 약한 채움 (active item bg, ghost hover) |
| `bg-success-subtle` | 성공 상태 약한 채움 |
| `bg-warning-subtle` | 경고 상태 약한 채움 |
| `bg-danger-subtle` | 위험/에러 약한 채움 |

### 1-2. Foreground

| alias | 의미 |
|---|---|
| `fg-strong` | 가장 강한 본문/제목 (alpha 1.0) |
| `fg-default` | 본문 기본 |
| `fg-secondary` | 라벨/캡션 |
| `fg-tertiary` | placeholder |
| `fg-disabled` | 비활성 |
| `fg-on-brand` | 브랜드 표면 위 텍스트 |
| `fg-brand` | 링크/active 강조 |
| `fg-success` | 성공 시그널 텍스트 |
| `fg-warning` | 경고 시그널 텍스트 |
| `fg-danger` | 위험/에러 텍스트 |

### 1-3. Border

| alias | 의미 |
|---|---|
| `border-subtle` | 카드 헤어라인 (가장 약한 보더) |
| `border-default` | 폼/secondary 버튼 보더 |
| `border-strong` | 강조 보더 (focus 외 시각 분리) |
| `border-brand` | 브랜드 강조 보더 (focus, selected) |

## 2. 간격 (spacing ladder)

4의 배수만 사용한다. 비-4의 배수(6/10/14/18/22)는 도입 금지.

```
space-4, space-8, space-12, space-16, space-20, space-24,
space-32, space-40, space-48, space-56, space-64, space-80, space-96, space-128
```

## 3. 라운드 (radius ladder)

```
radius-2, radius-4, radius-8, radius-12, radius-16, radius-full
```

## 4. 타이포 ramp (정의 필수)

| alias | 위계 |
|---|---|
| `display1`, `display2`, `display3` | 대형 헤드라인 |
| `title1`, `title2`, `title3` | 페이지/섹션 제목 |
| `label1`, `label2` | 폼 라벨, 네비게이션 |
| `body1`, `body1-read`, `body2` | 본문 (기본/산문/소형) |
| `caption1` | 캡션, 헤더 라벨 |

각 alias는 size·weight·line-height·letter-spacing을 명시한다.

## 5. 필수 컴포넌트 시그너처 (7종)

값은 다르되 **시그너처(이름과 역할)는 모든 시안이 정의**해야 한다.

| 컴포넌트 | 필수 variant |
|---|---|
| button | primary, secondary, tertiary, ghost, danger, disabled |
| input | default, focus, error, disabled |
| badge | active, pending, inactive, danger |
| chip | default (interactive) |
| avatar | 32px circle |
| icon-button | 36px round |
| icon | 16/20/24, monochrome, currentColor 상속 |

## 6. 선택 컴포넌트 (시안별 정책)

다음은 시안마다 다르게 가져갈 수 있다 — 정의 여부 자체가 정책 차이.

- `header`/`footer` (마케팅 표면이 있는 시안만)
- `sidebar-nav`, `top-bar (admin)`, `stat-card`, `data-table`, `login-layout` (admin 표면)
- `job-card`, `hero-banner` (도메인 특화)

본 계약 외 컴포넌트가 있어도 무방하나, **위 7종 시그너처는 누락 금지**.

## 7. Required 정책 선언

각 시안 frontmatter 또는 본문 상단에 다음 정책을 명시한다.

- 카드 그림자 허용 여부 (Wanted: 금지, Material: 허용)
- gradient 허용 위치 (Wanted: 4곳 한정, Linear: 그라디언트 강조 적극, monochrome: 전면 금지)
- 카피 톤 종결 어미 (Wanted: `-요/-어요/-아요`, 격식: `-습니다`, 영문 sentence case 등)
- 다크 모드 지원 여부 (light only / dark only / 양쪽)
- 비-4의 배수 spacing 도입 여부 (기본 금지)

## 8. 검수 체크리스트 (PR/리뷰 시)

신규 시안 또는 갱신을 검수할 때 사용한다.

- [ ] 색 alias 32종(bg 11 + fg 10 + border 4 + brand-subtle 등) 누락 없음
- [ ] light + dark 양쪽 정의 (다크 미지원이면 frontmatter에 명시)
- [ ] spacing/radius/typography ladder 누락 없음
- [ ] 필수 컴포넌트 7종 시그너처 정의
- [ ] 정책 선언 5종 명시
- [ ] frontmatter `name`, `slug`, `category`, `last_updated` 정확
- [ ] `STATE.md`에 변경 이력 기록

## 9. 미준수 시 영향

- admin guide(`docs/admin-fe-design-guide.md`)의 토큰 호출(`{colors.bg-brand}` 등)이 깨짐
- preview HTML이 깨짐 (CSS 변수 매핑 실패)
- design-reviewer가 위반 검출 불가
- skill 자동 활성화는 작동하지만 산출물 품질 보장 안 됨
