#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const skillsRoot = path.join(root, ".agents", "skills");
const manifestPath = path.join(root, ".claude", "plugins", "manifest.json");
const errors = [];

function readFrontmatter(file) {
  const text = fs.readFileSync(file, "utf8");
  if (!text.startsWith("---\n")) return null;
  const end = text.indexOf("\n---", 4);
  if (end < 0) return null;
  const values = {};
  for (const line of text.slice(4, end).split("\n")) {
    const match = line.match(/^([a-z]+):\s*(.+)$/);
    if (match) values[match[1]] = match[2].trim();
  }
  return values;
}

if (!fs.existsSync(skillsRoot)) {
  errors.push(".agents/skills 디렉터리가 없습니다.");
} else {
  const names = new Set();
  for (const entry of fs.readdirSync(skillsRoot, { withFileTypes: true })) {
    if (!entry.isDirectory()) continue;
    const skillFile = path.join(skillsRoot, entry.name, "SKILL.md");
    if (!fs.existsSync(skillFile)) {
      errors.push(`${entry.name}: SKILL.md가 없습니다.`);
      continue;
    }
    const frontmatter = readFrontmatter(skillFile);
    if (!frontmatter?.name || !frontmatter?.description) {
      errors.push(`${entry.name}: name/description frontmatter가 없습니다.`);
      continue;
    }
    if (names.has(frontmatter.name)) errors.push(`중복 Skill name: ${frontmatter.name}`);
    names.add(frontmatter.name);
    if (frontmatter.name !== entry.name) {
      errors.push(`${entry.name}: directory와 name이 다릅니다 (${frontmatter.name}).`);
    }
  }

  const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
  const manifestPaths = new Set(
    (manifest.codex?.files ?? []).map((entry) => entry.path),
  );
  for (const name of names) {
    const relative = `.agents/skills/${name}/SKILL.md`;
    if (!manifestPaths.has(relative)) errors.push(`manifest 누락: ${relative}`);
  }
}

if (errors.length) {
  console.error(errors.map((error) => `- ${error}`).join("\n"));
  process.exitCode = 1;
} else {
  console.log("Codex native skills: frontmatter, name uniqueness, manifest paths OK");
}
