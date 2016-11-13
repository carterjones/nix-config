#!/bin/bash

set -eux -o pipefail

# Install Yakuake.
sudo apt-get install -y yakuake

# Set up configurations.
mkdir -p $HOME/.kde/share/apps/konsole/
cp ${filespath}/.kde/share/apps/konsole/Shell.profile \
	$HOME/.kde/share/apps/konsole/
