#!/bin/bash
set -eux -o pipefail

pushd /tmp

pip install --upgrade pip
sudo -H pip install virtualenv virtualenvwrapper

popd
