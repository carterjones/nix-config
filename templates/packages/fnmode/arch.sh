#!/bin/bash
set -eux -o pipefail

sudo cp ./fnmode.service /etc/systemd/system/fnmode.service
sudo chown root:root /etc/systemd/system/fnmode.service

# Exit the script if this is CI.
if [[ -n "${CI}" ]]; then
    exit 0
fi

if ! sudo systemctl is-active --quiet fnmode; then
    sudo systemctl start fnmode
fi

# TODO(carter): add `GRUB_CMDLINE_LINUX_DEFAULT="quiet hid_apple.fnmode=2"` to /etc/default/grub.cnf & run `grub-mkconfig -o /boot/grub/grub.cnf`
