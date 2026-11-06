#!/bin/bash
set -eux -o pipefail

# Install rustup, the official Rust toolchain manager. The profile and PATH
# are handled here and in .exports, so the installer is told not to edit any
# shell startup files.
if [ ! -x "${HOME}/.cargo/bin/rustup" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- -y --no-modify-path --default-toolchain stable
fi

export PATH="${HOME}/.cargo/bin:${PATH}"

./update.sh
