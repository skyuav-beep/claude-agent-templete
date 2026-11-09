#!/usr/bin/env node
// phase-approval.sh 회귀 검사.
//
// 임시 저장소와 worktree를 만들고 훅을 실제로 실행해 출력으로 판정한다. 확인 요청
// (permissionDecision: ask)이 출력되면 확인, 허용(allow)이 출력되면 허용, 아무 출력
// 없이 끝나면 통과다. 허용은 세션 작업 폴더 밖 worktree의 기본 확인 창까지 건너뛴다.
// Node 내장 모듈만 쓰며 설치 배포 대상이 아니다.
//
//   node scripts/check-phase-approval.mjs
//
// 케이스를 늘릴 때는 "왜 이 수정이 그 판정이어야 하는가"를 note에 남긴다.

import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const HOOK = path.join(ROOT, ".claude", "hooks", "phase-approval.sh");
const SESSION = "approval-test";

const TMP = fs.mkdtempSync(path.join(os.tmpdir(), "phase-approval-"));
const REPO = path.join(TMP, "repo");
const WORKTREE = path.join(TMP, "worktree");

const git = (cwd, ...args) => {
  const result = spawnSync(
    "git",
    ["-c", "user.name=guard", "-c", "user.email=guard@example.invalid", "-c", "commit.gpgsign=false", ...args],
    { cwd, encoding: "utf8" },
  );
  if (result.status !== 0) throw new Error(`git ${args.join(" ")} 실패: ${result.stderr}`);
};

fs.mkdirSync(REPO);
git(REPO, "init", "-q");
fs.writeFileSync(path.join(REPO, "README.md"), "readme\n");
git(REPO, "add", "README.md");
git(REPO, "commit", "-q", "-m", "init");
git(REPO, "worktree", "add", "-q", "-b", "work", WORKTREE);
fs.mkdirSync(path.join(REPO, "backend"));
fs.mkdirSync(path.join(REPO, "docs"));
fs.writeFileSync(path.join(REPO, "docs", "DRAFT_PLAN.md"), "draft\n");

const marker = path.join(REPO, ".claude", ".approval", SESSION);

/** cwd는 세션 작업 위치, file은 수정 대상이다. withMarker면 3단계 승인 표시를 둔다. allow는 허용 출력 기대. */
const CASES = [
  // 사실 기록은 3단계 승인에 포함되므로 표시 없이도 묻지 않는다.
  { cwd: REPO, file: "STATE.md", ask: false, note: "메인 체크아웃의 STATE.md" },
  { cwd: REPO, file: path.join(REPO, "STATE.md"), ask: false, note: "절대 경로로 넘겨도 같다" },
  { cwd: WORKTREE, file: "STATE.md", ask: false, allow: true, note: "worktree의 STATE.md는 허용" },
  { cwd: REPO, file: "docs/archive/STATE-2026-09-17.md", ask: false, note: "아직 없는 폴더의 STATE 스냅샷" },

  // 기록이 아니거나 기록처럼 보이기만 하는 것은 그대로 확인한다.
  { cwd: REPO, file: "README.md", ask: true, note: "일반 파일" },
  { cwd: WORKTREE, file: "src/app.js", ask: true, note: "worktree의 일반 파일" },
  { cwd: REPO, file: "docs/99-archive/old.md", ask: true, note: "문서 이동은 구조 변경이다" },
  { cwd: REPO, file: "apps/web/STATE.md", ask: true, note: "저장소 최상위의 STATE.md만 기록이다" },
  { cwd: REPO, file: "docs/archive-old/x.md", ask: true, note: "이름만 비슷한 폴더" },
  { cwd: REPO, file: "docs/archive/../../README.md", ask: true, note: "경로를 정규화한 뒤 판정한다" },

  // 기존 동작. 승인 표시가 있거나 다른 저장소 파일이면 묻지 않는다.
  { cwd: REPO, file: "README.md", ask: false, withMarker: true, note: "승인 표시가 있으면 통과" },
  { cwd: REPO, file: path.join(WORKTREE, "src/new.ts"), ask: false, allow: true, withMarker: true, note: "승인 후 형제 worktree 새 파일은 허용" },
  { cwd: REPO, file: path.join(WORKTREE, "src/new.ts"), ask: true, note: "승인 전 worktree 새 파일은 확인" },
  { cwd: REPO, file: path.join(TMP, "outside.md"), ask: false, note: "저장소 밖 파일" },

  // 오토 모드는 작업 요청이 승인이다. 마커를 잊어도 worktree 수정은 막지 않고, 메인 체크아웃은 그대로 묻는다.
  { cwd: REPO, file: path.join(WORKTREE, "src/new.ts"), ask: false, allow: true, mode: "auto", note: "오토 모드 worktree 새 파일은 마커 없이 허용" },
  { cwd: WORKTREE, file: "src/app.js", ask: false, allow: true, mode: "acceptEdits", note: "편집 자동 수락 모드도 같다" },
  { cwd: REPO, file: "README.md", ask: true, mode: "auto", note: "오토 모드라도 메인 체크아웃은 확인" },
  { cwd: REPO, file: path.join(WORKTREE, "src/new.ts"), ask: true, mode: "default", note: "기본 모드는 마커가 있어야 허용" },

  // 새 Markdown 문서(계획서·분석 메모) 생성은 기존 내용을 건드리지 않으므로 메인 체크아웃이라도 다시 묻지 않는다.
  { cwd: REPO, file: "docs/NEW_PLAN.md", ask: false, allow: true, mode: "auto", note: "오토 모드 메인 체크아웃 새 .md는 허용" },
  { cwd: path.join(REPO, "backend"), file: path.join(REPO, "docs/plan.md"), ask: false, allow: true, mode: "auto", note: "하위 폴더 세션의 상위 docs/ 새 .md도 허용" },
  { cwd: REPO, file: "docs/NEW_PLAN.md", ask: false, allow: true, withMarker: true, mode: "default", note: "승인 표시가 있으면 기본 모드도 허용" },
  { cwd: REPO, file: "docs/NEW_PLAN.md", ask: true, mode: "default", note: "승인 전 기본 모드는 새 .md도 확인" },
  { cwd: REPO, file: "README.md", ask: true, mode: "auto", note: "커밋된 .md 덮어쓰기·수정은 확인" },
  { cwd: REPO, file: "docs/99-archive/new.md", ask: true, mode: "auto", note: "보관 폴더는 구조 변경이라 확인" },
  { cwd: REPO, file: "docs/notes.txt", ask: true, mode: "auto", note: ".md가 아닌 새 파일은 확인" },
  // 만든 뒤 아직 커밋하지 않은 .md를 이어서 고치는 것도 작성 중인 문서라 묻지 않는다.
  { cwd: path.join(REPO, "backend"), file: path.join(REPO, "docs/DRAFT_PLAN.md"), ask: false, allow: true, mode: "auto", note: "커밋 전 .md 수정은 허용" },
  { cwd: REPO, file: "docs/DRAFT_PLAN.md", ask: true, mode: "default", note: "승인 전 기본 모드는 커밋 전 .md도 확인" },
];

const run = ({ cwd, file, mode }) => {
  const input = {
    hook_event_name: "PreToolUse",
    tool_name: "Edit",
    tool_input: { file_path: file },
    cwd,
    session_id: SESSION,
    ...(mode ? { permission_mode: mode } : {}),
  };
  const result = spawnSync("bash", [HOOK], { input: JSON.stringify(input), encoding: "utf8" });
  if (result.error) throw result.error;
  const m = /"permissionDecision":\s*"(ask|allow)"/.exec(result.stdout);
  return m ? m[1] : "pass";
};

const NAMES = { ask: "확인", allow: "허용", pass: "통과" };

let failed = 0;
try {
  for (const testCase of CASES) {
    if (testCase.withMarker) {
      fs.mkdirSync(path.dirname(marker), { recursive: true });
      fs.writeFileSync(marker, "");
    }
    const got = run(testCase);
    fs.rmSync(marker, { force: true });
    const want = testCase.ask ? "ask" : testCase.allow ? "allow" : "pass";
    const ok = got === want;
    if (!ok) failed += 1;
    const verdict = NAMES[got];
    const expected = NAMES[want];
    const where = testCase.cwd === WORKTREE ? "worktree" : "main";
    const label = `${where}: ${path.isAbsolute(testCase.file) ? testCase.file.replace(TMP, "<tmp>") : testCase.file}`;
    const detail = ok ? testCase.note : `${expected}이어야 하는데 ${verdict}`;
    console.log(`${ok ? "  ok" : "FAIL"}  ${label.padEnd(48)} ${verdict}  ${detail}`);
  }
} finally {
  fs.rmSync(TMP, { recursive: true, force: true });
}

console.log(`\n${CASES.length - failed}/${CASES.length} 통과`);
if (failed) {
  console.error(`${failed}건 실패. 승인 게이트 판정이 의도와 어긋난다.`);
  process.exit(1);
}
