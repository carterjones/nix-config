#!/bin/bash
set -eux -o pipefail

export PATH="${HOME}/.cargo/bin:${PATH}"

# Update rustup and the stable toolchain, and make it the default.
rustup self update
rustup update stable
rustup default stable

# Install ifrextractor-rs, which pulls the setup forms out of UEFI images. It
# is not published on crates.io, so it comes from its repository.
cargo install --locked --git https://github.com/LongSoft/IFRExtractor-RS
