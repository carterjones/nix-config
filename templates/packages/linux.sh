#!/bin/bash
set -euxo pipefail

./go/linux.sh
./hack-font/linux.sh
./ipv6/linux.sh
./vscode/linux.sh
