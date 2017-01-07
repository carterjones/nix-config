#!/bin/bash
set -eux -o pipefail

archive_name="go1.7.4.linux-amd64.tar.gz"
golang_url="https://storage.googleapis.com/golang/${archive_name}"

pushd /tmp

wget -q $golang_url
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf $archive_name
sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
sudo update-alternatives --set go /usr/local/go/bin/go

popd
