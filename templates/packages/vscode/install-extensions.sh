#!/bin/bash
set -eux -o pipefail

while read -r in; do
    code --install-extension "$in"
done < ./extensions.txt
