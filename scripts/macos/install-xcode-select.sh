#!/bin/bash
# Do not set defensive flags here, since it will error out if already installed.
set +e

xcode-select --install

set -e
