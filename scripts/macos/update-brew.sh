#!/bin/bash

set -euxo pipefail

# Upgrade all brew packages.
brew update
brew upgrade
brew cleanup
