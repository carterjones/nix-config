#!/bin/bash
set -euxo pipefail

if grep -q 16.04 /etc/lsb-release; then
    cat ./openvpn/repo-public.gpg | sudo apt-key add -
    echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > openvpn.list
    sudo chown root:root openvpn.list
    sudo mv ./openvpn.list /etc/apt/sources.list.d/
    sudo apt-get update -y
fi

sudo apt-get install -y openvpn
