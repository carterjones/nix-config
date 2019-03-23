#!/bin/bash
set -euxo pipefail

version="5.7.1"
if ! zsh --version | grep -q "${version}"; then
    # Install zsh.
    pushd /tmp
    curl -Lo zsh.tgz "https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/zsh/zsh-${version}.tar.gz"
    sudo tar -xf zsh.tgz -C /
    popd
fi
