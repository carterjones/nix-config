#!/bin/bash
set -euxo pipefail

mkdir -p $HOME/.ssh
cp ${shared_files}/.ssh/rc $HOME/.ssh/
