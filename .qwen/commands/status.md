# /superpowers status

**Usage:** `/superpowers status`

**Purpose:** Show current Superpowers version, branch, and installation status.

## What It Does

1. Checks the current git commit and branch
2. Shows the last commit date and message
3. Verifies hooks are enabled
4. Shows skills symlink status

## Execution

Run this bash command:

```bash
~/.qwen/superpowers/.qwen/scripts/status.sh
```

## Expected Output

```
=== Superpowers Status ===

Repository: ~/.qwen/superpowers
Branch: qwen-code
Commit: a6ada22
Date: 2026-03-14 12:50:12 +0300
Message: Add Qwen Code support

Remote: https://github.com/alcherk/superpowers.git
✓ Up to date

Hooks: ENABLED

Skills: ~/.qwen/skills/superpowers
  ✓ Symlink OK
```

## Related Commands

- `/superpowers update` - Update to latest version
- `/superpowers disable` - Temporarily disable hooks
- `/superpowers enable` - Re-enable hooks
