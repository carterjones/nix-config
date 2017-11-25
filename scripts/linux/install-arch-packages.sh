#!/bin/bash
set -euxo pipefail

aur_packages=(
    dropbox
    google-chrome
    imagewriter
    pacaur
    slack-desktop
    spotify
    sslyze
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
     community/redis \
     community/redshift \
     community/sslscan \
     community/synergy \
     community/tmux \
     community/the_silver_searcher \
     community/vagrant \
     community/virtualbox \
     community/wine-mono \
     community/yakuake \
     community/winetricks \
     core/openssh \
     core/openvpn \
     extra/cmake \
     extra/dolphin \
     extra/emacs \
     extra/gimp \
     extra/hplip \
     extra/mesa \
     extra/mplayer \
     extra/networkmanager-openvpn \
     extra/nmap \
     extra/python-xdg \
     extra/samba \
     extra/spectacle \
     extra/wget \
     extra/xclip \
     extra/xdg-utils \
     multilib/lib32-gnutls \
     multilib/lib32-gtk2 \
     multilib/lib32-libldap \
     multilib/lib32-libpulse \
     multilib/lib32-libxtst \
     multilib/lib32-mesa \
     multilib/lib32-mpg123 \
     multilib/lib32-openal \
     multilib/wine \
     multilib/wine_gecko

# Wine section.
winetricks corefonts
