#!/bin/bash
set -euxo pipefail

if [[ "${install_plugins}" != "yes" ]]; then
    exit 0
fi

vagrant plugin install vagrant-share
vagrant plugin install vagrant-s3auth
vagrant plugin install vagrant-vbguest
