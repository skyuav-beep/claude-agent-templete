import { existsSync, readFileSync } from "node:fs";

const requiredPaths = [
  "AGENTS.md",
  "CLAUDE.md",
  "STATE.md",
  "README.md",
  "docs/project-guide.md",
  "docs/architecture.md",
  "docs/security-model.md",
  "apps/web/README.md",
  "apps/indexer/README.md",
  "packages/contracts/README.md",
  "packages/sdk/README.md",
  "packages/shared/README.md",
  "infra/README.md"
];

const requiredTerms = [
  ["AGENTS.md", "DEX 보안 규칙"],
  ["docs/project-guide.md", "Open Questions"],
  ["docs/security-model.md", "private key"],
  ["STATE.md", "다음 작업"]
];

const missing = requiredPaths.filter((path) => !existsSync(path));

const termFailures = requiredTerms.filter(([path, term]) => {
  if (!existsSync(path)) return true;
  return !readFileSync(path, "utf8").includes(term);
});

if (missing.length > 0 || termFailures.length > 0) {
  if (missing.length > 0) {
    console.error("Missing required paths:");
    for (const path of missing) console.error(`- ${path}`);
  }
  if (termFailures.length > 0) {
    console.error("Missing required terms:");
    for (const [path, term] of termFailures) console.error(`- ${path}: ${term}`);
  }
  process.exit(1);
}

console.log("dexchange project skeleton check passed.");
