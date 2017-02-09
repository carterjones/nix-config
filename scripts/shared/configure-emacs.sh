#!/bin/bash

set -eux -o pipefail

cp -R ${shared_files}/.emacs.d $HOME/
