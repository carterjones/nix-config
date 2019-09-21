#!/bin/bash
set -euxo pipefail

mkdir -p "${HOME}/Library/Application Support/Code/User/"
cp -R ./configs/* "${HOME}/Library/Application Support/Code/User/"
./install-extensions.sh
