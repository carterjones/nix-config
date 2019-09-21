#!/bin/bash
set -euxo pipefail

sudo cp ./fnmode.service /etc/systemd/system/fnmode.service
sudo chown root:root /etc/systemd/system/fnmode.service

[ -f /sbin/init ] || exit 0

if ! sudo systemctl is-active --quiet fnmode; then
    sudo systemctl start fnmode
fi

# TODO(carter): add `GRUB_CMDLINE_LINUX_DEFAULT="quiet hid_apple.fnmode=2"` to /etc/default/grub.cnf & run `grub-mkconfig -o /boot/grub/grub.cnf`
