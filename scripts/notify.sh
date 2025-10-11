#!/usr/bin/env bash
set -euo pipefail

# Check if user is watching (tmux active window)
if tmux display-message -p '#{window_active}' 2>/dev/null | grep -q '^1$'; then
    # User is watching, no notification needed
    exit 0
fi

# Send notification based on OS
if command -v notify-send &> /dev/null; then
    # Linux (using notify-send)
    notify-send "Claude Code" "Task completed ✅" 2>/dev/null || true
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS (using osascript)
    osascript -e 'display notification "Task completed ✅" with title "Claude Code"' 2>/dev/null || true
fi

# Log completion (for debugging)
echo "✅ Notification sent at $(date)" >> /tmp/claude_notifications.log

exit 0
