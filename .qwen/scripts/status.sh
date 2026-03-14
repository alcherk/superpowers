#!/usr/bin/env bash
# Superpowers Status Script
# Shows current version and installation status

set -euo pipefail

REPO_DIR="$HOME/.qwen/superpowers"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Superpowers Status ===${NC}"
echo ""

# Repository info
if [ ! -d "$REPO_DIR" ]; then
    echo -e "${RED}Repository: NOT INSTALLED${NC}"
    echo "Run the installation script:"
    echo "  curl -fsSL https://raw.githubusercontent.com/alcherk/superpowers/refs/heads/qwen-code/.qwen/install.sh | bash"
    exit 1
fi

cd "$REPO_DIR"

echo -e "Repository: ${GREEN}$REPO_DIR${NC}"
echo -e "Branch: $(git branch --show-current)"
echo -e "Commit: $(git rev-parse --short HEAD)"
echo -e "Date: $(git log -1 --format=%ci)"
echo -e "Message: $(git log -1 --format=%s)"
echo ""

# Check for updates
echo -e "Remote: $(git remote get-url origin)"
git fetch origin --dry-run 2>/dev/null || true
BEHIND=$(git rev-list --count HEAD..origin/qwen-code 2>/dev/null || echo "0")
if [ "$BEHIND" -gt 0 ]; then
    echo -e "${YELLOW}⚠ You are $BEHIND commit(s) behind origin${NC}"
    echo -e "  Run ${BLUE}/superpowers update${NC} to update"
else
    echo -e "${GREEN}✓ Up to date${NC}"
fi
echo ""

# Hooks status
DISABLE_FILE="$HOME/.qwen/superpowers-disabled"
if [ -f "$DISABLE_FILE" ]; then
    echo -e "Hooks: ${YELLOW}DISABLED${NC}"
    echo -e "  Run ${BLUE}/superpowers enable${NC} to re-enable"
else
    echo -e "Hooks: ${GREEN}ENABLED${NC}"
fi
echo ""

# Skills symlink
SKILLS_LINK="$HOME/.qwen/skills/superpowers"
echo -e "Skills: $SKILLS_LINK"
if [ -L "$SKILLS_LINK" ]; then
    echo -e "  ${GREEN}✓ Symlink OK${NC} -> $(readlink "$SKILLS_LINK")"
else
    echo -e "  ${RED}✗ Not found or not a symlink${NC}"
fi
