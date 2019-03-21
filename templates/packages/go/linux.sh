#!/bin/bash
set -euxo pipefail

target_version="go1.12"
current_version=$(/usr/local/go/bin/go version 2>&1 | cut -d" " -f3) || true

if [[ "${target_version}" != "${current_version}" ]]; then
    cd /tmp
    curl -o go.tar.gz "https://dl.google.com/go/${target_version}.linux-amd64.tar.gz"
    sudo mkdir -p /usr/local/go
    sudo rm -rf /usr/local/go/*
    sudo tar -C /usr/local/ -xvf /tmp/go.tar.gz 1> /dev/null
fi

sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go

if grep -q Ubuntu /etc/lsb-release; then
    update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
    update-alternatives --set go /usr/local/go/bin/go
fi
