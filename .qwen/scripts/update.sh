#!/usr/bin/env bash
# Superpowers Update Script
# Pulls latest changes from the repository

set -euo pipefail

REPO_DIR="$HOME/.qwen/superpowers"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Updating Superpowers...${NC}"
echo ""

if [ ! -d "$REPO_DIR" ]; then
    echo -e "${RED}Error: Superpowers not installed at $REPO_DIR${NC}"
    echo "Run the installation script first:"
    echo "  curl -fsSL https://raw.githubusercontent.com/alcherk/superpowers/refs/heads/qwen-code/.qwen/install.sh | bash"
    exit 1
fi

cd "$REPO_DIR"

# Fetch latest
echo "Fetching latest changes..."
git fetch origin qwen-code

# Check if we're behind
BEHIND=$(git rev-list --count HEAD..origin/qwen-code 2>/dev/null || echo "0")

if [ "$BEHIND" -eq 0 ]; then
    echo -e "${GREEN}✓ Already up to date${NC}"
else
    echo "Updating ($BEHIND commit(s) behind)..."
    git pull --rebase --autostash origin qwen-code
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Updated successfully${NC}"
        echo ""
        echo "Current version:"
        echo "  Commit: $(git rev-parse --short HEAD)"
        echo "  Date: $(git log -1 --format=%ci)"
        echo "  Message: $(git log -1 --format=%s)"
    else
        echo -e "${RED}✗ Update failed${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}Skills updated instantly through symlink${NC}"
