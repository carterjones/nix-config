#!/bin/bash
set -eux -o pipefail

mkdir -p $HOME/.ssh
cp ${shared_files}/.ssh/rc $HOME/.ssh/
