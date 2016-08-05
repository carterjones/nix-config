#!/bin/bash

set -eux -o pipefail

# Check for Sublime, exit if it exists.
if [[ ! $(which subl &>/dev/null; echo $?) ]]; then

	# Install Sublime 3.
	wget "https://download.sublimetext.com/sublime-text_build-3114_amd64.deb" \
		-o /tmp/sublime.deb
	sudo dpkg -i /tmp/sublime.deb

fi

# Set up config files.
mkdir -p ~/.config/sublime-text-3/
cp -r .config/sublime-text-3/* ~/.config/sublime-text-3/
