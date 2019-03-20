#!/bin/bash
set -euxo pipefail

./bgrep/shared.sh
./nmap/shared.sh
./pyenv/shared.sh
./tmux/shared.sh
./zsh/shared.sh
