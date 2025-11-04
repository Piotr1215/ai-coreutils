# ai-coreutils

<div align="center">

[![Tests](https://github.com/Piotr1215/ai-coreutils/workflows/Tests/badge.svg)](https://github.com/Piotr1215/ai-coreutils/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/Piotr1215/ai-coreutils/releases)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-1.0.0%2B-purple.svg)](https://docs.claude.com/en/docs/claude-code)

> What GNU coreutils are to Unix, ai-coreutils are to AI-assisted development

**Essential AI-augmented utilities for development following Unix coreutils philosophy**

[Installation](#installation) • [Quick Start](#quick-start) • [Documentation](#components) • [Examples](examples/) • [Contributing](CONTRIBUTING.md) • [Roadmap](ROADMAP.md)

</div>

---

## Why ai-coreutils?

**Problem:** Traditional Unix tools operate on text, but don't understand semantics.

**Solution:** ai-coreutils adds Claude's semantic understanding to your development workflow.

| You Need To... | Traditional | With ai-coreutils |
|----------------|-------------|-------------------|
| Find TODOs | `grep -rn "TODO"` → Manual prioritization | `/extract TODO` → Auto-prioritized with context |
| Understand code | `cat file.py` → Read & interpret yourself | `/summarize file.py` → Instant explanation |
| Compare files | `diff old new` → Parse syntax changes | `/compare old new` → Semantic analysis |
| Write docs | Manual writing & maintenance | `@doc-writer` → Auto-generated from code |
| Write tests | Manual test creation | `@test-generator` → Comprehensive test suites |

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

## Quick Start

```bash
# Add marketplace
/plugin marketplace add Piotr1215/aiverse

# Install plugin
/plugin install ai-coreutils@aiverse

# Verify installation
/plugin list

# Try it out!
/extract TODO src/
/summarize README.md
@doc-writer document your-file.py
```

## Installation

**From marketplace (recommended):**
```bash
/plugin marketplace add Piotr1215/aiverse
/plugin install ai-coreutils@aiverse
```

**From source:**
```bash
git clone https://github.com/Piotr1215/ai-coreutils.git
cd ai-coreutils
claude plugin install .
```

**Prerequisites:**
- Claude Code 1.0.0+
- Platform: Linux or macOS
- Optional: tmux (for smart notifications)
- Optional: bats (for running tests)

## Components

### Slash Commands
Prompts that guide Claude to perform specific operations with consistent output format. Claude uses its tool capabilities under the hood.

**Composable in natural language:** Slash commands can be combined by referencing them in natural language:
```bash
# Command composition examples
/extract TODO from src/ then filter for HIGH priority items
/summarize this file and highlight security concerns
```

No pipe symbols needed - just describe what you want using command names.

Examples: extract structured data, summarize in bullet format, semantic comparison.

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

### session-start

Displays core development principles at the start of every Claude session.

**Event:** SessionStart
**Behavior:** Outputs universal quality principles as session reminder
**Extensible:** Environment variables can trigger different hook content

**Example - Trigger different content via environment variable:**
```bash
PAIR_PROGRAMMING=1 claude  # Triggers pair programming mode content
```

Variables control which principles are displayed based on your workflow context.

---

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

## Real-World Examples

See [examples/](examples/) for detailed real-world usage patterns:

- **Code Maintenance**: Finding and prioritizing TODOs, comparing refactored code
- **Documentation**: Auto-generating API docs from code
- **Security Audits**: Finding security issues with semantic understanding
- **Refactoring**: Planning and validating refactors
- **Code Review**: Streamlining PR reviews with semantic analysis

**Quick example:**
```bash
# Before: Manual TODO review
grep -rn "TODO" src/
# 50 TODOs, all look the same, which to fix first?

# After: Semantic analysis with priority
/extract TODO src/
# Claude analyzes each TODO:
# - High Priority: Security issues, blocking bugs
# - Medium Priority: Features, tech debt
# - Low Priority: Style, minor improvements
```

---

## Testing

**Run tests locally:**
```bash
# Validate plugin structure
bash scripts/validate_plugin.sh

# Run hook tests
bats tests/notify_test.bats
```

**Coverage:**
- Hook tests (bats): 8 tests
- Structure validation: JSON validity, executable permissions
- CI/CD: Automated testing on push and PR

**Requirements**: `bats`, `jq` (see [CONTRIBUTING.md](CONTRIBUTING.md) for setup)

---

## Contributing

We welcome contributions! Here's how to get started:

**Quick Start:**
1. Read [CONTRIBUTING.md](CONTRIBUTING.md) for development setup
2. Check [ROADMAP.md](ROADMAP.md) for planned features
3. Look for [good first issues](https://github.com/Piotr1215/ai-coreutils/labels/good%20first%20issue)
4. Join [Discussions](https://github.com/Piotr1215/ai-coreutils/discussions)

**What we need:**
- New slash commands (extract, summarize, compare)
- New agents (code reviewer, security scanner)
- MCP servers (git, docs, testing)
- Documentation and examples
- Tests and CI improvements

See [ROADMAP.md](ROADMAP.md) for detailed feature roadmap and contribution opportunities.

---

## Community

- **Discussions**: [GitHub Discussions](https://github.com/Piotr1215/ai-coreutils/discussions)
- **Issues**: [Bug Reports & Feature Requests](https://github.com/Piotr1215/ai-coreutils/issues)
- **Marketplace**: [aiverse](https://github.com/Piotr1215/aiverse)
- **Code of Conduct**: [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- **Security**: [SECURITY.md](SECURITY.md)

---

## License

[MIT License](LICENSE) - Copyright (c) 2024 Piotr Zaniewski

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and release notes.

---

<div align="center">

**Made with Claude Code**

[⭐ Star this repo](https://github.com/Piotr1215/ai-coreutils) • [🐛 Report Bug](https://github.com/Piotr1215/ai-coreutils/issues/new?template=bug_report.yml) • [💡 Request Feature](https://github.com/Piotr1215/ai-coreutils/issues/new?template=feature_request.yml)

</div>
