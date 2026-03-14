# Superpowers for Qwen Code

Guide for installing and using Superpowers with Qwen Code.

## Quick Install

Copy the skills to your Qwen Code skills directory:

```bash
# Clone the repository
git clone https://github.com/obra/superpowers.git ~/.qwen/superpowers

# Create symlink to skills directory
ln -s ~/.qwen/superpowers/skills ~/.qwen/skills/superpowers
```

Or manually copy the skills:

```bash
# Create skills directory if it doesn't exist
mkdir -p ~/.qwen/skills

# Copy all skills
cp -r /path/to/superpowers/skills/* ~/.qwen/skills/
```

## How Skills Work

Skills are stored in `~/.qwen/skills/<skill-name>/SKILL.md`. When you want to use a skill:

1. **Announce**: "Using [skill-name] to [purpose]"
2. **Load**: Read the skill file with `read_file` tool
3. **Follow**: Execute the skill instructions exactly

## Tool Mapping

Superpowers skills use Claude Code tool names. Use these Qwen Code equivalents:

| Skill references | Qwen Code equivalent |
|-----------------|----------------------|
| `Read` | `read_file` |
| `Write` | `write_file` |
| `Edit` | `edit` |
| `Bash` | `run_shell_command` |
| `Grep` | `grep_search` |
| `Glob` | `glob` |
| `TodoWrite` | `todo_write` |
| `Task` (subagent) | `task` with `subagent_type: "general-purpose"` |
| `WebSearch` | `web_search` |
| `WebFetch` | `web_fetch` |
| `ListDirectory` | `list_directory` |

## Subagent Support

Qwen Code supports subagents via the `task` tool. Example:

```typescript
task({
  description: "Review spec compliance",
  subagent_type: "general-purpose",
  prompt: "Review the implementation against the spec document at..."
});
```

Skills like `subagent-driven-development` and `dispatching-parallel-agents` work natively with Qwen Code.

## Available Skills

### Core Workflow
- **brainstorming** - Design refinement before coding
- **writing-plans** - Implementation planning
- **subagent-driven-development** - Execute with subagents + review
- **finishing-a-development-branch** - Complete and merge work

### Quality
- **test-driven-development** - RED-GREEN-REFACTOR cycle
- **systematic-debugging** - Root cause analysis
- **verification-before-completion** - Ensure fixes work
- **requesting-code-review** - Pre-review checklist

### Collaboration
- **receiving-code-review** - Respond to feedback
- **using-git-worktrees** - Isolated branches
- **dispatching-parallel-agents** - Concurrent subagents

### Meta
- **writing-skills** - Create new skills
- **using-superpowers** - System introduction

## Usage Example

```
User: Help me add a new feature to my project

Assistant: I'll use the brainstorming skill to refine the design before we start coding.

[Uses read_file to load ~/.qwen/skills/brainstorming/SKILL.md]

Following the brainstorming skill, let me first understand your current project context...
```

## Updating Skills

To update to the latest version:

```bash
cd ~/.qwen/superpowers
git pull origin main
```

## Custom Skills

You can create your own skills in `~/.qwen/skills/my-custom-skill/SKILL.md`.

Follow the `writing-skills` skill for the proper methodology.

## Troubleshooting

**Skill not found:** Ensure the skill file exists at `~/.qwen/skills/<skill-name>/SKILL.md`

**Subagent not working:** Verify Qwen Code has the `task` tool available

**Server issues:** For brainstorming visual companion, ensure the server script is executable

## Support

- **Issues:** https://github.com/obra/superpowers/issues
- **Documentation:** https://github.com/obra/superpowers/tree/main/docs
