#!/bin/bash

set -eux -o pipefail

# Install the debs needed to run and develop go programs.
sudo apt-get install -y \
    golang

# Set up go folders.
mkdir -p $HOME/bin
mkdir -p $HOME/pkg
mkdir -p $HOME/src
