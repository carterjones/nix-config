#!/bin/bash

set -eux -o pipefail

# Install nmap.
sudo apt-get install -y \
    nmap

# Set up nmap directories.
mkdir -p $HOME/.nmap/logs
