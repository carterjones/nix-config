#!/bin/bash

set -eux -o pipefail

# Configure brew.
brew tap homebrew/completions

# Install various brew packages.
brew install \
    ag \
    git \
    go \
    govendor \
    jq \
    packer \
    tree \
    vagrant-completion \
    wget
