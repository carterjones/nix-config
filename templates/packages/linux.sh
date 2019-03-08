#!/bin/bash
set -euxo pipefail

./go/linux.sh
./hack-font/linux.sh
./vscode/linux.sh
