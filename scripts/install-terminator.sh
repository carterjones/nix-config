#!/bin/bash

set -eux -o pipefail

# Install Terminator.
sudo apt-get install -y \
	terminator

# Set up config files.
mkdir -p $HOME/.config/terminator
cp ./files/.config/terminator/config $HOME/.config/terminator/config
