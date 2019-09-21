#!/bin/bash
set -euxo pipefail

sudo cp ./pacman.conf /etc/pacman.conf
sudo chown root:root /etc/pacman.conf
