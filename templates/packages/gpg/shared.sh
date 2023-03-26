#!/usr/bin/env bash
set -eux -o pipefail

find "${HOME}/.gnupg" -type f -exec chmod 600 {} \;
find "${HOME}/.gnupg" -type d -exec chmod 700 {} \;
