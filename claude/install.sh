#!/usr/bin/env bash
set -euo pipefail

# Links the global Claude Code config into ~/.claude. Runs on macOS, Linux and
# Windows (Git Bash). Safe to re-run.

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.claude"

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*) windows=1 ;;
  *) windows=0 ;;
esac

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  green=$'\033[32m' yellow=$'\033[33m' reset=$'\033[0m'
else
  green='' yellow='' reset=''
fi
ok() { echo "  ${green}✓${reset} ~${1#"$HOME"}"; }

# Git Bash's plain `ln -s` silently copies, and a native symlink needs Developer
# Mode or an admin shell. Without either, copy loudly: the copy goes stale on
# every pull until this script runs again.
link() {
  src="$1"
  target="$2"
  if [ "$windows" = 0 ]; then
    ln -sf "$src" "$target"
    ok "$target"
    return
  fi
  rm -f "$target"
  if MSYS=winsymlinks:nativestrict ln -s "$src" "$target" 2>/dev/null; then
    ok "$target"
  else
    cp "$src" "$target"
    echo "  ${yellow}! copied ~${target#"$HOME"}: no symlink privilege. Enable Developer Mode, or re-run after every pull${reset}"
  fi
}

mkdir -p "$DEST/hooks"

link "$DOTFILES/claude/settings.json"        "$DEST/settings.json"
link "$DOTFILES/claude/CLAUDE.md"            "$DEST/CLAUDE.md"
link "$DOTFILES/claude/RTK.md"               "$DEST/RTK.md"
link "$DOTFILES/claude/hooks/rtk.sh"         "$DEST/hooks/rtk.sh"
link "$DOTFILES/claude/hooks/notify.sh"      "$DEST/hooks/notify.sh"
link "$DOTFILES/claude/hooks/statusline.sh"  "$DEST/hooks/statusline.sh"
