#!/bin/bash
set -eux -o pipefail

# Note: this is *not* getting run as root.
if [[ $EUID -eq 0 ]]; then
    echo "Do not run this script as root."
    exit 1
fi

# Install pyenv.
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# Install/update the virtualenvwrapper plugin.
if [[ -d $HOME/.pyenv/plugins/pyenv-virtualenvwrapper ]]; then
    pushd $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
    git pull
    popd
else
    git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
fi

# Update the pyenv cache.
# Note: this sometimes results in a nonzero error code, even though it is not a
# total failure. We accept this and move on.
set +e
pyenv update
set -e

# Install the latest non-labeled version.
latest_3_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v [a-zA-Z] \
                       tail -1 | \
                       sed "s/.*3/3/")
pyenv install -s $latest_3_version
pyenv global $latest_3_version
