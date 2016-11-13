#!/bin/bash

set -eux -o pipefail

# Set up bashrc related files.
cp ${linux_files}/.bash_aliases $HOME/
cp ${linux_files}/.bash_prompt $HOME/
cp ${linux_files}/.bashrc $HOME/
cp ${linux_files}/.exports $HOME/
cp ${linux_files}/.emacs $HOME/
cp ${linux_files}/.git-completion $HOME/
cp ${linux_files}/.gitconfig $HOME/
cp ${linux_files}/.nanorc $HOME/
cp ${linux_files}/.tmux.conf $HOME/
