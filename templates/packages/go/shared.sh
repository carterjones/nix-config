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

arch=$(uname -m)
if [[ "${arch}" == "aarch64" ]]; then
    arch="arm64"
elif [[ "${arch}" == "x86_64" ]]; then
    arch="amd64"
fi

platform=$(uname | tr "[:upper:]" "[:lower:]")
uri_base="https://dl.google.com/go/${target_version}.${platform}-${arch}"

if [[ $(uname) == "Darwin" ]]; then
    curl -o go.pkg "${uri_base}.pkg"
    sudo installer -pkg ./go.pkg -target /
elif [[ $(uname) == "Linux" ]]; then
    curl -o go.tar.gz "${uri_base}.tar.gz"
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
