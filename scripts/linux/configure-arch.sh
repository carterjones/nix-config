#!/bin/bash
set -euxo pipefail

sudo cp -r ${linux_files}/etc /

for svc in fnmode; do
    sudo systemctl enable "${svc}.service"
    sudo systemctl start "${svc}.service"
done
