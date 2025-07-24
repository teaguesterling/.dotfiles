#!/bin/bash

# Dotfiles Installation Script
# Creates symlinks from ~/.dotfiles to home directory
# Backs up existing files with timestamp

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo -e "${BLUE}=== Dotfiles Installation ===${NC}"
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Home directory: $HOME"
echo ""

# Create backup directory if we need it
create_backup_dir() {
    if [[ ! -d "$BACKUP_DIR" ]]; then
        mkdir -p "$BACKUP_DIR"
        echo -e "${YELLOW}Created backup directory: $BACKUP_DIR${NC}"
    fi
}

# Backup and symlink a file
install_file() {
    local file="$1"
    local source="$DOTFILES_DIR/$file"
    local target="$HOME/$file"
    
    # Check if source exists
    if [[ ! -e "$source" ]]; then
        echo -e "${RED}Warning: $source does not exist, skipping${NC}"
        return
    fi
    
    # If target exists and is not already a symlink to our file
    if [[ -e "$target" ]] && [[ "$(readlink "$target" 2>/dev/null)" != "$source" ]]; then
        create_backup_dir
        echo -e "${YELLOW}Backing up existing $file${NC}"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    # Remove existing symlink if it exists
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓ Linked $file${NC}"
}

# Install directory (like .claude)
install_directory() {
    local dir="$1"
    local source="$DOTFILES_DIR/$dir"
    local target="$HOME/$dir"
    
    # Check if source exists
    if [[ ! -d "$source" ]]; then
        echo -e "${RED}Warning: $source does not exist, skipping${NC}"
        return
    fi
    
    # If target exists and is not already a symlink to our directory
    if [[ -e "$target" ]] && [[ "$(readlink "$target" 2>/dev/null)" != "$source" ]]; then
        create_backup_dir
        echo -e "${YELLOW}Backing up existing $dir${NC}"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    # Remove existing symlink if it exists
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓ Linked $dir${NC}"
}

# Main installation
echo "Installing dotfiles..."
echo ""

# Install individual files
install_file ".bashrc"
install_file ".vimrc"
install_file ".tmux.conf"
install_file ".bash_aliases"

# Install directories
install_directory ".claude"

echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"

# Show backup info if backups were created
if [[ -d "$BACKUP_DIR" ]]; then
    echo -e "${YELLOW}Original files backed up to: $BACKUP_DIR${NC}"
    echo "You can safely delete this backup directory once you've verified everything works."
else
    echo "No backups were needed - no existing files were found."
fi

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Reload your shell: source ~/.bashrc"
echo "2. Reload tmux config: tmux source ~/.tmux.conf"
echo "3. Restart vim to pick up new config"
echo ""
echo -e "${GREEN}Happy dotfiles! 🎉${NC}"