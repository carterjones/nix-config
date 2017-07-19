#!/bin/bash
set -ex -o pipefail

pushd $GOPATH

set +u

# Check for a flag that can be set to avoid configuring go imports.
if [[ "$SKIP_GO_CONFIGURATION" != "true" ]]; then

    # Install govendor.
    go get -u github.com/kardianos/govendor

    # Install stuff for emacs golang integration.
    go get -u github.com/golang/lint/golint
    go get -u github.com/nsf/gocode
    go get -u golang.org/x/tools/cmd/goimports
    go get -u github.com/rogpeppe/godef

fi

popd

set -u
