#!/bin/bash

set -eux -o pipefail

# Update before any packages are installed.
sudo apt-get update

sudo apt-get install -y \
	build-essential
