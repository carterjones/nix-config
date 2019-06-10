#!/bin/bash
set -euxo pipefail

cp -R ./bgrep/bgrep /tmp/
gcc -O2 -x c -o /tmp/bgrep/bgrep /tmp/bgrep/bgrep.c
mv /tmp/bgrep/bgrep "$HOME/bin/bgrep"
rm -rf /tmp/bgrep
