#!/bin/bash

set -eux -o pipefail

# Set up config files.
mkdir -p $HOME/.config/xfce4/terminal
cp ${linux_files}~/.config/xfce4/terminal/terminalrc $HOME/.config/xfce4/terminal/terminalrc
