#!/bin/bash
set -euxo pipefail

# shellcheck source=./templates/packages/common.sh
source ./common.sh
install_pkg_for_env go linux
install_pkg_for_env hack-font linux
install_pkg_for_env ipv6 linux
install_pkg_for_env vscode linux
