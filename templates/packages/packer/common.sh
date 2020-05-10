#!/bin/bash

latest_version=$(curl --silent "https://api.github.com/repos/hashicorp/packer/tags" | jq -r '.[] | .name' | sort -r | grep "^v" | head -1 | sed "s/v//")
export latest_version
