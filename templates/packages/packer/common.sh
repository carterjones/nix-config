#!/bin/bash

latest_version=$(curl -s "https://packer.io/downloads.html" | grep darwin_amd64.zip | sed "s/.*packer_//;s/_darwin_amd64.*//")
export latest_version
