#!/bin/bash

set -euxo pipefail

# Check for Sublime, move on if it exists.
if [[ $(which subl &>/dev/null; echo $?) -ne 0 ]]; then

	# Install Sublime 3.
	wget "https://download.sublimetext.com/sublime-text_build-3114_amd64.deb" \
		-O /tmp/sublime.deb
	sudo dpkg -i /tmp/sublime.deb

fi

# Set up config files.
mkdir -p $HOME/.config/sublime-text-3/
cp -r ${linux_files}/.config/sublime-text-3/* $HOME/.config/sublime-text-3/
