#!/bin/bash

set -euxo pipefail

# Compile bgrep.
gcc -O2 -x c -o ${linux_files}/bin/bgrep ./lib/bgrep/bgrep.c

# Move it to the user's bin folder.
mv ${linux_files}/bin/bgrep $HOME/bin/bgrep
chmod +x $HOME/bin/bgrep
