#!/usr/bin/env node
// 디자인 시안(designs/<slug>.md) ↔ Claude Design System 동기화 도구.
//
// 원본은 Claude 안의 Design System(Artifact)이고, designs/<slug>.md는 그 스냅샷이다(B 방식, 2026-11-16).
// Claude Code가 Artifact를 내려받은 폴더를 이 스크립트로 시안 파일로 바꾸고(import),
// 처음 한 번은 시안 파일을 Design System 파일로 바꿔 올린다(export). 네트워크는 쓰지 않는다 —
// 내려받기·올리기는 Claude Code의 Artifact 도구가 한다(docs/design-guidelines.md "Claude Design System 동기화").
//
// 사용:
//   node scripts/design-sync.mjs export <slug>|--all --out <dir> [--index <기존 design-system.json>] [--by <이름>] [--suffix " (claude-agent-template)"]
//       <dir>/<slug>/project/{README.md, frontmatter.txt, tokens.json, components/Cover/preview.html, design-system.json}
//   node scripts/design-sync.mjs import <slug> --from <내려받은 폴더> --url <artifact url> --version <버전>
//       designs/<slug>.md를 다시 쓴다. 페이지 토큰 편집기로 바꾼 색은 README의 yaml 줄에 되돌려 반영하고,
//       되돌릴 수 없는 차이(색 외 값·README에 없는 토큰)가 있으면 쓰지 않고 종료 코드 2.
//   node scripts/design-sync.mjs preview [--fix]   프리뷰 3화면의 시안별 별칭 색 값이 시안 파일과 같은지 검사(--fix: 값만 고침)
//   node scripts/design-sync.mjs status            시안별 연결된 Design System 주소·버전
//   node scripts/design-sync.mjs check             토큰 변환·프리뷰 일치 검사(어긋나면 종료 코드 1)
// 외부 의존성 없이 Node 내장 모듈만 사용한다.
import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..');
const DESIGNS = join(ROOT, 'designs');
const PREVIEWS = ['docs/admin-fe-preview.html', 'docs/user-fe-preview.html', 'docs/user-fe-mobile-preview.html'];
const LINK_KEY = 'claude_design_system';
const NAME_RE = /^[A-Za-z0-9][A-Za-z0-9_.-]{0,63}$/;
const COLOR_RE = /^(#([0-9a-f]{3,4}|[0-9a-f]{6}|[0-9a-f]{8})|(rgb|rgba|hsl|hsla|oklch|oklab|lab|lch)\([0-9.,%\s/+-]+\))$/i;

// ── 시안 파일 읽기 ────────────────────────────────────────────────────────────
function slugs() {
  return readdirSync(DESIGNS).filter((f) => /^[a-z0-9][a-z0-9-]*\.md$/.test(f) && f !== 'README.md').map((f) => f.slice(0, -3));
}

/** frontmatter(연결 정보 블록 제외)·연결 정보·본문으로 나눈다. */
function splitDoc(text) {
  const m = /^---\n([\s\S]*?)\n---\n/.exec(text);
  if (!m) throw new Error('frontmatter(---)가 없습니다');
  const lines = m[1].split('\n');
  const front = [], link = {};
  for (let i = 0; i < lines.length; i++) {
    if (lines[i] === `${LINK_KEY}:`) {
      while (i + 1 < lines.length && /^\s+\S/.test(lines[i + 1])) {
        const kv = /^\s+([a-z_]+):\s*"?(.*?)"?\s*$/.exec(lines[++i]);
        if (kv) link[kv[1]] = kv[2];
      }
      continue;
    }
    front.push(lines[i]);
  }
  return { front: front.join('\n'), link, body: text.slice(m[0].length) };
}

function joinDoc(front, link, body) {
  const linkLines = link && link.url
    ? [`${LINK_KEY}:`, `  url: ${link.url}`, `  version: "${link.version ?? ''}"`, `  synced: "${link.synced ?? ''}"`]
    : [];
  return `---\n${[front.replace(/\n+$/, ''), ...linkLines].join('\n')}\n---\n${body}`;
}

const frontValue = (front, key) => (new RegExp(`^${key}:\\s*"?(.*?)"?\\s*$`, 'm').exec(front) || [])[1];

/** yaml 코드 블록 한 줄 → [{name, value, comment}]. 한 줄에 여러 쌍(space-4: 4  space-8: 8)과 { … } 값도 읽는다. */
function parseLine(line) {
  let inQ = null, depth = 0, cut = line.length;
  for (let i = 0; i < line.length; i++) {
    const c = line[i];
    if (inQ) { if (c === inQ) inQ = null; continue; }
    if (c === '"' || c === "'") inQ = c;
    else if (c === '{') depth++;
    else if (c === '}') depth--;
    else if (c === '#' && depth === 0 && (i === 0 || /\s/.test(line[i - 1]))) { cut = i; break; }
  }
  const comment = line.slice(cut + 1).trim();
  const src = line.slice(0, cut);
  const out = [];
  let pos = 0;
  while (pos < src.length) {
    const head = /^\s*([A-Za-z0-9][A-Za-z0-9_.-]*):\s*/.exec(src.slice(pos));
    if (!head) break;
    pos += head[0].length;
    let value;
    if (src[pos] === '"' || src[pos] === "'") {
      const end = src.indexOf(src[pos], pos + 1);
      value = src.slice(pos + 1, end); pos = end + 1;
    } else if (src[pos] === '{') {
      const end = src.indexOf('}', pos);
      value = src.slice(pos, end + 1); pos = end + 1;
    } else {
      const next = /\s{2,}(?=[A-Za-z0-9][A-Za-z0-9_.-]*:\s)/.exec(src.slice(pos));
      const end = next ? pos + next.index : src.length;
      value = src.slice(pos, end).trim(); pos = end;
    }
    out.push({ name: head[1], value, comment: out.length === 0 ? comment : '' });
  }
  if (out.length > 1) for (const o of out) o.comment = comment;
  return out;
}

/** 본문의 yaml 블록을 제목별로 모은다: [{heading, h2, entries:[{name,value,comment,line}]}] */
function yamlBlocks(body) {
  const lines = body.split('\n');
  const blocks = [];
  let h2 = '', h3 = '', cur = null;
  lines.forEach((l, i) => {
    if (cur) {
      if (/^```/.test(l)) { blocks.push(cur); cur = null; return; }
      // 이어지는 줄: 값이 `>`·`|`이거나 쉼표로 끝난 항목 뒤의 들여쓴 줄(새 키가 아님)은 그 값에 붙인다.
      const last = cur.entries[cur.entries.length - 1];
      if (last && /^\s+\S/.test(l) && !/^\s*[A-Za-z0-9][A-Za-z0-9_.-]*:\s/.test(l)
          && (last.folded || /^[>|]$/.test(last.value) || /,$/.test(last.value))) {
        if (/^[>|]$/.test(last.value)) { last.value = ''; last.folded = true; }
        const hash = l.search(/(^|\s)#/);
        const text = (hash >= 0 ? l.slice(0, hash) : l).trim();
        const note = hash >= 0 ? l.slice(hash).replace(/^\s*#\s*/, '').trim() : '';
        if (text) last.value = `${last.value} ${text}`.trim();
        if (note) last.comment = note;
        return;
      }
      for (const e of parseLine(l)) cur.entries.push({ ...e, line: i });
      return;
    }
    if (/^## /.test(l)) { h2 = l.slice(3).trim(); h3 = ''; }
    else if (/^### /.test(l)) h3 = l.slice(4).trim();
    else if (/^```yaml\s*$/.test(l)) cur = { heading: h3 || h2, h2, entries: [] };
  });
  return blocks;
}

const kind = (b) => {
  if (/^Semantic alias — Light/.test(b.heading)) return 'light';
  if (/^Semantic alias — Dark/.test(b.heading)) return 'dark';
  if (/^Brand\b(?!.*gradient)/i.test(b.heading)) return 'brand';
  if (/^Type ramp/.test(b.heading)) return 'type';
  if (b.heading === 'Spacing') return 'spacing';
  if (b.heading === 'Rounded') return 'radius';
  if (b.heading === 'Elevation & Depth') return 'shadow';
  return null;
};

const px = (v) => (/^-?[0-9.]+$/.test(String(v).trim()) ? `${String(v).trim()}px` : String(v).trim());

function typeStyle(name, raw) {
  let size, weight, lh, ls;
  if (raw.startsWith('{')) {
    const kv = Object.fromEntries([...raw.slice(1, -1).matchAll(/([a-z-]+):\s*([^,}]+)/g)].map((m) => [m[1], m[2].trim()]));
    size = kv.size; weight = kv.weight; lh = kv['line-height']; ls = kv.tracking ?? kv['letter-spacing'];
  } else {
    [size, weight, lh, ls] = raw.replace(/\([^)]*\)/g, '').split('/').map((s) => s.trim());
  }
  if (!size) return null;
  const s = { name, fontSize: px(size) };
  if (weight) s.fontWeight = Number(weight) || weight;
  if (lh) s.lineHeight = /^[0-9.]+$/.test(lh) && Number(lh) < 10 ? Number(lh) : px(lh);
  const lsLen = ls && (/^-?[0-9.]+(em|px|rem|%)?/.exec(ls) || [])[0];
  if (lsLen && lsLen !== '0') s.letterSpacing = lsLen;
  return s;
}

/** Typography 절에서 본문 서체 스택을 찾는다: 백틱 스택 → yaml `font-sans: >` 여러 줄 → "primary face는 **이름**". */
function fontStack(body) {
  const sec = (/^## Typography\n([\s\S]*?)(?=^## )/m.exec(body) || [])[1] || '';
  const ok = (s) => s && s.length <= 200 && !/[;{}<>\\()]/.test(s) ? s : null;
  const tick = [...sec.matchAll(/`([^`]*(?:sans-serif|system-ui|serif)[^`]*)`/g)].map((m) => ok(m[1].trim())).find(Boolean);
  if (tick) return tick;
  const folded = /^font-sans:\s*>\s*\n((?:[ \t]+\S.*\n)+)/m.exec(sec);
  if (folded) { const s = ok(folded[1].split('\n').map((l) => l.trim()).filter(Boolean).join(' ')); if (s) return s; }
  const face = /(?:primary face는|서체는)\s*\*\*([^*]+)\*\*/.exec(sec);
  return face ? ok(`"${face[1].trim()}", system-ui, sans-serif`) : null;
}

/** 시안 본문 → Design System tokens.json + 버린 항목 목록 */
function buildTokens(slug, front, body) {
  const notes = [];
  const used = new Set();
  const take = (name, where) => {
    if (!NAME_RE.test(name)) { notes.push(`${where}: 이름 형식이 맞지 않아 뺌 — ${name}`); return false; }
    if (used.has(name)) { notes.push(`${where}: 이름이 겹쳐 뺌 — ${name}`); return false; }
    used.add(name); return true;
  };
  const colors = new Map(); // name → {value:{light,dark}, usage}
  const spacing = [], radius = [], shadow = [], styles = [];
  for (const b of yamlBlocks(body)) {
    const k = kind(b);
    if (!k) continue;
    for (const e of b.entries) {
      if (k === 'light' || k === 'dark' || k === 'brand') {
        if (!COLOR_RE.test(e.value)) { notes.push(`${b.heading}: 색 형식이 아니라 뺌 — ${e.name}: ${e.value}`); continue; }
        const theme = k === 'dark' ? 'dark' : 'light';
        const c = colors.get(e.name) ?? { value: {}, usage: e.comment || b.heading };
        c.value[theme] = e.value.toLowerCase();
        if (e.comment && !c.usage) c.usage = e.comment;
        colors.set(e.name, c);
      } else if (k === 'spacing' || k === 'radius') {
        (k === 'spacing' ? spacing : radius).push({ name: e.name, value: px(e.value), usage: e.comment || b.heading });
      } else if (k === 'shadow') {
        if (/var\(|url\(/.test(e.value)) { notes.push(`그림자: var()/url()이라 뺌 — ${e.name}`); continue; }
        shadow.push({ name: e.name, value: e.value, usage: e.comment || b.heading });
      } else if (k === 'type') {
        const s = typeStyle(e.name, e.value);
        if (s) { if (e.comment) s.usage = e.comment; styles.push(s); } else notes.push(`글꼴: 읽지 못해 뺌 — ${e.name}`);
      }
    }
  }
  const colorTokens = [];
  for (const [name, c] of colors) if (take(name, '색')) colorTokens.push({ name, value: c.value, usage: c.usage });
  const fam = (list, label) => list.filter((t) => take(t.name, label));
  const stack = fontStack(body);
  if (!stack) notes.push('글꼴: 서체 스택을 찾지 못해 system-ui로 둠');
  const tokens = {
    name: frontValue(front, 'name') || slug,
    version: 1,
    meta: { source: 'claude-agent-template', slug, generatedBy: 'scripts/design-sync.mjs' },
    color: { themes: [{ id: 'light', name: 'Light' }, { id: 'dark', name: 'Dark' }], tokens: colorTokens },
    type: { fonts: [], families: { sans: stack || 'system-ui, sans-serif' }, groups: styles.length ? [{ name: 'Type ramp', family: 'sans', styles }] : [] },
    spacing: { tokens: fam(spacing, '간격') },
    radius: { tokens: fam(radius, '라운드') },
  };
  const sh = fam(shadow, '그림자');
  if (sh.length) tokens.shadow = { tokens: sh };
  return { tokens, notes };
}

// ── 표지(Cover) — 토큰만으로 그리는 기본 표지 ─────────────────────────────────
function cover(front, body, tokens) {
  const name = frontValue(front, 'name') || tokens.name;
  const quote = (/^>\s*(.+)$/m.exec(body) || [])[1] || '';
  const tagline = quote.replace(/\*\*|`|\[|\]\([^)]*\)/g, '').replace(/\s+/g, ' ').trim().slice(0, 90);
  const has = (n) => tokens.color.tokens.some((t) => t.name === n);
  const pick = (...names) => names.find(has);
  const brand = pick('bg-brand', 'brand-primary', 'fg-brand') ;
  const ink = pick('fg-strong', 'fg-default');
  const tint = pick('bg-brand-subtle', 'bg-muted', 'bg-subtle');
  const signal = pick('fg-success', 'bg-success-subtle', 'fg-warning');
  const ground = pick('bg-canvas', 'bg-surface');
  const sp = (n, d) => (tokens.spacing.tokens.find((t) => t.name === `space-${n}`) ? `var(--space-${n})` : `${d}px`);
  const r = tokens.radius.tokens.map((t) => t.name).filter((n) => n !== 'radius-full' && !/full|pill/.test(n));
  const rMd = r[Math.floor(r.length / 2)] || null;
  const size = name.length * 0.6 * 96 <= 440 ? 96 : 64;
  const dots = [];
  for (let y = 0; y < 4; y++) for (let x = 0; x < 6; x++) dots.push(`<circle class="dot" cx="${720 + x * 32}" cy="${196 + y * 24}" r="3"/>`);
  return `<!-- @dsCard height=288 -->
<!doctype html>
<html><head><meta charset="utf-8"><style>
  html, body { margin: 0; background: var(--${ground}); }
  .wrap { position: relative; width: 960px; height: 288px; overflow: hidden; font-family: var(--font-sans), system-ui, sans-serif; }
  svg { position: absolute; inset: 0; }
  .brand { fill: var(--${brand}); } .ink { fill: var(--${ink}); } .tint { fill: var(--${tint}); } .signal { fill: var(--${signal}); }
  .dot { fill: var(--${ink}); opacity: .35; }
  .tile { rx: ${rMd ? `var(--${rMd})` : '8px'}; }
  .text { position: absolute; left: ${sp(40, 40)}; bottom: ${sp(32, 32)}; max-width: 440px; }
  h1 { margin: 0; font-size: ${size}px; line-height: .92; font-weight: 700; letter-spacing: -0.02em; color: var(--${ink}); }
  p { margin: ${sp(12, 12)} 0 0; font-size: 13px; line-height: 1.5; color: var(--${pick('fg-secondary', 'fg-tertiary', 'fg-default')}); }
</style></head><body><div class="wrap">
<svg width="960" height="288" viewBox="0 0 960 288" aria-hidden="true">
  <!-- blocks: ${brand} 200×176, ${ink} 120×120, ${tint} 168×96, ${signal} 48×48 (scripts/design-sync.mjs 기본 표지) -->
  <!-- arrangement: 한 덩어리 슬랩(brand)에 위성 블록, x ≥ 480 영역만 사용 -->
  <!-- pattern: 4px ladder 시안이라 점 격자(32×24 간격)를 ink 35%로 -->
  <!-- scales: radius ${rMd || '8px'}, spacing 40·32·12 -->
  <rect class="brand tile" x="512" y="40" width="200" height="176"/>
  <rect class="tint tile" x="728" y="40" width="168" height="96"/>
  <rect class="ink tile" x="776" y="152" width="120" height="120"/>
  <rect class="signal tile" x="512" y="232" width="48" height="48"/>
  ${dots.join('')}
</svg>
<div class="text"><h1>${name}</h1>${tagline ? `<p>${tagline}</p>` : ''}</div>
</div></body></html>
`;
}

// ── export ────────────────────────────────────────────────────────────────────
function exportOne(slug, outDir, indexPath, by, suffix = '') {
  const { front, link, body } = splitDoc(readFileSync(join(DESIGNS, `${slug}.md`), 'utf8'));
  const { tokens, notes } = buildTokens(slug, front, body);
  const dir = join(outDir, slug, 'project');
  mkdirSync(join(dir, 'components', 'Cover'), { recursive: true });
  writeFileSync(join(dir, 'README.md'), body.replace(/^\n+/, ''));
  writeFileSync(join(dir, 'frontmatter.txt'), `${front}\n`);
  writeFileSync(join(dir, 'tokens.json'), `${JSON.stringify(tokens, null, 2)}\n`);
  writeFileSync(join(dir, 'components', 'Cover', 'preview.html'), cover(front, body, tokens));
  const now = new Date().toISOString();
  const lastChange = { by: by || 'Claude', at: now, via: 'Claude Code · claude-agent-template', note: `designs/${slug}.md에서 내보냄` };
  const index = indexPath
    ? { ...JSON.parse(readFileSync(indexPath, 'utf8')), lastChange }
    : { v: 3, layout: 'files', createdOnFiles: { v: 1, at: now }, title: `${tokens.name}${suffix}`, namespace: `DS_${slug.replace(/[^A-Za-z0-9]/g, '_')}`,
        libraries: [], sections: {}, groups: [], assetGroups: {}, blobs: {}, docs: { sections: [] }, lastChange };
  writeFileSync(join(dir, 'design-system.json'), `${JSON.stringify(index, null, 2)}\n`);
  const count = `색 ${tokens.color.tokens.length} · 글꼴 ${tokens.type.groups[0]?.styles.length ?? 0} · 간격 ${tokens.spacing.tokens.length} · 라운드 ${tokens.radius.tokens.length} · 그림자 ${tokens.shadow?.tokens.length ?? 0}`;
  console.log(`${slug}: ${count}${link.url ? ` · 연결 ${link.url}` : ' · 연결 없음'}`);
  for (const n of notes) console.log(`  - ${n}`);
  return { tokens, notes };
}

// ── import ────────────────────────────────────────────────────────────────────
function stripGenerated(readme) {
  // 페이지가 README 끝에 붙이는 생성 절(--- 뒤 Consuming this system / Index)을 떼어 낸다.
  const i = readme.search(/\n---\n+## (Consuming this system|Index)\b/);
  return i >= 0 ? `${readme.slice(0, i).replace(/\n+$/, '')}\n` : readme;
}

function importOne(slug, from, url, version) {
  const existing = join(DESIGNS, `${slug}.md`);
  if (existsSync(existing) && splitDoc(readFileSync(existing, 'utf8')).link.mode === 'adopt') {
    console.error(`${slug}: 대응표로 연결된 시안입니다 — import 대신 adopt를 쓰세요(designs/_sync/${slug}.map.json)`);
    process.exit(1);
  }
  const proj = existsSync(join(from, 'project')) ? join(from, 'project') : from;
  const readme = stripGenerated(readFileSync(join(proj, 'README.md'), 'utf8'));
  const front = readFileSync(join(proj, 'frontmatter.txt'), 'utf8').replace(/\n+$/, '');
  let body = `\n${readme}`;
  const remote = existsSync(join(proj, 'tokens.json')) ? JSON.parse(readFileSync(join(proj, 'tokens.json'), 'utf8')) : null;
  const problems = [], patched = [];
  if (remote) {
    // 페이지 토큰 편집기로 바뀐 색을 README yaml 줄에 되돌린다.
    const local = buildTokens(slug, front, body).tokens;
    const localColor = new Map(local.color.tokens.map((t) => [t.name, t.value]));
    const lines = body.split('\n');
    const blocks = yamlBlocks(body);
    for (const t of remote.color?.tokens ?? []) {
      const want = typeof t.value === 'string' ? { light: t.value } : t.value;
      const have = localColor.get(t.name);
      if (!have) { problems.push(`README에 없는 색 토큰: ${t.name}`); continue; }
      for (const [theme, v] of Object.entries(want)) {
        if (!v || String(have[theme] || '').toLowerCase() === String(v).toLowerCase()) continue;
        if (!COLOR_RE.test(v)) { problems.push(`${t.name}(${theme}): README에 옮길 수 없는 값 ${v}`); continue; }
        const block = blocks.find((b) => (kind(b) === theme || (theme === 'light' && kind(b) === 'brand')) && b.entries.some((e) => e.name === t.name));
        const e = block?.entries.find((x) => x.name === t.name);
        if (!e) { problems.push(`${t.name}(${theme}): README에서 줄을 찾지 못함`); continue; }
        lines[e.line] = lines[e.line].replace(e.value, v);
        patched.push(`${t.name}(${theme}) ${e.value} → ${v}`);
      }
    }
    body = lines.join('\n');
    for (const fam of ['spacing', 'radius']) {
      const localMap = new Map(local[fam].tokens.map((t) => [t.name, t.value]));
      for (const t of remote[fam]?.tokens ?? []) if (localMap.get(t.name) !== t.value) problems.push(`${fam} ${t.name}: 페이지 값 ${t.value} ≠ README ${localMap.get(t.name) ?? '(없음)'} — README를 직접 고쳐 주세요`);
    }
  }
  if (problems.length) {
    console.error(`${slug}: 되돌릴 수 없는 차이 ${problems.length}건 — designs/${slug}.md를 쓰지 않았습니다`);
    for (const p of problems) console.error(`  - ${p}`);
    process.exit(2);
  }
  const synced = new Date().toISOString().slice(0, 10);
  writeFileSync(join(DESIGNS, `${slug}.md`), joinDoc(front, { url, version, synced }, body));
  console.log(`${slug}: designs/${slug}.md 갱신 (버전 ${version}${patched.length ? `, 페이지 색 변경 ${patched.length}건 반영` : ''})`);
  for (const p of patched) console.log(`  - ${p}`);
}

// ── adopt (형식이 다른 기존 Design System → 대응표로 시안 생성) ──────────────────
const CONTRACT_ALIAS = ['bg-canvas', 'bg-surface', 'bg-subtle', 'bg-muted', 'bg-elevated', 'bg-inverse', 'bg-brand', 'bg-brand-subtle',
  'bg-success-subtle', 'bg-warning-subtle', 'bg-danger-subtle', 'fg-strong', 'fg-default', 'fg-secondary', 'fg-tertiary', 'fg-disabled',
  'fg-on-brand', 'fg-brand', 'fg-success', 'fg-warning', 'fg-danger', 'border-subtle', 'border-default', 'border-strong', 'border-brand'];
const CONTRACT_TYPE = ['display1', 'display2', 'display3', 'title1', 'title2', 'title3', 'label1', 'label2', 'body1', 'body1-read', 'body2', 'caption1'];
const SPACE_LADDER = [4, 8, 12, 16, 20, 24, 32, 40, 48, 56, 64, 80, 96, 128];
const RADIUS_LADDER = [2, 4, 8, 12, 16];
const CONTRACT_VARIANTS = {
  button: ['primary', 'secondary', 'tertiary', 'ghost', 'danger', 'disabled'],
  input: ['default', 'focus', 'error', 'disabled'],
  badge: ['active', 'pending', 'inactive', 'danger'],
};
const MOBILE_COMPONENTS = ['bottom-sheet', 'mobile-nav', 'nav-drawer', 'fab', 'card-row'];
const CSS_KEEP = /^(height|min-height|max-height|width|min-width|max-width|border-radius|background|background-color|color|border|border-top|border-bottom|border-width|box-shadow|padding|font|font-family|font-size|font-weight|letter-spacing|gap|outline|transform|backdrop-filter|opacity|filter)$/;

// bundle.css → 구역(/* 주석 */)별 "선택자 | 핵심 속성" 행. 미디어쿼리·keyframes 안쪽도 같은 방식으로 읽는다.
function cssSummary(css) {
  const rows = [];
  let section = '';
  const rules = [];
  for (const part of css.split(/(\/\*[\s\S]*?\*\/)/)) {
    if (part.startsWith('/*')) { const t = part.slice(2, -2).trim().replace(/\s+/g, ' '); if (t && t.length < 60) section = t; continue; }
    for (const m of part.matchAll(/([^{}]+)\{([^{}]*)\}/g)) rules.push([section, m[1], m[2]]);
  }
  for (const [sec, rawSel, body] of rules) {
    section = sec;
    const m = [null, null, rawSel, body];
    const sel = m[2].trim().replace(/\s+/g, ' ');
    if (!sel || sel.startsWith('@') || /^(from|to|[0-9.]+%)$/.test(sel)) continue;
    const decl = m[3].split(';').map((d) => d.trim()).filter(Boolean).map((d) => {
      const i = d.indexOf(':'); return [d.slice(0, i).trim(), d.slice(i + 1).trim()];
    }).filter(([k]) => CSS_KEEP.test(k)).map(([k, v]) => `${k} ${v.replace(/var\(--([\w-]+)\)/g, '$1')}`);
    if (!decl.length) continue;
    const cut = (s, n) => (s.length > n ? `${s.slice(0, n - 1)}…` : s);
    rows.push(`| ${section.replace(/\|/g, '/')} | \`${cut(sel, 70).replace(/\|/g, '\\|')}\` | ${cut(decl.join(' · '), 220).replace(/\|/g, '/')} |`);
  }
  return rows;
}

function adoptOne(slug, from, url, version) {
  const map = JSON.parse(readFileSync(join(DESIGNS, '_sync', `${slug}.map.json`), 'utf8'));
  const proj = existsSync(join(from, 'project')) ? join(from, 'project') : from;
  const src = JSON.parse(readFileSync(join(proj, 'tokens.json'), 'utf8'));
  const problems = [];
  const colors = new Map((src.color?.tokens ?? []).map((t) => [t.name, t]));
  const first = src.color?.themes?.[0]?.id ?? 'light';
  const colorOf = (name, theme, depth = 0) => {
    const t = colors.get(name);
    if (!t || depth > 16) return null;
    let v = typeof t.value === 'string' ? t.value : (t.value[theme] ?? t.value[first]);
    const alias = /^\{([^}]+)\}$/.exec(v ?? '');
    return alias ? colorOf(alias[1], theme, depth + 1) : v;
  };
  const th = map.themes ?? { light: 'light', dark: 'dark' };
  const missing = CONTRACT_ALIAS.filter((a) => !map.alias?.[a]);
  if (missing.length) problems.push(`대응표에 없는 별칭: ${missing.join(', ')}`);
  const aliasRows = { light: [], dark: [] }, synth = [];
  for (const a of CONTRACT_ALIAS) {
    const m = map.alias?.[a]; if (!m) continue;
    const name = typeof m === 'string' ? m : m.src;
    for (const theme of ['light', 'dark']) {
      const v = colorOf(name, th[theme]);
      if (!v || !COLOR_RE.test(v)) { problems.push(`${a}(${theme}) ← ${name}: 원본 값 없음/형식 아님 (${v})`); continue; }
      aliasRows[theme].push(`${a}: "${v.toLowerCase()}"`.padEnd(34) + `  # ← ${name}${typeof m === 'object' && m.note ? ` · ${m.note}` : ''}`);
    }
    if (typeof m === 'object' && m.note) synth.push(`\`${a}\` ← \`${name}\`: ${m.note}`);
  }
  const brandRows = Object.entries(map.brand ?? {}).map(([n, s]) => {
    const v = colorOf(s, th.light);
    if (!v || !COLOR_RE.test(v)) { problems.push(`brand ${n} ← ${s}: 원본 값 없음`); return null; }
    return `${n}: "${v.toLowerCase()}"`.padEnd(30) + `  # ← ${s}`;
  }).filter(Boolean);
  // 글꼴
  const styles = new Map();
  for (const g of src.type?.groups ?? []) for (const s of g.styles ?? []) styles.set(s.name, { ...s, family: s.family ?? g.family });
  const num = (v) => parseFloat(String(v));
  const ramp = (s) => {
    const size = num(s.fontSize);
    const lh = String(s.lineHeight ?? '').endsWith('px') ? +(num(s.lineHeight) / size).toFixed(2) : (s.lineHeight ?? 1.5);
    return `${size}/${s.fontWeight ?? 400}/${lh}/${s.letterSpacing ?? 0}`;
  };
  const typeRows = [];
  for (const t of CONTRACT_TYPE) {
    const s = styles.get(map.type?.[t]);
    if (!s) { problems.push(`글꼴 ${t} ← ${map.type?.[t]}: 원본 스타일 없음`); continue; }
    typeRows.push(`${t}: ${ramp(s)}`.padEnd(32) + `  # ← ${s.name} (${s.fontSize}/${s.lineHeight})${s.usage ? ` ${s.usage}` : ''}`);
  }
  const usedStyles = new Set(Object.values(map.type ?? {}));
  const extraStyles = [...styles.values()].filter((s) => !usedStyles.has(s.name));
  const stack = src.type?.families?.sans ?? 'system-ui, sans-serif';
  // 간격·라운드·그림자
  const srcSpace = new Map((src.spacing?.tokens ?? []).map((t) => [num(t.value), t]));
  const spaceRows = SPACE_LADDER.map((n) => `space-${n}: ${n}`.padEnd(16) + (srcSpace.has(n) ? `  # ← ${srcSpace.get(n).name} ${srcSpace.get(n).usage ?? ''}`.trimEnd() : '  # 표준 ladder (원본에 없음)'));
  const srcRadius = new Map((src.radius?.tokens ?? []).map((t) => [t.name, t]));
  const radiusRows = RADIUS_LADDER.filter((n) => !Object.keys(map.radius ?? {}).includes(`radius-${n}`)).map((n) => `radius-${n}: ${n}`.padEnd(18) + '  # 표준 ladder');
  for (const [name, s] of Object.entries(map.radius ?? {})) {
    const t = srcRadius.get(s);
    if (!t) { problems.push(`라운드 ${name} ← ${s}: 원본 없음`); continue; }
    const v = name === 'radius-full' ? 9999 : num(t.value);
    const special = name !== 'radius-full' && v % 4 !== 0;
    radiusRows.push(`${name}: ${v}`.padEnd(18) + `  # ← ${s} ${t.value}${special ? ' · 시안 전용(비-4)' : ''} — ${t.usage ?? ''}`.trimEnd());
  }
  const srcShadow = new Map((src.shadow?.tokens ?? []).map((t) => [t.name, t]));
  const shadowRows = [];
  for (const [name, s] of Object.entries(map.shadow ?? {})) {
    const t = srcShadow.get(s);
    if (!t) { problems.push(`그림자 ${name} ← ${s}: 원본 없음`); continue; }
    const light = typeof t.value === 'string' ? t.value : t.value[th.light] ?? Object.values(t.value)[0];
    const dark = typeof t.value === 'string' ? '' : t.value[th.dark] ?? '';
    shadowRows.push(`${name}: "${light}"`.padEnd(40) + `  # ← ${s}${dark ? ` · dark ${dark}` : ''}`);
  }
  // 변형·모바일·규칙 — 대응표 필수 항목(값이 null이면 '원본 없음'으로 적는다)
  for (const [comp, keys] of Object.entries(CONTRACT_VARIANTS)) {
    const miss = keys.filter((k) => !(k in (map.variants?.[comp] ?? {})));
    if (miss.length) problems.push(`대응표 variants.${comp}에 없는 변형: ${miss.join(', ')}`);
  }
  const missMobile = MOBILE_COMPONENTS.filter((k) => !(k in (map.mobile ?? {})));
  if (missMobile.length) problems.push(`대응표 mobile에 없는 항목: ${missMobile.join(', ')}`);
  for (const k of ['signatures', 'dos', 'donts', 'responsive']) if (!map[k]?.length) problems.push(`대응표 ${k}가 비어 있음`);
  if (problems.length) {
    console.error(`${slug}: 대응표 적용 실패 ${problems.length}건 — designs/${slug}.md를 쓰지 않았습니다`);
    for (const p of problems) console.error(`  - ${p}`);
    process.exit(2);
  }
  // 원본 문서(README·추가 절·컴포넌트 설명)
  const demote = (md) => md.replace(/^(#{1,3}) /gm, (h, m) => `${'#'.repeat(m.length + 3)} `);
  const sections = readdirSync(proj).filter((f) => f.endsWith('.md') && f !== 'README.md').sort();
  const compDir = join(proj, 'components');
  const comps = existsSync(compDir) ? readdirSync(compDir).filter((c) => existsSync(join(compDir, c, 'README.md'))).sort() : [];
  const summary = (c) => readFileSync(join(compDir, c, 'README.md'), 'utf8').split('\n').map((l) => l.trim())
    .filter((l) => l && !l.startsWith('#')).join(' ').split(/(?<=[.다요])\s/)[0].replace(/\|/g, '/').slice(0, 160);
  // 원본 컴포넌트 속성(index.d.ts의 문자열 union)과 스타일(bundle.css 구역별 핵심 속성)
  const dts = existsSync(join(compDir, 'index.d.ts')) ? readFileSync(join(compDir, 'index.d.ts'), 'utf8') : '';
  const unions = new Map();
  for (const m of dts.matchAll(/interface (\w+?)Props\b[^{]*\{([^\n]*)\}/g)) {
    const props = [...m[2].matchAll(/(\w+)\??:\s*((?:'[^']*'\s*\|?\s*)+)(?=[;}])/g)]
      .map(([, k, v]) => `${k} ${v.match(/'([^']*)'/g).map((s) => s.slice(1, -1)).join('/')}`);
    if (props.length) unions.set(m[1], props.join(' · '));
  }
  const screens = existsSync(compDir) ? readdirSync(compDir).filter((c) => !comps.includes(c) && existsSync(join(compDir, c, 'preview.html'))).sort() : [];
  // 스타일 근거: components/bundle.css, 없으면 화면·표지 미리보기의 <style>
  const bundle = join(compDir, 'bundle.css');
  const cssSource = existsSync(bundle) ? 'components/bundle.css' : screens.length ? screens.map((s) => `components/${s}/preview.html`).join(', ') : '';
  const cssRows = cssSummary(existsSync(bundle) ? readFileSync(bundle, 'utf8')
    : screens.map((s) => [...readFileSync(join(compDir, s, 'preview.html'), 'utf8').matchAll(/<style[^>]*>([\s\S]*?)<\/style>/g)].map((m) => m[1]).join('\n')).join('\n'));
  const cell = (s) => String(s ?? '').replace(/\|/g, '/').replace(/\n/g, ' ');
  const reasons = map.null_reasons ?? {};
  const orNone = (v, path) => (v == null ? `원본 없음${reasons[path] ? `(${cell(reasons[path])})` : ''} — 템플릿 기본 명세를 이 시안 토큰으로 쓴다` : cell(v));
  const variantTables = Object.entries(CONTRACT_VARIANTS).map(([comp, keys]) => {
    const v = map.variants[comp];
    const extra = (v._extra ?? []).map((e) => `| (원본 추가) | ${cell(e)} |`);
    return `#### ${comp}\n\n| 계약 변형 | 원본 대응 |\n|---|---|\n${[...keys.map((k) => `| ${k} | ${orNone(v[k], `variants.${comp}.${k}`)} |`), ...extra].join('\n')}`;
  }).join('\n\n');
  const colorTable = [...colors.values()].map((t) => {
    const v = (theme) => (colorOf(t.name, th[theme]) ?? '').toLowerCase();
    return `| \`${t.name}\` | ${v('light')} | ${v('dark')} | ${(t.usage ?? '').replace(/\|/g, '/').replace(/\n/g, ' ')} |`;
  });
  const today = new Date().toISOString().slice(0, 10);
  const p = map.policy;
  const front = [
    `name: ${map.name}`, `slug: ${slug}`, `category: ${map.category}`, `last_updated: "${today}"`,
    'sources:', `  - ${map.source.url}`,
    `related_services: [${(map.related_services ?? []).map((s) => `"${s}"`).join(', ')}]`,
    `lang: ${map.lang ?? 'ko'}`,
    'policy:',
    `  shadow_on_cards: ${p.shadow_on_cards}`, `  gradient_locations: ${JSON.stringify(p.gradient_locations)}`,
    `  copy_tone: "${p.copy_tone}"`, `  dark_mode: "${p.dark_mode}"`, `  non_4_spacing: ${p.non_4_spacing}`,
    `${LINK_KEY}:`, `  url: ${url}`, `  version: "${version}"`, `  synced: "${today}"`, '  mode: adopt', `  map: designs/_sync/${slug}.map.json`,
  ].join('\n');
  const body = `
# ${map.name} — design.md

> ${map.tagline}

본 시안은 Claude Design System 「${map.source.title}」(${map.source.url})의 **스냅샷**이다. 원본 토큰 이름을 템플릿 별칭 계약(\`designs/_alias-contract.md\`)으로 옮긴 대응표는 \`designs/_sync/${slug}.map.json\`이고, \`node scripts/design-sync.mjs adopt\`가 이 파일을 다시 만든다. 이 파일을 직접 고치지 않는다 — 디자인은 Claude 쪽에서, 대응은 대응표에서 고친다.

## Brand & Style

${map.tagline}

- 카드 그림자: ${p.shadow_on_cards ? '허용' : '금지(헤어라인 우선)'} · gradient: ${p.gradient_locations.length ? p.gradient_locations.join(', ') : '전면 금지'} · 카피: ${p.copy_tone} · 다크 모드: ${p.dark_mode}
- 원칙·보이스·레이아웃의 원문은 아래 \`## 원본 문서\`에 그대로 있다.

## Colors

### Brand

\`\`\`yaml
${brandRows.join('\n')}
\`\`\`

### Semantic alias — Light

\`\`\`yaml
${aliasRows.light.join('\n')}
\`\`\`

### Semantic alias — Dark

\`\`\`yaml
${aliasRows.dark.join('\n')}
\`\`\`

### 원본 색 토큰 (시안 전용 포함)

| 원본 토큰 | light | dark | 용도 |
|---|---|---|---|
${colorTable.join('\n')}

## Typography

### 서체 선택

- **Primary**: \`${stack}\`${src.type?.families?.mono ? `\n- **Mono**: \`${src.type.families.mono}\`` : ''}

### Type ramp

\`\`\`yaml
${typeRows.join('\n')}
\`\`\`

${extraStyles.length ? `### 시안 전용 글꼴 스타일\n\n| 원본 스타일 | 크기/굵기/줄높이/자간 | 용도 |\n|---|---|---|\n${extraStyles.map((s) => `| \`${s.name}\` | ${ramp(s)} | ${(s.usage ?? '').replace(/\|/g, '/')} |`).join('\n')}\n` : ''}
## Spacing

\`\`\`yaml
${spaceRows.join('\n')}
\`\`\`

원본 간격은 단계 번호 이름(\`space-1\`=4px …)이라 값 기준으로 템플릿 이름(\`space-4\`=4px)에 옮겼다.

## Rounded

\`\`\`yaml
${radiusRows.join('\n')}
\`\`\`

## Elevation & Depth

\`\`\`yaml
${shadowRows.join('\n')}
\`\`\`

## Components

### 필수 컴포넌트 대응 (계약 §5)

| 계약 컴포넌트 | 원본 대응 |
|---|---|
${Object.entries(map.requiredComponents ?? {}).map(([k, v]) => `| ${k} | ${v} |`).join('\n')}

### 변형 대응

${variantTables}

### 모바일 컴포넌트 대응

| 템플릿 모바일 컴포넌트 | 원본 대응 |
|---|---|
${MOBILE_COMPONENTS.map((k) => `| ${k} | ${orNone(map.mobile[k], `mobile.${k}`)} |`).join('\n')}

### 시그니처

이 시안을 알아보게 하는 원본 고유 모양이다. 화면을 만들 때 표준 컴포넌트에 이 모양을 입힌다.

${map.signatures.map((s) => `- ${s}`).join('\n')}

### 원본 컴포넌트 (${comps.length}종)

| 컴포넌트 | 요약 | 변형·속성 |
|---|---|---|
${comps.map((c) => `| ${c} | ${summary(c)} | ${cell(unions.get(c) ?? '')} |`).join('\n')}
${screens.length ? `\n### 원본 화면 예시\n\n원본 Design System의 미리보기에만 있는 전체 화면·표지다(설명 문서 없음).\n\n${screens.map((s) => `- \`${s}\`${map.screens?.[s] ? ` — ${map.screens[s]}` : ''}`).join('\n')}\n` : ''}
${cssRows.length ? `### 원본 컴포넌트 스타일\n\n원본 \`${cssSource}\`의 스타일을 구역별로 요약했다(크기·모서리·색·테두리·그림자·글꼴). \`var(--x)\`는 원본 토큰 \`x\`다.\n\n| 구역 | 선택자 | 핵심 속성 |\n|---|---|---|\n${cssRows.join('\n')}\n` : ''}
## Do's and Don'ts

**Do**

${map.dos.map((s) => `- ${s}`).join('\n')}

**Don't**

${map.donts.map((s) => `- ${s}`).join('\n')}

## Responsive Behavior

${map.responsive.map((s) => `- ${s}`).join('\n')}

## Known Gaps

${[...(map.notes ?? []), ...synth].map((n) => `- ${n}`).join('\n')}

## 원본 문서

아래는 원본 Design System의 문서를 그대로 옮긴 것이다(제목 단계만 낮춤).

${demote(stripGenerated(readFileSync(join(proj, 'README.md'), 'utf8'))).trim()}

${sections.map((f) => demote(readFileSync(join(proj, f), 'utf8')).trim()).join('\n\n')}
`;
  writeFileSync(join(DESIGNS, `${slug}.md`), `---\n${front}\n---\n${body.replace(/\n{3,}/g, '\n\n')}`);
  console.log(`${slug}: designs/${slug}.md 생성 (대응표 적용, 원본 버전 ${version}) · 합성 별칭 ${synth.length}개 · 원본 컴포넌트 ${comps.length}종 · 추가 문서 ${sections.length}개`);
}

// ── preview 등록 (새 시안을 프리뷰 3화면에 추가) ─────────────────────────────────
function registerPreview(slug) {
  const { front, body } = splitDoc(readFileSync(join(DESIGNS, `${slug}.md`), 'utf8'));
  const blocks = yamlBlocks(body);
  const get = (k) => blocks.filter((b) => kind(b) === k).flatMap((b) => b.entries);
  const varLines = (entries, fmt) => entries.map((e) => `--${e.name}: ${fmt(e)};`);
  const typeVars = get('type').flatMap((e) => {
    const s = typeStyle(e.name, e.value);
    return s ? [`--font-size-${e.name}: ${s.fontSize};`, `--font-weight-${e.name}: ${s.fontWeight};`, `--line-height-${e.name}: ${s.lineHeight};`,
      `--letter-spacing-${e.name}: ${s.letterSpacing ?? 0};`] : [];
  });
  const stack = fontStack(body);
  const policy = { shadow_on_cards: /shadow_on_cards:\s*true/.test(front), gradient_locations: JSON.parse((/gradient_locations:\s*(\[.*\])/.exec(front) || [])[1] || '[]'),
    copy_tone: (/copy_tone:\s*"([^"]+)"/.exec(front) || [])[1] || 'ko-friendly', dark_mode: (/dark_mode:\s*"([^"]+)"/.exec(front) || [])[1] || 'supported',
    non_4_spacing: /non_4_spacing:\s*true/.test(front) };
  for (const file of PREVIEWS) {
    let html = readFileSync(join(ROOT, file), 'utf8');
    if (html.includes(`data-design="${slug}"`)) { console.log(`${file}: ${slug} 이미 등록됨`); continue; }
    // CSS: 마지막 시안 dark 블록 뒤에 넣는다.
    const re = /^([ \t]*):root\[data-design="[^"]+"\]\[data-theme="dark"\]\s*\{/gm;
    let m, last = null;
    while ((m = re.exec(html))) last = m;
    if (!last) throw new Error(`${file}: 시안 블록을 찾지 못함`);
    const ind = last[1];
    let i = last.index + last[0].length, depth = 1;
    while (depth) { if (html[i] === '{') depth++; else if (html[i] === '}') depth--; i++; }
    const block = (theme, lines) => `${ind}:root[data-design="${slug}"][data-theme="${theme}"] {\n${lines.map((l) => `${ind}  ${l}`).join('\n')}\n${ind}}`;
    const light = [
      '/* scripts/design-sync.mjs preview --register 로 생성 — 값은 designs 시안 파일이 정본 */',
      ...varLines(get('light'), (e) => e.value),
      ...varLines(get('spacing'), (e) => px(e.value)),
      ...varLines(get('radius'), (e) => px(e.value)),
      ...varLines(get('shadow'), (e) => e.value),
      ...(stack ? [`--font-sans: ${stack};`] : []),
      ...typeVars,
    ];
    const css = `\n\n${block('light', light)}\n\n${block('dark', varLines(get('dark'), (e) => e.value))}`;
    html = html.slice(0, i) + css + html.slice(i);
    // DESIGNS 등록
    const start = html.indexOf('const DESIGNS = {');
    if (start < 0) throw new Error(`${file}: DESIGNS 목록을 찾지 못함`);
    let j = html.indexOf('{', start) + 1; depth = 1;
    while (depth) { if (html[j] === '{') depth++; else if (html[j] === '}') depth--; j++; }
    const close = html.lastIndexOf('\n', j - 1) + 1;
    const keyInd = (/\n([ \t]+)\S/.exec(html.slice(html.indexOf('{', start)))) [1];
    const entry = [`${keyInd}'${slug}': {`, `${keyInd}  label: '${slug}',`, `${keyInd}  policy: {`,
      ...Object.entries(policy).map(([k, v]) => `${keyInd}    ${k}: ${JSON.stringify(v).replace(/"/g, "'")},`), `${keyInd}  },`, `${keyInd}},`].join('\n');
    const before = html.slice(0, close).replace(/\s*$/, '');
    html = `${before}${before.endsWith(',') ? '' : ','}\n${entry}\n${html.slice(close)}`;
    writeFileSync(join(ROOT, file), html);
    console.log(`${file}: ${slug} 등록`);
  }
}

// ── preview ───────────────────────────────────────────────────────────────────
function previewBlocks(html, slug, theme) {
  const re = new RegExp(`:root\\[data-design="${slug}"\\]\\[data-theme="${theme}"\\]\\s*\\{`, 'g');
  const out = [];
  let m;
  while ((m = re.exec(html))) {
    let depth = 1, i = m.index + m[0].length;
    while (i < html.length && depth) { if (html[i] === '{') depth++; else if (html[i] === '}') depth--; i++; }
    out.push({ start: m.index + m[0].length, end: i - 1 });
  }
  return out;
}

function preview(fix) {
  const norm = (v) => v.replace(/\s+/g, '').toLowerCase();
  let drift = 0;
  for (const file of PREVIEWS) {
    let html = readFileSync(join(ROOT, file), 'utf8');
    let changed = 0;
    for (const slug of slugs()) {
      const { front, body } = splitDoc(readFileSync(join(DESIGNS, `${slug}.md`), 'utf8'));
      const blocks = yamlBlocks(body);
      for (const theme of ['light', 'dark']) {
        const want = new Map();
        for (const b of blocks) if (kind(b) === theme) for (const e of b.entries) if (COLOR_RE.test(e.value)) want.set(e.name, e.value);
        const found = previewBlocks(html, slug, theme);
        if (!found.length) { console.log(`${file}: ${slug}/${theme} 블록 없음`); drift++; continue; }
        for (const blk of found.reverse()) {
          let seg = html.slice(blk.start, blk.end);
          seg = seg.replace(/--([A-Za-z0-9-]+):\s*([^;]+);/g, (all, name, val) => {
            const w = want.get(name);
            if (!w || norm(w) === norm(val)) return all;
            drift++;
            console.log(`${file}: ${slug}/${theme} --${name} ${val.trim()} ≠ 시안 ${w}`);
            if (!fix) return all;
            changed++;
            return all.replace(val, w);
          });
          html = html.slice(0, blk.start) + seg + html.slice(blk.end);
        }
      }
      void front;
    }
    if (fix && changed) { writeFileSync(join(ROOT, file), html); console.log(`${file}: ${changed}곳 고침`); }
  }
  if (!drift) console.log('프리뷰: 시안 별칭 색이 모두 일치');
  return drift;
}

// ── status / check ────────────────────────────────────────────────────────────
function status() {
  for (const slug of slugs()) {
    const { front, link } = splitDoc(readFileSync(join(DESIGNS, `${slug}.md`), 'utf8'));
    console.log(`${slug}\t${frontValue(front, 'name') || ''}\t${link.url || '(연결 없음)'}\t${link.version || '-'}\t${link.synced || '-'}\t${link.mode === 'adopt' ? 'adopt' : 'import'}`);
  }
}

function check() {
  let bad = 0;
  for (const slug of slugs()) {
    const { front, link, body } = splitDoc(readFileSync(join(DESIGNS, `${slug}.md`), 'utf8'));
    const { tokens } = buildTokens(slug, front, body);
    if (!tokens.color.tokens.length) { console.log(`${slug}: 색 토큰 0개`); bad++; }
    if (!link.url) console.log(`${slug}: Claude Design System 연결 없음(경고)`);
  }
  bad += preview(false) ? 1 : 0;
  if (bad) process.exit(1);
  console.log('design-sync check: 통과');
}

// ── main ──────────────────────────────────────────────────────────────────────
const [cmd, ...rest] = process.argv.slice(2);
const opt = (k) => { const i = rest.indexOf(k); return i >= 0 ? rest[i + 1] : undefined; };
const positional = rest.filter((a, i) => !a.startsWith('--') && !(i > 0 && rest[i - 1].startsWith('--') && !['--all', '--fix'].includes(rest[i - 1])));
if (cmd === 'export') {
  const out = opt('--out');
  if (!out) { console.error('--out <dir>이 필요합니다'); process.exit(1); }
  const list = rest.includes('--all') ? slugs() : positional;
  if (!list.length) { console.error('시안 slug 또는 --all이 필요합니다'); process.exit(1); }
  for (const s of list) exportOne(s, out, opt('--index'), opt('--by'), opt('--suffix') ?? '');
} else if (cmd === 'import') {
  const [slug] = positional;
  if (!slug || !opt('--from') || !opt('--url') || !opt('--version')) { console.error('import <slug> --from <dir> --url <url> --version <ver>'); process.exit(1); }
  importOne(slug, opt('--from'), opt('--url'), opt('--version'));
} else if (cmd === 'adopt') {
  const [slug] = positional;
  if (!slug || !opt('--from') || !opt('--url') || !opt('--version')) { console.error('adopt <slug> --from <dir> --url <url> --version <ver>'); process.exit(1); }
  adoptOne(slug, opt('--from'), opt('--url'), opt('--version'));
} else if (cmd === 'preview') {
  if (opt('--register')) { registerPreview(opt('--register')); process.exit(0); }
  process.exit(preview(rest.includes('--fix')) && !rest.includes('--fix') ? 1 : 0);
} else if (cmd === 'status') status();
else if (cmd === 'check') check();
else { console.error('사용: export | import | adopt | preview [--fix|--register <slug>] | status | check'); process.exit(1); }
