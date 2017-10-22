#!/bin/bash

set -euxo pipefail

# Create commonly used directories.
mkdir -p $HOME/bin
mkdir -p $HOME/src
mkdir -p $HOME/pkg # for golang

# Copy bin scripts.
cp -r ${shared_files}/bin/* $HOME/bin/

# Create a placeholder for the OS-specific files/scripts directories.
os_files=""
os_scripts=""

case $(uname) in
Linux)
    os_files=${linux_files}
    os_scripts=${linux_scripts}

    # Make symlinks.
    if ! (cat /etc/issue | grep "Arch" -q); then
        ln -fs $(which ack-grep) $HOME/bin/ag
    fi
    ;;
Darwin)
    os_files=${macos_files}
    os_scripts=${macos_scripts}
    ;;
esac

# Copy bin scripts.
cp -r ${os_files}/bin/* $HOME/bin/

# Reuse Vagrant install script for upgrades.
cp ${os_scripts}/install-vagrant.sh $HOME/bin/upgrade-vagrant
chmod +x $HOME/bin/upgrade-vagrant
