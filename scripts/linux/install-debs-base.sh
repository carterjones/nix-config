#!/bin/bash

set -eux -o pipefail

# Set up apt repository for the latest version of tmux.
sudo add-apt-repository -y ppa:pi-rho/dev

# Set up apt repository for the latest version of emacs.
sudo add-apt-repository -y ppa:ubuntu-elisp

# Set up apt repository for the latest version of git.
sudo add-apt-repository -y ppa:git-core/ppa

# Update before any packages are installed.
sudo apt-get update

# Base packages.
PACKAGES="build-essential"

# Useful utilities.
PACKAGES="${PACKAGES}
    ack-grep
    emacs-snapshot
    git
    git-el
    meld
    python-pip
    python3-pip
    tmux
    whois"

# Install the packages.
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install ${PACKAGES}

# Remove unneeded packages.
sudo apt-get autoremove -y
