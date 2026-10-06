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

# Git Bash's plain `ln -s` silently copies, and a native symlink needs Developer
# Mode or an admin shell. Without either, copy loudly: the copy goes stale on
# every pull until this script runs again.
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

mkdir -p "$DEST/hooks"

link "$DOTFILES/claude/settings.json"        "$DEST/settings.json"
link "$DOTFILES/claude/CLAUDE.md"            "$DEST/CLAUDE.md"
link "$DOTFILES/claude/RTK.md"               "$DEST/RTK.md"
link "$DOTFILES/claude/hooks/rtk.sh"         "$DEST/hooks/rtk.sh"
link "$DOTFILES/claude/hooks/notify.sh"      "$DEST/hooks/notify.sh"
link "$DOTFILES/claude/hooks/statusline.sh"  "$DEST/hooks/statusline.sh"

# CLAUDE.md imports ~/.claude/STYLE.md from the skills repo, which lives at a
# different path on each machine. SKILLS overrides the search.
for skills in "${SKILLS:-}" "$DOTFILES/../skills" "$HOME/Projects/personal/skills"; do
  if [ -n "$skills" ] && [ -f "$skills/STYLE.md" ]; then
    link "$(cd "$skills" && pwd)/STYLE.md" "$DEST/STYLE.md"
    exit 0
  fi
done
echo "warn: skills repo not found; clone Esequiel378/skills next to dotfiles or set SKILLS=<path>" >&2
