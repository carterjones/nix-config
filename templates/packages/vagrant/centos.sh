#!/bin/bash
set -euxo pipefail

source ./vagrant/common.sh
export install_plugins

if [[ "${latest_version}" != "${current_version}" ]]; then
    yum -y install "https://releases.hashicorp.com/vagrant/${latest_version}/vagrant_${latest_version}_x86_64.rpm"
fi

./vagrant/plugins.sh
