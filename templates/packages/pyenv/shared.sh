#!/bin/bash
set -eux -o pipefail

mkdir -p "${HOME}/src/github.com/pyenv"
pushd "${HOME}/src/github.com/pyenv"
if [ ! -d "${HOME}/.pyenv" ]; then
    git clone https://github.com/pyenv/pyenv "${HOME}/.pyenv"
fi
cd "${HOME}/.pyenv"
git pull
popd

mkdir -p "${HOME}/.pyenv/plugins"
pushd "${HOME}/.pyenv/plugins"
if [ ! -d pyenv-virtualenvwrapper ]; then
    git clone https://github.com/yyuu/pyenv-virtualenvwrapper
fi
cd "${HOME}/.pyenv/plugins/pyenv-virtualenvwrapper"
git pull
popd

./pyenv/pyenv-installer
./update.sh
