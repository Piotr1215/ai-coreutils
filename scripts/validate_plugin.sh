#!/usr/bin/env bash
set -euo pipefail

# Plugin structure validation script
# Validates plugin.json and directory structure

PLUGIN_ROOT="${1:-.}"
EXIT_CODE=0

echo "Validating plugin structure in: $PLUGIN_ROOT"
echo

# Check plugin.json exists
if [ ! -f "$PLUGIN_ROOT/.claude-plugin/plugin.json" ]; then
    echo "[FAIL] .claude-plugin/plugin.json not found"
    exit 1
fi

echo "[OK] plugin.json found"

# Validate JSON syntax
if ! jq empty "$PLUGIN_ROOT/.claude-plugin/plugin.json" 2>/dev/null; then
    echo "[FAIL] plugin.json is not valid JSON"
    exit 1
fi

echo "[OK] plugin.json is valid JSON"

# Check required fields
REQUIRED_FIELDS=("name" "version" "description")
for field in "${REQUIRED_FIELDS[@]}"; do
    if ! jq -e ".$field" "$PLUGIN_ROOT/.claude-plugin/plugin.json" >/dev/null 2>&1; then
        echo "[FAIL] Required field missing: $field"
        EXIT_CODE=1
    else
        echo "[OK] Required field present: $field"
    fi
done

# Validate paths start with ./
if [ -d "$PLUGIN_ROOT/commands" ]; then
    echo "[OK] commands directory exists"
fi

if [ -d "$PLUGIN_ROOT/agents" ]; then
    echo "[OK] agents directory exists"
fi

if [ -d "$PLUGIN_ROOT/hooks" ]; then
    echo "[OK] hooks directory exists"

    # Check hooks.json if it exists
    if [ -f "$PLUGIN_ROOT/hooks/hooks.json" ]; then
        if ! jq empty "$PLUGIN_ROOT/hooks/hooks.json" 2>/dev/null; then
            echo "[FAIL] hooks/hooks.json is not valid JSON"
            EXIT_CODE=1
        else
            echo "[OK] hooks/hooks.json is valid JSON"
        fi
    fi
fi

# Check scripts are executable
if [ -d "$PLUGIN_ROOT/scripts" ]; then
    echo
    echo "Checking script permissions:"
    while IFS= read -r -d '' script; do
        if [ -x "$script" ]; then
            echo "[OK] $(basename "$script") is executable"
        else
            echo "[FAIL] $(basename "$script") is not executable"
            EXIT_CODE=1
        fi
    done < <(find "$PLUGIN_ROOT/scripts" -type f -name "*.sh" -print0)
fi

echo
if [ $EXIT_CODE -eq 0 ]; then
    echo "✓ Plugin structure validation passed"
else
    echo "✗ Plugin structure validation failed"
fi

exit $EXIT_CODE
