#!/bin/bash
set -eux -o pipefail

pushd /tmp

wget -nc "https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb" -O vagrant.deb || true
sudo dpkg -i vagrant.deb

popd
