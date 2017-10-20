#!/bin/bash
set -euxo pipefail

if cat /etc/issue | grep "Arch" -q; then
    bash ${linux_scripts}/install-arch-packages.sh
else
    bash ${linux_scripts}/install-debs-base.sh
fi
