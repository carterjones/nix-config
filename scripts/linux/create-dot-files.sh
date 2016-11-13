#!/bin/bash

set -eux -o pipefail

# Set up bashrc related files.
cp ${filespath}/.bash_aliases $HOME/
cp ${filespath}/.bash_prompt $HOME/
cp ${filespath}/.bashrc $HOME/
cp ${filespath}/.exports $HOME/
cp ${filespath}/.emacs $HOME/
cp ${filespath}/.git-completion $HOME/
cp ${filespath}/.gitconfig $HOME/
cp ${filespath}/.nanorc $HOME/
cp ${filespath}/.tmux.conf $HOME/
