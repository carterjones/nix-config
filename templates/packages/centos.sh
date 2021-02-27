#!/bin/bash
set -eux -o pipefail

# Base packages.
sudo yum install -y \
    fontconfig \
    jq

# Python requirements.
sudo yum install -y \
    bzip2 \
    bzip2-devel \
    emacs \
    git \
    findutils \
    libffi-devel \
    libffi-devel \
    openssl-devel \
    readline-devel \
    sqlite \
    sqlite-devel \
    xz \
    xz-devel \
    zsh

sudo yum groupinstall -y "Development Tools"

source ./common.sh
install_pkg_for_env vscode centos
