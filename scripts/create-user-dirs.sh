#!/bin/bash

set -eux -o pipefail

# Create commonly used directories.
mkdir -p $HOME/bin
mkdir -p $HOME/code

# Copy bin scripts.
cp -r ./files/bin/* $HOME/bin/

# Make symlinks.
ln -fs $(which ack-grep) $HOME/bin/ag
