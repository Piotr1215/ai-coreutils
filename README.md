# ai-coreutils

> What GNU coreutils are to Unix, ai-coreutils are to AI-assisted development

Essential AI-augmented utilities for development following Unix coreutils philosophy.

## Philosophy

Unix coreutils (`ls`, `grep`, `sed`) operate on text streams through standard interfaces. ai-coreutils leverage Claude's capabilities through slash commands, agents, hooks, and MCP servers.

### The Evolution

```
Traditional:  User → Unix Tools (ls, grep, sed)
AI-Enhanced:  User → Claude → Unix Tools + AI Capabilities
```

Claude sits between user and tools, leveraging both traditional Unix utilities and AI-specific operations. Not replacing, augmenting.

### The Parallel

| Unix System | Description | Claude Code System | Description |
|-------------|-------------|-----------|-------------|
| **Coreutils** (`ls`, `grep`) | Small C programs<br>Operate on text | **Slash Commands** (`/extract`, `/summarize`) | Prompts guiding Claude's tool use<br>Predictable text operations |
| **Shell/Pipes** (`bash`, `\|`) | Composition layer<br>Chain operations | **Hooks** (PostToolUse, SessionStart) | Event-driven automation<br>Orchestrate Claude's actions |
| **Daemons** (`sshd`, `httpd`) | Single-purpose services<br>Always available | **Agents** (doc-writer, test-generator) | Focused Claude instances<br>Specialized tasks |
| **System Services** (`systemd`, `cron`) | Complex coordination<br>Inter-process comm | **MCP Servers** (Model Context Protocol) | External tool integration<br>State & communication |

### Common Interface

**Unix:** stdin/stdout (text streams)
**Claude Code:** tool calls/results + conversation context

### Practical Examples

Claude sits between you and Unix tools, adding semantic understanding:

| Traditional | AI-Augmented |
|------------|--------------|
| `grep -rn "TODO" .` → You read and prioritize manually | `/extract TODO` → Claude provides context, priority, explanation |
| `head -n 20 file.py` → You interpret what code does | `/summarize file.py` → Claude explains purpose, components, dependencies |
| `diff old.py new.py` → You analyze if equivalent | `/compare old.py new.py` → Claude identifies semantic equivalence and risks |

## Installation

```bash
# Add marketplace
/plugin marketplace add Piotr1215/aiverse

# Install plugin
/plugin install ai-coreutils@aiverse

# Verify installation
/plugin list
```

## Components

### Slash Commands
Prompts that guide Claude to perform specific operations with consistent output format. Claude uses its tool capabilities under the hood. Examples: extract structured data, summarize in bullet format, semantic comparison.

### Agents
Pre-configured Claude instances with focused behavior and limited scope. Each agent has specific system prompts and tool access. Examples: documentation writer, test generator, security reviewer.

### Hooks
Bash/Python scripts triggered by Claude Code lifecycle events (SessionStart, PostToolUse, Stop). Orchestrate workflows, call external systems, automate responses to Claude's actions.

### MCP Servers
Model Context Protocol servers that extend Claude's capabilities. Provide custom tools, maintain state, enable communication between instances, integrate external systems.

---

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

- [Marketplace](https://github.com/Piotr1215/aiverse)
- [Issues](https://github.com/Piotr1215/ai-coreutils/issues)
- [Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins-reference)
