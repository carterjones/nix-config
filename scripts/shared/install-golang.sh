#!/bin/bash
set -eux -o pipefail

if [[ $(uname) == Linux ]]; then
    archive_name="go1.7.5.linux-amd64.tar.gz"
elif [[ $(uname) == Darwin ]]; then
    archive_name="go1.7.5.darwin-amd64.pkg"
elif [[ $(uname) == MINGW* ]]; then
    exit
fi

golang_url="https://storage.googleapis.com/golang/${archive_name}"

pushd /tmp

wget -nc -q $golang_url

if [[ $(uname) == Linux ]]; then
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $archive_name
    sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
    sudo update-alternatives --set go /usr/local/go/bin/go
elif [[ $(uname) == Darwin ]]; then
    sudo installer -pkg $archive_name -target /
fi

popd
