#!/bin/bash
set -euo pipefail

# Update emacs config files.
echo "Copying: "
for dst in $(find files/shared/.emacs.d -type f); do
    shared_path=$(echo $dst | sed "s,files/shared/.emacs.d/,,")
    src="$HOME/.emacs.d/${shared_path}"
    echo "- $shared_path"
    cp $src $dst
done
echo "Done."
