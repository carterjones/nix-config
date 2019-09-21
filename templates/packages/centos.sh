#!/bin/bash
set -euxo pipefail

# Base packages.
sudo yum install -y \
    fontconfig

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

# shellcheck source=./templates/packages/common.sh
source ./common.sh
install_pkg_for_env emacs centos
install_pkg_for_env git centos
install_pkg_for_env packer centos
install_pkg_for_env vscode centos
install_pkg_for_env zsh centos
