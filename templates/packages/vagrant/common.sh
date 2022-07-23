#!/bin/bash

versions=$(curl --silent "https://releases.hashicorp.com/vagrant/")
latest_version=$(echo "${versions}" | grep '/vagrant/' | head -1 | sed 's,.*vagrant_,,;s,<.*,,')
current_version=$(vagrant --version 2>&1 | cut -d" " -f2) || true
install_plugins="no"
export latest_version
export current_version
export install_plugins
