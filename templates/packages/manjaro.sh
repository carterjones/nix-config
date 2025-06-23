#!/bin/bash
set -eux -o pipefail

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
    jq \
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
    virtualbox \
    wget \
    which \
    xclip \
    xdg-utils \
    yakuake \
    zsh

source ./common.sh
install_pkg_for_env docker manjaro
install_pkg_for_env fnmode manjaro
install_pkg_for_env pacman manjaro
install_pkg_for_env trizen manjaro
