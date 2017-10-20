#!/bin/bash
set -euxo pipefail

# Run arch-specific customizations.
if (cat /etc/issue | grep "Arch" -q); then
    bash ${linux_scripts}/configure-arch.sh
fi
