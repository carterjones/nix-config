#!/bin/bash

set -eux -o pipefail

dependency_path="${HOME}/.emacs.d/"
mkdir -p $dependency_path

cp -R ${shared_files}/.emacs.d/ $dependency_path
