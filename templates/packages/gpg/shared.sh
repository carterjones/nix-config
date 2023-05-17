#!/usr/bin/env bash
set -eux -o pipefail

gpg_dir="${HOME}/.gnupg"

if [[ -d "${gpg_dir}" ]]; then
    find "${gpg_dir}" -type f -exec chmod 600 {} \;
    find "${gpg_dir}" -type d -exec chmod 700 {} \;
fi
