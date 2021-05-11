#!/bin/bash
set -x

export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Refresh the local list of python versions.
pyenv update 1> /dev/null

# Identify the latest Python version.
latest_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v "[a-zA-Z]" | \
                       tail -1 | \
                       sed "s/.* 3/3/")

# Make sure TLS gets installed.
if [[ $(uname) == "Darwin" ]]; then
    CFLAGS="-I$(brew --prefix openssl)/include"
    LDFLAGS="-L$(brew --prefix openssl)/lib"
    export CFLAGS
    export LDFLAGS
fi

# Install the latest Python version.
pyenv install -s "$latest_version" | grep -v "python-build: use.*from homebrew"

# Set the latest Python version as the global default.
pyenv global "$latest_version"

# Upgrade pyenv-virtualenvwrapper.
pip3 install --upgrade virtualenvwrapper 1> /dev/null

# Upgrade pip.
pip3 install --upgrade pip 1> /dev/null
