#!/bin/bash
set -euxo pipefail

mkdir -p "${HOME}/.config/Code/User/"
cp -R ./vscode/configs/* "${HOME}/.config/Code/User/"
./vscode/install-extensions.sh
