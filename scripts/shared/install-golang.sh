#!/bin/bash
set -eux -o pipefail

target_version="go1.8"

# Test to see if go is installed in the PATH.
if which go &>/dev/null; then
    # See which version is installed.
    installed_version=$(go version | cut -d" " -f3)

    if [[ "$target_version" == "$installed_version" ]]; then
        # Exit if the target version matches the installed version.
        echo "Version $target_version of go is already installed."
        exit
    fi
fi

if [[ $(uname) == Linux ]]; then
    archive_name="${target_version}.linux-amd64.tar.gz"
elif [[ $(uname) == Darwin ]]; then
    archive_name="${target_version}.darwin-amd64.pkg"
elif [[ $(uname) == MINGW* ]]; then
    echo "Windows installations are not supported by this installer."
    exit
fi

golang_url="https://storage.googleapis.com/golang/${archive_name}"

pushd /tmp

wget -nc -q $golang_url

if [[ $(uname) == Linux ]]; then
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $archive_name
    if which update-alternatives; then
	sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
	sudo update-alternatives --set go /usr/local/go/bin/go
    fi
elif [[ $(uname) == Darwin ]]; then
    sudo installer -pkg $archive_name -target /
fi

popd
