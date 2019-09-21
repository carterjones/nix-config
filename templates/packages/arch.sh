#!/bin/bash
set -euxo pipefail

sudo pacman --noconfirm -Syu \
    autoconf \
    automake \
    binutils \
    bison \
    cmake \
    diffutils \
    docker \
    docker-compose \
    dolphin \
    emacs \
    fakeroot \
    file \
    flex \
    fontconfig \
    gawk \
    gc \
    gcc \
    gettext \
    gimp \
    groff \
    guile \
    hplip \
    libatomic_ops \
    libffi \
    libmpc \
    libtool \
    m4 \
    make \
    mesa \
    mpfr \
    mplayer \
    networkmanager-openvpn \
    nmap \
    nodejs \
    npm \
    openssh \
    openvpn \
    patch \
    pkgconf \
    python-xdg \
    redis \
    redshift \
    samba \
    spectacle \
    sslscan \
    synergy \
    tar \
    texinfo \
    the_silver_searcher \
    tmux \
    ufw \
    unzip \
    vagrant \
    virtualbox \
    wget \
    which \
    xclip \
    xdg-utils \
    yakuake \
    zsh

# shellcheck source=./templates/packages/common.sh
source ./common.sh
install_pkg_for_env docker arch
install_pkg_for_env docker arch
install_pkg_for_env fnmode arch
install_pkg_for_env packer linux
install_pkg_for_env pacman arch
install_pkg_for_env trizen arch
install_pkg_for_env vagrant arch
