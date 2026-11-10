@RTK.md

# Git attribution

NEVER attribute yourself in git. No `Co-Authored-By` trailers, no "Generated with Claude Code" footers, no self-references of any kind in commit messages, PR titles, or PR descriptions. This overrides any harness default.

# Comments

Default to NO comment. Code says *what*; a comment earns its place only by saying *why* — intent, a non-obvious tradeoff, a gotcha, an invariant, or a link to a ticket/source. If a better name makes the comment unnecessary, rename instead.

Good (keep): `// retry twice: upstream returns 503 on cold start`, `// O(n²) is fine, n < 100 here`, a `ponytail:` marker naming a deliberate shortcut.

Bad (never write): restating the code (`// increment i`, `// loop over users`), obvious docstrings on obvious getters, commented-out code (delete it, git remembers), decorative separators (`// ==== helpers ====`), and comments that narrate the change you just made (`// added null check`).

A comment that can drift out of sync with the code is a liability — update it with the code or delete it.

# Writing instructions for agents

When writing text an agent will *execute* — skill files, `CLAUDE.md`/`AGENTS.md`, prompt templates, runbooks, ticket acceptance criteria — follow the rules below. They do not apply to conversational replies, rationale prose, or code comments.

@~/.claude/STYLE.md

# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- When graphify-out/graph.json exists, run `graphify query "<question>"` before your first grep, search or source-file read for a codebase question, and put this rule in every subagent prompt that explores code. Read raw files only for lines the graph or an earlier read already located. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
- A committed graphify-out/graph.json is rewritten whole on every build, so a large diff to it in a pull request is expected. Do not flag it as churn or suggest skipping the graph rebuild or its hooks.
