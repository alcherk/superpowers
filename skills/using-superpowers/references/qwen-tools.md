# Qwen Code Tool Mapping

Skills use Claude Code tool names. When you encounter these in a skill, use your Qwen Code equivalent:

| Skill references | Qwen Code equivalent |
|-----------------|----------------------|
| `Read` (file reading) | `read_file` |
| `Write` (file creation) | `write_file` |
| `Edit` (file editing) | `edit` |
| `Bash` (run commands) | `run_shell_command` |
| `Grep` (search file content) | `grep_search` |
| `Glob` (search files by name) | `glob` |
| `TodoWrite` (task tracking) | `todo_write` |
| `Skill` tool (invoke a skill) | Load skill content via `read_file` from `~/.qwen/skills/` |
| `Task` tool (dispatch subagent) | `task` (general-purpose subagent) |
| `WebSearch` | `web_search` |
| `WebFetch` | `web_fetch` |
| `ListDirectory` | `list_directory` |

## Subagent Support

Qwen Code supports subagents via the `task` tool with `general-purpose` subagent type. Skills like `subagent-driven-development` and `dispatching-parallel-agents` work natively.

### Dispatching Subagents

```
Use the task tool to dispatch a subagent:
- description: Short task name
- subagent_type: "general-purpose"
- prompt: Detailed instructions for the subagent
```

### Example Usage

When a skill says:
```
Dispatch subagent with Task tool...
```

You do:
```
Use the `task` tool with:
- description: "Review spec compliance"
- subagent_type: "general-purpose"
- prompt: "Review the implementation against the spec document..."
```

## Skill Loading

Qwen Code loads skills from `~/.qwen/skills/`. When a skill is invoked:

1. Read the skill file from `~/.qwen/skills/<skill-name>/SKILL.md`
2. Follow the instructions in the skill
3. Use Qwen Code native tools for any actions

## Platform-Specific Notes

- **File operations**: Always use absolute paths with Qwen Code tools
- **Shell commands**: Use `run_shell_command` for all terminal operations
- **Task tracking**: Use `todo_write` to track progress through skill checklists
- **Subagents**: Provide clear, detailed prompts to subagents for best results
