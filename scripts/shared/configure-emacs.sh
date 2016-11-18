#!/bin/bash

set -eux -o pipefail

dependency_path="${HOME}/.emacs.d/site-lisp"
mkdir -p $dependency_path

cp ${shared_files}/.emacs.d/site-lisp/* $dependency_path/
