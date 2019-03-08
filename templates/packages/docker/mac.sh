#!/bin/bash
set -euxo pipefail

if ! $(ps -A | grep -q '[/]Applications/Docker.app/Contents/MacOS/Docker'); then
    nohup /Applications/Docker.app/Contents/MacOS/Docker > /dev/null & disown
fi
