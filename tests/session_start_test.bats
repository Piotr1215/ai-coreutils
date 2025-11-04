#!/usr/bin/env bats

# Test suite for session_start.sh hook
# Tests session start hook execution and output

setup() {
    REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
    export REPO_ROOT

    SCRIPT_PATH="${REPO_ROOT}/scripts/session_start.sh"
    export SCRIPT_PATH
}

@test "session_start.sh exists and is executable" {
    [ -f "$SCRIPT_PATH" ]
    [ -x "$SCRIPT_PATH" ]
}

@test "session_start.sh executes without errors" {
    run bash "$SCRIPT_PATH"
    [ "$status" -eq 0 ]
}

@test "session_start.sh outputs core principles" {
    run bash "$SCRIPT_PATH"

    # Check for key principles in output
    echo "$output" | grep -q "CORE PRINCIPLES"
    echo "$output" | grep -q "80% READING/RESEARCH, 20% WRITING"
    echo "$output" | grep -q "Every line must FIGHT for its right to exist"
}

@test "session_start.sh outputs all expected principles" {
    run bash "$SCRIPT_PATH"

    # Verify all core principles are present
    echo "$output" | grep -q "understand deeply before creating"
    echo "$output" | grep -q "Read source materials"
    echo "$output" | grep -q "Minimize output - less is better"
    echo "$output" | grep -q "NEVER add features not asked for"
    echo "$output" | grep -q "Work without tests is incomplete"
    echo "$output" | grep -q "Only commit when explicitly asked"
}

@test "session_start.sh outputs to stdout" {
    run bash "$SCRIPT_PATH"

    # Should have output
    [ -n "$output" ]
}

@test "session_start.sh does not output to stderr" {
    run bash "$SCRIPT_PATH" 2>&1

    # All output should be on stdout, stderr should be empty
    [ "$status" -eq 0 ]
}

@test "session_start.sh does not contain emojis in output" {
    run bash "$SCRIPT_PATH"

    # Check for common emoji hex patterns (should only find bullet points)
    ! echo "$output" | grep -P "[\x{1F300}-\x{1F9FF}]"
    ! echo "$output" | grep -P "[\x{2600}-\x{26FF}]"
}

@test "session_start.sh has proper shebang and set options" {
    # Verify bash shebang
    head -n 1 "$SCRIPT_PATH" | grep -q "#!/usr/bin/env bash"

    # Verify set options for safety
    head -n 2 "$SCRIPT_PATH" | grep -q "set -euo pipefail"
}
