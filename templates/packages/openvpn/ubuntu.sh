#!/bin/bash
set -eux -o pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openvpn
