#!/bin/bash
set -x

export PATH="{{ salt['environ.get']('HOME') }}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Refresh the local list of python versions.
pyenv update 1> /dev/null

# Identify the latest Python version.
latest_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v [a-zA-Z] | \
                       tail -1 | \
                       sed "s/.* 3/3/")

# Install the latest Python version.
if [ $(uname) == Darwin ]; then
    # Mojave has issues with zlib, so we need this hack.
    # https://github.com/pyenv/pyenv/issues/1219#issuecomment-429331397
    export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
fi
pyenv install -s $latest_version | grep -v "python-build: use.*from homebrew"

# Set the latest Python version as the global default.
pyenv global $latest_version

# Upgrade pyenv-virtualenvwrapper.
pip3 install --upgrade virtualenvwrapper 1> /dev/null

# Upgrade pip.
pip3 install --upgrade pip 1> /dev/null
