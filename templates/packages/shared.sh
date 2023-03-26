#!/bin/bash
set -eux -o pipefail

source ./common.sh
install_pkg_for_env bgrep shared
install_pkg_for_env go shared
install_pkg_for_env gpg shared
install_pkg_for_env nmap shared
install_pkg_for_env pyenv shared
install_pkg_for_env ramdisk shared
install_pkg_for_env tmux shared
install_pkg_for_env zsh shared
