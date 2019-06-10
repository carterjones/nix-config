#!/bin/bash

latest_version=$(curl -s "https://www.vagrantup.com/downloads.html" | grep dmg | sed "s/.*vagrant_//;s/_x86_64.dmg.*//")
current_version=$(vagrant --version 2>&1 | cut -d" " -f2) || true
install_plugins="no"
export latest_version
export current_version
export install_plugins

