#!/bin/bash
set -eux -o pipefail

sudo cp ./disable-ipv6.service /etc/systemd/system/disable-ipv6.service
sudo chown root:root /etc/systemd/system/disable-ipv6.service

# Exit the script if this is CI.
if [[ -n "${CI:-}" ]]; then
    exit 0
fi

sudo systemctl enable disable-ipv6

if ! sudo systemctl is-active --quiet disable-ipv6; then
    sudo systemctl start disable-ipv6
fi
