#!/bin/bash

set -euxo pipefail

# Set up the tmux plugins.
mkdir -p $CODE/github.com/tmux-plugins
pushd $CODE/github.com/tmux-plugins

# Clone the tmux-resurrect repo if it does not exist.
[ ! -d tmux-resurrect ] && git clone https://github.com/tmux-plugins/tmux-resurrect

# Update the tmux-resurrect repo.
cd $CODE/github.com/tmux-plugins/tmux-resurrect
git pull
