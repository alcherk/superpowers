# /superpowers disable

**Usage:** `/superpowers disable`

**Purpose:** Temporarily disable Superpowers session-start hook without uninstalling.

## When to Use

- Debugging issues with skill loading
- Testing Qwen Code without Superpowers
- Temporarily want raw Qwen Code behavior
- Troubleshooting conflicts with other extensions

## What It Does

1. Creates a flag file at `~/.qwen/superpowers-disabled`
2. The session-start hook checks for this file and skips injection when present
3. Skills and repository remain installed

## Execution

Run this bash command:

```bash
~/.qwen/superpowers/.qwen/scripts/disable.sh
```

## Verification

Check if disabled:
```bash
if [ -f ~/.qwen/superpowers-disabled ]; then echo "DISABLED"; else echo "ENABLED"; fi
```

## Re-enabling

Use `/superpowers enable` to re-enable hooks.

## Related Commands

- `/superpowers enable` - Re-enable hooks
- `/superpowers status` - Check current status
- `/superpowers update` - Update skills
