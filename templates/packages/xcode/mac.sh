#!/bin/bash
set -euxo pipefail

if ! command -v make; then
    xcode-select --install &> /dev/null || true
fi
