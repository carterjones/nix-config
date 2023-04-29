#!/bin/bash
set -eux -o pipefail

if [ ! -f "${HOME}/Library/Fonts/Hack Regular Nerd Font Complete.ttf" ]; then
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font
fi
