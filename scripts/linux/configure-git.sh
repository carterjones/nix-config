#!/bin/bash

set -euxo pipefail

# Set up Linux-specific configuration.
git config --global diff.tool meld
