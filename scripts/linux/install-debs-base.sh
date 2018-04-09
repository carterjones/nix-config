#!/bin/bash
set -euxo pipefail

# Set up special PPAs for Ubuntu.
if which lsb_release &>/dev/null && lsb_release -i | grep -q Ubuntu; then
    # Set up apt repository for the latest version of tmux.
    sudo add-apt-repository -y ppa:pi-rho/dev

    # Set up apt repository for the latest version of emacs.
    sudo add-apt-repository -y ppa:ubuntu-elisp

    # Set up apt repository for the latest version of git.
    sudo add-apt-repository -y ppa:git-core/ppa

    if cat /etc/lsb-release | grep 14.04 &> /dev/null; then
        # Set up apt repository for emacs25.
        sudo add-apt-repository -y ppa:kelleyk/emacs
    fi
fi

# Update before any packages are installed.
sudo apt-get update

# Base packages.
PACKAGES="build-essential"

# Useful utilities.
PACKAGES="${PACKAGES}
    ack-grep
    emacs
    git
    git-el
    meld
    tmux
    whois
    zsh"

# Python.
PACKAGES="${PACKAGES}
    libbz2-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    python-pip
    python3-pip
    zlib1g-dev"

if cat /etc/lsb-release | grep 14.04 &> /dev/null; then
    PACKAGES="${PACKAGES}
    emacs25"
fi

# Install the packages.
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install ${PACKAGES}

# Remove unneeded packages.
sudo apt-get autoremove -y
