#!/bin/bash
set -euxo pipefail

mkdir -p "${HOME}/src/github.com/tmux-plugins"
pushd "${HOME}/src/github.com/tmux-plugins"
if [ ! -d tmux-resurrect ]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect
fi
cd tmux-resurrect
git pull
popd
