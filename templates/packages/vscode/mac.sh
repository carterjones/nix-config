#!/bin/bash
set -euxo pipefail

mkdir -p "${HOME}/Library/Application Support/Code/User/"
cp -R ./vscode/configs/* "${HOME}/Library/Application Support/Code/User/"
