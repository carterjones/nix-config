#!/bin/bash
set -euxo pipefail

sudo cp ./ipv6/disable-ipv6.service /etc/systemd/system/disable-ipv6.service
sudo chown root:root /etc/systemd/system/disable-ipv6.service

[ -f /sbin/init ] || exit 0

if ! $(systemctl is-active --quiet disable-ipv6); then
    sudo systemctl start disable-ipv6
fi
