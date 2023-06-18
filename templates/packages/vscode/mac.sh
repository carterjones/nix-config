#!/bin/bash
set -eux -o pipefail

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    # Install Visual Studio Code from the Microsoft website rather than homebrew
    # since the update mechanism never seems to work correctly when trying to
    # update Visual Studio Code if it was installed using homebrew.
    pushd /tmp
    curl -Lo code.zip "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
    unzip -q code.zip
    mv "Visual Studio Code.app" /Applications/
    rm code.zip
    popd
fi

# Point "code" to Visual Studio Code. This is based on the resulting effect of
# running the "Shell Command: Install 'code' command in PATH" from within
# Visual Studio Code, which appears to just add a symlink to /usr/local/bin.
if [[ ! -f /usr/local/bin/code ]]; then
    sudo ln -nfs \
        /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code \
        /usr/local/bin/code
fi

# Configure extensions.
mkdir -p "${HOME}/Library/Application Support/Code/User/"
cp -R ./configs/* "${HOME}/Library/Application Support/Code/User/"
./install-extensions.sh
