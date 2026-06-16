#!/usr/bin/env bash
# Claude Code desktop notification hook (macOS).
# Usage: notify.sh start|stop|notification   — hook JSON arrives on stdin.

input=$(cat)
event="$1"

# --- diagnostic log: confirms the hook fired. Safe to delete this line later. ---
echo "$(date '+%F %T')  event=$event" >> /Users/arlequin/.claude/hooks/notify.log

# Per-session prompt timer read by statusline.sh: line1=start, line2=end.
sid=$(printf '%s' "$input" | jq -r '.session_id // "default"' 2>/dev/null)
timer="${TMPDIR:-/tmp}/claude-prompt-${sid}"
case "$event" in
  start) date +%s  > "$timer"; exit 0 ;;   # UserPromptSubmit: reset start
  stop)  date +%s >> "$timer" ;;           # Stop: append end (freezes elapsed)
esac

cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
project=$(basename "${cwd:-$PWD}")

case "$event" in
  notification)
    message=$(printf '%s' "$input" | jq -r '.message // "Claude Code needs your input"' 2>/dev/null)
    title="Claude Code — input needed"
    sound="/System/Library/Sounds/Funk.aiff"
    ;;
  stop | *)
    message="Chat complete — ready for you"
    title="Claude Code — done"
    sound="/System/Library/Sounds/Glass.aiff"
    ;;
esac

# Guaranteed signal: afplay needs no notification permission, so the sound
# plays even when the banner is suppressed by macOS.
[ -f "$sound" ] && afplay "$sound" >/dev/null 2>&1

# Best-effort banner via Apple's supported AppleScript path. Strings are passed
# as argv so quotes/specials in the message can't break the script.
osascript \
  -e 'on run argv' \
  -e 'display notification (item 1 of argv) with title (item 2 of argv) subtitle (item 3 of argv)' \
  -e 'end run' \
  -- "$message" "$title" "$project" >/dev/null 2>&1 || true
