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
// icon은 이모지가 아닌 단색 기호를 쓴다(다크 UI에서 색을 CSS로 통제하기 위해).
// color는 계열로 묶어 소속을 드러낸다 — Codex 3종은 teal 계열.
const GROUPS = [
  {
    prefix: '.claude/skills/', label: 'Skills (자동 활성화)', icon: '✦', color: '#7c3aed',
    desc: '대화 속 키워드를 감지해 스스로 켜지는 작업 흐름. 사용자가 부르지 않아도 동작한다.',
  },
  {
    prefix: '.claude/commands/', label: 'Commands (슬래시 호출)', icon: '▸', color: '#ec4899',
    desc: '사용자가 슬래시로 직접 호출하는 명령. 같은 이름의 Skill과 짝을 이룬다.',
  },
  {
    prefix: '.claude/agents/', label: 'Subagents (역할 정의)', icon: '◉', color: '#f97316',
    desc: '조사·리뷰·구현 등을 나눠 맡기는 보조 에이전트 정의. 파일 첫머리 설정으로 자동 등록된다.',
  },
  {
    prefix: '.claude/', label: 'Claude 실행 레이어', icon: '⬡', color: '#94a3b8',
    desc: '위 세 가지를 제외한 실행 계층 문서. 가드레일과 배포 도구 설명이 들어간다.',
  },
  {
    prefix: '.codex/workflows/', label: 'Codex Workflows', icon: '▶', color: '#14b8a6',
    desc: 'Codex 런타임에서 쓰는 작업 유형별 절차서. Claude 자동화와 분리된 보완 경로다.',
  },
  {
    prefix: '.codex/agents/', label: 'Codex Agent Guides', icon: '◇', color: '#2dd4bf',
    desc: 'Codex 쪽 보조 에이전트에게 주는 역할별 지침.',
  },
  {
    prefix: '.codex/', label: 'Codex 런타임', icon: '⬢', color: '#5eead4',
    desc: 'Codex 어댑터 자체의 구성과 사용법 설명.',
  },
  {
    prefix: 'agents/', label: '역할별 에이전트 규칙', icon: '◆', color: '#5b6af5',
    desc: '요청 해석·조사·구현·리뷰를 각각 어떻게 수행할지 정한 행동 규칙. 작업 유형에 맞춰 골라 읽는다.',
  },
  {
    prefix: 'templates/', label: '요청·Intake 양식', icon: '▤', color: '#0ea5e9',
    desc: '작업을 요청할 때 채우는 양식과, 프로젝트 정보를 캐묻는 질문지 모음.',
  },
  {
    prefix: 'docs/', label: '가이드·플레이북', icon: '▣', color: '#10b981',
    desc: '주제별 운영 가이드와 실행 절차. 디자인·로컬 개발·금액 처리 같은 판단 기준의 정본이다.',
  },
  {
    prefix: 'designs/', label: '디자인 시안 라이브러리', icon: '◐', color: '#a78bfa',
    desc: '고를 수 있는 디자인 시스템 시안들. 선택한 하나가 루트 디자인 문서의 활성 사본이 된다.',
  },
  {
    prefix: 'scripts/', label: '유지보수 스크립트', icon: '✱', color: '#64748b',
    desc: '이 저장소를 관리하는 도구 설명. 배포 대상이 아니다.',
  },
];

const ROOT_GROUP = {
  label: '루트 문서', icon: '★', color: '#f59e0b',
  desc: '항상 먼저 읽는 최상위 문서. 규칙·운영 절차·현재 상태·디자인 정본이 여기 있다.',
};

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
  return path.includes('/') ? path.split('/')[0] : ROOT_GROUP.label;
}

/** 그룹 라벨에 붙는 아이콘·색·역할 설명. 정의가 없는 디렉터리는 중립값으로 채운다. */
function groupMeta(label) {
  if (label === ROOT_GROUP.label) return ROOT_GROUP;
  const found = GROUPS.filter((g) => g.label === label)[0];
  return found || { label, icon: '·', color: '#64748b', desc: '분류가 지정되지 않은 디렉터리.' };
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
  if (!g) {
    const meta = groupMeta(doc.group);
    groups.push((g = { label: meta.label, icon: meta.icon, color: meta.color, desc: meta.desc, count: 0 }));
  }
  g.count++;
}

const index = {
  generatedBy: 'scripts/build-docs-index.mjs',
  docCount: docs.length,
  totalBytes: docs.reduce((sum, d) => sum + d.bytes, 0),
  groups,
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
