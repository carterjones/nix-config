#!/bin/bash
set -eux -o pipefail

# Configure oh-my-zsh.
if [[ ! -d $HOME/src/github.com/robbyrussell/oh-my-zsh/ ]]; then
    # Clone the antigen repo if it is not yet cloned.
    mkdir -p $HOME/src/github.com/robbyrussell/
    pushd $HOME/src/github.com/robbyrussell/
    git clone https://github.com/robbyrussell/oh-my-zsh
else
    # Update the antigen repo if it is already cloned.
    pushd $HOME/src/github.com/robbyrussell/oh-my-zsh/
    git pull
fi

popd

# Configure antigen.
if [[ ! -d $HOME/src/github.com/zsh-users/antigen ]]; then
    # Clone the antigen repo if it is not yet cloned.
    mkdir -p $HOME/src/github.com/zsh-users/
    pushd $HOME/src/github.com/zsh-users/
    git clone https://github.com/zsh-users/antigen
else
    # Update the antigen repo if it is already cloned.
    pushd $HOME/src/github.com/zsh-users/antigen
    git pull
fi

popd
