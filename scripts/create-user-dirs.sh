#!/bin/bash

set -eux -o pipefail

# Create commonly used directories.
mkdir -p ~/bin
mkdir -p ~/code

# Copy bin scripts.
cp -r ./files/bin/* ~/bin/
ln -s `which ack-grep` ~/bin/ag
