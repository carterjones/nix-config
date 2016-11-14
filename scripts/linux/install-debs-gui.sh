#!/bin/bash

set -eux -o pipefail

# Base packages.
PACKAGES=""

# Terminator.
PACKAGES="${PACKAGES}
    terminator"

# Nmap.
PACKAGES="${PACKAGES}
    nmap"

# Install the packages.
sudo apt-get install -y "${PACKAGES}"
