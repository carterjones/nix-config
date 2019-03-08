#!/bin/bash
set -euxo pipefail

./nmap/shared.sh
./pyenv/shared.sh
./tmux/shared.sh
./zsh/shared.sh
