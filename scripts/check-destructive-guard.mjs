#!/usr/bin/env node
// block-destructive.sh 회귀 검사.
//
// 훅을 실제로 실행해 종료 코드로 판정한다. exit 2가 차단, exit 0이 통과다.
// Node 내장 모듈만 쓰며 설치 배포 대상이 아니다.
//
//   node scripts/check-destructive-guard.mjs
//
// 케이스를 늘릴 때는 "왜 이 명령이 그 판정이어야 하는가"를 note에 남긴다.

import { spawnSync } from "node:child_process";
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
  { command: "git reset --hard HEAD~1", blocked: true, note: "미커밋 작업 소실" },
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

const run = (command) => {
  const result = spawnSync("bash", [HOOK], {
    input: JSON.stringify({ hook_event_name: "PreToolUse", tool_name: "Bash", tool_input: { command } }),
    encoding: "utf8",
  });
  if (result.error) throw result.error;
  return result.status === 2;
};

let failed = 0;
for (const testCase of CASES) {
  const blocked = run(testCase.command);
  const ok = blocked === testCase.blocked;
  if (!ok) failed += 1;
  const verdict = blocked ? "차단" : "통과";
  const expected = testCase.blocked ? "차단" : "통과";
  const mark = ok ? "  ok" : "FAIL";
  const detail = ok ? testCase.note : `${expected}이어야 하는데 ${verdict}`;
  console.log(`${mark}  ${testCase.command.padEnd(64)} ${verdict}  ${detail}`);
}

console.log(`\n${CASES.length - failed}/${CASES.length} 통과`);
if (failed) {
  console.error(`${failed}건 실패. 차단 규칙이 의도와 어긋난다.`);
  process.exit(1);
}
