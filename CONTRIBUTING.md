# Contributing to dev-essentials

Thank you for your interest in contributing!

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/Piotr1215/claude-plugin-dev-essentials.git
cd claude-plugin-dev-essentials
```

2. Install locally for testing:
```bash
claude plugin install .
```

3. Test your changes:
```bash
# Validate plugin
claude plugin validate .

# Test commands
claude /extract TODO .
claude /summarize README.md

# Test agents
@doc-writer document a file
@test-generator suggest tests for a function
```

## Adding a New Command

1. Create `commands/your-command.md`
2. Include frontmatter (description, argument-hint, model, thinking)
3. Write clear command prompt with examples
4. Test locally
5. Update README.md with command documentation

## Adding a New Agent

1. Create `agents/your-agent.md`
2. Include frontmatter (name, description, tools, model)
3. Write focused system prompt
4. Define output format clearly
5. Test locally
6. Update README.md with agent documentation

## Adding a New Hook

1. Update `hooks/hooks.json` with hook configuration
2. Create script in `scripts/` directory
3. Make script executable (`chmod +x scripts/your-hook.sh`)
4. Test hook triggers correctly
5. Update README.md with hook documentation

## Coding Standards

- **Unix philosophy**: Small, focused, composable
- **No thin wrappers**: Add semantic value
- **Generic utilities**: Not project-specific
- **Clear documentation**: Examples for everything
- **Cross-platform**: Test on Linux and macOS

## Testing

Manual testing required for MVP:
1. `claude plugin validate .` passes
2. All commands work with test data
3. All agents produce quality output
4. Hooks trigger correctly

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

## Questions?

Open an issue or discussion on GitHub.

---

Thank you for contributing to dev-essentials!
