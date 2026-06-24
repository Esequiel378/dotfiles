#!/usr/bin/env bash
# Claude Code status line: dir  git-branch  model  [PONYTAIL]
# Reads session JSON on stdin; first line of output is the status line.

input=$(cat)
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
cost=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // empty')
sid=$(printf '%s' "$input" | jq -r '.session_id // "default"')
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
mid=$(printf '%s' "$input" | jq -r '.model.id // empty')
[ -z "$dir" ] && dir="$PWD"

# Context: latest usage from the transcript (input + cache reads/writes) vs window.
case "$mid" in *1m*) climit=1000000; limlabel="1M";; *) climit=200000; limlabel="200k";; esac
ctx=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    used=$(tail -r "$transcript" 2>/dev/null | jq -r 'select(.message.usage.input_tokens != null) | .message.usage | (.input_tokens + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0))' 2>/dev/null | head -1)
    if [ -n "$used" ]; then
        ctx=$(printf '%dk/%s %d%%' $((used/1000)) "$limlabel" $((used*100/climit)))
    fi
fi

branch=$(git -C "$dir" branch --show-current 2>/dev/null)

# Prompt elapsed: (end || now) - start, from the per-session timer notify.sh writes.
elapsed=""
timer="${TMPDIR:-/tmp}/claude-prompt-${sid}"
if [ -f "$timer" ]; then
    start=$(sed -n 1p "$timer"); end=$(sed -n 2p "$timer")
    [ -z "$end" ] && end=$(date +%s)
    if [ -n "$start" ]; then
        s=$((end - start))
        [ "$s" -ge 60 ] && elapsed=$(printf '%dm%02ds' $((s/60)) $((s%60))) || elapsed="${s}s"
    fi
fi

# ponytail: inline the flag read instead of calling the version-pinned plugin script
pony=""
flag="$HOME/.claude/.ponytail-active"
if [ -f "$flag" ]; then
    mode=$(head -n1 "$flag" | tr -d '[:space:]')
    if [ -z "$mode" ] || [ "$mode" = "full" ]; then
        pony=$(printf '  \033[38;5;108m[PONYTAIL]\033[0m')
    else
        pony=$(printf '  \033[38;5;108m[PONYTAIL:%s]\033[0m' "$(printf '%s' "$mode" | tr '[:lower:]' '[:upper:]')")
    fi
fi

printf '\033[38;5;75m%s\033[0m' "$(basename "$dir")"
[ -n "$branch" ]  && printf '  \033[38;5;108m \033[0m\033[38;5;108m%s\033[0m' "$branch"
[ -n "$model" ]   && printf '  \033[38;5;244m%s\033[0m' "$model"
[ -n "$cost" ]    && printf '  \033[38;5;179m$%.2f\033[0m' "$cost"
[ -n "$ctx" ]     && printf '  \033[38;5;110m%s\033[0m' "$ctx"
[ -n "$elapsed" ] && printf '  \033[38;5;245m%s\033[0m' "$elapsed"
printf '%s' "$pony"
