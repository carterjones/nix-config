#!/bin/bash
set -eux -o pipefail

# Note: this is *not* getting run as root.
if [[ $EUID -eq 0 ]]; then
    echo "Do not run this script as root."
    exit 1
fi

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

latest_3_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v dev | \
                       tail -1 | \
                       sed "s/.*3/3/")
pyenv install -s $latest_3_version
pyenv global $latest_3_version
