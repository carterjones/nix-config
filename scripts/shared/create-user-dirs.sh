#!/bin/bash

set -eux -o pipefail

# Create commonly used directories.
mkdir -p $HOME/bin
mkdir -p $HOME/src
mkdir -p $HOME/pkg # for golang

# Copy bin scripts.
cp -r ${shared_files}/bin/* $HOME/bin/

if [[ $(uname) == Linux ]]; then
    # Copy bin scripts.
    cp -r ${linux_files}/bin/* $HOME/bin/

    # Make symlinks.
    ln -fs $(which ack-grep) $HOME/bin/ag
elif [[ $(uname) == Darwin ]]; then
    # Reuse Vagrant install script for upgrades.
    cp ${macos_scripts}/install-vagrant.sh $HOME/bin/upgrade-vagrant
    chmod +x $HOME/bin/upgrade-vagrant
fi
