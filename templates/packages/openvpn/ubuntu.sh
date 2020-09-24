#!/bin/bash
set -eux -o pipefail

if grep -q 16.04 /etc/lsb-release; then
    sudo apt-key add ./repo-public.gpg
    echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > openvpn.list
    sudo chown root:root openvpn.list
    sudo mv ./openvpn.list /etc/apt/sources.list.d/
    sudo apt-get update -y
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openvpn
