#!/bin/bash

# ls aliases
alias ls='ls -G'
alias ll='ls -alFG'
alias la='ls -AG'
alias lh='ls -alFhG'
alias l='ls -CFG'

# grep aliases
alias grep='grep --color=auto -E'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Nmap customizations.
alias nmap='nmap -oA $NMAP_LOGS/$(date +"%F-%I:%M:%S-%p") -vv'
