#!/bin/bash

alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -alFh'
alias l='ls -CF'

# Nmap customizations.
alias nmap='nmap -oA $NMAP_LOGS/$(date +"%F-%I:%M:%S-%p") -vv'
