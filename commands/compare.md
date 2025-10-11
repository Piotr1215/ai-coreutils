---
description: Compare two files for semantic equivalence
argument-hint: FILE1 FILE2
model: sonnet
thinking: auto
---

# Compare Files Command

Compare files: `{0}` and `{1}` for semantic equivalence

## Your Task

1. **Read both files** using Read tool:
   - File 1: {0}
   - File 2: {1}

2. **Analyze:**
   - **Semantic equivalence**: Do they achieve the same result despite different syntax?
   - **Functional differences**: What actually changed in behavior?
   - **Risk assessment**: Is it safe to replace one with the other?

3. **Provide structured comparison** in markdown format

## Output Format

```markdown
# Comparison: {file1} vs {file2}

**Semantic Equivalence:** {Identical|Mostly equivalent|Different}

**Identical Functionality:**
- {functionality_description} (same logic, different variable names)
- {algorithm} (same approach, different implementation style)

**Differences:**
- {difference_1} ({enhancement|regression|change})
  - File 1: {behavior_in_file1}
  - File 2: {behavior_in_file2}

**Risk Assessment:** {Low|Medium|High} - {explanation}

**Recommendation:** {which_version_to_use} - {reason}
```

## Analysis Criteria

### Semantic Equivalence

**Identical:**
- Exactly the same algorithm and result
- Only variable names or formatting differ

**Mostly equivalent:**
- Same core algorithm
- Minor optimizations or refactoring
- Same result for all inputs

**Different:**
- Different algorithms
- Different behavior for some inputs
- Significant logic changes

### Functional Differences

**Enhancement:**
- New features added
- Performance improvements
- Better error handling
- Security improvements

**Regression:**
- Features removed
- Worse performance
- Missing error handling
- Security concerns

**Change:**
- Different approach, neither better nor worse
- Different error handling strategy
- Different architecture

### Risk Levels

**Low:**
- Core logic unchanged
- Only improvements or optimizations
- No behavioral changes
- Safe to replace

**Medium:**
- Some behavior changes
- Needs testing to verify
- Different edge case handling
- Review recommended

**High:**
- Significant logic changes
- Different algorithms
- Potential breaking changes
- Thorough review and testing required

## Example

**Input:** `/compare auth_v1.py auth_v2.py`

**Output:**
```markdown
# Comparison: auth_v1.py vs auth_v2.py

**Semantic Equivalence:** Mostly equivalent with improvements

**Identical Functionality:**
- Login flow (same authentication logic, different async implementation)
- Token generation (identical JWT algorithm and claims)
- Session management (same Redis approach)

**Differences:**
- **Enhancement**: auth_v2.py adds rate limiting
  - File 1: No rate limiting (security concern)
  - File 2: 5 attempts per minute limit with exponential backoff
- **Enhancement**: auth_v2.py uses async/await
  - File 1: Synchronous blocking calls
  - File 2: Async non-blocking with better performance
- **Regression**: auth_v2.py missing password complexity validation
  - File 1: Requires 8+ chars, uppercase, number, special char
  - File 2: No validation (accepts any password)

**Risk Assessment:** Medium - Core authentication is solid, but missing password validation is a concern

**Recommendation:** Use auth_v2.py BUT add password complexity validation from auth_v1.py
```

## Edge Cases

- **Identical files**: "Files are identical - byte-for-byte match"
- **Different languages**: Compare functionality conceptually: "Files implement same logic in different languages (Python vs JavaScript)"
- **One file missing**: "Error: File '{file}' not found"
- **Binary files**: "Cannot compare binary files semantically"
- **Very different files**: "Files have completely different purposes - no meaningful comparison possible"

## Performance

- Typical comparison: Complete within 15 seconds
- Large files: Focus on key differences, not line-by-line
- Timeout: 30 seconds maximum
