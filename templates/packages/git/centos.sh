#!/bin/bash
set -euxo pipefail

version="2.21.0"
if ! git --version | grep -q "${version}"; then
    mkdir /tmp/git
    pushd /tmp/git

    # curl-devel is required to support https URLs.
    sudo yum install -y curl-devel

    curl -Lo git.tgz "https://github.com/git/git/archive/v${version}.tar.gz"
    tar -xvf git.tgz
    cd "git-${version}"
    make configure
    ./configure
    make all
    sudo make install

    popd
fi
