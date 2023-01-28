#!/bin/bash
set -eux -o pipefail

target_version="go$(cat .go-version)"
current_version=$(/usr/local/go/bin/go version 2>&1 | cut -d" " -f3) || true

if [[ "${target_version}" == "${current_version}" ]]; then
    exit 0
fi

sudo mkdir -p /usr/local/go
sudo rm -rf /usr/local/go/*
cd /tmp

if [[ $(uname) == "Darwin" ]]; then
    type="amd64"
    if [[ $(uname -m) == 'arm64' ]]; then
        type="arm64"
    fi
    curl -o go.pkg "https://dl.google.com/go/${target_version}.darwin-${type}.pkg"
    sudo installer -pkg ./go.pkg -target /
elif [[ $(uname) == "Linux" ]]; then
    export platform="linux-amd64.tar.gz"
    curl -o go.tar.gz "https://dl.google.com/go/${target_version}.linux-amd64.tar.gz"
    sudo tar -C /usr/local/ -xvf ./go.tar.gz 1> /dev/null
else
    echo "unsupported platform. bye!"
    exit 1
fi

if [[ ! -d /usr/local/bin ]]; then
    sudo mkdir -p /usr/local/bin
fi

sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go

if grep -q Ubuntu /etc/lsb-release; then
    sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
    sudo update-alternatives --set go /usr/local/go/bin/go
fi
