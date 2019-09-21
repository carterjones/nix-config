#!/bin/bash
set -euxo pipefail

# Change to the root directory.
cd "$(git rev-parse --show-toplevel)"

# Run shellcheck against top level scripts.
shellcheck install
shellcheck update.sh

# Run shellcheck against all scripts that end with ".sh".
find . -path '*/*.sh' -type f -print0 | xargs -0 shellcheck -x

# Run shellcheck against all binfiles.
find . -path './templates/binfiles/*' -type f -print0 | xargs -0 shellcheck -x
