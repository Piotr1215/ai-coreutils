# Contributing to ai-coreutils

Thank you for your interest in contributing! We're excited to have you here.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Adding New Components](#adding-new-components)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Community](#community)

## Getting Started

**New to the project?** Start here:

1. Read the [README.md](README.md) to understand the project philosophy
2. Check the [ROADMAP.md](ROADMAP.md) for planned features
3. Look for [good first issues](https://github.com/Piotr1215/ai-coreutils/labels/good%20first%20issue)
4. Join [GitHub Discussions](https://github.com/Piotr1215/ai-coreutils/discussions) to ask questions

**Never contributed to open source?** No problem! Here are some helpful resources:
- [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [About Pull Requests](https://docs.github.com/en/pull-requests)

## Development Setup

### Prerequisites

**Required:**
- [Claude Code](https://docs.claude.com/en/docs/claude-code) 1.0.0+
- Git

**Optional (for running tests):**
- [bats](https://github.com/bats-core/bats-core) - Bash testing framework
- [jq](https://stedolan.github.io/jq/) - JSON processor

### Installation

1. **Fork and clone the repository:**
```bash
# Fork the repo on GitHub first, then:
git clone https://github.com/YOUR_USERNAME/ai-coreutils.git
cd ai-coreutils
```

2. **Install test dependencies (optional but recommended):**
```bash
# On macOS
brew install bats-core jq

# On Ubuntu/Debian
sudo apt-get install jq
sudo npm install -g bats

# On other systems, see: https://github.com/bats-core/bats-core
```

3. **Install the plugin locally:**
```bash
claude plugin install .
```

4. **Verify installation:**
```bash
# Check plugin is installed
claude plugin list

# Validate plugin structure
bash scripts/validate_plugin.sh

# Run tests
bats tests/notify_test.bats
```

5. **Test the plugin:**
```bash
# Test slash commands
claude /extract TODO .
claude /summarize README.md

# Test agents
@doc-writer document a file
@test-generator suggest tests for a function
```

## How to Contribute

There are many ways to contribute:

### Code Contributions
- Implement new slash commands, agents, or hooks
- Fix bugs
- Improve test coverage
- Optimize performance

### Non-Code Contributions
- Improve documentation
- Create examples and tutorials
- Write blog posts about your experience
- Report bugs
- Suggest features
- Help others in Discussions

### Good First Issues

Look for issues tagged with [`good first issue`](https://github.com/Piotr1215/ai-coreutils/labels/good%20first%20issue). These are:
- Well-defined and scoped
- Suitable for newcomers
- Have clear acceptance criteria
- Include guidance on implementation

## Adding New Components

### Adding a New Slash Command

Slash commands are prompts that guide Claude to perform specific operations.

**Steps:**

1. **Create command file:**
```bash
commands/your-command.md
```

2. **Add frontmatter:**
```markdown
---
description: Brief description of what the command does
argument-hint: PATTERN [OPTIONS]
---
```

3. **Write the command prompt:**
   - Clear instructions for Claude
   - Output format specification
   - Examples
   - Edge case handling

4. **Test locally:**
```bash
claude /your-command test-input
```

5. **Add tests** (if applicable):
```bash
tests/your-command_test.bats
```

6. **Update documentation:**
   - Add to README.md
   - Add examples to examples/
   - Update CHANGELOG.md

**Example:** See [commands/extract.md](commands/extract.md)

### Adding a New Agent

Agents are pre-configured Claude instances with focused behavior.

**Steps:**

1. **Create agent file:**
```bash
agents/your-agent.md
```

2. **Add frontmatter:**
```markdown
---
name: your-agent
description: What the agent specializes in
tools:
  - Read
  - Write
  - Grep
model: claude-sonnet-4
---
```

3. **Write the agent prompt:**
   - Focused system instructions
   - Clear role definition
   - Output format
   - Tool usage guidelines

4. **Test locally:**
```bash
@your-agent perform some task
```

5. **Update documentation:**
   - Add to README.md
   - Add examples
   - Update CHANGELOG.md

**Example:** See [agents/doc-writer.md](agents/doc-writer.md)

### Adding a New Hook

Hooks are scripts triggered by Claude Code lifecycle events.

**Steps:**

1. **Create the script:**
```bash
scripts/your-hook.sh
```

2. **Make it executable:**
```bash
chmod +x scripts/your-hook.sh
```

3. **Update hooks configuration:**
```json
// hooks/hooks.json
{
  "hooks": {
    "EventName": [{
      "hooks": [{
        "type": "command",
        "command": "./scripts/your-hook.sh",
        "timeout": 5
      }]
    }]
  }
}
```

4. **Add tests:**
```bash
tests/your-hook_test.bats
```

5. **Test locally:**
   - Trigger the event that runs your hook
   - Verify expected behavior

6. **Update documentation:**
   - Add to README.md
   - Document hook behavior
   - Update CHANGELOG.md

**Example:** See [scripts/notify.sh](scripts/notify.sh)

### Adding an MCP Server

MCP servers extend Claude's capabilities with custom tools.

**Steps:**

1. **Create server directory:**
```bash
mcp-servers/your-server/
```

2. **Implement server:**
   - Follow [MCP specification](https://docs.claude.com/en/docs/model-context-protocol)
   - Implement required endpoints
   - Add error handling

3. **Add documentation:**
```bash
mcp-servers/your-server/README.md
```

4. **Test integration:**
```bash
# Test server startup
# Test tool calls
# Test error cases
```

5. **Update documentation:**
   - Add to README.md
   - Add usage examples
   - Update CHANGELOG.md

## Coding Standards

- **Unix philosophy**: Small, focused, composable
- **No thin wrappers**: Add semantic value
- **Generic utilities**: Not project-specific
- **Clear documentation**: Examples for everything
- **Cross-platform**: Test on Linux and macOS

## Testing

We take testing seriously! All contributions should include appropriate tests.

### Running Tests

**Validate plugin structure:**
```bash
bash scripts/validate_plugin.sh
```

This checks:
- JSON validity (plugin.json, hooks.json)
- Required fields present
- Executable permissions on scripts

**Run hook tests:**
```bash
bats tests/notify_test.bats
```

**Run all tests:**
```bash
bash scripts/validate_plugin.sh && bats tests/notify_test.bats
```

### Writing Tests

**For hooks** (using bats):
```bash
# tests/your-hook_test.bats
@test "hook executes successfully" {
  run ./scripts/your-hook.sh
  [ "$status" -eq 0 ]
}

@test "hook handles errors gracefully" {
  # Test error case
  run ./scripts/your-hook.sh invalid-input
  [ "$status" -eq 1 ]
}
```

**For commands/agents** (manual testing):
1. Test with valid inputs
2. Test with invalid inputs
3. Test edge cases
4. Verify output format
5. Check error messages

### Test Coverage Goals

- Hooks: Automated tests required (bats)
- Commands: Manual testing required, automated tests encouraged
- Agents: Manual testing required
- Documentation: Examples should be runnable

## Pull Request Process

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Make changes following coding standards
4. Test thoroughly
5. Update documentation (README, CHANGELOG)
6. Commit: `git commit -m 'feat: add amazing feature'`
7. Push: `git push origin feature/amazing-feature`
8. Open Pull Request with clear description

## Commit Message Format

```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
- `feat: add explain command`
- `fix: extract command handles binary files`
- `docs: update README with new examples`

## Community

### Getting Help

- **Questions**: Open a [Discussion](https://github.com/Piotr1215/ai-coreutils/discussions)
- **Bugs**: Create an [Issue](https://github.com/Piotr1215/ai-coreutils/issues/new?template=bug_report.yml)
- **Feature Ideas**: Submit a [Feature Request](https://github.com/Piotr1215/ai-coreutils/issues/new?template=feature_request.yml)

### Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code. Please report unacceptable behavior to piotr@cloudrumble.net.

### Recognition

Contributors are recognized in:
- GitHub contributors page
- CHANGELOG.md release notes
- Special thanks in release announcements

## Need Help?

**Stuck on something?** Don't hesitate to ask!

- Comment on the issue you're working on
- Open a Discussion
- Reach out in your Pull Request

We're here to help you succeed!

---

## Quick Reference

**Before submitting a PR:**
- [ ] Tests pass (`bash scripts/validate_plugin.sh`)
- [ ] Documentation updated (README, CHANGELOG)
- [ ] Code follows Unix philosophy
- [ ] Commit messages follow convention
- [ ] PR template filled out

**Commit message format:**
```
<type>: <description>

feat: add new command
fix: correct bug in agent
docs: update README
test: add tests for hook
```

---

Thank you for contributing to ai-coreutils!

Your contributions help make AI-assisted development better for everyone.
