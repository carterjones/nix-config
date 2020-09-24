#!/bin/bash
set -eux -o pipefail

cp -R ./bgrep /tmp/
gcc -O2 -x c -o /tmp/bgrep/bgrep /tmp/bgrep/bgrep.c
mv /tmp/bgrep/bgrep "$HOME/bin/bgrep"
rm -rf /tmp/bgrep
