#!/bin/bash
set -euxo pipefail

# Base software.
sudo apt-get install -y \
    ack-grep \
    apt-transport-https \
    build-essential \
    fontconfig \
    git-el \
    iproute2 \
    meld \
    nmap \
    tmux \
    unzip \
    whois \
    zsh

# Python dependencies.
sudo apt-get install -y \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    python-pip \
    python3-pip \
    zlib1g-dev

if [ -d /usr/share/xsessions/ ]; then
    if apt list --installed 2>/dev/null | grep gnome-desktop; then
        sudo apt-get install -y compizconfig-settings-manager
    fi
    sudo apt-get install -y \
        xfce4-terminal \
        yakuake
fi

./gnome/ubuntu.sh
./openvpn/ubuntu.sh
./packer/linux.sh
./vagrant/ubuntu.sh
