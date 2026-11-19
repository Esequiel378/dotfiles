#!/usr/bin/env bash
set -euo pipefail

# Links the global Codex instructions into ~/.codex and registers the vault MCP.
# Runs on macOS, Linux and Windows (Git Bash). Safe to re-run.
# ~/.codex/config.toml is runtime state and stays unmanaged: `codex mcp add` edits it.

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.codex"

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*) windows=1 ;;
  *) windows=0 ;;
esac

# Same as claude/install.sh: Git Bash's plain `ln -s` silently copies, so try a
# native symlink and copy loudly when that is not allowed.
link() {
  src="$1"
  target="$2"
  if [ "$windows" = 0 ]; then
    ln -sf "$src" "$target"
    echo "linked $target"
    return
  fi
  rm -f "$target"
  if MSYS=winsymlinks:nativestrict ln -s "$src" "$target" 2>/dev/null; then
    echo "linked $target"
  else
    cp "$src" "$target"
    echo "copied $target (no symlink privilege: enable Developer Mode, or re-run after every pull)"
  fi
}

mkdir -p "$DEST"

link "$DOTFILES/codex/AGENTS.md" "$DEST/AGENTS.md"

# The vault MCP on zx (tailnet only). Re-runnable: remove first, then add.
if command -v codex >/dev/null 2>&1; then
  codex mcp remove vault >/dev/null 2>&1 || true
  codex mcp add vault --url http://zx:8765/mcp
else
  echo "codex not on PATH: skipped the vault MCP entry"
fi
