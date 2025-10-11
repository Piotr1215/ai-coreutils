#!/usr/bin/env bats

# Test suite for notify.sh hook
# Tests notification script execution and logging

setup() {
    REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
    export REPO_ROOT

    TEST_DIR="$(mktemp -d)"
    export TEST_DIR

    export PATH="${TEST_DIR}:${PATH}"

    # Mock dunstify
    cat > "${TEST_DIR}/dunstify" << 'EOF'
#!/bin/bash
echo "[DUNSTIFY] $*" >> "${TEST_DIR}/notification_calls.log"
exit 0
EOF
    chmod +x "${TEST_DIR}/dunstify"

    # Mock notify-send
    cat > "${TEST_DIR}/notify-send" << 'EOF'
#!/bin/bash
echo "[NOTIFY-SEND] $*" >> "${TEST_DIR}/notification_calls.log"
exit 0
EOF
    chmod +x "${TEST_DIR}/notify-send"

    # Override log file location
    export CLAUDE_NOTIFICATIONS_LOG="${TEST_DIR}/claude_notifications.log"

    # Temporarily modify script to use our log location
    sed "s|/tmp/claude_notifications.log|\${CLAUDE_NOTIFICATIONS_LOG}|g" \
        "${REPO_ROOT}/scripts/notify.sh" > "${TEST_DIR}/notify.sh"
    chmod +x "${TEST_DIR}/notify.sh"
}

teardown() {
    rm -rf "$TEST_DIR"
}

@test "notify.sh executes without errors" {
    run bash "${TEST_DIR}/notify.sh"
    [ "$status" -eq 0 ]
}

@test "notify.sh calls dunstify when available" {
    run bash "${TEST_DIR}/notify.sh"

    [ -f "${TEST_DIR}/notification_calls.log" ]
    grep -q "DUNSTIFY" "${TEST_DIR}/notification_calls.log"
}

@test "notify.sh creates log file" {
    bash "${TEST_DIR}/notify.sh"

    [ -f "${CLAUDE_NOTIFICATIONS_LOG}" ]
}

@test "notify.sh logs successful notification" {
    bash "${TEST_DIR}/notify.sh"

    grep -q "\[OK\] Notification sent" "${CLAUDE_NOTIFICATIONS_LOG}"
}

@test "notify.sh logs timestamp" {
    bash "${TEST_DIR}/notify.sh"

    # Check log contains date-like pattern
    grep -E "[A-Z][a-z]{2} [A-Z][a-z]{2} [0-9]{1,2}" "${CLAUDE_NOTIFICATIONS_LOG}"
}

@test "notify.sh uses correct notification message" {
    bash "${TEST_DIR}/notify.sh"

    grep -q "Claude Code" "${TEST_DIR}/notification_calls.log"
    grep -q "Task completed" "${TEST_DIR}/notification_calls.log"
    # Verify no emojis in notification
    ! grep -E "✅|⚠️" "${TEST_DIR}/notification_calls.log"
}

@test "notify.sh does not contain emojis" {
    # Verify no emoji in notification messages or log
    bash "${TEST_DIR}/notify.sh"

    # Check for common emoji hex patterns
    ! grep -P "[\x{1F300}-\x{1F9FF}]" "${CLAUDE_NOTIFICATIONS_LOG}"
    ! grep -P "[\x{2600}-\x{26FF}]" "${CLAUDE_NOTIFICATIONS_LOG}"
}

@test "notify.sh suppresses stderr from notification tools" {
    # Make dunstify output to stderr
    cat > "${TEST_DIR}/dunstify" << 'EOF'
#!/bin/bash
echo "error message" >&2
exit 0
EOF
    chmod +x "${TEST_DIR}/dunstify"

    run bash "${TEST_DIR}/notify.sh"

    # Script should complete, stderr should be suppressed (2>/dev/null in script)
    [ "$status" -eq 0 ]
}
