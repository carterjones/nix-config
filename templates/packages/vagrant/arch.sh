#!/bin/bash
set -euxo pipefail

source ./vagrant/common.sh
export install_plugins
./vagrant/plugins.sh
