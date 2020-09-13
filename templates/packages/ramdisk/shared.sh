#!/bin/bash
set -eux -o pipefail

if ! command -v ramdisk; then
    GOBIN="${HOME}/bin" go install github.com/mroth/ramdisk/cmd/ramdisk
fi
