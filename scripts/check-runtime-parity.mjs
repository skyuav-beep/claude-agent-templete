#!/usr/bin/env node
// Claude Code와 Codex 두 런타임의 작업 유형·가드레일 대응을 검사한다.
// 한쪽 런타임에만 스킬을 추가하거나, 매트릭스 갱신을 빠뜨리는 실수를 잡는다.
// 정본 규칙: docs/agent-runtime-matrix.md ## 변경 규칙

import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const errors = [];
const notes = [];

const dirNames = (rel) => {
  const dir = path.join(root, rel);
  if (!fs.existsSync(dir)) {
    errors.push(`${rel} 디렉터리가 없습니다.`);
    return new Set();
  }
  return new Set(
    fs
      .readdirSync(dir, { withFileTypes: true })
      .filter((entry) => entry.isDirectory())
      .map((entry) => entry.name),
  );
};

const fileNames = (rel, ext) => {
  const dir = path.join(root, rel);
  if (!fs.existsSync(dir)) {
    errors.push(`${rel} 디렉터리가 없습니다.`);
    return new Set();
  }
  return new Set(
    fs
      .readdirSync(dir)
      .filter((name) => name.endsWith(ext))
      .map((name) => name.slice(0, -ext.length)),
  );
};

const read = (rel) => {
  const file = path.join(root, rel);
  if (!fs.existsSync(file)) {
    errors.push(`${rel} 파일이 없습니다.`);
    return "";
  }
  return fs.readFileSync(file, "utf8");
};

const missing = (label, from, to, hint) => {
  for (const name of [...from].sort()) {
    if (!to.has(name)) errors.push(`${label}: ${name} — ${hint}`);
  }
};

// 1. 작업 유형 스킬 양방향 대조
const claudeSkills = dirNames(".claude/skills");
const codexSkills = dirNames(".agents/skills");
missing("Codex 스킬 누락", claudeSkills, codexSkills, ".agents/skills/<name>/SKILL.md를 추가하세요.");
missing("Claude 스킬 누락", codexSkills, claudeSkills, ".claude/skills/<name>/SKILL.md를 추가하세요.");

// 2. Claude 스킬과 slash command 1:1
const commands = fileNames(".claude/commands", ".md");
missing("slash command 누락", claudeSkills, commands, ".claude/commands/<name>.md를 추가하세요.");
missing("대응 스킬 없는 command", commands, claudeSkills, ".claude/skills/<name>/SKILL.md를 추가하세요.");

// 3. Codex 스킬이 참조하는 workflow 존재
const workflows = fileNames(".codex/workflows", ".md");
for (const name of [...codexSkills].sort()) {
  const body = read(`.agents/skills/${name}/SKILL.md`);
  const ref = body.match(/\.codex\/workflows\/([a-z0-9-]+)\.md/);
  if (!ref) {
    notes.push(`${name}: workflow 참조 없음 (스킬 본문만으로 실행 가능해야 합니다).`);
    continue;
  }
  if (!workflows.has(ref[1])) errors.push(`workflow 누락: .codex/workflows/${ref[1]}.md (${name}이 참조)`);
}

// 4. 서브에이전트 양방향 대조
const claudeAgents = fileNames(".claude/agents", ".md");
const codexAgents = fileNames(".codex/agents", ".md");
missing("Codex agent guide 누락", claudeAgents, codexAgents, ".codex/agents/<name>.md를 추가하세요.");
missing("Claude agent 정의 누락", codexAgents, claudeAgents, ".claude/agents/<name>.md를 추가하세요.");

// 5. 매트릭스가 모든 작업 유형을 다루는지
const matrix = read("docs/agent-runtime-matrix.md");
for (const name of [...claudeSkills].sort()) {
  if (!matrix.includes(name)) {
    errors.push(`매트릭스 누락: ${name} — docs/agent-runtime-matrix.md ## 지원 수준에 행을 추가하세요.`);
  }
}

// 6. 가드레일 훅이 Codex 체크리스트에 대응되는지
const checklist = read(".codex/checks/safety-checklist.md");
const hookDir = path.join(root, ".claude/hooks");
if (fs.existsSync(hookDir)) {
  for (const hook of fs.readdirSync(hookDir).filter((n) => n.startsWith("block-")).sort()) {
    if (!checklist.includes(hook)) {
      errors.push(`Codex 대응 누락: ${hook} — .codex/checks/safety-checklist.md에 판정 절차를 추가하세요.`);
    }
  }
}

// 7. 신규 스킬·command가 설치 manifest에 등록됐는지
const manifestPath = path.join(root, ".claude/plugins/manifest.json");
if (fs.existsSync(manifestPath)) {
  const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
  const registered = new Set();
  const walk = (node) => {
    if (Array.isArray(node)) return node.forEach(walk);
    if (node && typeof node === "object") {
      if (typeof node.path === "string") registered.add(node.path);
      return Object.values(node).forEach(walk);
    }
  };
  walk(manifest);
  for (const paths of Object.values(manifest.supporting ?? {})) {
    if (Array.isArray(paths)) {
      for (const rel of paths) {
        if (typeof rel === "string") registered.add(rel);
      }
    }
  }
  // 설치 후에도 운영 가이드와 문서 브라우저가 남아 있어야 한다.
  // supporting.docs에서 빠지면 원본 저장소에서는 보이지만 소비 프로젝트에는 배포되지 않는다.
  const requiredInstallPaths = [
    "docs/guide-browser.html",
    "docs/notification-guide.md",
  ];
  for (const rel of requiredInstallPaths) {
    if (!registered.has(rel)) {
      errors.push(`필수 설치 파일 manifest 누락: ${rel} — 소비 프로젝트에 배포되지 않습니다.`);
    }
  }
  for (const name of [...claudeSkills].sort()) {
    const rel = `.claude/skills/${name}/SKILL.md`;
    if (!registered.has(rel)) errors.push(`manifest 누락: ${rel} — 설치 시 배포되지 않습니다.`);
  }
  for (const name of [...commands].sort()) {
    const rel = `.claude/commands/${name}.md`;
    if (!registered.has(rel)) errors.push(`manifest 누락: ${rel} — 설치 시 배포되지 않습니다.`);
  }
  for (const rel of [...registered].sort()) {
    if (!fs.existsSync(path.join(root, rel))) errors.push(`manifest가 없는 파일을 가리킵니다: ${rel}`);
  }
}

// 8. 작업 유형 선택 규칙이 공통 정본에 있는지
if (!read("AGENTS.md").includes("## 작업 유형 선택 규칙")) {
  errors.push("AGENTS.md에 '## 작업 유형 선택 규칙'이 없습니다. Codex는 CLAUDE.md의 해당 절을 읽지 않습니다.");
}

if (notes.length) console.log(notes.map((note) => `- 참고: ${note}`).join("\n"));
if (errors.length) {
  console.error(errors.map((error) => `- ${error}`).join("\n"));
  process.exitCode = 1;
} else {
  console.log(
    `런타임 parity OK — 스킬 ${claudeSkills.size}종(양방향), command ${commands.size}종, ` +
      `서브에이전트 ${claudeAgents.size}종, 매트릭스·가드레일 대응 확인`,
  );
}
