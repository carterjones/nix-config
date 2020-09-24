#!/bin/bash
set -eux -o pipefail

# shellcheck disable=SC1091
source ./common.sh
export install_plugins

if [[ "${latest_version:?}" != "${current_version:?}" ]]; then
    curl -o /tmp/vagrant_installer "https://releases.hashicorp.com/vagrant/${latest_version}/vagrant_${latest_version}_x86_64.deb"
    sudo dpkg -i /tmp/vagrant_installer
fi

./plugins.sh
