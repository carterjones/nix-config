#!/bin/bash

set -euxo pipefail

# Base packages.
PACKAGES=""

# Useful utilities.
PACKAGES="${PACKAGES}
	compizconfig-settings-manager"

# Install the packages.
sudo apt-get install -y ${PACKAGES}
