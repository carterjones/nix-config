#!/bin/bash
set -euxo pipefail

# Ensure gnome is installed.
if ! apt list --installed 2>/dev/null | grep -q gnome-desktop; then
    exit 0
fi

# Ensure this is being run from a terminal with a DISPLAY variable that is set. I have no plans to
# support running this remotely.
if [[ -z "${DISPLAY:-}" ]]; then
    exit 0
fi

# Set up terminal settings.
PROFILE_PATH=/org/gnome/terminal/legacy/profiles:/
PROFILE=$(dconf list $PROFILE_PATH)
dconf write "${PROFILE_PATH}${PROFILE}scrollback-unlimited" true

# Set up workspaces
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 3
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 3
