#!/bin/bash

mkdir -p $HOME/src/aur.archlinux.org
pushd $HOME/src/aur.archlinux.org

aur_packages=(
    cower
    dropbox
    emacs-git
    google-chrome
    spotify
)

for package in "${aur_packages[@]}"; do
    echo $package
    if [ ! -d $package ]; then
	git clone "https://aur.archlinux.org/${package}.git"
        pushd $package
        makepkg -si
        popd
    fi
done

popd

# Look for updates to AUR packages.
cower -vdu

sudo pacman --needed -S \
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
     extra/networkmanager-openvpn \
     extra/wget \
     extra/xdg-utils \
     lib32-mesa \
     multilib/wine \
     multilib/wine_gecko \
     xf86-video-ati
