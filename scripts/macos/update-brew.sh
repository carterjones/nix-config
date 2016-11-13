#!/bin/bash

set -eux -o pipefail

# Upgrade all brew packages.
brew update
brew upgrade
brew cleanup
