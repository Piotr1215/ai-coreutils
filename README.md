# dev-essentials

Essential AI-augmented utilities for development following Unix coreutils philosophy.

## Philosophy

What GNU coreutils are to Unix, dev-essentials are to AI-assisted development.

Claude sits between you and Unix tools, adding semantic understanding:

| Traditional | AI-Augmented |
|------------|--------------|
| `grep -rn "TODO" .` → You read and prioritize manually | `/extract TODO` → Claude provides context, priority, explanation |
| `head -n 20 file.py` → You interpret what code does | `/summarize file.py` → Claude explains purpose, components, dependencies |
| `diff old.py new.py` → You analyze if equivalent | `/compare old.py new.py` → Claude identifies semantic equivalence and risks |

## Installation

```bash
# Add marketplace
/plugin marketplace add Piotr1215/ai-coreutils-marketplace

# Install plugin
/plugin install dev-essentials@ai-coreutils

# Verify installation
/plugin list
```

## Commands

### /extract PATTERN [PATH] [--format=json|markdown]

Extract patterns from code with semantic context and priority analysis.

**Example:**
```bash
/extract TODO src/
```

**Output:** Structured list with context, priority (High/Medium/Low), and explanation of why each match matters.

---

### /summarize FILE

Condense file to essential information with language-specific understanding.

**Example:**
```bash
/summarize src/auth.py
```

**Output:** Purpose statement, key components, dependencies, notable issues.

---

### /compare FILE1 FILE2

Compare files for semantic equivalence, not just syntax differences.

**Example:**
```bash
/compare old_version.py new_version.py
```

**Output:** Equivalence assessment, functional differences, risk level, recommendation.

---

## Agents

### @doc-writer

Technical documentation specialist for API docs and READMEs.

**Tools:** Read, Write, Grep, WebFetch
**Focus:** Clear, comprehensive documentation with runnable examples

**Example:**
```bash
@doc-writer document the authentication module in src/auth.py
```

**Output:** Standard API documentation with signatures, parameters, returns, examples, error cases.

---

### @test-generator

Test case generation expert focusing on coverage and edge cases.

**Tools:** Read, Write, Grep
**Focus:** Comprehensive test suites achieving >80% coverage

**Example:**
```bash
@test-generator create tests for src/auth.py
```

**Output:** Runnable test file with happy path, edge cases, error cases, integration tests.

---

## Hooks

### notification-manager

Automatically sends notification when Claude finishes work (if you're not watching).

**Event:** Stop
**Behavior:** Detects if you're in active tmux window, sends platform-appropriate notification
**Platforms:** Linux (notify-send), macOS (osascript)

**No configuration needed** - automatically enabled on installation.

---

## Design Principles

1. **Augmentation, not replacement** - Adds semantic layer, doesn't replace Unix tools
2. **Generic and composable** - Works across projects and tech stacks
3. **Predictable output** - Consistent formats for chaining with other tools
4. **Real value** - Leverages Claude's unique semantic capabilities
5. **Unix philosophy** - Small, focused, composable utilities

---

## Examples

### Pattern extraction with priority

```bash
/extract TODO src/
```

Output includes high-priority security TODOs first, explains why each matters.

### Semantic file comparison

```bash
/compare auth_v1.py auth_v2.py
```

Claude identifies that files are "mostly equivalent" despite async refactoring, highlights added rate limiting as enhancement, warns about missing password validation.

### Generate documentation

```bash
@doc-writer document src/auth.py
```

Creates comprehensive API documentation with runnable examples.

---

## Requirements

- Claude Code 1.0.0+
- Platform: Linux or macOS
- Optional: tmux (for smart notifications)

---

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## License

MIT - See [LICENSE](LICENSE) file for details.

---

## Links

- [Marketplace](https://github.com/Piotr1215/ai-coreutils-marketplace)
- [Issues](https://github.com/Piotr1215/claude-plugin-dev-essentials/issues)
- [Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins-reference)
