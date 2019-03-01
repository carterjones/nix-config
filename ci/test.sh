#!/bin/bash
set -exo pipefail

# Change to the root directory.
cd $(git rev-parse --show-toplevel)

# If specified in the TASK environment variable, run shellcheck instead of
# performing a test installation.
if [[ "${TASK}" == "Shellcheck" ]]; then
  shellcheck install
  exit $?
fi

# Execute a test based on the OS environment variable.
case "${OS}" in
Arch)         docker run -v $(pwd):/nix-config carterjones/arch         /bin/bash -c "cd /nix-config && ./install";;
Manjaro)      docker run -v $(pwd):/nix-config carterjones/manjaro      /bin/bash -c "cd /nix-config && ./install";;
Ubuntu_16.04) docker run -v $(pwd):/nix-config carterjones/ubuntu-16.04 /bin/bash -c "cd /nix-config && ./install";;
Ubuntu_18.04) docker run -v $(pwd):/nix-config carterjones/ubuntu-18.04 /bin/bash -c "cd /nix-config && ./install";;
Mac_OS_X)     ./install;;
esac
