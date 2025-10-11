---
description: Extract patterns from code with context and semantic understanding
argument-hint: PATTERN [PATH] [--format=json|markdown]
---

# Extract Patterns Command

Extract all instances of `{0}` from files in `{1}` (default: current directory).

## Your Task

1. Use Grep tool to find all matches of pattern: {0}
   - Search in path: {1} (if not specified, use current directory)
   - Include context: 3 lines before and after each match

2. For each match, provide:
   - **Location**: file:line
   - **Context**: Surrounding code (3 lines each side)
   - **Semantic analysis**: WHY this match matters
   - **Priority assessment**: High/Medium/Low

3. **Priority criteria:**
   - **High**: Security issues, critical functionality, blocking errors
   - **Medium**: Feature work, non-critical bugs, technical debt
   - **Low**: Style issues, minor improvements, documentation

4. **Output format**: {format} (default: markdown)

## Output Format

### Markdown format:
```markdown
## Pattern "{0}" Found: {count} instances

### High Priority
1. **{file}:{line}**
   ```{language}
   {context_lines}
   ```
   **Context:** {semantic_analysis}
   **Priority:** High - {reason}

### Medium Priority
2. **{file}:{line}**
   ...

### Low Priority
3. **{file}:{line}**
   ...
```

### JSON format (if --format=json specified):
```json
{
  "pattern": "{0}",
  "total_matches": 5,
  "matches": [
    {
      "file": "src/auth.py",
      "line": 42,
      "matched_text": "TODO: Implement rate limiting",
      "context": ["line before", "matched line", "line after"],
      "priority": "high",
      "reason": "Security vulnerability - missing rate limiting"
    }
  ]
}
```

## Example

**Input:** `/extract TODO src/`

**Output:**
```markdown
## Pattern "TODO" Found: 3 instances

### High Priority
1. **src/auth.py:42**
   ```python
   def login(username, password):
       # TODO: Implement rate limiting for login attempts
       session = create_session(username)
   ```
   **Context:** Security concern - authentication without rate limiting exposes system to brute force attacks
   **Priority:** High - Security vulnerability
```

## Edge Cases

- **Empty results**: "No matches found for pattern '{0}' in {1}"
- **Binary files**: Skip with notice "Skipping binary file: {file}"
- **Large codebases**: Show progress indicator every 100 files
- **Invalid path**: "Error: Path '{1}' does not exist"

## Performance

- For codebases >10,000 files: Show progress and prioritize critical matches
- Timeout: 30 seconds maximum
- If taking too long: Return partial results with note "Analysis incomplete - showing first N high-priority matches"
