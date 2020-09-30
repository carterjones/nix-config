#!/bin/bash
set -eux -o pipefail

source ./common.sh
export install_plugins
./plugins.sh
