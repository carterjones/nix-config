# Temporarily comment out setxkbmap command. For some reason, out of nowhere, it
# is now totally hanging whenever it is run from inside a shell on a Mac.
# TODO: try uncommenting this on or after February 2018
#if which setxkbmap &> /dev/null; then
#    if ! [ -z "${DISPLAY:-}" ]; then
#        setxkbmap -option altwin:ctrl_win \
#                  -option caps:ctrl_modifier
#    fi
#fi

if which localectl &> /dev/null; then
    if ! (localectl status | grep -q "VC Keymap: dvorak"); then
            echo "Changing system keyboard layout to dvorak..."
            sudo localectl set-keymap dvorak
    fi
fi

# We don't need flow control, because we're not working in Bell Labs.
stty stop ''

if [[ $- == *i* ]]; then
    if [[ -f $HOME/.use_zsh ]]; then
        # This is a horrible, but... elegant(?) hack to make zsh the default
        # shell in the event that a user does not exist in /etc/password (such
        # as in LDAP authenticated environments).
        export SHELL=/bin/zsh
        exec /bin/zsh -l
        exit
    fi
fi

source $HOME/.connect-ssh-agent

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set username on Windows
if [[ $(uname) == MINGW* ]]; then
    export USER=$USERNAME
fi

# Load exported settings.
source $HOME/.exports

# Stop processing if this is a non-interactive prompt.
set +u
[[ -z "$PS1" ]] && return
set -u

# Source external files.
source $HOME/.bash_aliases
source $HOME/.bash_completion
source $HOME/.bash_prompt

# Source any private settings not tracked in this repo.
if [ -f ~/.private ]; then
   source ~/.private
fi

source $HOME/.venv_setup
