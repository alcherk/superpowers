# /superpowers enable

**Usage:** `/superpowers enable`

**Purpose:** Re-enable Superpowers session-start hook after being disabled.

## What It Does

1. Removes the flag file at `~/.qwen/superpowers-disabled`
2. Session-start hook will resume injecting Superpowers context
3. Skills remain installed (no changes to repository)

## Execution

Run this bash command:

```bash
~/.qwen/superpowers/.qwen/scripts/enable.sh
```

## Verification

Check if enabled:
```bash
if [ -f ~/.qwen/superpowers-disabled ]; then echo "DISABLED"; else echo "ENABLED"; fi
```

Should output: `ENABLED`

## Related Commands

- `/superpowers disable` - Temporarily disable hooks
- `/superpowers status` - Check current status
- `/superpowers update` - Update skills
