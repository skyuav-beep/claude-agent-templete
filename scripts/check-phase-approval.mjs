#!/usr/bin/env node
// phase-approval.sh 회귀 검사.
//
// 임시 저장소와 worktree를 만들고 훅을 실제로 실행해 출력으로 판정한다. 확인 요청
// (permissionDecision: ask)이 출력되면 확인, 아무 출력 없이 끝나면 통과다.
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

const marker = path.join(REPO, ".claude", ".approval", SESSION);

/** cwd는 세션 작업 위치, file은 수정 대상이다. withMarker면 3단계 승인 표시를 둔다. */
const CASES = [
  // 사실 기록은 3단계 승인에 포함되므로 표시 없이도 묻지 않는다.
  { cwd: REPO, file: "STATE.md", ask: false, note: "메인 체크아웃의 STATE.md" },
  { cwd: REPO, file: path.join(REPO, "STATE.md"), ask: false, note: "절대 경로로 넘겨도 같다" },
  { cwd: WORKTREE, file: "STATE.md", ask: false, note: "worktree의 STATE.md" },
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
  { cwd: REPO, file: path.join(TMP, "outside.md"), ask: false, note: "저장소 밖 파일" },
];

const run = ({ cwd, file }) => {
  const input = {
    hook_event_name: "PreToolUse",
    tool_name: "Edit",
    tool_input: { file_path: file },
    cwd,
    session_id: SESSION,
  };
  const result = spawnSync("bash", [HOOK], { input: JSON.stringify(input), encoding: "utf8" });
  if (result.error) throw result.error;
  return /"permissionDecision":\s*"ask"/.test(result.stdout);
};

let failed = 0;
try {
  for (const testCase of CASES) {
    if (testCase.withMarker) {
      fs.mkdirSync(path.dirname(marker), { recursive: true });
      fs.writeFileSync(marker, "");
    }
    const asked = run(testCase);
    fs.rmSync(marker, { force: true });
    const ok = asked === testCase.ask;
    if (!ok) failed += 1;
    const verdict = asked ? "확인" : "통과";
    const expected = testCase.ask ? "확인" : "통과";
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
