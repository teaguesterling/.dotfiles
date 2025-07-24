# Teague's Dotfiles

A cross-system configuration for essential development tools, optimized for tmux + vim workflow.

## 🚀 Quick Install

```bash
cd ~/.dotfiles
./install.sh
```

The install script will:
- Backup any existing config files with timestamp
- Create symlinks from `~/.dotfiles/` to your home directory  
- Provide clear feedback on what was installed

## 📁 What's Included

### Core Shell Configuration
- **`.bashrc`** - Enhanced bash config with session-specific history for tmux
- **`.bash_aliases`** - Custom command shortcuts and aliases
- **`.profile`** - Login shell environment variables

### Development Tools  
- **`.vimrc`** - Vim editor configuration optimized for tmux integration
- **`.tmux.conf`** - Tmux terminal multiplexer with Terminator-style keybindings
- **`.claude/`** - Claude Code AI assistant settings

## ✨ Key Features

### Tmux Configuration
- **Prefix**: `Ctrl-a` (screen-style, easier than default `Ctrl-b`)
- **Pane Navigation**: `Alt + Arrow Keys` (no prefix needed)
- **Pane Resizing**: `Ctrl + Alt + Arrow Keys` 
- **Quick Pane Switch**: `Alt + 1-4` for panes 1-4
- **Scrolling**: `Shift + Home/End/PageUp/PageDown`
- **Mouse Support**: Enabled with proper selection behavior
- **Session-Specific History**: Each tmux session maintains separate command history
- **Status Bar**: Hidden by default, `prefix + b` to show temporarily
- **Clipboard Integration**: Works with system clipboard

### Vim Configuration
- **Mouse Support**: Full mouse integration
- **Clipboard Integration**: Uses system clipboard (`+` register)
- **Search Enhancements**: Smart case, incremental search, highlighting
- **Performance Optimizations**: Fast update times, lazy redraw
- **Tmux Integration**: Cursor shape support, proper color handling

### Bash Enhancements
- **Session-Specific History**: Each tmux session gets its own `~/.bash_history_tmux_SESSION`
- **Large History**: 10K commands in memory, 20K on disk
- **Smart History**: Ignores duplicates and commands starting with space
- **Color Support**: Enhanced prompts and `ls` output
- **Vim as Default Editor**: For git commits, crontab, etc.

## 🔧 Requirements & Dependencies

### Essential
- **bash** - Shell configuration
- **tmux** - Terminal multiplexer  
- **vim** - Text editor
- **xclip** - System clipboard integration (Linux)

### Recommended Vim Plugins
Install [vim-plug](https://github.com/junegunn/vim-plug) first, then add to your vim config:

```vim
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'  " REQUIRED - seamless vim/tmux navigation
Plug 'tmux-plugins/vim-tmux'           " Optional - tmux syntax highlighting  
Plug 'roxma/vim-tmux-clipboard'        " Optional - enhanced clipboard
call plug#end()
```

Run `:PlugInstall` in vim to install.

## 🎯 Key Bindings Reference

### Tmux (prefix = `Ctrl-a`)
| Key | Action |
|-----|--------|
| `Alt + ←↑↓→` | Navigate panes |
| `Ctrl + Alt + ←↑↓→` | Resize panes |  
| `Alt + 1-4` | Jump to pane 1-4 |
| `Shift + Home/End` | Scroll to top/bottom |
| `Shift + PageUp/Down` | Page up/down |
| `prefix + e` | Split vertical |
| `prefix + o` | Split horizontal |
| `prefix + b` | Show status bar (3 sec) |
| `prefix + B` | Toggle status bar |
| `prefix + r` | Reload config |

### Vim
| Key | Action |
|-----|--------|
| `Alt + hjkl` | Navigate vim/tmux panes |
| `Ctrl-c` (visual) | Copy to clipboard |
| `y` (visual) | Copy to clipboard |
| `J/K` (visual) | Move selected lines |
| `leader + space` | Clear search highlight |

## 🔄 After Installation

1. **Reload configurations**:
   ```bash
   source ~/.bashrc
   tmux source ~/.tmux.conf
   ```

2. **Start a new tmux session**:
   ```bash
   tmux new-session -s work
   ```

3. **Install vim plugins** (if using recommendations above)

4. **Test key bindings** to ensure everything works

## 🛠 Customization

These dotfiles are designed to be practical and cross-system. Key design decisions:

- **Caps Lock → Escape**: Configs assume you've remapped caps lock to escape
- **Session Isolation**: Each tmux session has separate command history
- **Minimal Dependencies**: Uses standard tools available on most systems
- **Well Documented**: Every major setting has inline comments explaining purpose

## 📝 Notes

- **Backup Safety**: Install script automatically backs up existing files
- **Cross-System**: Designed to work on different Linux distributions  
- **Tmux Version**: Tested with tmux 3.0+ (uses modern syntax)
- **Terminal**: Works with most terminals, optimized for 256 colors

## 🐛 Troubleshooting

**Clipboard not working?**
- Install `xclip`: `sudo apt install xclip` (Ubuntu/Debian)
- Check tmux `set-clipboard on` is enabled

**Colors look wrong?**
- Ensure terminal supports 256 colors
- Check `$TERM` is set to `*-256color`

**Vim/tmux navigation not working?**
- Install `vim-tmux-navigator` plugin in vim
- Restart both vim and tmux

---

*These configurations have been battle-tested in daily development work. Enjoy! 🎉*