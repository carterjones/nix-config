#!/bin/bash
set -eux -o pipefail

if [ ! -f "${HOME}/Library/Fonts/Hack Regular Nerd Font Complete.ttf" ]; then
    brew install font-hack-nerd-font
fi
