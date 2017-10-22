#!/bin/bash

set -euxo pipefail

# Set up config files.
mkdir -p $HOME/.config/terminator
cp ${linux_files}/.config/terminator/config $HOME/.config/terminator/config
