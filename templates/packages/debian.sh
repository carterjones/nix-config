#!/bin/bash
set -eux -o pipefail

# Base software.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ack-grep \
    apt-transport-https \
    build-essential \
    cool-retro-term \
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

source ./common.sh
