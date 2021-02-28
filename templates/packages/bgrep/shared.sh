#!/bin/bash
set -eux -o pipefail

curl -L 'https://github.com/tmbinc/bgrep/raw/master/bgrep.c' | gcc -O2 -x c -o /tmp/bgrep -
mv /tmp/bgrep "$HOME/bin/bgrep"
