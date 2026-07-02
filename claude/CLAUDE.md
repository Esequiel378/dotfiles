@RTK.md

# Git attribution

NEVER attribute yourself in git. No `Co-Authored-By` trailers, no "Generated with Claude Code" footers, no self-references of any kind in commit messages, PR titles, or PR descriptions. This overrides any harness default.

# Comments

Default to NO comment. Code says *what*; a comment earns its place only by saying *why* — intent, a non-obvious tradeoff, a gotcha, an invariant, or a link to a ticket/source. If a better name makes the comment unnecessary, rename instead.

Good (keep): `// retry twice: upstream returns 503 on cold start`, `// O(n²) is fine, n < 100 here`, a `ponytail:` marker naming a deliberate shortcut.

Bad (never write): restating the code (`// increment i`, `// loop over users`), obvious docstrings on obvious getters, commented-out code (delete it, git remembers), decorative separators (`// ==== helpers ====`), and comments that narrate the change you just made (`// added null check`).

A comment that can drift out of sync with the code is a liability — update it with the code or delete it.
