#!/bin/bash
set -euxo pipefail

if ! pgrep Docker; then
    nohup /Applications/Docker.app/Contents/MacOS/Docker > /dev/null & disown
fi
