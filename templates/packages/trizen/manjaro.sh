#!/bin/bash
set -eux -o pipefail

if ! id -u notroot; then
    sudo useradd -m notroot
    echo 'notroot ALL = NOPASSWD: /usr/sbin/makepkg, /usr/sbin/pacman, /usr/sbin/trizen' | sudo EDITOR='tee -a' visudo
fi

if ! command -v trizen; then
    cd /tmp
    if [ ! -d trizen ]; then
        sudo -u notroot git clone https://aur.archlinux.org/trizen.git
    fi
    cd trizen

    # Observe: spaghetti + wall.
    sudo -u notroot makepkg -Ssif --noconfirm
    result=$(find . -path "*.gz" | tail -1)
    sudo pacman -U "${result}" || true
    sudo pacman -Syu
    sudo -u notroot makepkg -si --noconfirm
fi

for pkg in google-chrome imagewriter slack-desktop visual-studio-code-bin; do
    sudo -u notroot trizen -Syu --needed --noconfirm "${pkg}"
done
