#!/bin/bash

set -eux -o pipefail

# Install the debs needed to run and develop go programs.
sudo apt-get install -y \
    golang

# Set up go folders.
mkdir -p ~/code/go/bin
mkdir -p ~/code/go/pkg
mkdir -p ~/code/go/src
