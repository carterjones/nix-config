#!/bin/bash
set -euxo pipefail

mkdir -p "${HOME}/src/github.com/robbyrussell"
pushd "${HOME}/src/github.com/robbyrussell"
if [ ! -d oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh
fi
cd oh-my-zsh
git pull
popd

mkdir -p "${HOME}/src/github.com/zsh-users"
pushd "${HOME}/src/github.com/zsh-users"
if [ ! -d antigen ]; then
    git clone https://github.com/zsh-users/antigen
fi
cd antigen
git pull
popd
