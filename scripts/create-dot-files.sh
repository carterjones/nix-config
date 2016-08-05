#!/bin/bash

set -eux -o pipefail

# Set up bashrc related files.
cp ./.bashrc ~/.bashrc
cp ./.bash_aliases ~/.bash_aliases
cp ./.exports ~/.exports
