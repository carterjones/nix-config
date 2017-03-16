#!/bin/bash
set -eux -o pipefail

# Check for a flag that can be set to avoid configuring go imports.
if [[ "$SKIP_GO_CONFIGURATION" != "true" ]]; then
    pushd $GOPATH

    # Install govendor.
    go get -u github.com/kardianos/govendor

    # Install stuff for emacs golang integration.
    go get -u github.com/golang/lint/golint
    go get -u github.com/nsf/gocode
    go get -u golang.org/x/tools/cmd/goimports

    popd
fi
