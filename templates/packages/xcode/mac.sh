#!/bin/bash
set -eux -o pipefail

if ! command -v make; then
    xcode-select --install &> /dev/null || true
fi
