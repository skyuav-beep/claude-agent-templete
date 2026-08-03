#!/usr/bin/env node
/**
 * 저장소 문서를 브라우저에서 보기 위한 로컬 정적 서버.
 *
 * 시작할 때 docs/docs-index.json을 새로 만들고, 저장소 루트를 127.0.0.1에 붙인다.
 * 외부 의존성 없이 Node 내장 모듈만 사용한다.
 *
 * 기본은 읽기 전용이다. --edit을 붙였을 때만 문서 저장 경로가 열리며, 그때도
 * 이 저장소 안의 기존 .md 파일 수정으로만 제한한다(신규 생성·삭제 없음).
 *
 *   node scripts/serve-docs.mjs            # 기본 포트 8765, 읽기 전용
 *   node scripts/serve-docs.mjs --port 9000
 *   node scripts/serve-docs.mjs --no-index # 인덱스 재생성 없이 서버만
 *   node scripts/serve-docs.mjs --edit     # 브라우저에서 문서 편집·저장 허용
 */

import { createServer } from 'node:http';
import { createReadStream, existsSync, readFileSync, renameSync, statSync, writeFileSync } from 'node:fs';
import { join, extname, normalize, sep } from 'node:path';
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const HERE = fileURLToPath(new URL('.', import.meta.url));
const ROOT = join(HERE, '..');

const argv = process.argv.slice(2);
const portArg = argv.indexOf('--port');
const PORT = portArg !== -1 ? Number(argv[portArg + 1]) : 8765;
const HOST = '127.0.0.1';
const ENTRY = '/docs/guide-browser.html';
const EDIT = argv.includes('--edit');
// 저장 본문 상한. 이 저장소에서 가장 큰 문서도 여유 있게 들어간다.
const MAX_BODY = 4 * 1024 * 1024;

// file://에서는 fetch가 막히고, charset을 붙이지 않으면 한글이 깨지는 환경이 있다.
const TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.md': 'text/markdown; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.mjs': 'application/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.txt': 'text/plain; charset=utf-8',
  '.svg': 'image/svg+xml; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.webp': 'image/webp',
  '.ico': 'image/x-icon',
};

if (!argv.includes('--no-index')) {
  try {
    const out = execFileSync(process.execPath, [join(HERE, 'build-docs-index.mjs')], { encoding: 'utf8' });
    process.stdout.write(out);
  } catch (err) {
    console.error('문서 인덱스 생성 실패:', err.message);
    console.error('인덱스 없이 서버만 띄우려면 --no-index 를 붙이세요.');
    process.exit(1);
  }
}

function resolveSafe(urlPath) {
  let decoded;
  try {
    decoded = decodeURIComponent(urlPath.split('?')[0].split('#')[0]);
  } catch {
    return null;
  }
  if (decoded === '/') decoded = ENTRY;
  const target = normalize(join(ROOT, decoded));
  // 저장소 밖으로 나가는 경로는 거부한다.
  if (target !== ROOT && !target.startsWith(ROOT + sep)) return null;
  return target;
}

// 로컬에서 연 화면이 보낸 요청인지 확인한다. 127.0.0.1에만 바인딩해도 다른 사이트가
// 브라우저를 통해 저장 요청을 보낼 수 있으므로 Host와 Origin을 함께 본다.
function isLocalRequest(req) {
  const host = String(req.headers.host || '').split(':')[0];
  if (host !== HOST && host !== 'localhost') return false;
  const origin = req.headers.origin;
  if (!origin) return true;
  try {
    const hostname = new URL(origin).hostname;
    return hostname === HOST || hostname === 'localhost';
  } catch {
    return false;
  }
}

function sendJson(res, status, payload) {
  res.writeHead(status, { 'content-type': 'application/json; charset=utf-8', 'cache-control': 'no-store' });
  res.end(JSON.stringify(payload));
}

// 편집 가능한 대상인지 판정한다. 저장소 안의 이미 존재하는 .md 파일만 통과한다.
function resolveEditable(docPath) {
  if (typeof docPath !== 'string' || !docPath) return null;
  const target = resolveSafe('/' + docPath.replace(/^\/+/, ''));
  if (!target) return null;
  if (extname(target).toLowerCase() !== '.md') return null;
  if (!existsSync(target) || !statSync(target).isFile()) return null;
  return target;
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    let size = 0;
    const chunks = [];
    req.on('data', (chunk) => {
      size += chunk.length;
      if (size > MAX_BODY) {
        reject(new Error('본문이 너무 큽니다.'));
        req.destroy();
        return;
      }
      chunks.push(chunk);
    });
    req.on('end', () => resolve(Buffer.concat(chunks).toString('utf8')));
    req.on('error', reject);
  });
}

function handleSave(req, res, url) {
  readBody(req).then((raw) => {
    let payload;
    try {
      payload = JSON.parse(raw);
    } catch {
      return sendJson(res, 400, { ok: false, error: '요청 본문을 해석할 수 없습니다.' });
    }
    const target = resolveEditable(url.searchParams.get('path') || payload.path);
    if (!target) {
      return sendJson(res, 400, { ok: false, error: '이 저장소 안의 기존 .md 문서만 저장할 수 있습니다.' });
    }
    if (typeof payload.content !== 'string') {
      return sendJson(res, 400, { ok: false, error: '본문이 없습니다.' });
    }
    // 다른 창이나 에디터가 먼저 고쳤으면 덮어쓰지 않는다.
    const current = statSync(target).mtimeMs;
    if (payload.mtimeMs != null && Math.abs(Number(payload.mtimeMs) - current) > 1) {
      return sendJson(res, 409, {
        ok: false,
        error: '문서가 이 화면 밖에서 바뀌었습니다. 새로고침한 뒤 다시 편집하세요.',
        mtimeMs: current,
      });
    }
    try {
      // 같은 디렉터리에 쓴 뒤 교체해, 쓰기 도중 중단돼도 원본이 깨지지 않게 한다.
      const temp = target + '.tmp-' + process.pid;
      writeFileSync(temp, payload.content, 'utf8');
      renameSync(temp, target);
    } catch (err) {
      return sendJson(res, 500, { ok: false, error: '저장 실패: ' + err.message });
    }
    sendJson(res, 200, { ok: true, mtimeMs: statSync(target).mtimeMs });
  }).catch((err) => {
    sendJson(res, 413, { ok: false, error: err.message });
  });
}

const server = createServer((req, res) => {
  const url = new URL(req.url || '/', 'http://' + HOST);

  if (url.pathname === '/api/capabilities') {
    if (req.method !== 'GET') {
      res.writeHead(405, { 'content-type': 'text/plain; charset=utf-8', allow: 'GET' });
      return res.end('GET만 허용합니다.\n');
    }
    return sendJson(res, 200, { edit: EDIT });
  }

  if (url.pathname === '/api/doc') {
    if (req.method !== 'PUT' && req.method !== 'GET') {
      res.writeHead(405, { 'content-type': 'text/plain; charset=utf-8', allow: 'GET, PUT' });
      return res.end('GET 또는 PUT만 허용합니다.\n');
    }
    if (req.method === 'GET') {
      // 편집 시작 시 원문과 수정 시각을 함께 받는다. 저장할 때 이 시각으로 충돌을 판정한다.
      if (!EDIT) return sendJson(res, 403, { ok: false, error: '읽기 전용 모드입니다.' });
      const target = resolveEditable(url.searchParams.get('path'));
      if (!target) return sendJson(res, 400, { ok: false, error: '이 저장소 안의 기존 .md 문서만 열 수 있습니다.' });
      return sendJson(res, 200, {
        ok: true,
        content: readFileSync(target, 'utf8'),
        mtimeMs: statSync(target).mtimeMs,
      });
    }
    if (!EDIT) {
      return sendJson(res, 403, {
        ok: false,
        error: '읽기 전용 모드입니다. 편집하려면 node scripts/serve-docs.mjs --edit 으로 다시 띄우세요.',
      });
    }
    if (!isLocalRequest(req)) {
      return sendJson(res, 403, { ok: false, error: '로컬 화면에서 온 요청이 아닙니다.' });
    }
    return handleSave(req, res, url);
  }

  if (req.method !== 'GET' && req.method !== 'HEAD') {
    res.writeHead(405, { 'content-type': 'text/plain; charset=utf-8', allow: 'GET, HEAD' });
    res.end('이 경로는 읽기 전용입니다.\n');
    return;
  }

  const target = resolveSafe(req.url || '/');
  if (!target || !existsSync(target) || !statSync(target).isFile()) {
    res.writeHead(404, { 'content-type': 'text/plain; charset=utf-8' });
    res.end('404 Not Found\n');
    return;
  }

  const type = TYPES[extname(target).toLowerCase()] || 'application/octet-stream';
  res.writeHead(200, { 'content-type': type, 'cache-control': 'no-cache' });
  if (req.method === 'HEAD') return res.end();
  createReadStream(target).pipe(res);
});

server.listen(PORT, HOST, () => {
  console.log(`\n문서 서버 실행 중 — http://${HOST}:${PORT}${ENTRY}`);
  console.log(EDIT
    ? '  모드: 편집 허용 (이 저장소의 기존 .md 문서 수정만, 커밋은 별도)'
    : '  모드: 읽기 전용 (편집하려면 --edit 을 붙여 실행)');
  console.log('  다른 화면:');
  for (const page of ['development-process', 'development-strategy', 'intake', 'admin-fe-preview', 'user-fe-preview', 'user-fe-mobile-preview']) {
    console.log(`    http://${HOST}:${PORT}/docs/${page}.html`);
  }
  console.log('\n  종료: Ctrl+C\n');
});

server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`포트 ${PORT}이 이미 사용 중입니다. --port 로 다른 포트를 지정하세요.`);
    process.exit(1);
  }
  throw err;
});
