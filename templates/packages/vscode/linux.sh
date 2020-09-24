#!/bin/bash
set -eux -o pipefail

mkdir -p "${HOME}/.config/Code/User/"
cp -R ./configs/* "${HOME}/.config/Code/User/"
