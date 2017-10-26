#!/bin/bash
set -euxo pipefail

sudo cp -r ${linux_files}/etc /

services=(
    docker
    fnmode
)

for svc in "${services[@]}"; do
    sudo systemctl enable "${svc}.service"
    sudo systemctl start "${svc}.service"
done
