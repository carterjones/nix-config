#!/bin/bash
set -eux -o pipefail

# Base software.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ack-grep \
    apt-transport-https \
    build-essential \
    fontconfig \
    iproute2 \
    jq \
    meld \
    nmap \
    tmux \
    unzip \
    whois \
    zsh

# Python dependencies.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    python3-pip \
    zlib1g-dev

if [ -d /usr/share/xsessions/ ]; then
    if apt list --installed 2>/dev/null | grep gnome-desktop; then
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y compizconfig-settings-manager
    fi
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
        xfce4-terminal \
        yakuake
fi

source ./common.sh
install_pkg_for_env docker ubuntu
install_pkg_for_env gnome ubuntu
install_pkg_for_env openvpn ubuntu
