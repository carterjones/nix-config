#!/bin/bash

pushd $GOPATH

# Install govendor.
go get -u github.com/kardianos/govendor

# Install stuff for emacs golang integration.
go get -u github.com/golang/lint/golint
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports

popd
