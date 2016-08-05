#!/bin/bash

set -eux -o pipefail

# Set up bashrc related files.
cp ./files/.bashrc ~/.bashrc
cp ./files/.bash_aliases ~/.bash_aliases
cp ./files/.exports ~/.exports
