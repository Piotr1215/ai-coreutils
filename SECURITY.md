# Security Policy

## Supported Versions

We take security seriously and actively maintain the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We appreciate your efforts to responsibly disclose your findings and will make every effort to acknowledge your contributions.

### Where to Report

**Please DO NOT report security vulnerabilities through public GitHub issues.**

Instead, please report security vulnerabilities by email to:

**piotr@cloudrumble.net**

### What to Include

To help us better understand and resolve the issue, please include as much of the following information as possible:

- Type of issue (e.g., command injection, path traversal, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

### Response Timeline

- **Initial Response**: Within 48 hours
- **Detailed Response**: Within 7 days
- **Fix Timeline**: Varies based on complexity, but we aim for 30 days for critical issues

### What to Expect

1. **Acknowledgment**: We'll acknowledge receipt of your vulnerability report
2. **Assessment**: We'll assess the vulnerability and determine its severity
3. **Fix Development**: We'll work on a fix, which may involve requesting additional information
4. **Disclosure**: Once fixed, we'll:
   - Release a patch
   - Publish a security advisory
   - Credit you (unless you prefer to remain anonymous)

## Security Best Practices for Users

When using ai-coreutils:

1. **Keep Updated**: Always use the latest version
2. **Review Scripts**: Review hook scripts before enabling them
3. **Limit Permissions**: Use appropriate file permissions for hook scripts
4. **Validate Input**: Be cautious when using commands on untrusted code repositories
5. **Monitor Execution**: Review what commands and agents do, especially with sensitive data

## Security Considerations by Component

### Slash Commands
- Commands use Claude's built-in tools (Grep, Read, etc.)
- No direct shell execution from command prompts
- Output sanitization is Claude's responsibility

### Agents
- Agents have limited tool access as defined in their configuration
- Review agent tool permissions before use
- Agents operate within Claude's security sandbox

### Hooks
- Hooks execute shell scripts on your system
- **Review hook scripts before installation**
- Hooks run with your user permissions
- Keep hook scripts readable and minimal
- Avoid hooks that modify system files or execute untrusted code

### MCP Servers
- MCP servers run as separate processes
- Review MCP server code before installation
- Limit network access if possible
- Use trusted MCP server sources only

## Known Security Considerations

1. **Hook Execution**: Hooks execute arbitrary shell commands. Only install hooks from trusted sources.
2. **File Access**: Commands and agents can read files in your repository. Don't run on repositories with sensitive data without review.
3. **Claude Context**: Code content is sent to Claude's API. Follow Anthropic's terms of service regarding sensitive data.

## Responsible Disclosure

We follow a coordinated disclosure model:

1. Security researchers should give us reasonable time to fix issues before public disclosure
2. We'll keep reporters informed of our progress
3. We'll credit researchers in security advisories (unless they prefer anonymity)
4. We won't take legal action against researchers who follow this policy

## Security Updates

Security updates will be:
- Released as patch versions (e.g., 0.1.1)
- Documented in CHANGELOG.md
- Announced in GitHub Security Advisories
- Tagged with `security` label

## Questions?

For security-related questions that aren't vulnerabilities, you can:
- Open a discussion on GitHub Discussions
- Email piotr@cloudrumble.net with "Security Question" in the subject

Thank you for helping keep ai-coreutils and its users safe!
