#!/bin/bash

set -eux -o pipefail

# Install the debs needed to run and develop go programs.
sudo apt-get install -y \
    whois
