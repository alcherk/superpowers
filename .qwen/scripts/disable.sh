#!/usr/bin/env bash
# Superpowers Disable Script
# Temporarily disables session-start hook

set -euo pipefail

DISABLE_FILE="$HOME/.qwen/superpowers-disabled"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -f "$DISABLE_FILE" ]; then
    echo -e "${YELLOW}Superpowers hooks already disabled${NC}"
else
    touch "$DISABLE_FILE"
    echo -e "${GREEN}✓ Superpowers hooks disabled${NC}"
    echo ""
    echo "Skills remain installed but session-start hook is inactive."
    echo "Run /superpowers enable to re-enable."
fi
