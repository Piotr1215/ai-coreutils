# Changelog

All notable changes to ai-coreutils will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-10-11

### Added

**Commands:**
- `/extract` - Pattern extraction with semantic context and priority analysis
- `/summarize` - File summarization with language-specific understanding
- `/compare` - Semantic file comparison with risk assessment

**Agents:**
- `@doc-writer` - Technical documentation specialist (API docs, READMEs)
- `@test-generator` - Test case generation expert (comprehensive test suites)

**Hooks:**
- `notification-manager` - Task completion notifications (tmux-aware, cross-platform)

**Infrastructure:**
- Initial plugin structure and metadata
- README with installation instructions and examples
- CHANGELOG for version tracking
- LICENSE (MIT)
- Cross-platform support (Linux, macOS)

### Notes

- MVP release (Phase 1 of roadmap)
- Tested on Linux (Ubuntu 22.04) and macOS (Sonoma)
- Performance: Commands <30s, agents <90s, hook <3s
- Zero external service dependencies

---

## [Unreleased]

### Planned for 0.2.0

**Commands:**
- `/explain` - Versatile code explanation
- `/trace-deps` - Dependency tracing
- `/suggest-tests` - Test case suggestions

**Agents:**
- `@security-reviewer` - Security vulnerability analysis
- `@refactorer` - Refactoring suggestions

**Hooks:**
- `session-init` - Project-aware session initialization
