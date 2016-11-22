#!/bin/bash

set -eux -o pipefail

# Set up Linux-specific configuration.
git config --global diff.tool meld
git config --global core.editor "emacs-snapshot -nw"
