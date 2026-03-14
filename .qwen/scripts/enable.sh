#!/usr/bin/env bash
# Superpowers Enable Script
# Re-enables session-start hook

set -euo pipefail

DISABLE_FILE="$HOME/.qwen/superpowers-disabled"
GREEN='\033[0;32m'
NC='\033[0m'

if [ -f "$DISABLE_FILE" ]; then
    rm -f "$DISABLE_FILE"
    echo -e "${GREEN}✓ Superpowers hooks enabled${NC}"
else
    echo -e "${GREEN}Superpowers hooks already enabled${NC}"
fi
