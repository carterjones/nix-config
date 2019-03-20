#!/bin/bash
set -euxo pipefail

# Base packages.
sudo yum install -y \
    fontconfig \
    zsh

# Python requirements.
sudo yum install -y \
    bzip2 \
    bzip2-devel \
    findutils \
    libffi-devel \
    libffi-devel \
    openssl-devel \
    readline-devel \
    sqlite \
    sqlite-devel \
    xz \
    xz-devel

sudo yum groupinstall -y "Development Tools"

./emacs/centos.sh
./git/centos.sh
./packer/centos.sh
./vscode/centos.sh
