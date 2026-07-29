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

for (const file of files) {
  const html = readFileSync(join(targetDir, file), 'utf8');
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

if (failures.length > 0) {
  console.error('\n구문 오류:');
  for (const f of failures) {
    console.error(`  ✗ ${f.file} (script #${f.idx}): ${f.message}`);
  }
  console.error(`\n${failures.length}/${checked} 개 스크립트 블록이 구문 검사에 실패했습니다.`);
  process.exit(1);
}

console.log(
  `✓ HTML ${files.length}개의 인라인 스크립트 ${checked}개 구문 검사 통과` +
    (skipped ? ` (건너뜀 ${skipped}개)` : ''),
);
