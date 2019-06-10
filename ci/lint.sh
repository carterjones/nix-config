#!/bin/bash
set -euxo pipefail

# Change to the root directory.
cd "$(git rev-parse --show-toplevel)"

# Run shellcheck against all scripts that end with ".sh".
find . -path '*/*.sh' -type f -print0 | xargs -0 shellcheck -x
