# Past sessions

Every Claude Code and Codex transcript from the Mac (source `mac`) and Windows (source `win`) is indexed on `zx`. Call `cass` over ssh.

## When to search

- If the task needs a non-trivial investigation, search first.
- If you are about to re-decide something, search first.
- If the user asks "did we already…" or "what did we decide about…", search first.

## Commands

Search for a distinctive term.

```bash
ssh zx cass search "<term>" --robot --limit 10 --fields summary
```

Expand a hit with its `source_path`, `source_id` and `line_number`.

```bash
ssh zx cass expand "<source_path>" --source "<source_id>" --message-index <line_number> -C 5 --json
```

Pass `line_number` to `--message-index` unchanged. Never pass it to `--line`.

List sessions in a date window.

```bash
ssh zx cass timeline --since 2026-11-01 --until 2026-11-03 --group-by day --json
```

## Limits

- The index refreshes nightly at 02:30. Sessions from the last day may be missing.
- Results contain raw transcripts. They may contain secrets.
- Never paste a secret value into a reply, ticket, commit, or file.
