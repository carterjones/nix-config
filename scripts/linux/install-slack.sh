#!/bin/bash

set -eux -o pipefail

# Check for Slack, move on if it exists.
if [[ $(which slack &>/dev/null; echo $?) -ne 0 ]]; then

	# Install Slack.
	wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.0-amd64.deb" \
		-O /tmp/slack.deb
	sudo dpkg -i /tmp/slack.deb

fi
