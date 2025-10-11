#!/usr/bin/env bash
set -euo pipefail

notification_sent=false

if command -v dunstify &>/dev/null; then
    dunstify -a "Claude Code" "Task completed" 2>/dev/null && notification_sent=true
fi

if [ "$notification_sent" = false ] && command -v notify-send &>/dev/null; then
    notify-send "Claude Code" "Task completed" 2>/dev/null && notification_sent=true
fi

if [ "$notification_sent" = false ] && [[ "$OSTYPE" == "darwin"* ]]; then
    osascript -e 'display notification "Task completed" with title "Claude Code"' 2>/dev/null && notification_sent=true
fi

if [ "$notification_sent" = false ] && command -v terminal-notifier &>/dev/null; then
    terminal-notifier -title "Claude Code" -message "Task completed" 2>/dev/null && notification_sent=true
fi

if [ "$notification_sent" = true ]; then
    echo "[OK] Notification sent at $(date)" >> /tmp/claude_notifications.log
else
    echo "[WARN] No notification tool available at $(date)" >> /tmp/claude_notifications.log
fi

exit 0
