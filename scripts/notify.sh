#!/usr/bin/env bash
set -euo pipefail

# Detect and use available notification tool (priority order)
# 1. dunstify (modern, feature-rich)
# 2. notify-send (standard freedesktop)
# 3. osascript (macOS)
# 4. terminal-notifier (macOS alternative)

notification_sent=false

# Try dunstify first (best Linux option)
if command -v dunstify &> /dev/null; then
    dunstify -a "Claude Code" "Task completed ✅" 2>/dev/null && notification_sent=true
fi

# Try notify-send (standard Linux)
if [ "$notification_sent" = false ] && command -v notify-send &> /dev/null; then
    notify-send "Claude Code" "Task completed ✅" 2>/dev/null && notification_sent=true
fi

# Try osascript (macOS)
if [ "$notification_sent" = false ] && [[ "$OSTYPE" == "darwin"* ]]; then
    osascript -e 'display notification "Task completed ✅" with title "Claude Code"' 2>/dev/null && notification_sent=true
fi

# Try terminal-notifier (macOS alternative)
if [ "$notification_sent" = false ] && command -v terminal-notifier &> /dev/null; then
    terminal-notifier -title "Claude Code" -message "Task completed ✅" 2>/dev/null && notification_sent=true
fi

# Log result
if [ "$notification_sent" = true ]; then
    echo "✅ Notification sent at $(date)" >> /tmp/claude_notifications.log
else
    echo "⚠️  No notification tool available at $(date)" >> /tmp/claude_notifications.log
fi

exit 0
