#!/bin/bash
set -euxo pipefail

if ! emacs --version | grep -q 26.1.92; then
    # Install dependencies.
    sudo yum install -y \
        libtiff \
        libpng \
        giflib \
        libXpm \
        libXaw \
        gnutls

    # Install emacs.
    pushd /tmp
    curl -Lo emacs.tgz https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/emacs/emacs-26.1.92.tar.gz
    sudo tar -xf emacs.tgz -C /
    popd
fi
