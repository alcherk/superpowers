#!/usr/bin/env bash
# Superpowers for Qwen Code - Installation Script
# Installs skills, hooks, and slash commands for automatic skill loading

set -euo pipefail

# Configuration
REPO_URL="https://github.com/alcherk/superpowers.git"
REPO_DIR="$HOME/.qwen/superpowers"
BRANCH="qwen-code"
HOOKS_DIR="$HOME/.qwen/hooks"
COMMANDS_DIR="$HOME/.qwen/commands"
SKILLS_DIR="$HOME/.qwen/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}✓${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed. Please install Git first:"
        echo "  brew install git"
        exit 1
    fi
    
    if ! command -v qwen &> /dev/null; then
        log_warning "Qwen Code command not found in PATH"
        echo "  Make sure Qwen Code is installed"
    fi
    
    log_info "Prerequisites check passed"
}

# Clone or update repository
clone_repo() {
    if [ -d "$REPO_DIR" ]; then
        log_info "Repository exists, updating..."
        cd "$REPO_DIR"
        git fetch origin "$BRANCH"
        git reset --hard "origin/$BRANCH"
        log_success "Repository updated"
    else
        log_info "Cloning Superpowers repository..."
        git clone --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"
        log_success "Repository cloned to $REPO_DIR"
    fi
}

# Create hooks directory and configuration
setup_hooks() {
    log_info "Setting up hooks..."
    
    # Create hooks directory
    mkdir -p "$HOOKS_DIR"
    
    # Create hooks.json
    cat > "$HOOKS_DIR/hooks.json" << 'EOF'
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
    
    log_success "Hooks configuration created"
}

# Create commands directory
setup_commands() {
    log_info "Setting up slash commands..."
    
    # Create commands directory if it doesn't exist
    mkdir -p "$COMMANDS_DIR"
    
    # Symlink command files from repo
    local cmds=("update" "status" "disable" "enable")
    for cmd in "${cmds[@]}"; do
        local src="$REPO_DIR/.qwen/commands/${cmd}.md"
        local dst="$COMMANDS_DIR/superpowers-${cmd}.md"
        if [ -f "$src" ]; then
            ln -sf "$src" "$dst"
        fi
    done
    
    log_success "Slash commands installed"
}

# Symlink scripts directory
setup_scripts() {
    log_info "Setting up scripts symlink..."
    
    # Create scripts symlink for slash commands to execute
    local scripts_link="$COMMANDS_DIR/superpowers-scripts"
    if [ -L "$scripts_link" ]; then
        unlink "$scripts_link"
    elif [ -d "$scripts_link" ]; then
        rm -rf "$scripts_link"
    fi
    ln -s "$REPO_DIR/.qwen/scripts" "$scripts_link"
    
    log_success "Scripts symlinked: $scripts_link"
}

# Create skills symlink
setup_skills() {
    log_info "Setting up skills..."
    
    # Create skills directory
    mkdir -p "$SKILLS_DIR"
    
    # Create symlink to superpowers skills
    local skills_link="$SKILLS_DIR/superpowers"
    if [ -L "$skills_link" ]; then
        unlink "$skills_link"
    elif [ -d "$skills_link" ]; then
        rm -rf "$skills_link"
    fi
    ln -s "$REPO_DIR/skills" "$skills_link"
    
    log_success "Skills installed: $skills_link -> $REPO_DIR/skills"
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    local errors=0
    
    # Check repository
    if [ ! -d "$REPO_DIR" ]; then
        log_error "Repository not found at $REPO_DIR"
        errors=$((errors + 1))
    fi
    
    # Check hooks.json
    if [ ! -f "$HOOKS_DIR/hooks.json" ]; then
        log_error "Hooks configuration not found"
        errors=$((errors + 1))
    fi
    
    # Check skills symlink
    if [ ! -L "$SKILLS_DIR/superpowers" ]; then
        log_error "Skills symlink not found"
        errors=$((errors + 1))
    fi
    
    # Check commands
    local cmd_count=$(ls -1 "$COMMANDS_DIR"/superpowers-*.md 2>/dev/null | wc -l)
    if [ "$cmd_count" -lt 4 ]; then
        log_warning "Some slash commands may be missing"
    fi
    
    # Check scripts symlink
    if [ ! -L "$COMMANDS_DIR/superpowers-scripts" ]; then
        log_warning "Scripts symlink not found"
    fi
    
    if [ $errors -eq 0 ]; then
        log_success "Installation verified successfully"
        return 0
    else
        log_error "Installation completed with $errors error(s)"
        return 1
    fi
}

# Print usage instructions
print_usage() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Superpowers for Qwen Code Installed!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo "Slash commands available:"
    echo "  /superpowers update   - Update to latest version"
    echo "  /superpowers status   - Show current version and status"
    echo "  /superpowers disable  - Temporarily disable hooks"
    echo "  /superpowers enable   - Re-enable hooks"
    echo ""
    echo "Skills location: $SKILLS_DIR/superpowers"
    echo "Repository: $REPO_DIR"
    echo ""
    echo "To update manually:"
    echo "  cd $REPO_DIR && git pull"
    echo ""
    echo "Start a new Qwen Code session to use Superpowers!"
    echo ""
}

# Main installation
main() {
    echo -e "${BLUE}Installing Superpowers for Qwen Code...${NC}"
    echo ""
    
    check_prerequisites
    clone_repo
    setup_hooks
    setup_commands
    setup_scripts
    setup_skills
    verify_installation
    print_usage
    
    log_success "Installation complete!"
}

main "$@"
