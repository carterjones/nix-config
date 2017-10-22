#!/bin/bash
set -euxo pipefail

pushd /tmp

wget -nc "https://releases.hashicorp.com/packer/0.12.3/packer_0.12.3_linux_amd64.zip" -O packer.zip
unzip packer.zip
mv packer $HOME/bin/

popd
