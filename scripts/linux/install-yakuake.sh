#!/bin/bash

set -euxo pipefail

# Set up configurations.
mkdir -p $HOME/.kde/share/apps/konsole/
cp ${linux_files}/.kde/share/apps/konsole/Shell.profile \
	$HOME/.kde/share/apps/konsole/
