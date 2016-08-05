#!/bin/bash

set -eux -o pipefail

# Set up terminal settings.
PROFILE_PATH=/org/gnome/terminal/legacy/profiles:/
PROFILE=$(dconf list $PROFILE_PATH)
dconf write ${PROFILE_PATH}${PROFILE}scrollback-unlimited true
