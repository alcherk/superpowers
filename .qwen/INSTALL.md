# Superpowers for Qwen Code - Installation

Automated installation for Superpowers skills on Qwen Code (macOS).

## Quick Install

Run this one-liner in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/alcherk/superpowers/refs/heads/qwen-code/.qwen/install.sh | bash
```

This will:
1. Clone the Superpowers repository to `~/.qwen/superpowers`
2. Set up the session-start hook for automatic skill loading
3. Install slash commands (`/superpowers update`, `/superpowers status`, etc.)
4. Create skills symlink at `~/.qwen/skills/superpowers`

## What Gets Installed

| Component | Location | Purpose |
|-----------|----------|---------|
| Repository | `~/.qwen/superpowers` | Main codebase |
| Hooks | `~/.qwen/hooks/` | Session-start injection |
| Commands | `~/.qwen/commands/` | Slash commands |
| Skills | `~/.qwen/skills/superpowers` | Skill library (symlink) |

## Slash Commands

After installation, use these commands in Qwen Code:

| Command | Purpose |
|---------|---------|
| `/superpowers update` | Update to latest version |
| `/superpowers status` | Show current version and status |
| `/superpowers disable` | Temporarily disable hooks |
| `/superpowers enable` | Re-enable hooks |

## Usage

### Start a Session

Just start Qwen Code normally. The session-start hook will:
1. Inject Superpowers context automatically
2. Instruct Qwen to load the `using-superpowers` skill
3. Skills are ready to use

### Update Skills

When a new version is available:

```
/superpowers update
```

Or manually:

```bash
cd ~/.qwen/superpowers && git pull
```

### Check Status

```
/superpowers status
```

Shows current version, branch, and whether you're up to date.

### Disable/Enable

Temporarily disable Superpowers without uninstalling:

```
/superpowers disable
```

Re-enable later:

```
/superpowers enable
```

## Manual Installation

If you prefer not to use the install script:

### 1. Clone Repository

```bash
git clone --branch qwen-code https://github.com/alcherk/superpowers.git ~/.qwen/superpowers
```

### 2. Create Hooks Configuration

```bash
mkdir -p ~/.qwen/hooks
cat > ~/.qwen/hooks/hooks.json << 'EOF'
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "type": "command",
        "command": "$HOME/.qwen/superpowers/.qwen/hooks/session-start",
        "timeout": 8
      }
    ]
  }
}
EOF
```

### 3. Create Skills Symlink

```bash
mkdir -p ~/.qwen/skills
ln -s ~/.qwen/superpowers/skills ~/.qwen/skills/superpowers
```

### 4. Install Slash Commands

```bash
mkdir -p ~/.qwen/commands
ln -s ~/.qwen/superpowers/.qwen/commands/update.md ~/.qwen/commands/superpowers-update.md
ln -s ~/.qwen/superpowers/.qwen/commands/status.md ~/.qwen/commands/superpowers-status.md
ln -s ~/.qwen/superpowers/.qwen/commands/disable.md ~/.qwen/commands/superpowers-disable.md
ln -s ~/.qwen/superpowers/.qwen/commands/enable.md ~/.qwen/commands/superpowers-enable.md
```

## Uninstalling

```bash
# Remove repository
rm -rf ~/.qwen/superpowers

# Remove hooks
rm -rf ~/.qwen/hooks

# Remove skills symlink
rm -f ~/.qwen/skills/superpowers

# Remove slash commands
rm -f ~/.qwen/commands/superpowers-*.md

# Remove disable flag (if exists)
rm -f ~/.qwen/superpowers-disabled
```

## Troubleshooting

### Hooks not working

1. Check hooks.json exists: `cat ~/.qwen/hooks/hooks.json`
2. Check session-start is executable: `ls -la ~/.qwen/superpowers/.qwen/hooks/session-start`
3. Restart Qwen Code

### Skills not found

1. Check symlink: `ls -la ~/.qwen/skills/superpowers`
2. Should point to: `~/.qwen/superpowers/skills`

### Slash commands not working

1. Check commands exist: `ls ~/.qwen/commands/superpowers-*.md`
2. Check scripts symlink: `ls -la ~/.qwen/commands/superpowers-scripts`

## Support

- **Issues:** https://github.com/alcherk/superpowers/issues
- **Documentation:** https://github.com/alcherk/superpowers/tree/qwen-code
