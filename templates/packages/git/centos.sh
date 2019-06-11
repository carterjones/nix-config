#!/bin/bash
set -euxo pipefail

version="2.21.0"
if ! git --version | grep -q "${version}"; then
    # Install git.
    pushd /tmp
    curl -Lo git.tgz "https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/git/git-${version}.tar.gz"
    sudo tar -xf git.tgz -C /
    popd
fi
