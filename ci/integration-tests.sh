#!/bin/sh
set -eux

# Copy the contents of the repository to the notroot user's home directory, so we can build the go
# binary and run it without getting permission errors.
cp -R ./ /home/notroot/nix-config
chown -R notroot:notroot /home/notroot/nix-config
cd /home/notroot/nix-config

# Run the installation the first time.
./install

# Run the installation a second time so that we can uncover any strange failures that only occur
# after a previous installation has been run. We anticipate this to take significantly less time
# than the first installation.
./install
