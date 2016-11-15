#!/bin/bash

set -eux -o pipefail

# Set up Bash related files.
cp ${shared_files}/.bash_aliases $HOME/
cp ${shared_files}/.bash_completion $HOME/
cp ${shared_files}/.bash_prompt $HOME/
cp ${shared_files}/.bashrc $HOME/
cp ${shared_files}/.exports $HOME/
cp ${shared_files}/.emacs $HOME/
cp ${shared_files}/.gitconfig $HOME/
cp ${shared_files}/.git-completion $HOME/
cp ${shared_files}/.tmux.conf $HOME/
cp ${shared_files}/.venv_setup $HOME/

if [[ $(uname) == Linux ]]; then
    cp ${linux_files}/.nanorc $HOME/
elif [[ $(uname) == Darwin ]]; then
    cp ${macos_files}/.bash_profile $HOME/
    cp ${macos_files}/.nanorc $HOME/
fi
