#!/bin/bash
set -euxo pipefail

brew update
brew upgrade

brew install \
    git \
    go \
    jq \
    reattach-to-user-namespace \
    packer \
    pyenv \
    pyenv-virtualenvwrapper \
    the_silver_searcher \
    tmux \
    tree \
    vagrant-completion \
    wget \
    zsh

brew cask install \
    docker \
    emacs \
    vagrant \
    visual-studio-code

brew cleanup 1> /dev/null

./docker/mac.sh
./hack-font/mac.sh
./vscode/mac.sh
./xcode/mac.sh
