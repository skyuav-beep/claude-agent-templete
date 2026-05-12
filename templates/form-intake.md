# Form & Validation Intake Template

## 폼 (Form) 관리
- 권장/허용되는 상태 관리 라이브러리 (React Hook Form, Formik 등)

## 유효성 검사 (Validation)
- 스키마 기반 유효성 검사 도구 사용 여부 (Zod, Yup 등)
- 실시간(onBlur, onChange) 검증할 것인가, 혹은 제출(onSubmit) 시점에만 검증할 것인가?

## 에러 표시 (Error Display)
- 폼 필드 하단, 우측 측면, 전체 에러 모아서 상단 표시 등 화면 기획

## 작성 예시

```
## 폼 (Form) 관리
- React Hook Form v7 사용.
- 모든 폼은 `useForm` + `FormProvider` 조합으로 작성하고 controlled input을 기본으로 한다.

## 유효성 검사 (Validation)
- Zod 스키마 + `zodResolver` 사용.
- 검증 시점: onBlur (필드 단위) + onSubmit (전체).
- 비동기 검증(예: 이메일 중복)은 onBlur 트리거 + debounce 300ms.

## 에러 표시 (Error Display)
- 기본: 필드 하단 한 줄 메시지.
- 폼 제출 실패 시: 첫 에러 필드로 자동 스크롤 + focus.
- 서버 에러로 인한 제출 실패는 폼 상단 배너로 별도 표시.
```
