#!/bin/bash
set -euxo pipefail

# Remove the flag file for zsh so that the default bash shell is used.
rm -f $HOME/.use_zsh
