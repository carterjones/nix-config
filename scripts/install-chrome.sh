#!/bin/bash

set -eux -o pipefail

# Check for Chrome, move on if it exists.
if [[ ! $(which google-chrome &>/dev/null; echo $?) ]]; then

	# Install Chrome.
	wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
		-o /tmp/chrome.deb
	sudo dpkg -i /tmp/chrome.deb

fi
