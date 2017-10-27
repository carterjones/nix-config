#!/bin/bash
set -euxo pipefail

aur_packages=(
    dropbox
    google-chrome
    pacaur
    slack-desktop
    spotify
)

# Don't run pacaur if user is root.
if [[ "$UID" != 0 ]]; then
    # There is a bit of a catch 22 with this. dealwithit.jpg
    pacaur -Syu --needed "${aur_packages[@]}"
fi

# Install regular packages.
sudo pacman --needed -Syu \
     community/docker \
     community/nodejs \
     community/npm \
     community/redshift \
     community/synergy \
     community/tmux \
     community/the_silver_searcher \
     community/vagrant \
     community/virtualbox \
     community/virtualbox-host-modules-arch \
     community/wine-mono \
     community/yakuake \
     core/openssh \
     core/openvpn \
     extra/cmake \
     extra/dolphin \
     extra/emacs \
     extra/mplayer \
     extra/networkmanager-openvpn \
     extra/nmap \
     extra/python-xdg \
     extra/spectacle \
     extra/wget \
     extra/xclip \
     extra/xdg-utils \
     lib32-mesa \
     multilib/wine \
     multilib/wine_gecko \
     xf86-video-ati
