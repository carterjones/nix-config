#!/bin/bash
set -euxo pipefail

sudo modprobe hid_apple fnmode=2

sudo cp -r ${linux_files}/etc /

for svc in fnmode; do
    sudo systemctl enable "${svc}.service"
    sudo systemctl start "${svc}.service"
done
