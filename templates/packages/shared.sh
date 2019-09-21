#!/bin/bash
set -euxo pipefail

# shellcheck source=./templates/packages/common.sh
source ./common.sh
install_pkg_for_env bgrep shared
install_pkg_for_env nmap shared
install_pkg_for_env pyenv shared
install_pkg_for_env tmux shared
install_pkg_for_env zsh shared
