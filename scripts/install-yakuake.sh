#!/bin/bash

set -eux -o pipefail

# Install Yakuake.
sudo apt-get install -y yakuake

# Set up configurations.
mkdir -p ~/.kde/share/apps/konsole/
cp ./files/.kde/share/apps/konsole/Shell.profile \
	~/.kde/share/apps/konsole/
