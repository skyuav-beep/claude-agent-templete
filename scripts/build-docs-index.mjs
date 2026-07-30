#!/usr/bin/env node
/**
 * 저장소의 모든 Markdown 문서를 훑어 docs/docs-index.json을 만든다.
 *
 * docs/guide-browser.html이 이 인덱스를 읽어 사이드바 트리와 검색을 구성한다.
 * 외부 의존성 없이 Node 내장 모듈만 사용한다.
 *
 *   node scripts/build-docs-index.mjs
 *   node scripts/build-docs-index.mjs --check   # 갱신 필요 여부만 검사(쓰기 없음)
 */

import { readFileSync, writeFileSync, readdirSync, statSync, existsSync } from 'node:fs';
import { join, relative, sep, posix } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = join(fileURLToPath(new URL('.', import.meta.url)), '..');
const OUT = join(ROOT, 'docs', 'docs-index.json');

// 문서가 아니거나 인덱싱할 이유가 없는 경로
const SKIP_DIRS = new Set(['.git', 'node_modules', '.cache', 'dist', 'build']);

// 사이드바 그룹. 접두사가 긴 것부터 먼저 맞춰본다.
const GROUPS = [
  { prefix: '.claude/skills/', label: 'Skills (자동 활성화)' },
  { prefix: '.claude/commands/', label: 'Commands (슬래시 호출)' },
  { prefix: '.claude/agents/', label: 'Subagents (역할 정의)' },
  { prefix: '.claude/', label: 'Claude 실행 레이어' },
  { prefix: '.codex/workflows/', label: 'Codex Workflows' },
  { prefix: '.codex/agents/', label: 'Codex Agent Guides' },
  { prefix: '.codex/', label: 'Codex 런타임' },
  { prefix: 'agents/', label: '역할별 에이전트 규칙' },
  { prefix: 'templates/', label: '요청·Intake 양식' },
  { prefix: 'docs/', label: '가이드·플레이북' },
  { prefix: 'designs/', label: '디자인 시안 라이브러리' },
  { prefix: 'scripts/', label: '유지보수 스크립트' },
];

const ROOT_ORDER = ['CLAUDE.md', 'AGENTS.md', 'STATE.md', 'DESIGN.md', 'README.md', 'todo.md'];

function walk(dir, acc = []) {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      if (SKIP_DIRS.has(entry.name)) continue;
      walk(join(dir, entry.name), acc);
    } else if (entry.isFile() && entry.name.endsWith('.md')) {
      acc.push(join(dir, entry.name));
    }
  }
  return acc;
}

/** 문서 제목과 헤딩 목록을 뽑는다. 코드블록 안의 `#`은 헤딩이 아니다. */
function parse(text) {
  const lines = text.split('\n');
  const headings = [];
  let title = '';
  let frontmatter = null;
  let inFence = false;
  let i = 0;

  // YAML frontmatter (skill/command/subagent 정의가 사용한다)
  if (lines[0]?.trim() === '---') {
    const end = lines.indexOf('---', 1);
    if (end > 0) {
      frontmatter = {};
      for (const line of lines.slice(1, end)) {
        const m = line.match(/^([A-Za-z_][\w-]*):\s*(.*)$/);
        if (m) frontmatter[m[1]] = m[2].replace(/^["']|["']$/g, '');
      }
      i = end + 1;
    }
  }

  for (; i < lines.length; i++) {
    const line = lines[i];
    if (/^\s*(```|~~~)/.test(line)) {
      inFence = !inFence;
      continue;
    }
    if (inFence) continue;
    const m = line.match(/^(#{1,4})\s+(.+?)\s*#*\s*$/);
    if (!m) continue;
    const level = m[1].length;
    const text_ = m[2].trim();
    if (level === 1 && !title) {
      title = text_;
      continue;
    }
    if (level <= 3) headings.push({ level, text: text_ });
  }
  return { title, headings, frontmatter };
}

function groupOf(path) {
  for (const g of GROUPS) if (path.startsWith(g.prefix)) return g.label;
  return path.includes('/') ? path.split('/')[0] : '루트 문서';
}

const files = walk(ROOT)
  .map((abs) => relative(ROOT, abs).split(sep).join(posix.sep))
  .sort();

const docs = files.map((path) => {
  const abs = join(ROOT, path);
  const text = readFileSync(abs, 'utf8');
  const { title, headings, frontmatter } = parse(text);
  const name = path.split('/').pop();
  return {
    path,
    name,
    group: groupOf(path),
    title: title || frontmatter?.name || name.replace(/\.md$/, ''),
    description: frontmatter?.description || '',
    headings,
    lines: text.split('\n').length,
    bytes: Buffer.byteLength(text, 'utf8'),
    mtime: statSync(abs).mtime.toISOString().slice(0, 10),
  };
});

// 루트 문서는 읽기 순서대로, 나머지는 경로순
docs.sort((a, b) => {
  const ra = ROOT_ORDER.indexOf(a.path);
  const rb = ROOT_ORDER.indexOf(b.path);
  if (ra !== -1 || rb !== -1) {
    if (ra === -1) return 1;
    if (rb === -1) return -1;
    return ra - rb;
  }
  return a.path.localeCompare(b.path);
});

const groups = [];
for (const doc of docs) {
  let g = groups.find((x) => x.label === doc.group);
  if (!g) groups.push((g = { label: doc.group, count: 0 }));
  g.count++;
}

const index = {
  generatedBy: 'scripts/build-docs-index.mjs',
  docCount: docs.length,
  totalBytes: docs.reduce((sum, d) => sum + d.bytes, 0),
  groups: groups.map((g) => g.label),
  docs,
};

const json = JSON.stringify(index, null, 2) + '\n';

if (process.argv.includes('--check')) {
  const current = existsSync(OUT) ? readFileSync(OUT, 'utf8') : '';
  const stale = current !== json;
  // 생성 시각을 넣지 않으므로 내용이 같으면 항상 동일 문자열이 된다.
  console.log(stale
    ? `docs-index.json 갱신 필요 (문서 ${docs.length}개)`
    : `docs-index.json 최신 (문서 ${docs.length}개)`);
  process.exit(stale ? 1 : 0);
}

writeFileSync(OUT, json, 'utf8');
console.log(`docs/docs-index.json 생성 — 문서 ${docs.length}개 · 그룹 ${index.groups.length}개 · ${(index.totalBytes / 1024).toFixed(0)} KB`);
