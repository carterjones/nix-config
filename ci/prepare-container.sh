#!/bin/sh
set -eux

# Copy the contents of the repository to the notroot user's home directory, so we can build the go
# binary and run it without getting permission errors.
cp -R ./ /home/notroot/nix-config
chown -R notroot:notroot /home/notroot/nix-config
cd /home/notroot/nix-config
