#!/bin/bash

versions=$(curl --silent "https://releases.hashicorp.com/packer/")
latest_version=$(echo "${versions}" | grep '/packer/' | head -1 | sed 's,.*packer/,,' | cut -f1 -d '/')
export latest_version
