#!/bin/bash
set -eux -o pipefail

sudo cp ./disable-ipv6.service /etc/systemd/system/disable-ipv6.service
sudo chown root:root /etc/systemd/system/disable-ipv6.service

[ -f /sbin/init ] || exit 0

# Make sure this isn't a docker container.
if [ -f /proc/1/cgroup ] && ! grep -q docker /proc/1/cgroup; then
    sudo systemctl enable disable-ipv6

    if ! sudo systemctl is-active --quiet disable-ipv6; then
        sudo systemctl start disable-ipv6
    fi
fi
