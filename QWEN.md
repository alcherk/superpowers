# Superpowers - Project Context

## Project Overview

**Superpowers** is a comprehensive software development workflow system for AI coding agents (Claude Code, Cursor, Codex, Gemini CLI, OpenCode). It provides a composable library of "skills" that guide agents through disciplined development practices.

**Core Philosophy:**
- **Test-Driven Development** - Write tests first, always
- **Systematic over ad-hoc** - Process over guessing
- **Complexity reduction** - Simplicity as primary goal
- **Evidence over claims** - Verify before declaring success

**Key Innovation:** Skills activate automatically before tasks. Agents check for relevant skills and invoke them via the `Skill` tool before any response or action—even before asking clarifying questions.

## Architecture

```
superpowers/
├── skills/           # Core skill library (14 skills)
├── agents/           # Specialized agent prompts
├── commands/         # Command documentation
├── hooks/            # Session lifecycle hooks
├── tests/            # Integration test suites
├── docs/             # Platform-specific guides
└── .*/               # Platform configs (.claude-plugin, .codex, .opencode, .cursor-plugin)
```

### Skills Library

| Skill | Purpose |
|-------|---------|
| `brainstorming` | Socratic design refinement before coding |
| `test-driven-development` | RED-GREEN-REFACTOR cycle enforcement |
| `systematic-debugging` | 4-phase root cause analysis |
| `writing-plans` | Detailed implementation planning |
| `subagent-driven-development` | Parallel subagent workflows with two-stage review |
| `executing-plans` | Batch execution with human checkpoints |
| `dispatching-parallel-agents` | Concurrent subagent delegation |
| `requesting-code-review` | Pre-review checklist |
| `receiving-code-review` | Responding to feedback |
| `using-git-worktrees` | Isolated development branches |
| `finishing-a-development-branch` | Merge/PR decision workflow |
| `verification-before-completion` | Ensure fixes actually work |
| `writing-skills` | TDD for skill creation |
| `using-superpowers` | System introduction |

### Key Workflows

**Standard Development Flow:**
1. `brainstorming` → Design specification
2. `using-git-worktrees` → Isolated branch
3. `writing-plans` → Implementation tasks
4. `subagent-driven-development` → Execute with review
5. `finishing-a-development-branch` → Merge/PR

**Debugging Flow:**
1. `systematic-debugging` → Root cause analysis
2. `test-driven-development` → Fix with tests
3. `verification-before-completion` → Confirm fix

## Building and Running

### Installation (Platform-Specific)

**Claude Code (Official Marketplace):**
```bash
/plugin install superpowers@claude-plugins-official
```

**Claude Code (Dev Marketplace):**
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

**Cursor:**
```text
/add-plugin superpowers
```

**Codex:**
```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md
```

**Gemini CLI:**
```bash
gemini extensions install https://github.com/obra/superpowers
gemini extensions update superpowers  # To update
```

**OpenCode:**
```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.opencode/INSTALL.md
```

### Testing

Integration tests run real Claude Code sessions in headless mode:

```bash
cd tests/claude-code
./test-subagent-driven-development-integration.sh
```

**Requirements:**
- Claude Code installed as `claude` command
- Local dev marketplace enabled in `~/.claude/settings.json`
- Tests run from superpowers plugin directory

**Note:** Integration tests take 10-30 minutes (real subagent execution).

### Development

**Creating New Skills:**
1. Follow `skills/writing-skills/SKILL.md` methodology
2. Use TDD approach: baseline test → write skill → verify compliance
3. Test with pressure scenarios before deployment
4. Commit to git and push to fork

**Skill Structure:**
```
skills/skill-name/
  SKILL.md              # Main reference (required)
  scripts/              # Executable tools (if needed)
  references/           # Heavy API docs (if needed)
```

## Development Conventions

### Skill Writing

- **Name format:** lowercase with hyphens (`test-driven-development`)
- **Description:** Start with "Use when...", third-person, triggers only (no workflow summary)
- **TDD for skills:** Run baseline scenario WITHOUT skill first, document violations, write skill addressing them
- **Token efficiency:** Frequently-loaded skills <200 words, cross-reference instead of repeating

### Code Style

- **TypeScript/JavaScript** for examples (primary language)
- **One excellent example** beats multiple mediocre ones
- **Complete and runnable** examples with WHY comments
- **No generic templates** or fill-in-the-blank patterns

### Testing Practices

- **Integration tests** for complex workflows (subagent-driven-development)
- **Headless Claude Code** sessions with transcript verification
- **Token analysis** for context efficiency

### Git Workflow

- Skills live in flat namespace under `skills/`
- Each skill is self-contained when possible
- Platform configs in dot-directories (`.claude-plugin/`, `.codex/`, etc.)
- Version in `gemini-extension.json` and `.claude-plugin/marketplace.json`

## Key Files

| File | Purpose |
|------|---------|
| `README.md` | User-facing documentation, installation, workflow overview |
| `GEMINI.md` | Gemini CLI extension entry point, tool mappings |
| `gemini-extension.json` | Extension metadata (name, version, context file) |
| `skills/using-superpowers/SKILL.md` | Core system documentation, skill invocation rules |
| `skills/writing-skills/SKILL.md` | Skill creation methodology (TDD for documentation) |
| `hooks/session-start` | Injects using-superpowers into every session |
| `docs/README.codex.md` | Codex-specific installation and usage |
| `docs/README.opencode.md` | OpenCode-specific installation and usage |

## Version

Current: **v5.0.2** (2026-03-11)

**Recent changes:**
- Zero-dependency brainstorm server (removed node_modules)
- Auto-exit after 30 minutes idle
- Subagent context isolation
- Gemini CLI native extension support

## License

MIT License - see LICENSE file

## Support

- **Issues:** https://github.com/obra/superpowers/issues
- **Marketplace:** https://github.com/obra/superpowers-marketplace
- **Blog:** https://blog.fsck.com/2025/10/09/superpowers/
