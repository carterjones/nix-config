#!/bin/bash

set -eux -o pipefail

# Set up bashrc related files.
cp ./files/.bash_aliases $HOME/
cp ./files/.bash_prompt $HOME/
cp ./files/.bashrc $HOME/
cp ./files/.exports $HOME/
cp ./files/.emacs $HOME/
cp ./files/.git-completion $HOME/
cp ./files/.gitconfig $HOME/
cp ./files/.nanorc $HOME/
cp ./files/.tmux.conf $HOME/
