#!/bin/bash
set -eux -o pipefail

if ! command -v ramdisk; then
    # Due to https://github.com/golang/go/issues/29415, we have to trick go
    # into thinking that we are in a project in order to pin the version of the
    # repo we're using here.
    #
    # Instead of doing all that, I cloned the repo to avoid installing
    # potential breaking changes that the original author
    # (https://github.com/mroth) may make.
    go get github.com/carterjones/ramdisk/cmd/ramdisk@latest
    GOBIN="${HOME}/bin" go install github.com/carterjones/ramdisk/cmd/ramdisk@latest
fi
