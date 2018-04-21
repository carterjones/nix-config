{% if grains['os'] == 'MacOS' %}

Install brew software:
    pkg.installed:
        - pkgs:
            - emacs
            - git
            - jq
            - reattach-to-user-namespace
            - packer
            - pyenv
            - pyenv-virtualenvwrapper
            - the_silver_searcher
            - tmux
            - tree
            - vagrant-completion
            - wget
        - refresh: True

Clean up brew:
    cmd.run:
        - name: brew cleanup 1> /dev/null
        - runas: {{ salt['cmd.run']('logname') }}
        - stateful: True

{% elif grains['os'] == 'Ubuntu' %}

Install apt software:
    pkg.installed:
        - pkgs:
            # Base software
            - ack-grep
            - build-essential
            - git-el
            - meld
            - nmap
            - tmux
            - whois
            - zsh

            # Python
            - libbz2-dev
            - libreadline-dev
            - libsqlite3-dev
            - libssl-dev
            - python-pip
            - python3-pip
            - zlib1g-dev

            # GUI
{% if salt['cmd.run']('apt list --installed 2>/dev/null | grep gnome-desktop') %}
            - compizconfig-settings-manager
{% endif %}
            - xfce4-terminal
            - yakuake

{% if grains['lsb_distrib_release'] == '14.04' %}

emacs:
    pkgrepo.managed:
        - ppa: kelleyk/emacs
    pkg.latest:
        - name: emacs
        - refresh: True

{% elif grains['lsb_distrib_release'] == '16.04' %}

emacs:
    pkgrepo.managed:
        - ppa: kelleyk/emacs
    pkg.latest:
        - name: emacs25
        - refresh: True

Update emacs alternative:
    alternatives.set:
        - name: emacs
        - path: /usr/bin/emacs25

{% endif %}

git:
    pkgrepo.managed:
        - ppa: git-core/ppa
    pkg.latest:
        - name: git
        - refresh: True

skippy-xd:
    pkgrepo.managed:
        - ppa: landronimirc/skippy-xd-daily
    pkg.latest:
        - name: skippy-xd
        - refresh: True

tmux:
    pkgrepo.managed:
        - ppa: pi-rho/dev
    pkg.latest:
        - name: tmux
        - refresh: True

{% elif grains['os'] == 'Arch' %}

/etc/pacman.conf:
    file.managed:
        - source: salt://base-packages/pacman.conf

Install Arch software:
    pkg.installed:
        - pkgs:
            - cmake
            - docker
            - dolphin
            - emacs
            - gimp
            - hplip
            - lib32-gnutls
            - lib32-gtk2
            - lib32-libldap
            - lib32-libpulse
            - lib32-libxtst
            - lib32-mesa
            - lib32-mpg123
            - lib32-openal
            - mesa
            - mplayer
            - networkmanager-openvpn
            - nmap
            - nodejs
            - npm
            - openssh
            - openvpn
            - python-xdg
            - redis
            - redshift
            - samba
            - spectacle
            - sslscan
            - synergy
            - the_silver_searcher
            - tmux
            - ufw
            - vagrant
            - virtualbox
            - wget
            - wine
            - wine_gecko
            - wine-mono
            - winetricks
            - xclip
            - xdg-utils
            - yakuake
        - refresh: True

Install trizen:
    cmd.run:
        - name: |
            git clone https://aur.archlinux.org/trizen.git
            cd trizen
            makepkg -si --noconfirm
        - unless:
            - which trizen

Install AUR packages:
    cmd.run:
        - name: |
            aur_packages=(
                dropbox
                google-chrome
                imagewriter
                slack-desktop
                sslyze
                visual-studio-code-bin
            )
            trizen -Syu --needed --noconfirm "${aur_packages[@]}"
        - runas: {{ salt['user.current']() }}

{% elif grains['os'] == 'Kali' %}

Install Kali software:
    pkg.installed:
        - pkgs:
            - kali-defaults
            - kali-root-login
            - desktop-base
            - kde-plasma-desktop

{% endif %}
