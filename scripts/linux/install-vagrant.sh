#!/bin/bash
set -euxo pipefail

pushd /tmp

# Don't run this on Arch, since it automatically handles this via pacman.
if ! (cat /etc/issue | grep -E "(Arch|Manjaro)" -q); then
    wget -nc "https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb" -O vagrant.deb || true
    sudo dpkg -i vagrant.deb
fi

popd
