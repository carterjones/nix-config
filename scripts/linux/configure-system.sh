#!/bin/bash
set -euxo pipefail

# Run arch-specific customizations.
if (cat /etc/issue | grep -q "Arch"); then
    bash ${linux_scripts}/configure-arch.sh
fi

# Run Kali-specific customizations.
if (uname -r | grep -q "kali"); then
    bash ${linux_scripts}/configure-kali.sh
fi
