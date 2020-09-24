#!/bin/bash
set -eux -o pipefail

# shellcheck disable=SC1091
source ./common.sh
export install_plugins
./plugins.sh
