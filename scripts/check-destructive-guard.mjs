#!/usr/bin/env node
// block-destructive.sh 회귀 검사.
//
// 훅을 실제로 실행해 종료 코드와 출력으로 판정한다. exit 2가 차단이고, exit 0에
// 확인 요청(permissionDecision: ask)이 출력되면 확인, 아무 출력이 없으면 통과다.
// Node 내장 모듈만 쓰며 설치 배포 대상이 아니다.
//
//   node scripts/check-destructive-guard.mjs
//
// 케이스를 늘릴 때는 "왜 이 명령이 그 판정이어야 하는가"를 note에 남긴다.

import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const HOOK = path.join(ROOT, ".claude", "hooks", "block-destructive.sh");

/** blocked: true면 훅이 막아야 하고, false면 그대로 통과해야 한다. */
const CASES = [
  // 재귀 삭제. 표기가 무엇이든, 강제 플래그가 있든 없든 되돌릴 수 없다.
  { command: "rm -rf dir", blocked: true, note: "기본 형태" },
  { command: "rm -r -f dir", blocked: true, note: "플래그 분리" },
  { command: "rm -fr dir", blocked: true, note: "묶음 역순" },
  { command: "rm -Rf dir", blocked: true, note: "대문자 R" },
  { command: "rm --recursive --force dir", blocked: true, note: "장문 플래그" },
  { command: "rm -r dir", blocked: true, note: "강제 없는 재귀" },
  { command: "sudo rm -rf /var/log", blocked: true, note: "권한 상승" },
  { command: "cd /tmp && rm -rf data", blocked: true, note: "체인 뒤" },
  { command: "find . -name '*.tmp' -exec rm -rf {} \\;", blocked: true, note: "exec 안" },
  { command: 'sh -c "rm -rf /"', blocked: true, note: "인용부호가 곧 코드" },

  { command: "git rm -r dir", blocked: true, note: "작업 트리 파일을 실제로 지운다" },
  {
    command: "rm -rf dir --cached",
    blocked: true,
    note: "git 없는 rm에는 --cached 예외가 적용되지 않는다",
  },

  // 나머지 차단 규칙. 이 파일을 고칠 때 함께 깨지지 않도록 같이 고정한다.
  { command: "git push --force origin main", blocked: true, note: "원격 이력 덮어쓰기" },
  { command: "git clean -fd", blocked: true, note: "추적 밖 파일 삭제" },
  { command: "git checkout .", blocked: true, note: "로컬 수정 폐기" },

  // 통과해야 하는 것. 되돌릴 수 있거나, 애초에 rm이 아니다.
  { command: "rm note.txt", blocked: false, note: "단일 파일" },
  { command: "rm -f note.txt", blocked: false, note: "강제이나 재귀 아님" },
  { command: "docker rm mycontainer", blocked: false, note: "컨테이너는 다시 만든다" },
  { command: "docker run --rm -it img", blocked: false, note: "'-'가 앞에 붙은 플래그" },
  { command: "git rm --cached file", blocked: false, note: "추적 해제일 뿐" },
  {
    command: "git rm -r --cached dir",
    blocked: false,
    note: "재귀이나 색인에서만 뺀다. 작업 트리 파일은 남는다",
  },
  { command: "ls -la", blocked: false, note: "rm이 없다" },
  { command: "git reset --soft HEAD~1", blocked: false, note: "--hard가 아니면 작업 트리를 건드리지 않는다" },
  {
    command: 'grep -rn "x" . && docker compose -f a.yaml rm --force svc',
    blocked: false,
    note: "오탐: -r은 grep, -f는 compose의 것이다",
  },
  {
    command:
      "docker compose -f a.yaml -f b.yaml --profile secure rm --stop --force agent-ui-production",
    blocked: false,
    note: "오탐: compose의 -f를 rm의 것으로 보지 않는다",
  },
  { command: 'echo "rm -rf /" >> notes.txt', blocked: false, note: "인용부호 안은 데이터" },
  { command: 'git commit -m "drop the rm -rf branch"', blocked: false, note: "커밋 메시지는 데이터" },
];

// git reset --hard는 막지 않고 실행 직전에 확인받는다. 다만 커밋하지 않은 변경이나
// 원격 어디에도 없는 커밋이 있으면 보류한다. 판정이 저장소 상태에 달려 있으므로
// 임시 저장소를 만들어 상황별로 고정한다.
const TMP = fs.mkdtempSync(path.join(os.tmpdir(), "destructive-guard-"));
const SESSION = "guard-test";

const git = (cwd, ...args) => {
  const result = spawnSync(
    "git",
    ["-c", "user.name=guard", "-c", "user.email=guard@example.invalid", "-c", "commit.gpgsign=false", ...args],
    { cwd, encoding: "utf8" },
  );
  if (result.status !== 0) throw new Error(`git ${args.join(" ")} 실패: ${result.stderr}`);
  return result.stdout.trim();
};

let repoCount = 0;
/** 첫 커밋을 원격 main에 push까지 끝낸 깨끗한 클론을 만든다. */
const cleanRepo = () => {
  repoCount += 1;
  const remote = path.join(TMP, `remote-${repoCount}.git`);
  const work = path.join(TMP, `work-${repoCount}`);
  git(TMP, "init", "-q", "--bare", remote);
  git(TMP, "clone", "-q", remote, work);
  git(work, "symbolic-ref", "HEAD", "refs/heads/main");
  fs.writeFileSync(path.join(work, "a.txt"), "one\n");
  git(work, "add", "a.txt");
  git(work, "commit", "-q", "-m", "init");
  git(work, "push", "-q", "origin", "main");
  return work;
};

const commitLocally = (work) => {
  fs.writeFileSync(path.join(work, "b.txt"), "two\n");
  git(work, "add", "b.txt");
  git(work, "commit", "-q", "-m", "local");
};

/** relPath를 추가한 커밋을 원격 main에 올린 뒤, 로컬은 그 직전 커밋으로 되돌린 클론을 만든다. */
const behindRemoteWith = (relPath) => {
  const work = cleanRepo();
  const file = path.join(work, relPath);
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, "committed\n");
  git(work, "add", relPath);
  git(work, "commit", "-q", "-m", "add");
  git(work, "push", "-q", "origin", "main");
  git(work, "reset", "-q", "--hard", "HEAD~1");
  return work;
};

const discardMarker = (work) => path.join(work, ".claude", ".approval", `${SESSION}.reset-discard`);

/** setup은 { command, cwd, verify? }를 돌려준다. verify는 판정 뒤 부수 효과를 확인한다. */
const RESET_CASES = [
  {
    ask: true,
    note: "보존할 작업이 없으면 확인만 받는다",
    setup: () => ({ cwd: cleanRepo(), command: "git reset --hard origin/main" }),
  },
  {
    blocked: true,
    note: "커밋하지 않은 수정은 reset이 지운다",
    setup: () => {
      const cwd = cleanRepo();
      fs.writeFileSync(path.join(cwd, "a.txt"), "changed\n");
      return { cwd, command: "git reset --hard" };
    },
  },
  {
    ask: true,
    note: "대상과 겹치지 않는 추적 안 되는 파일은 reset이 지우지 않는다",
    setup: () => {
      const cwd = cleanRepo();
      fs.writeFileSync(path.join(cwd, "new.txt"), "untracked\n");
      return { cwd, command: "git reset --hard" };
    },
  },
  {
    blocked: true,
    note: "push하지 않은 커밋은 원격 어디에도 없다",
    setup: () => {
      const cwd = cleanRepo();
      commitLocally(cwd);
      return { cwd, command: "git reset --hard origin/main" };
    },
  },
  {
    ask: true,
    note: "원격의 다른 브랜치에 올라간 커밋은 보존돼 있다",
    setup: () => {
      const cwd = cleanRepo();
      commitLocally(cwd);
      git(cwd, "push", "-q", "origin", "HEAD:refs/heads/feature");
      return { cwd, command: "git reset --hard origin/main" };
    },
  },
  {
    ask: true,
    note: "사용자 폐기 확인이 있으면 경고와 함께 확인받고 표시를 지운다",
    setup: () => {
      const cwd = cleanRepo();
      fs.writeFileSync(path.join(cwd, "a.txt"), "changed\n");
      const marker = discardMarker(cwd);
      fs.mkdirSync(path.dirname(marker), { recursive: true });
      fs.writeFileSync(marker, "");
      return { cwd, command: "git reset --hard", verify: () => !fs.existsSync(marker) };
    },
  },
  {
    blocked: true,
    note: "reset 앞의 cd를 따라가 대상 저장소를 판정한다",
    setup: () => {
      const repo = cleanRepo();
      fs.writeFileSync(path.join(repo, "a.txt"), "changed\n");
      return { cwd: TMP, command: `cd '${repo}' && git reset --hard` };
    },
  },
  {
    blocked: true,
    note: "저장소 밖에서는 보존 여부를 알 수 없다",
    setup: () => ({ cwd: TMP, command: "git reset --hard" }),
  },
  {
    blocked: true,
    note: "대상 커밋에 같은 경로가 있으면 추적 안 되는 파일도 덮어써진다",
    setup: () => {
      const cwd = behindRemoteWith("b.txt");
      fs.writeFileSync(path.join(cwd, "b.txt"), "untracked work\n");
      return { cwd, command: "git reset --hard origin/main" };
    },
  },
  {
    blocked: true,
    note: "대상 커밋이 디렉터리로 쓰는 자리의 추적 안 되는 파일도 사라진다",
    setup: () => {
      const cwd = behindRemoteWith("sub/b.txt");
      fs.writeFileSync(path.join(cwd, "sub"), "untracked work\n");
      return { cwd, command: "git reset --hard origin/main" };
    },
  },
  {
    ask: true,
    note: "대상 커밋과 겹치지 않는 추적 안 되는 파일은 남는다",
    setup: () => {
      const cwd = behindRemoteWith("b.txt");
      fs.writeFileSync(path.join(cwd, "c.txt"), "untracked work\n");
      return { cwd, command: "git reset --hard origin/main" };
    },
  },
  {
    blocked: true,
    note: "git -C가 가리키는 저장소를 판정한다",
    setup: () => {
      const repo = cleanRepo();
      fs.writeFileSync(path.join(repo, "a.txt"), "changed\n");
      return { cwd: TMP, command: `git -C '${repo}' reset --hard` };
    },
  },
  {
    ask: true,
    note: "git -C로 가리킨 깨끗한 저장소는 확인만 받는다",
    setup: () => ({ cwd: TMP, command: `git -C '${cleanRepo()}' reset --hard origin/main` }),
  },
  {
    blocked: true,
    note: "reset 옵션이 --hard 앞에 끼어도 같은 명령이다",
    setup: () => {
      const cwd = cleanRepo();
      fs.writeFileSync(path.join(cwd, "a.txt"), "changed\n");
      return { cwd, command: "git reset -q --hard" };
    },
  },
  {
    ask: true,
    note: "--hard가 대상 커밋 뒤에 와도 대상을 읽는다",
    setup: () => ({ cwd: cleanRepo(), command: "git reset origin/main --hard" }),
  },
  {
    blocked: true,
    note: "--git-dir로 지정한 저장소는 보존 여부를 확인하지 못한다",
    setup: () => ({ cwd: cleanRepo(), command: "git --git-dir=.git reset --hard" }),
  },
  {
    blocked: true,
    note: "다른 차단 규칙이 함께 걸리면 차단이 우선한다",
    setup: () => ({ cwd: cleanRepo(), command: "git reset --hard && git clean -fd" }),
  },
];

const run = (command, cwd) => {
  const input = { hook_event_name: "PreToolUse", tool_name: "Bash", tool_input: { command } };
  if (cwd) Object.assign(input, { cwd, session_id: SESSION });
  const result = spawnSync("bash", [HOOK], { input: JSON.stringify(input), encoding: "utf8" });
  if (result.error) throw result.error;
  if (result.status === 2) return "차단";
  return /"permissionDecision":\s*"ask"/.test(result.stdout) ? "확인" : "통과";
};

const expectedOf = (testCase) => (testCase.blocked ? "차단" : testCase.ask ? "확인" : "통과");

let failed = 0;
let total = 0;
const report = (label, verdict, expected, note, sideEffectOk = true) => {
  total += 1;
  const ok = verdict === expected && sideEffectOk;
  if (!ok) failed += 1;
  const mark = ok ? "  ok" : "FAIL";
  const detail = ok
    ? note
    : verdict !== expected
      ? `${expected}이어야 하는데 ${verdict}`
      : "판정 뒤 부수 효과가 기대와 다르다";
  console.log(`${mark}  ${label.padEnd(64)} ${verdict}  ${detail}`);
};

try {
  for (const testCase of CASES) {
    report(testCase.command, run(testCase.command), expectedOf(testCase), testCase.note);
  }
  for (const testCase of RESET_CASES) {
    const { command, cwd, verify } = testCase.setup();
    const verdict = run(command, cwd);
    report(command.replace(TMP, "<tmp>"), verdict, expectedOf(testCase), testCase.note, verify ? verify() : true);
  }
} finally {
  fs.rmSync(TMP, { recursive: true, force: true });
}

console.log(`\n${total - failed}/${total} 통과`);
if (failed) {
  console.error(`${failed}건 실패. 차단 규칙이 의도와 어긋난다.`);
  process.exit(1);
}
