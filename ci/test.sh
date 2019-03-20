#!/bin/bash
set -euxo pipefail

# Change to the root directory.
cd $(git rev-parse --show-toplevel)

# Execute a test based on the OS environment variable.
case "${OS}" in
Arch)         docker run -v $(pwd):/nix-config carterjones/arch         /bin/bash -c "cd /nix-config && ./install && ./install" || exit 0;;
Manjaro)      docker run -v $(pwd):/nix-config carterjones/manjaro      /bin/bash -c "cd /nix-config && ./install && ./install" || exit 0;;
Ubuntu_16.04) docker run -v $(pwd):/nix-config carterjones/ubuntu-16.04 /bin/bash -c "cd /nix-config && ./install && ./install";;
Ubuntu_18.04) docker run -v $(pwd):/nix-config carterjones/ubuntu-18.04 /bin/bash -c "cd /nix-config && ./install && ./install";;
CentOS_7)     docker run -v $(pwd):/nix-config centos:7                 /bin/bash -c "cd /nix-config && ./install && ./install";;
Mac_OS_X)     ./install;;
esac
