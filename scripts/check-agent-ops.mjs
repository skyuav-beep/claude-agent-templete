#!/usr/bin/env node
// 실행 보조 훅 판정 고정: memory-gate.sh(메모리 80% 대기)와 agent-events.sh(이벤트 기록·현황).
// 정본 규칙: docs/claude-codex-collaboration.md ## 동시 실행과 메모리 한도 / ## 이벤트 기록과 현황 보기
// 실행: node scripts/check-agent-ops.mjs  (Node 내장 모듈만 사용, jq 필요)
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";

const root = process.cwd();
const gate = path.join(root, ".claude/hooks/memory-gate.sh");
const events = path.join(root, ".claude/hooks/agent-events.sh");
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "agent-ops-"));
const failures = [];
let passed = 0;

const run = (script, args, { input = "", env = {} } = {}) => {
  const r = spawnSync("bash", [script, ...args], {
    input,
    encoding: "utf8",
    env: { ...process.env, AGENT_MEM_DISABLE: "0", AGENT_EVENTS_DISABLE: "0", ...env },
    timeout: 30000,
  });
  return { code: r.status, out: (r.stdout || "").trim(), err: (r.stderr || "").trim() };
};
const expect = (name, cond, detail = "") => {
  if (cond) passed++;
  else failures.push(`${name}${detail ? ` — ${detail}` : ""}`);
};
const seq = (values) => {
  const f = path.join(tmp, `seq-${Math.random().toString(36).slice(2)}`);
  fs.writeFileSync(f, values.join("\n") + "\n");
  return f;
};

if (spawnSync("bash", ["-c", "command -v jq"]).status !== 0) {
  console.log("jq가 없어 검사를 건너뜁니다.");
  process.exit(0);
}

// 1. 무거운 명령 판정
const heavy = [
  "codex", "codex exec 'fix'", "claude -p 'hi'", "npm run dev", "pnpm dev", "pnpm --filter web dev",
  "npm --prefix app run dev", "npx playwright test", "docker compose up -d", "docker build -t x .",
  "node /p/scripts/codex-companion.mjs review --wait", "git pull && npm run dev", "cd app && vite --port 3000",
  "python3 scripts/with_server.py --server 'npm run dev'",
];
const light = [
  "codex --version", "codex login", "claude --version", "claude mcp serve", "npm test", "npm install",
  "pnpm --filter web build", "docker compose ps", "node /p/scripts/codex-companion.mjs status", "echo codex",
  "grep codex README.md", "ls -la", "git status",
];
for (const c of heavy) expect(`heavy: ${c}`, run(gate, ["check", c]).out === "heavy");
for (const c of light) expect(`light: ${c}`, run(gate, ["check", c]).out === "light");

// 2. 훅: 가벼운 명령은 메모리가 높아도 바로 통과
const hookInput = (cmd) => JSON.stringify({ hook_event_name: "PreToolUse", tool_name: "Bash", tool_input: { command: cmd } });
let r = run(gate, [], { input: hookInput("git status"), env: { AGENT_MEM_TEST_SEQ: seq([95]), AGENT_MEM_INTERVAL: "1", AGENT_MEM_MAX_WAIT: "2" } });
expect("훅: 가벼운 명령 즉시 통과", r.code === 0 && r.out === "", JSON.stringify(r));

// 3. 훅: 무거운 명령은 한도 아래로 내려갈 때까지 기다렸다가 통과(출력 없음)
let t0 = Date.now();
r = run(gate, [], { input: hookInput("npm run dev"), env: { AGENT_MEM_TEST_SEQ: seq([85, 82, 70]), AGENT_MEM_INTERVAL: "1", AGENT_MEM_MAX_WAIT: "10" } });
expect("훅: 대기 후 통과", r.code === 0 && r.out === "" && Date.now() - t0 >= 1800, `${JSON.stringify(r)} ${Date.now() - t0}ms`);

// 4. 훅: 한도 미만이면 기다리지 않음
t0 = Date.now();
r = run(gate, [], { input: hookInput("npm run dev"), env: { AGENT_MEM_TEST_SEQ: seq([79]), AGENT_MEM_INTERVAL: "5" } });
expect("훅: 79%는 즉시 통과", r.code === 0 && r.out === "" && Date.now() - t0 < 3000);

// 5. 훅: 최대 대기를 넘기면 사용자 확인(ask)
r = run(gate, [], { input: hookInput("codex exec 'x'"), env: { AGENT_MEM_TEST_SEQ: seq([90]), AGENT_MEM_INTERVAL: "1", AGENT_MEM_MAX_WAIT: "2" } });
let decision = null;
try { decision = JSON.parse(r.out).hookSpecificOutput; } catch {}
expect("훅: 시간 초과 시 ask", r.code === 0 && decision?.permissionDecision === "ask" && /80%/.test(decision?.permissionDecisionReason ?? ""), r.out);

// 6. 한도 값 조정과 비활성화
r = run(gate, [], { input: hookInput("npm run dev"), env: { AGENT_MEM_TEST_SEQ: seq([85]), AGENT_MEM_LIMIT: "90" } });
expect("한도 90%면 85%는 통과", r.code === 0 && r.out === "");
r = run(gate, [], { input: hookInput("npm run dev"), env: { AGENT_MEM_TEST_SEQ: seq([99]), AGENT_MEM_DISABLE: "1" } });
expect("비활성화 시 통과", r.code === 0 && r.out === "");

// 7. wait / run 하위 명령
r = run(gate, ["wait"], { env: { AGENT_MEM_TEST_SEQ: seq([90]), AGENT_MEM_INTERVAL: "1", AGENT_MEM_MAX_WAIT: "1" } });
expect("wait: 시간 초과 종료 코드 1", r.code === 1);
r = run(gate, ["run", "--", "echo", "started"], { env: { AGENT_MEM_TEST_SEQ: seq([81, 60]), AGENT_MEM_INTERVAL: "1", AGENT_MEM_MAX_WAIT: "5" } });
expect("run: 대기 후 실행", r.code === 0 && r.out === "started", JSON.stringify(r));
r = run(gate, ["status", "--short"], { env: { AGENT_MEM_TEST_SEQ: seq([85]) } });
expect("status --short: 대기 표시", /85%>=80 대기/.test(r.out), r.out);

// 8. 이벤트 기록: 정규화, 비밀값 가림, 본문 미기록
const evFile = path.join(tmp, "events.jsonl");
const evEnv = { AGENT_EVENTS_FILE: evFile, CODEX_HOME: path.join(tmp, "codex-home") };
const send = (obj) => run(events, [], { input: JSON.stringify({ cwd: root, ...obj }), env: evEnv });
send({ session_id: "s-run", hook_event_name: "UserPromptSubmit", prompt: "PROMPT-BODY-SHOULD-NOT-APPEAR" });
send({ session_id: "s-run", hook_event_name: "PreToolUse", tool_name: "Bash", tool_input: { command: "TOKEN=abc123 curl -H 'Authorization: Bearer xyz.abc' https://u:p@h && echo sk-proj-abcdefghij12 ghp_abcdefghijklmnopqrstuv" } });
send({ session_id: "s-run", hook_event_name: "SubagentStart", agent_id: "a", agent_type: "Explore" });
send({ session_id: "s-wait", hook_event_name: "Notification", notification_type: "permission_prompt", message: "Claude needs your permission" });
send({ session_id: "s-done", hook_event_name: "TaskCreated", task_id: "1", task_subject: "login" });
send({ session_id: "s-done", hook_event_name: "TaskCompleted", task_id: "1", task_subject: "login" });
send({ session_id: "s-done", hook_event_name: "Stop", last_assistant_message: "ANSWER-BODY-SHOULD-NOT-APPEAR" });
send({ session_id: "s-end", hook_event_name: "SessionEnd" });
send({ session_id: "s-bg", hook_event_name: "Stop" });
send({ session_id: "s-idle", hook_event_name: "SessionStart" });
// tmux 창 위치: 가짜 tmux가 "work:3"을 돌려준다
{
  const bin = path.join(tmp, "bin");
  fs.mkdirSync(bin, { recursive: true });
  fs.writeFileSync(path.join(bin, "tmux"), "#!/bin/sh\necho work:3\n", { mode: 0o755 });
  const tmuxEnv = { ...evEnv, TMUX_PANE: "%7", PATH: `${bin}:${process.env.PATH}` };
  run(events, [], { input: JSON.stringify({ cwd: root, session_id: "s-tmux", hook_event_name: "PreToolUse", tool_name: "Read", tool_input: { file_path: "/x" } }), env: tmuxEnv });
  run(events, ["codex-hook"], { input: JSON.stringify({ cwd: root, session_id: "cx-hook", hook_event_name: "PermissionRequest", tool_name: "Bash", tool_input: { command: "TOKEN=abc123 ls" } }), env: tmuxEnv });
}
send({ session_id: "s-bg", hook_event_name: "SubagentStop", agent_id: "b", agent_type: "Explore" });
run(events, [], { input: "not json", env: evEnv });
run(events, ["codex", JSON.stringify({ type: "agent-turn-complete", "thread-id": "c-1", cwd: root, "last-assistant-message": "ANSWER-BODY-SHOULD-NOT-APPEAR" })], { env: evEnv });
run(events, ["codex", JSON.stringify({ type: "agent-turn-complete", "thread-id": "c-nogit", cwd: tmp })], { env: evEnv });
const text = fs.existsSync(evFile) ? fs.readFileSync(evFile, "utf8") : "";
const lines = text.trim().split("\n").filter(Boolean).map((l) => JSON.parse(l));
expect("기록 줄 수(잘못된 입력 제외)", lines.length === 15, String(lines.length));
expect("본문 미기록", !/SHOULD-NOT-APPEAR/.test(text));
expect("비밀값 가림", !/abc123|xyz\.abc|u:p@|sk-proj-abcdefghij12|ghp_abcdefghijklmnopqrstuv/.test(text), lines[1]?.target);
expect("공통 필드", lines.every((l) => l.ts && l.provider && l.event && l.session && l.project));
expect("tmux 창 위치 기록", lines.some((l) => l.session === "s-tmux" && l.tmux === "work:3" && l.pane === "%7"), JSON.stringify(lines.find((l) => l.session === "s-tmux")));
expect("tmux 밖이면 창 위치 없음", lines.filter((l) => l.session === "s-run").every((l) => !("tmux" in l) && !("pane" in l)));
expect("Codex 훅 기록(provider=codex, 가림)", lines.some((l) => l.session === "cx-hook" && l.provider === "codex" && l.event === "PermissionRequest" && l.tmux === "work:3" && !/abc123/.test(l.target)));
expect("Codex 턴 완료 기록", lines.some((l) => l.provider === "codex" && l.event === "Stop" && l.session === "c-1"));

// 9. 현황: 응답 필요가 맨 위, 종료 세션 숨김, 서브·작업 집계
r = run(events, ["status"], { env: evEnv });
const rows = r.out.split("\n").filter((l) => /^(응답 필요|실행 중|완료|오류|멈춤\?|대기)/.test(l));
expect("현황: 응답 필요 우선", /^응답 필요/.test(rows[0] ?? ""), r.out);
expect("현황: 종료 세션 숨김", !/s-end/.test(r.out));
expect("현황: 실행 중 + 서브 1", rows.some((l) => /^실행 중/.test(l) && /\s1\s/.test(l)), r.out);
expect("현황: 작업 1/1", rows.some((l) => /1\/1/.test(l)), r.out);
expect("현황: 창 열 표시", rows.some((l) => /s-tmux/.test(l) && /work:3/.test(l)), r.out);
expect("현황: Codex 훅 응답 필요", rows.some((l) => /^응답 필요/.test(l) && /codex/.test(l) && /cx-hook/.test(l)), r.out);
expect("현황: 시작만 한 세션은 대기", rows.some((l) => /^대기/.test(l) && /s-idle/.test(l)) && !rows.some((l) => /^멈춤/.test(l)), r.out);
expect("현황: Stop 뒤 늦게 온 SubagentStop은 완료 유지", rows.some((l) => /^완료/.test(l) && /s-bg/.test(l)), r.out);
expect("현황: 빈 최근 동작이 열을 밀지 않음(Codex 완료 행)", rows.some((l) => /c-nogit/.test(l) && /\s-\s+-\s+-\s*$/.test(l)), r.out);
r = run(events, ["status", "--short"], { env: evEnv });
expect("현황 한 줄", /실행 2 · 응답 2/.test(r.out), r.out);

// 9-1. watch: 터미널 없이 돌 때 바쁜 루프를 돌지 않음(간격을 지킴)
{
  const t = spawnSync("bash", ["-c", `TIMEFORMAT='%U %S'; time (timeout 4 bash "${events}" watch --interval 1 >/dev/null 2>&1 </dev/null)`], {
    encoding: "utf8", env: { ...process.env, ...evEnv }, timeout: 20000,
  });
  const [u, s] = (t.stderr || "").trim().split(/\s+/).slice(-2).map(Number);
  expect("watch: 비터미널에서 CPU 1초 미만 사용(4초 실행)", u + s < 1, t.stderr);
}

// 10. 비활성화와 파일 넘김
const before = fs.readFileSync(evFile, "utf8").length;
run(events, [], { input: JSON.stringify({ session_id: "x", cwd: root, hook_event_name: "Stop" }), env: { ...evEnv, AGENT_EVENTS_DISABLE: "1" } });
expect("기록 비활성화", fs.readFileSync(evFile, "utf8").length === before);
run(events, [], { input: JSON.stringify({ session_id: "x", cwd: root, hook_event_name: "Stop" }), env: { ...evEnv, AGENT_EVENTS_MAX_MB: "0" } });
expect("크기 초과 시 .1로 넘김", fs.existsSync(`${evFile}.1`) && fs.readFileSync(evFile, "utf8").trim().split("\n").length === 1);

// 11. 설정 템플릿 등록
const settings = JSON.parse(fs.readFileSync(path.join(root, ".claude/settings.template.json"), "utf8"));
const all = Object.entries(settings.hooks).flatMap(([ev, ms]) => ms.flatMap((m) => m.hooks.map((h) => ({ ev, matcher: m.matcher, ...h }))));
const gateHook = all.find((h) => /memory-gate\.sh/.test(h.command));
expect("memory-gate: PreToolUse Bash 등록", gateHook?.ev === "PreToolUse" && gateHook?.matcher === "Bash");
expect("memory-gate: timeout이 최대 대기(600초)보다 김", (gateHook?.timeout ?? 0) > 600);
expect("memory-gate: 동기 실행", !gateHook?.async);
const evHooks = all.filter((h) => /agent-events\.sh/.test(h.command));
for (const e of ["SessionStart", "SessionEnd", "UserPromptSubmit", "PreToolUse", "Notification", "PermissionRequest", "Stop", "StopFailure", "SubagentStart", "SubagentStop", "TaskCreated", "TaskCompleted"]) {
  expect(`agent-events: ${e} 등록`, evHooks.some((h) => h.ev === e));
}
expect("agent-events: 모두 async", evHooks.length > 0 && evHooks.every((h) => h.async === true));

fs.rmSync(tmp, { recursive: true, force: true });
if (failures.length) {
  console.error(`실행 보조 훅 검사 실패 ${failures.length}건 (통과 ${passed}):`);
  for (const f of failures) console.error(`  - ${f}`);
  process.exit(1);
}
console.log(`실행 보조 훅 검사 통과 — ${passed}건 (memory-gate 판정·대기·ask, agent-events 기록·가림·현황, 설정 등록)`);
