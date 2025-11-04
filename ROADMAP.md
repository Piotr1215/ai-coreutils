# Roadmap

This roadmap outlines the future direction of ai-coreutils and highlights areas where contributions are welcome.

## Current Status: v0.1.0 (MVP)

**Core Components:**
- ✅ 3 Slash Commands: extract, summarize, compare
- ✅ 2 Agents: doc-writer, test-generator
- ✅ 1 Hook: notification-manager
- ✅ Basic test infrastructure
- ✅ CI/CD with GitHub Actions

## Short-term Goals (v0.2.0)

### New Slash Commands
Priority: High | Difficulty: Medium | Good for contributors

- [ ] `/refactor FILE [PATTERN]` - Suggest refactoring opportunities with semantic understanding
- [ ] `/explain CODE_SNIPPET` - Detailed code explanation with context
- [ ] `/find DESCRIPTION` - Semantic code search (find by what it does, not what it's called)
- [ ] `/deps FILE` - Analyze dependencies and suggest updates
- [ ] `/lint CODE [STYLE]` - Semantic linting beyond syntax

**🎯 Good First Issue**: Pick one command above and implement it!

### New Agents
Priority: Medium | Difficulty: Medium

- [ ] `@code-reviewer` - Automated code review with best practices
- [ ] `@security-scanner` - Security vulnerability detection
- [ ] `@performance-analyzer` - Performance bottleneck identification
- [ ] `@migration-helper` - Help migrate code between versions/frameworks

**🎯 Good First Issue**: Implement `@code-reviewer` agent

### Enhanced Testing
Priority: High | Difficulty: Low

- [ ] Add tests for slash commands (bats or similar)
- [ ] Add tests for agents (mock Claude interactions)
- [ ] Integration tests for hooks
- [ ] Increase coverage to >80%

**🎯 Good First Issue**: Add tests for `/extract` command

### Documentation
Priority: High | Difficulty: Low

- [ ] Video tutorials/demos
- [ ] More real-world examples
- [ ] Blog post series on Unix philosophy + AI
- [ ] Interactive playground/demo site

**🎯 Good First Issue**: Create video demo of core features

## Mid-term Goals (v0.3.0)

### MCP Servers
Priority: High | Difficulty: High

- [ ] **Git MCP Server** - Semantic git operations (commit message generation, PR summaries)
- [ ] **Docs MCP Server** - Maintain documentation consistency across projects
- [ ] **Testing MCP Server** - Test generation and coverage analysis
- [ ] **Architecture MCP Server** - System design analysis and suggestions

### Advanced Hooks
Priority: Medium | Difficulty: Medium

- [ ] `PreToolUse` hooks - Validate or modify tool calls before execution
- [ ] `OnError` hooks - Custom error handling and recovery
- [ ] `SessionStart` hooks - Project-specific initialization
- [ ] Hook composition - Chain multiple hooks together

### Command Chaining
Priority: Medium | Difficulty: High

- [ ] Pipe-like composition: `/extract TODO | /summarize`
- [ ] Output format standardization for chaining
- [ ] Context preservation across commands

### Cross-platform Support
Priority: Medium | Difficulty: Medium

- [ ] Windows support for hooks
- [ ] Platform-specific hook implementations
- [ ] Cross-platform testing

## Long-term Vision (v1.0.0+)

### Ecosystem
- [ ] Plugin marketplace integration
- [ ] Community-contributed commands/agents/hooks repository
- [ ] Plugin dependency management
- [ ] Versioned command/agent APIs

### Advanced Features
- [ ] Multi-repository operations
- [ ] Workspace-aware commands
- [ ] Session memory/context persistence
- [ ] Custom agent training/fine-tuning

### Integration
- [ ] IDE integrations (VS Code, JetBrains)
- [ ] CI/CD pipeline integrations
- [ ] Git hosting platform integrations (GitHub, GitLab)
- [ ] Project management tool integrations

### Performance
- [ ] Command output caching
- [ ] Incremental analysis for large codebases
- [ ] Parallel execution for independent operations
- [ ] Optimized prompt engineering

## How to Contribute

### For New Contributors

**Start Here:**
1. Pick a task marked with 🎯 **Good First Issue**
2. Read [CONTRIBUTING.md](CONTRIBUTING.md)
3. Comment on or create an issue before starting work
4. Ask questions in Discussions if unsure

**Easy Wins:**
- Add examples to `examples/` directory
- Write tests for existing commands
- Improve documentation with screenshots/examples
- Create video tutorials

### For Experienced Contributors

**High-Impact Areas:**
- Implement new MCP servers
- Build command chaining infrastructure
- Add comprehensive test coverage
- Create advanced agents

### For Domain Experts

**Specialized Areas:**
- Security experts: Build security-focused commands/agents
- DevOps experts: CI/CD integration and hooks
- Documentation experts: Improve docs, create tutorials
- UX experts: Improve command interfaces and output formats

## Feature Requests

Have an idea not listed here?

1. Check [existing issues](https://github.com/Piotr1215/ai-coreutils/issues)
2. Open a [Feature Request](https://github.com/Piotr1215/ai-coreutils/issues/new/choose)
3. Discuss in [GitHub Discussions](https://github.com/Piotr1215/ai-coreutils/discussions)

## Versioning Strategy

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.0.0): Breaking changes to command/agent interfaces
- **MINOR** (0.x.0): New features, commands, agents, hooks
- **PATCH** (0.0.x): Bug fixes, documentation, minor improvements

## Timeline

- **v0.2.0**: Q1 2025 (March 2025)
- **v0.3.0**: Q2 2025 (June 2025)
- **v1.0.0**: Q4 2025 (December 2025)

*Note: Timelines are approximate and depend on community contributions*

## Priorities

Our decision-making framework:

1. **Unix Philosophy Alignment** - Does it fit the core philosophy?
2. **Real-World Value** - Does it solve actual problems?
3. **Community Demand** - Is there demonstrated need?
4. **Maintainability** - Can we sustain it long-term?
5. **Composability** - Does it work well with existing components?

## Questions?

- **About the roadmap**: Open a Discussion
- **Want to work on something**: Comment on the relevant issue or create one
- **Stuck on implementation**: Ask in Discussions or the issue

---

**Last Updated**: November 2024

This roadmap is a living document and will be updated based on community feedback and project evolution.
