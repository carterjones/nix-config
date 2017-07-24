#!/bin/bash

set -eux -o pipefail

# Configure brew.
brew tap homebrew/completions

# Install various brew packages.
brew install \
     ag \
     emacs \
     git \
     jq \
     reattach-to-user-namespace \
     packer \
     pyenv \
     pyenv-virtualenvwrapper \
     tmux \
     tree \
     vagrant-completion \
     wget
