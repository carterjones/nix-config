#!/bin/bash
set -euxo pipefail

# Install prerequisite software.
sudo yum install -y \
    gnutls-devel \
    libjpeg-devel \
    libpng-devel \
    libtiff-devel \
    libungif-devel \
    libXaw-devel \
    texinfo

if ! emacs --version | grep -q 26.1.92; then
    mkdir /tmp/emacs
    pushd /tmp/emacs

    version="26.1.92"
    curl -Lo emacs.tgz "https://github.com/emacs-mirror/emacs/archive/emacs-${version}.tar.gz"
    tar -xvf emacs.tgz
    cd "emacs-emacs-${version}"
    make configure
    ./configure
    make
    sudo make install

    popd
fi
