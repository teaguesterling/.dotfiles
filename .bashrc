# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History behavior: ignore duplicates and lines starting with space
# ignoreboth = ignoredups + ignorespace
HISTCONTROL=ignoreboth

# Append to history file rather than overwrite (important for multiple sessions)
shopt -s histappend

# Avoid expanding directories to prevent \$PWD
shopt -s direxpand

# History size limits - in-memory vs on-disk
HISTSIZE=10000          # Commands to remember in current session
HISTFILESIZE=20000      # Commands to keep in history file

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    # Fallback prompt for non-color terminals (AUDIT CHANGE: added missing fallback)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable case-insensitive tab completion
bind "set completion-ignore-case on"

# Default text editor configuration (used by git, crontab, etc.)
export VISUAL=/usr/bin/vim      # Full-screen editor
export EDITOR="$VISUAL"         # Fallback editor (same as VISUAL)

# Development tools
_VCPKG=/home/teague/Dev/vcpkg
_SPACK=/home/teague/Dev/spack
_SPACK_SETUP="$_SPACK/share/spack/setup-env.sh"
function spackup() {
	source "$_SPACK_SETUP"
	[ ! -z "$1" ] && spack env activate "$1"
}

if [ -f $_VCPKG/scripts/buildsystems/vcpkg.cmake ] ; then
	export VCPKG_TOOLCHAIN_PATH=$_VCPKG/scripts/buildsystems/vcpkg.cmake
fi

# tmux settings
# Ensure terminal capabilities are preserved
#if [ -n "$TMUX" ]; then
#    export TERM=screen-256color
#fi

# Session-specific history for tmux (AUDIT CHANGE: replaced shared history with session-specific)
# Each tmux session gets its own history file, but panes within a session share history
if [[ -n "$TMUX" ]]; then
    TMUX_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
    if [[ -n "$TMUX_SESSION" ]]; then
        export HISTFILE="$HOME/.bash_history_tmux_$TMUX_SESSION"
        # Load existing history and save commands immediately
        export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -r"
    fi
else
    # Use default history file when not in tmux
    export HISTFILE="$HOME/.bash_history"
fi

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.dotfiles/bin" ] ; then
    export PATH="$HOME/.dotfiles/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then 
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Auto-attach to tmux (optional - uncomment if you want this)
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#    exec tmux new-session -As main
#fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.tmux-use.bashrc ]; then
    . ~/.tmux-use.bashrc
fi

if [ -f ~/.shq-init.bashrc ]; then
    . ~/.shq-init.bashrc
fi
