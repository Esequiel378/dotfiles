#!/usr/bin/env bash
# PreToolUse hook: let rtk rewrite Bash commands, or pass them through untouched
# on machines without rtk instead of failing every call.

command -v rtk >/dev/null 2>&1 || exit 0
exec rtk hook claude
