#!/bin/bash
set -ex -o pipefail

pushd $GOPATH

set +u

# Check for a flag that can be set to avoid configuring go imports.
if [[ "$SKIP_GO_CONFIGURATION" != "true" ]]; then

    # Install dep.
    go get -u github.com/golang/dep/cmd/dep

    # Install awsinfo utilities.
    go get -u github.com/carterjones/awsinfo/...

fi

popd

set -u
