#!/bin/bash
set -eux -o pipefail

latest_3_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v dev | \
                       tail -1 | \
                       sed "s/.*3/3/")
pyenv install -s $latest_3_version
pyenv global $latest_3_version
