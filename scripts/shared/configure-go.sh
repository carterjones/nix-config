#!/bin/bash

pushd $GOPATH

# Install govendor.
go get -u github.com/kardianos/govendor

popd
