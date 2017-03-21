#!/bin/bash

set -eux -o pipefail

# Set up apt repository for skippy-xd.
sudo add-apt-repository ppa:landronimirc/skippy-xd-daily

# Update before any packages are installed.
sudo apt-get update

# Base packages.
PACKAGES=""

# Terminator.
PACKAGES="${PACKAGES}
    xfce4-terminal"

# Nmap.
PACKAGES="${PACKAGES}
    nmap"

PACKAGES="${PACKAGES}
    skippy-xd"

# Yakuake.
PACKAGES="${PACKAGES}
    yakuake"

# Install the packages.
sudo apt-get install -y ${PACKAGES}
