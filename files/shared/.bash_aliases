#!/bin/bash

# bash aliases
alias b='source ~/.bashrc'

# emacs alias
alias e='emacs -nw'

# git aliases
alias ghist='git hist'
alias gprune='git remote prune origin'

# grep aliases
alias grep='grep --color=auto -E'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ls='ls -G'
alias ll='ls -alFG'
alias la='ls -AG'
alias lh='ls -alFhG'
alias l='ls -CFG'

# tmux aliases
alias t='tmux a'
alias tk='tmux kill-server'

# OS-specific aliases
if [[ $(uname) == Linux ]]; then
    # overwrite the emacs alias
    alias e='emacs-snapshot -nw'

    # nmap aliases
    alias nmap='nmap -oA $NMAP_LOGS/$(date +"%F-%I:%M:%S-%p") -vv'
fi
