#!/usr/bin/env node
// docs/ 아래 화면 HTML 상단에 공통 이동 바를 심고, 이후에는 같은 구간을 다시 생성한다.
//
// 배경: 프리뷰 화면들은 "파일 하나로 완결 · 외부 참조 없음"이 원칙이라 공통 CSS/JS를
// 링크로 끌어올 수 없다. 그래서 바를 각 파일에 직접 써 넣되, 아래 마커 사이만
// 이 스크립트가 통째로 갈아끼운다. 바를 고칠 일이 생기면 이 파일만 고치고 다시 돌린다.
//
// 사용: node scripts/build-nav.mjs [--check]
//   --check  파일을 쓰지 않고 최신 상태인지만 검사한다(어긋나면 종료 코드 1).
// 외부 의존성 없이 Node 내장 모듈만 사용한다.

import { readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = fileURLToPath(new URL('.', import.meta.url));
const DOCS = join(HERE, '..', 'docs');

const START = '<!-- agent-nav:start — scripts/build-nav.mjs 가 생성한다. 이 구간은 직접 고치지 말 것 -->';
const END = '<!-- agent-nav:end -->';

// 바 높이. 아래 보정 CSS가 이 값을 기준으로 기존 고정 요소를 밀어 준다.
const BAR_H = 40;

// 화면 목록. 순서가 곧 바에 찍히는 순서다.
// home:true 인 화면은 허브이며 바 왼쪽의 돌아가기 버튼이 된다.
const SCREENS = [
  { file: 'guide-browser.html', label: '가이드 브라우저', short: '가이드', home: true },
  { file: 'admin-fe-preview.html', label: '관리자 프리뷰', short: '관리자' },
  { file: 'user-fe-preview.html', label: '사용자 프리뷰', short: '사용자' },
  { file: 'user-fe-mobile-preview.html', label: '모바일 프리뷰', short: '모바일' },
  { file: 'development-process.html', label: '개발 프로세스', short: '프로세스' },
  { file: 'development-strategy.html', label: '개발 전략', short: '전략' },
  { file: 'intake.html', label: 'Intake 폼', short: 'Intake' },
];

// 화면마다 기존 레이아웃이 달라, 바가 기존 고정 요소를 가리지 않도록 보정한다.
// 여기 없는 화면은 보정 없이도 바가 자연스럽게 얹힌다.
const FIXUPS = {
  'guide-browser.html':
    '.shell{min-height:calc(100vh - var(--an-h));}' +
    '.shell > .sidebar{height:calc(100vh - var(--an-h));top:var(--an-h);}',
  'intake.html':
    '.layout{min-height:calc(100vh - var(--an-h));}' +
    '.layout > .sidebar{top:var(--an-h);max-height:calc(100vh - var(--an-h));}',
  'development-strategy.html':
    '.layout{min-height:calc(100vh - var(--an-h));}' +
    '.layout > .sidebar{top:var(--an-h);max-height:calc(100vh - var(--an-h));}',
  'admin-fe-preview.html': '.preview-bar{top:var(--an-h);}',
  'user-fe-preview.html': '.preview-bar{top:var(--an-h);}',
  'user-fe-mobile-preview.html': '.preview-bar{top:var(--an-h);}',
};

// 색은 DESIGN.md 의 neutral ramp 값을 그대로 옮겼다. 화면마다 색 체계가 달라
// 바까지 따라가면 "같은 이동 바"로 읽히지 않으므로, 바는 중립 크롬 한 벌로 고정한다.
function styleBlock(fixup) {
  return [
    '<style>',
    // 높이는 :root 에 둔다. 아래 보정 CSS가 바 바깥의 기존 고정 요소에서도 이 값을
    // 읽어야 하는데, .agent-nav 안에 두면 그쪽에서 var() 가 무효가 되어 top 이
    // auto 로 풀리고 기존 상단 바가 스크롤에 떠내려간다.
    ':root{',
    `  --an-h:${BAR_H}px;`,
    '}',
    '.agent-nav{',
    '  --an-bg:#111827; --an-fg:#E7E9EC; --an-fg-dim:#6B7280;',
    '  --an-active-bg:#1F2937; --an-active-fg:#FFFFFF; --an-line:#1F2937;',
    '  position:sticky; top:0; z-index:900;',
    '  display:flex; align-items:center; gap:var(--an-gap,8px);',
    '  height:var(--an-h); padding:0 12px; box-sizing:border-box;',
    '  background:var(--an-bg); border-bottom:1px solid var(--an-line);',
    '  font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Noto Sans KR",sans-serif;',
    '  font-size:12px; line-height:1; overflow-x:auto; scrollbar-width:none;',
    '}',
    '.agent-nav::-webkit-scrollbar{display:none;}',
    '.agent-nav a,.agent-nav span{',
    '  display:inline-flex; align-items:center; white-space:nowrap;',
    '  padding:8px 12px; border-radius:8px; text-decoration:none;',
    '  color:var(--an-fg); font-weight:500;',
    '}',
    '.agent-nav a:hover{background:var(--an-active-bg); color:var(--an-active-fg);}',
    '.agent-nav a:focus-visible{outline:2px solid #FFFFFF; outline-offset:-2px;}',
    '.agent-nav [aria-current="page"]{background:var(--an-active-bg); color:var(--an-active-fg); font-weight:600;}',
    '.agent-nav .an-home{font-weight:600;}',
    '.agent-nav .an-sep{',
    '  flex:0 0 1px; width:1px; height:16px; padding:0; margin:0 4px;',
    '  background:var(--an-line); border-radius:0;',
    '}',
    // 바는 문서 최상단 크롬이라 인쇄물에는 남기지 않는다.
    '@media print{.agent-nav{display:none;}}',
    fixup ? fixup : '',
    '</style>',
  ]
    .filter(Boolean)
    .join('\n');
}

function navMarkup(currentFile) {
  const home = SCREENS.find((s) => s.home);
  const rest = SCREENS.filter((s) => !s.home);
  const parts = ['<nav class="agent-nav" aria-label="화면 이동">'];

  if (currentFile === home.file) {
    parts.push(`  <span class="an-home" aria-current="page">${home.label}</span>`);
  } else {
    parts.push(`  <a class="an-home" href="./${home.file}">&#8592; ${home.label}</a>`);
  }
  parts.push('  <span class="an-sep" aria-hidden="true"></span>');

  for (const s of rest) {
    if (s.file === currentFile) {
      parts.push(`  <span aria-current="page">${s.short}</span>`);
    } else {
      parts.push(`  <a href="./${s.file}">${s.short}</a>`);
    }
  }
  parts.push('</nav>');
  return parts.join('\n');
}

function block(currentFile) {
  return [START, navMarkup(currentFile), styleBlock(FIXUPS[currentFile]), END].join('\n');
}

// 마커가 이미 있으면 그 구간을 갈아끼우고, 없으면 <body> 여는 태그 바로 뒤에 심는다.
function applyTo(html, currentFile) {
  const next = block(currentFile);
  const startAt = html.indexOf(START);
  if (startAt !== -1) {
    const endAt = html.indexOf(END, startAt);
    if (endAt === -1) throw new Error('시작 마커만 있고 끝 마커가 없습니다.');
    return html.slice(0, startAt) + next + html.slice(endAt + END.length);
  }
  const bodyMatch = /<body[^>]*>/i.exec(html);
  if (!bodyMatch) throw new Error('<body> 태그를 찾을 수 없습니다.');
  const insertAt = bodyMatch.index + bodyMatch[0].length;
  return html.slice(0, insertAt) + '\n' + next + '\n' + html.slice(insertAt);
}

const checkOnly = process.argv.includes('--check');
let changed = 0;
let failed = 0;

for (const screen of SCREENS) {
  const path = join(DOCS, screen.file);
  let html;
  try {
    html = readFileSync(path, 'utf8');
  } catch {
    console.error(`  없음  ${screen.file} — 파일을 찾을 수 없습니다.`);
    failed++;
    continue;
  }

  let next;
  try {
    next = applyTo(html, screen.file);
  } catch (err) {
    console.error(`  실패  ${screen.file} — ${err.message}`);
    failed++;
    continue;
  }

  if (next === html) {
    console.log(`  유지  ${screen.file}`);
    continue;
  }
  if (checkOnly) {
    console.error(`  차이  ${screen.file} — 이동 바가 최신이 아닙니다.`);
    changed++;
    continue;
  }
  writeFileSync(path, next, 'utf8');
  console.log(`  갱신  ${screen.file}`);
  changed++;
}

if (failed > 0) {
  console.error(`\n${failed}개 화면에서 문제가 발생했습니다.`);
  process.exit(1);
}
if (checkOnly && changed > 0) {
  console.error(`\n${changed}개 화면이 최신이 아닙니다. node scripts/build-nav.mjs 로 다시 생성하세요.`);
  process.exit(1);
}
console.log(
  checkOnly
    ? `\n화면 ${SCREENS.length}개 모두 최신입니다.`
    : `\n화면 ${SCREENS.length}개 처리 — 갱신 ${changed}개.`
);
