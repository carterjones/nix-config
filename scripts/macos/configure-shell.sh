#!/bin/bash
set -eux -o pipefail

# Set the default shell to zsh.
zsh_path=$(which zsh)
if [[ "${SHELL}" != "${zsh_path}" ]]; then
    chsh -s $zsh_path
fi
