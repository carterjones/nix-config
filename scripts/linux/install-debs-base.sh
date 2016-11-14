#!/bin/bash

set -eux -o pipefail

# Update before any packages are installed.
sudo apt-get update

# Base packages.
PACKAGES="build-essential"

# Useful utilities.
PACKAGES="${PACKAGES}
	ack-grep
	whois"

# golang packages.
PACKAGES="${PACKAGES}
	golang"

# Install the packages.
sudo apt-get install -y "${PACKAGES}"
