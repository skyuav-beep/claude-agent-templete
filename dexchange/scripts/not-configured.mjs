const command = process.argv[2] ?? "command";

console.log(
  [
    `pnpm ${command} is reserved for the runtime app.`,
    "The dexchange skeleton is ready, but frontend/indexer/contract tooling is not selected yet.",
    "Run pnpm check for the current validation."
  ].join("\n")
);
