#!/bin/bash
set -euxo pipefail

# shellcheck disable=SC1091
source ./common.sh
current_version=$("${HOME}/bin/packer.io" --version 2>&1 | cut -d" " -f2) || true

if [[ "${latest_version:?}" != "${current_version}" ]]; then
    cd /tmp
    curl -o packer.zip "https://releases.hashicorp.com/packer/${latest_version}/packer_${latest_version}_linux_amd64.zip"
    unzip -o packer.zip
    mkdir -p "$HOME/bin"
    mv packer "$HOME/bin/packer.io"
fi
