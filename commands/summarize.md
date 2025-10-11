---
description: Condense file to bullet points respecting language semantics
argument-hint: FILE
model: sonnet
thinking: auto
---

# Summarize File Command

Analyze and summarize the file: `{0}`

## Your Task

1. **Read the file** using Read tool: {0}

2. **Identify:**
   - Primary purpose (one clear sentence)
   - Key components (functions, classes, modules with brief descriptions)
   - External dependencies (imports, libraries used)
   - Notable issues or incomplete sections (TODOs, FIXMEs, missing implementations)

3. **Provide concise summary** in structured markdown format

## Output Format

```markdown
# Summary: {file_path}

**Purpose:** {one_sentence_describing_file_purpose}

**Key Components:**
- `{function_name}` - {brief_description}
- `{class_name}` - {brief_description}
- `{module_name}` - {brief_description}

**Dependencies:**
- {library_name} - {what_its_used_for}
- {package_name} - {usage_context}

**Notes:**
- {notable_issue_todo_or_concern}
- {incomplete_functionality}
```

## Language-Specific Understanding

**Python:**
- Functions: `def function_name(params):`
- Classes: `class ClassName:`
- Imports: `import x`, `from y import z`
- Decorators: `@decorator`

**JavaScript/TypeScript:**
- Functions: `function name()`, `const name = () =>`
- Classes: `class Name`
- Exports/Imports: `export`, `import`
- Async: `async/await` patterns

**Go:**
- Functions: `func Name(params) returnType`
- Structs: `type Name struct`
- Packages: `package name`

**Rust:**
- Functions: `fn name(params) -> ReturnType`
- Structs: `struct Name`
- Traits: `trait Name`
- Mods: `mod name`

**Java:**
- Classes: `public class Name`
- Interfaces: `interface Name`
- Packages: `package com.example`

## Example

**Input:** `/summarize src/auth.py`

**Output:**
```markdown
# Summary: src/auth.py

**Purpose:** User authentication and session management module

**Key Components:**
- `login(username, password)` - Authenticates user and creates session
- `logout(session_id)` - Terminates active user session
- `validate_token(token)` - Verifies JWT token validity
- `Session` class - Represents active user session with token and expiry

**Dependencies:**
- jwt - Token generation and validation
- bcrypt - Password hashing
- redis - Session storage and caching

**Notes:**
- TODO line 42: Rate limiting not implemented (security concern)
- Password reset flow incomplete (missing email notification)
- Token refresh mechanism not yet implemented
```

## Edge Cases

- **Empty file**: "File is empty - no content to summarize"
- **Binary file**: "Cannot summarize binary file: {file}"
- **Large file (>5000 lines)**: Summarize key sections only, note "Large file - focusing on main components"
- **Multiple languages in one file**: Handle polyglot files, note languages present
- **File not found**: "Error: File '{0}' not found"

## Performance

- Typical files (<1000 lines): Complete within 10 seconds
- Large files (>5000 lines): Focus on structure, skip exhaustive listing
- Timeout: 30 seconds maximum
