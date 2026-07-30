#!/usr/bin/env node
/**
 * 저장소 문서를 브라우저에서 보기 위한 로컬 정적 서버.
 *
 * 시작할 때 docs/docs-index.json을 새로 만들고, 저장소 루트를 127.0.0.1에 붙인다.
 * 외부 의존성 없이 Node 내장 모듈만 사용하며 읽기 전용이다(쓰기 경로 없음).
 *
 *   node scripts/serve-docs.mjs            # 기본 포트 8765
 *   node scripts/serve-docs.mjs --port 9000
 *   node scripts/serve-docs.mjs --no-index # 인덱스 재생성 없이 서버만
 */

import { createServer } from 'node:http';
import { createReadStream, existsSync, statSync } from 'node:fs';
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

const server = createServer((req, res) => {
  if (req.method !== 'GET' && req.method !== 'HEAD') {
    res.writeHead(405, { 'content-type': 'text/plain; charset=utf-8', allow: 'GET, HEAD' });
    res.end('이 서버는 읽기 전용입니다.\n');
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
