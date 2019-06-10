#!/bin/bash
set -euxo pipefail

# shellcheck disable=SC1091
source ./vagrant/common.sh
export install_plugins
./vagrant/plugins.sh
