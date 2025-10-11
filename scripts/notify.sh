#!/usr/bin/env bash
set -euo pipefail

# Simple notification: Claude task completed

if command -v dunstify &>/dev/null; then
    dunstify "Claude Code" "Task completed"
elif command -v notify-send &>/dev/null; then
    notify-send "Claude Code" "Task completed"
elif [[ "$OSTYPE" == "darwin"* ]] && command -v osascript &>/dev/null; then
    osascript -e 'display notification "Task completed" with title "Claude Code"'
elif command -v terminal-notifier &>/dev/null; then
    terminal-notifier -title "Claude Code" -message "Task completed"
fi

exit 0
