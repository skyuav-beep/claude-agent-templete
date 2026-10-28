#!/usr/bin/env node
// session-coordination.sh git 삭제 가드 회귀 검사.
//
// 임시 저장소와 임시 상태 디렉터리에서 세션 두 개(A, B)를 등록하고 훅을 실제로
// 실행해 출력으로 판정한다. 확인 요청(permissionDecision: ask)이 출력되면 확인,
// 아무 출력 없이 끝나면 통과다. 케이스는 순서대로 실행되며 앞 케이스가 남긴
// 세션 레코드(이 세션이 만든 브랜치·worktree)를 뒤 케이스가 이어 쓴다.
// Node 내장 모듈만 쓰며 설치 배포 대상이 아니다.
//
//   node scripts/check-session-guard.mjs
//
// 케이스를 늘릴 때는 "왜 이 명령이 그 판정이어야 하는가"를 note에 남긴다.

import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const HOOK = path.join(ROOT, ".claude", "hooks", "session-coordination.sh");

const TMP = fs.mkdtempSync(path.join(os.tmpdir(), "session-guard-"));
const REPO = path.join(TMP, "repo");
const ORIGIN = path.join(TMP, "origin.git");
const SHARED = path.join(TMP, "state-shared");
const ALONE = path.join(TMP, "state-alone");

const git = (cwd, ...args) => {
  const result = spawnSync(
    "git",
    ["-c", "user.name=guard", "-c", "user.email=guard@example.invalid", "-c", "commit.gpgsign=false", ...args],
    { cwd, encoding: "utf8" },
  );
  if (result.status !== 0) throw new Error(`git ${args.join(" ")} 실패: ${result.stderr}`);
};

fs.mkdirSync(REPO);
git(TMP, "init", "-q", "--bare", ORIGIN);
git(REPO, "init", "-q", "-b", "main");
fs.writeFileSync(path.join(REPO, "README.md"), "readme\n");
git(REPO, "add", "README.md");
git(REPO, "commit", "-q", "-m", "init");
git(REPO, "remote", "add", "origin", ORIGIN);
git(REPO, "push", "-q", "origin", "main");
git(REPO, "fetch", "-q", "origin");

const hook = (session, event, command, stateDir = SHARED) => {
  const input = { hook_event_name: event, session_id: session, cwd: REPO };
  if (command !== undefined) input.tool_input = { command };
  const result = spawnSync("bash", [HOOK], {
    cwd: REPO,
    input: JSON.stringify(input),
    encoding: "utf8",
    env: { ...process.env, SESSION_COORD_STATE_DIR: stateDir },
  });
  if (result.error) throw result.error;
  return /"permissionDecision":\s*"ask"/.test(result.stdout);
};

hook("B", "SessionStart");
hook("A", "SessionStart");

/** who는 명령을 실행하는 세션이다. stateDir를 주면 다른 세션이 없는 저장소로 본다. */
const CASES = [
  { who: "A", cmd: "git status --short", ask: false, note: "지우지 않는 명령" },
  { who: "A", cmd: "git branch -D feat/x", ask: true, note: "이 세션이 만들지 않은 브랜치" },
  { who: "A", cmd: "git worktree add -q -b feat/a ../wt-a origin/main", ask: false, note: "만들기는 통과하고 레코드에 적는다" },
  {
    who: "A",
    cmd: "gh pr merge 1 --squash 2>&1 | tail -1; git fetch -q; git worktree remove --force ../wt-a && git branch -D -q feat/a && git push -q origin --delete feat/a; git status --short | head -3",
    ask: false,
    note: "이 세션 것만 정리하는 복합 명령(리다이렉션·파이프 포함)",
  },
  { who: "A", cmd: "cd ../wt-a && git push origin :refs/heads/feat/a", ask: false, note: "cd 뒤 refspec 삭제 형식" },
  { who: "A", cmd: "git -C ../wt-a worktree remove .", ask: false, note: "-C 기준 상대 경로" },
  { who: "A", cmd: "git commit -q -F - <<'EOF'\n메시지 > 기록\nEOF\ngit branch -D feat/a", ask: false, note: "heredoc 뒤의 이 세션 브랜치 삭제" },
  { who: "A", cmd: "git branch -D main", ask: true, note: "다른 세션이 등록한 브랜치" },
  { who: "B", cmd: "git worktree add -b feat/b ../wt-b", ask: false, note: "B가 만든 브랜치" },
  { who: "A", cmd: "git push origin --delete feat/b", ask: true, note: "다른 세션이 만든 원격 브랜치" },
  { who: "A", cmd: "git worktree remove ../wt-b", ask: true, note: "다른 세션이 만든 worktree" },
  { who: "B", cmd: "git worktree remove ../wt-b && git branch -D feat/b", ask: false, note: "B는 자기 것을 묻지 않고 정리한다" },
  { who: "A", cmd: "git branch -D feat/a feat/x", ask: true, note: "대상 중 하나라도 남의 것이면 확인" },
  { who: "A", cmd: 'git branch -D "$BR"', ask: true, note: "실행 시점에 정해지는 대상" },
  { who: "A", cmd: "git push --force origin feat/a", ask: true, note: "이력 덮어쓰기는 대상과 무관하게 확인" },
  { who: "A", cmd: "git worktree prune", ask: true, note: "대상을 특정할 수 없는 정리" },
  { who: "A", cmd: "git push -u origin feat/c", ask: false, note: "원격에 없던 브랜치를 올리면 이 세션 것" },
  { who: "A", cmd: "git push origin --delete feat/c", ask: false, note: "이 세션이 올린 원격 브랜치 삭제" },
  { who: "A", cmd: "git push origin main", ask: false, note: "이미 있는 원격 브랜치 push" },
  { who: "A", cmd: "git push origin --delete main", ask: true, note: "이미 있던 브랜치는 push해도 이 세션 것이 아니다" },
  { who: "A", cmd: "git branch -D 'feat/a", ask: true, note: "셸 문법으로 읽지 못하면 종전 규칙" },
  { who: "C", cmd: "git branch -D anything", ask: false, stateDir: ALONE, note: "다른 세션이 없으면 개입하지 않는다" },
];

let failed = 0;
try {
  for (const testCase of CASES) {
    const asked = hook(testCase.who, "PreToolUse", testCase.cmd, testCase.stateDir);
    const ok = asked === testCase.ask;
    if (!ok) failed += 1;
    const label = `${testCase.who}: ${testCase.cmd.split("\n")[0]}`.slice(0, 60).padEnd(60);
    console.log(`  ${ok ? "ok  " : "FAIL"} ${label} ${asked ? "확인" : "통과"}  ${testCase.note}`);
  }
} finally {
  fs.rmSync(TMP, { recursive: true, force: true });
}

console.log(`\n${CASES.length - failed}/${CASES.length} 통과`);
process.exit(failed === 0 ? 0 : 1);
