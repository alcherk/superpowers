# /superpowers update

**Usage:** `/superpowers update`

**Purpose:** Update Superpowers skills to the latest version from the repository.

## What It Does

1. Navigates to the Superpowers repository at `~/.qwen/superpowers`
2. Pulls the latest changes from the `qwen-code` branch
3. Rebases local changes and stashes any modifications
4. Reports the update status

## Execution

Run this bash command:

```bash
~/.qwen/superpowers/.qwen/scripts/update.sh
```

## Expected Output

**Success:**
```
Already up to date.
```
or
```
Updating (2 commit(s) behind)...
✓ Updated successfully

Current version:
  Commit: a6ada22
  Date: 2026-03-14 12:50:12 +0300
  Message: Add Qwen Code support
```

**Failure:**
```
Error: Superpowers not installed
```

## After Update

Skills update instantly through the symlink. No restart required.

## Related Commands

- `/superpowers status` - Check current version
- `/superpowers disable` - Temporarily disable hooks
- `/superpowers enable` - Re-enable hooks
