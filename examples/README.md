# ai-coreutils Examples

Real-world examples demonstrating how to use ai-coreutils in your daily workflow.

## Table of Contents

- [Code Maintenance](#code-maintenance)
- [Documentation](#documentation)
- [Security Audits](#security-audits)
- [Refactoring](#refactoring)
- [Code Review](#code-review)

## Code Maintenance

### Finding and Prioritizing TODOs

**Scenario**: You have a large codebase with scattered TODO comments and want to prioritize them.

**Traditional Approach**:
```bash
grep -rn "TODO" src/
# Output: Long list of TODOs with no context or priority
# You manually read each one to determine importance
```

**AI-Augmented Approach**:
```bash
/extract TODO src/
```

**Output**:
```markdown
## Pattern "TODO" Found: 15 instances

### High Priority
1. **src/auth/login.ts:42**
   ```typescript
   async function login(username: string, password: string) {
       // TODO: Add rate limiting to prevent brute force attacks
       const user = await db.findUser(username);
   ```
   **Context:** Security vulnerability - authentication endpoint without rate limiting
   **Priority:** High - Could lead to account compromise via brute force

2. **src/api/payment.ts:128**
   ```typescript
   // TODO: Implement transaction rollback on payment failure
   await processPayment(order);
   await updateInventory(order);
   ```
   **Context:** Data consistency issue - payment processing without proper error handling
   **Priority:** High - Financial data integrity at risk

### Medium Priority
3. **src/utils/cache.ts:67**
   ```typescript
   // TODO: Add cache invalidation logic
   cache.set(key, value, TTL);
   ```
   **Context:** Performance optimization - stale data might be served
   **Priority:** Medium - Affects user experience but not critical

[... more TODOs organized by priority ...]
```

**Value Added**: Semantic understanding of why each TODO matters, automatic prioritization, context-aware analysis.

---

### Comparing Refactored Code

**Scenario**: Your teammate refactored a critical module and you need to verify it's functionally equivalent.

**Traditional Approach**:
```bash
diff old_auth.py new_auth.py
# Output: Hundreds of lines of syntax differences
# You manually trace through to understand semantic changes
```

**AI-Augmented Approach**:
```bash
/compare old_auth.py new_auth.py
```

**Output**:
```markdown
## Comparison: old_auth.py vs new_auth.py

### Equivalence Assessment
**Status:** Mostly Equivalent with Enhancements

### Functional Differences

**Added Features:**
1. **Rate Limiting** (new_auth.py:35-42)
   - Implements token bucket algorithm
   - Prevents brute force attacks
   - **Risk:** Low - Enhancement, not a change

2. **Async/Await Pattern** (new_auth.py:15-89)
   - Converted from synchronous to asynchronous
   - **Risk:** Medium - Changes execution model, requires testing

**Removed Features:**
None

**Behavioral Changes:**
1. **Password Validation** (old_auth.py:28 vs new_auth.py:31)
   - Old: Basic length check (8 chars minimum)
   - New: Comprehensive validation (length + complexity)
   - **Risk:** Low - Strengthens security

### Risk Assessment
**Overall Risk:** Medium

**Concerns:**
- Async conversion changes error propagation patterns
- Existing callers must be updated to handle promises
- Race conditions possible if not properly awaited

**Recommendations:**
1. Add integration tests for async flow
2. Verify all callers properly await the async functions
3. Test error handling with various failure scenarios
4. Review rate limiting configuration for production load
```

**Value Added**: Semantic equivalence analysis, risk assessment, actionable recommendations.

---

## Documentation

### Generating API Documentation

**Scenario**: You need to document a new API module for your team.

**Traditional Approach**:
```bash
# Manually write documentation by reading code
# Hope you don't miss important details
# Struggle to keep docs in sync with code
```

**AI-Augmented Approach**:
```bash
@doc-writer document the user management API in src/api/users.ts
```

**Output**:
```markdown
# User Management API

## Overview
Comprehensive user management system providing authentication, authorization, and profile management capabilities.

## Endpoints

### POST /api/users/register
Register a new user account.

**Parameters:**
- `username` (string, required): Unique username, 3-20 characters
- `email` (string, required): Valid email address
- `password` (string, required): Minimum 8 characters, must contain uppercase, lowercase, number, and special character

**Returns:**
```typescript
{
  id: string;
  username: string;
  email: string;
  createdAt: Date;
}
```

**Example:**
```typescript
const response = await fetch('/api/users/register', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    username: 'johndoe',
    email: 'john@example.com',
    password: 'SecureP@ss123'
  })
});
```

**Error Cases:**
- `400 Bad Request`: Invalid input (username taken, weak password, etc.)
- `409 Conflict`: User already exists
- `500 Internal Server Error`: Database or system error

**Notes:**
- Passwords are hashed using bcrypt with 12 rounds
- Email verification is sent asynchronously
- Rate limited to 5 requests per hour per IP

[... more endpoints documented ...]
```

**Value Added**: Comprehensive documentation with examples, error cases, and implementation notes extracted from code.

---

## Security Audits

### Finding Security Issues

**Scenario**: Security audit before a release.

```bash
# Extract potential security issues
/extract "password\|secret\|api.?key\|token" src/ --format=json

# Summarize authentication logic
/summarize src/auth/

# Compare old and new security implementations
/compare src/old_security.py src/new_security.py
```

**Example Output**:
```markdown
## Pattern "password|secret|api_key|token" Found: 8 instances

### High Priority
1. **src/config/database.ts:12**
   ```typescript
   const DB_PASSWORD = process.env.DB_PASSWORD || 'default_password';
   ```
   **Context:** Hardcoded fallback password - security vulnerability
   **Priority:** High - Exposed credentials in source code

2. **src/api/external.ts:45**
   ```typescript
   const apiKey = req.headers['x-api-key'];
   if (apiKey) { // TODO: Validate API key
   ```
   **Context:** API key validation not implemented
   **Priority:** High - Unauthenticated API access possible

### Medium Priority
3. **src/utils/jwt.ts:23**
   ```typescript
   const secret = process.env.JWT_SECRET;
   // Token expires in 7 days
   ```
   **Context:** Long token expiration - security consideration
   **Priority:** Medium - Extended attack window if token leaked
```

---

## Refactoring

### Planning a Refactor

**Scenario**: You want to refactor a messy file but need to understand it first.

```bash
# First, understand what the file does
/summarize src/legacy/data_processor.py

# Find all the TODOs and technical debt
/extract "TODO\|FIXME\|HACK\|XXX" src/legacy/data_processor.py

# Generate comprehensive tests before refactoring
@test-generator create comprehensive tests for src/legacy/data_processor.py

# After refactoring, verify equivalence
/compare src/legacy/data_processor.py src/new/data_processor.py
```

---

## Code Review

### Reviewing Pull Requests

**Workflow for reviewing a teammate's PR:**

```bash
# 1. Understand what changed
git diff main...feature-branch > changes.diff
/summarize changes.diff

# 2. Check for security issues in the changes
/extract "password\|token\|secret\|api.?key" changes.diff

# 3. Verify test coverage
/extract "test\|it\(.*should\|describe\(" tests/

# 4. Compare critical files for semantic changes
/compare main:src/auth.ts feature-branch:src/auth.ts

# 5. Generate documentation for new features
@doc-writer document the new payment processing feature in src/payments/
```

---

## Workflow Automation

### Using Hooks for Automated Workflows

**Example: Auto-notify on completion**

The included notification hook automatically sends you a notification when Claude finishes work:

```bash
# In one tmux/terminal window, start a long-running task
/extract TODO large-codebase/

# Switch to another window to do other work
# You'll get a notification when extraction is complete
```

**Create your own hooks** in `hooks/hooks.json`:

```json
{
  "hooks": {
    "PostToolUse": [{
      "hooks": [{
        "type": "command",
        "command": "./scripts/log_usage.sh",
        "timeout": 5
      }]
    }]
  }
}
```

---

## Composition Patterns

### Chaining Commands (Manual)

While native piping isn't implemented yet, you can manually chain operations:

```bash
# Step 1: Extract high-priority TODOs
/extract TODO src/ --format=json > todos.json

# Step 2: Use the output to generate fix tasks
# (Pass todos.json content to next command)

# Step 3: Generate tests for fixed code
@test-generator create tests based on the TODO fixes
```

---

## Tips and Best Practices

### Command Usage

1. **Be Specific**: Use precise patterns and paths
   ```bash
   # Good
   /extract "TODO.*security" src/auth/

   # Less effective
   /extract TODO .
   ```

2. **Use Format Options**: JSON for processing, Markdown for reading
   ```bash
   /extract FIXME src/ --format=json  # For scripts
   /extract TODO src/ --format=markdown  # For reading
   ```

3. **Scope Appropriately**: Target specific directories to reduce noise
   ```bash
   /summarize src/core/  # Focused summary
   /summarize .  # Might be too broad
   ```

### Agent Usage

1. **Provide Context**: Give agents clear, specific instructions
   ```bash
   # Good
   @doc-writer document the REST API in src/api/v2/users.ts, include authentication requirements

   # Less effective
   @doc-writer document this
   ```

2. **Review Output**: Agents generate drafts - always review and refine
   ```bash
   @test-generator create tests for src/auth.py
   # Review, add edge cases, verify coverage
   ```

---

## Contributing Examples

Have a great use case? Add it here!

1. Create a new section or file in `examples/`
2. Include before/after comparisons
3. Show actual command usage and output
4. Explain the value added
5. Submit a PR!

---

## Need Help?

- Open an [issue](https://github.com/Piotr1215/ai-coreutils/issues)
- Start a [discussion](https://github.com/Piotr1215/ai-coreutils/discussions)
- Check the [main README](../README.md)
