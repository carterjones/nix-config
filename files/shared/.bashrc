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

if [[ $(uname) == Linux* ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [[ $(uname) == Darwin* ]]; then
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi
