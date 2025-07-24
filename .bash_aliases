# ~/.bash_aliases - All aliases in one organized place

# -----------------------------------------------------------------------------
# Core utilities
# -----------------------------------------------------------------------------

# ls variations
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -ltr'              # Sort by date, newest last
alias lh='ls -lh'               # Human readable sizes
alias ldot='ls -ld .*'          # List only dotfiles

# grep variations
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rg='grep -r'              # Recursive grep

# Safety nets
alias rm='rm -i'                # Confirm before removing
alias cp='cp -i'                # Confirm before overwriting
alias mv='mv -i'                # Confirm before overwriting
alias ln='ln -i'                # Confirm before linking

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'               # Go to previous directory

# -----------------------------------------------------------------------------
# System utilities
# -----------------------------------------------------------------------------

# Quick system info
alias dfh='df -h'                # Human readable disk free
alias duh='du -h'                # Human readable disk usage
alias free='free -h'            # Human readable memory

# Process management
alias ps='ps auxf'              # Better process list
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'  # Search processes

# Misc utilities
alias h='history'
alias j='jobs -l'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'  # Print each PATH entry on new line
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# Alert for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# -----------------------------------------------------------------------------
# Development tools
# -----------------------------------------------------------------------------

# Your existing development aliases
alias o="xdg-open "
alias jqless="jq -C . | less -R"
alias claude="/home/teague/.claude/local/node_modules/.bin/claude"

# Spack aliases
alias sp="spack "
alias spa="spack env activate "
alias spd="spack env deactivate "
alias spl="spack location "
alias spcd="spack cd "
alias spackup="source $_SPACK_SETUP"

# Git shortcuts (add these if you use git)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# -----------------------------------------------------------------------------
# tmux aliases
# -----------------------------------------------------------------------------

# Session management
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'   # Detach others and attach
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Quick tmux
alias tmain='tmux attach -t main || tmux new -s main'
alias twork='tmux attach -t work || tmux new -s work'
alias tdev='tmux attach -t dev || tmux new -s dev'

# -----------------------------------------------------------------------------
# Alacritty specific
# -----------------------------------------------------------------------------

# Quick theme testing
alias atest='alacritty --config-file'
alias atheme='alacritty --print-events'  # Debug theme loading

# -----------------------------------------------------------------------------
# Useful functions as aliases
# -----------------------------------------------------------------------------

# Make directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract various archive types
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick backup of a file
backup() { cp "$1"{,.bak}; }

# Show all open ports
ports() { sudo lsof -i -P -n | grep LISTEN; }
