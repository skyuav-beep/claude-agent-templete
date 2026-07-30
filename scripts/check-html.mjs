#!/usr/bin/env node
// docs/ 아래 HTML의 인라인 <script> 블록을 추출해 구문(syntax)만 검사한다.
// 실행하지 않고 컴파일만 시도하므로 부작용이 없다. 외부 의존성 없이 Node 내장 모듈만 사용한다.
//
// 배경: Node 22에서 `node --check docs/*.html`은 .html 확장자를 JS로 파싱하려다 즉시 실패한다.
// 그래서 <script> 본문만 뽑아 vm.Script로 컴파일 검사한다(classic script 기준).
//
// 사용: node scripts/check-html.mjs [디렉터리]   (기본값 docs)
// 종료 코드: 구문 오류가 하나라도 있으면 1, 모두 통과하면 0.

import { readFileSync, readdirSync, existsSync } from 'node:fs';
import { join } from 'node:path';
import vm from 'node:vm';

const targetDir = process.argv[2] || 'docs';

if (!existsSync(targetDir)) {
  console.error(`대상 디렉터리를 찾을 수 없습니다: ${targetDir}`);
  process.exit(1);
}

const scriptRe = /<script\b([^>]*)>([\s\S]*?)<\/script>/gi;
const files = readdirSync(targetDir)
  .filter((f) => f.endsWith('.html'))
  .sort();

let checked = 0;
let skipped = 0;
const failures = [];
const controlChars = [];

// 원시 제어 문자는 파일을 바이너리로 만들어 grep 같은 텍스트 도구를 무력화한다.
// 파서가 U+FFFD로 치환하면 문자열 값 자체가 달라지므로 sentinel 용도로도 위험하다.
// 이스케이프 표기(\u0000 등)로 적어야 한다. 탭·개행·CR은 정상 문자다.
const CONTROL_RE = /[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g;

for (const file of files) {
  const html = readFileSync(join(targetDir, file), 'utf8');

  let ctrl;
  const seen = new Set();
  CONTROL_RE.lastIndex = 0;
  while ((ctrl = CONTROL_RE.exec(html)) !== null) {
    const code = ctrl[0].charCodeAt(0);
    if (seen.has(code)) continue;
    seen.add(code);
    const line = html.slice(0, ctrl.index).split('\n').length;
    controlChars.push({ file, code, line });
  }

  let match;
  let idx = 0;
  while ((match = scriptRe.exec(html)) !== null) {
    idx += 1;
    const attrs = match[1] || '';
    const code = match[2] || '';

    // 외부 스크립트(src=...)는 본문이 없으므로 검사 대상이 아니다.
    if (/\bsrc\s*=/.test(attrs)) {
      skipped += 1;
      continue;
    }
    // 빈 블록은 건너뛴다.
    if (!code.trim()) {
      skipped += 1;
      continue;
    }
    // ES module(type="module")은 vm.Script로 검사할 수 없어 표시만 남기고 건너뛴다.
    if (/\btype\s*=\s*["']module["']/i.test(attrs)) {
      skipped += 1;
      console.warn(`  - ${file} (script #${idx}): type=module 은 구문 검사에서 제외`);
      continue;
    }

    checked += 1;
    try {
      // 컴파일만 수행(실행하지 않음). 구문 오류가 있으면 예외가 발생한다.
      new vm.Script(code, { filename: `${file}#script${idx}` });
    } catch (err) {
      failures.push({ file, idx, message: err.message });
    }
  }
}

if (controlChars.length > 0) {
  console.error('\n원시 제어 문자:');
  for (const c of controlChars) {
    const hex = c.code.toString(16).padStart(4, '0').toUpperCase();
    console.error(`  ✗ ${c.file}:${c.line} — U+${hex} 가 그대로 들어 있습니다. \\u${hex} 표기로 바꾸세요.`);
  }
}

if (failures.length > 0) {
  console.error('\n구문 오류:');
  for (const f of failures) {
    console.error(`  ✗ ${f.file} (script #${f.idx}): ${f.message}`);
  }
  console.error(`\n${failures.length}/${checked} 개 스크립트 블록이 구문 검사에 실패했습니다.`);
}

if (failures.length > 0 || controlChars.length > 0) process.exit(1);

console.log(
  `✓ HTML ${files.length}개의 인라인 스크립트 ${checked}개 구문 검사 + 제어 문자 검사 통과` +
    (skipped ? ` (건너뜀 ${skipped}개)` : ''),
);
