#!/bin/bash

latest_version=$(curl --silent "https://api.github.com/repos/hashicorp/vagrant/tags" | jq -r '.[] | .name' | sort -r | grep "^v" | head -1 | sed "s/v//")
current_version=$(vagrant --version 2>&1 | cut -d" " -f2) || true
install_plugins="no"
export latest_version
export current_version
export install_plugins

