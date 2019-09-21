#!/bin/bash
set -euxo pipefail

# shellcheck disable=SC1091
source ./common.sh
export install_plugins
./plugins.sh
