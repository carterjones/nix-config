#!/bin/bash

set -eux -o pipefail

# Set up Bash related files.
cp ${shared_files}/.bash_aliases $HOME/
cp ${shared_files}/.bash_completion $HOME/
cp ${shared_files}/.bash_prompt $HOME/
cp ${shared_files}/.bashrc $HOME/
cp ${shared_files}/.exports $HOME/
cp ${shared_files}/.emacs $HOME/
cp ${shared_files}/.git-completion $HOME/
cp ${shared_files}/.nanorc $HOME/
cp ${shared_files}/.tmux.conf $HOME/

if [[ $(uname) == Linux ]]; then
    cp ${linux_files}/.gitconfig $HOME/
elif [[ $(uname) == Darwin ]]; then
    cp ${macos_files}/.bash_profile $HOME/
fi
