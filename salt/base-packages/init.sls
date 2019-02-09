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
        - name: /usr/local/bin/brew cleanup 1> /dev/null
        - runas: {{ salt['cmd.run']('logname') }}
        - stateful: True

{% elif grains['os'] == 'Ubuntu' %}

{% if grains['osrelease'] == '14.04' %}

git-ppa:
    pkgrepo.managed:
        - humanname: Git
        - name: deb http://ppa.launchpad.net/git-core/ppa/ubuntu {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/git.list
        - gpgcheck: 1
        - keyid: E1DD270288B4E6030699E45FA1715D88E1DF1F24
        - keyserver: keyserver.ubuntu.com
    pkg.latest:
        - name: git
        - refresh: True

skippy-xd-daily-ppa:
    pkgrepo.managed:
        - humanname: Skippy XD
        - name: deb http://ppa.launchpad.net/landronimirc/skippy-xd-daily/ubuntu {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/skippy-xd.list
        - gpgcheck: 1
        - keyid: 28773E94D114BC47F55B0333A80C8DFE23A187B2
        - keyserver: keyserver.ubuntu.com
    pkg.latest:
        - name: skippy-xd
        - refresh: True

tmux-ppa:
    pkgrepo.managed:
        - humanname: tmux
        - name: deb http://ppa.launchpad.net/pi-rho/dev/ubuntu {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/tmux.list
        - gpgcheck: 1
        - keyid: 3823B5A8A54746CA6CBED237CC892FC6779C27D7
        - keyserver: keyserver.ubuntu.com
    pkg.latest:
        - name: tmux
        - refresh: True

{% endif %}

Install apt software:
    pkg.installed:
        - pkgs:
            # Base software
            - ack-grep
            - apt-transport-https
            - build-essential
            - fontconfig
            - git-el
            - iproute2
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

{% if salt['file.directory_exists']('/usr/share/xsessions/') %}

Install gui software:
    pkg.installed:
        - pkgs:
{% if salt['cmd.run']('apt list --installed 2>/dev/null | grep gnome-desktop') %}
            - compizconfig-settings-manager
{% endif %}
            - xfce4-terminal
            - yakuake

{% endif %}

{% if grains['lsb_distrib_release'] == '14.04' or grains['lsb_distrib_release'] == '16.04' %}

emacs-ppa:
    pkgrepo.managed:
        - humanname: Emacs
        - name: deb http://ppa.launchpad.net/kelleyk/emacs/ubuntu {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/emacs.list
        - gpgcheck: 1
        - keyid: 873503A090750CDAEB0754D93FF0E01EEAAFC9CD
        - keyserver: keyserver.ubuntu.com
    pkg.latest:
{% if grains['lsb_distrib_release'] == '14.04' %}
        - name: emacs25
{% elif grains['lsb_distrib_release'] == '16.04' %}
        - name: emacs26
{% endif %}
        - refresh: True

Update emacs alternative:
    alternatives.set:
        - name: emacs
{% if grains['lsb_distrib_release'] == '14.04' %}
        - path: /usr/bin/emacs25
{% elif grains['lsb_distrib_release'] == '16.04' %}
        - path: /usr/bin/emacs26
{% endif %}

{% endif %}

{% elif grains['os'] == 'Arch' %}

/etc/pacman.conf:
    file.managed:
        - source: salt://base-packages/pacman.conf

Install Arch software:
    pkg.installed:
        - pkgs:
            - autoconf
            - automake
            - binutils
            - bison
            - cmake
            - diffutils
            - docker
            - dolphin
            - emacs
            - fakeroot
            - file
            - flex
            - gawk
            - gc
            - gcc
            - gettext
            - gimp
            - groff
            - guile
            - hplip
            - lib32-gnutls
            - lib32-gtk2
            - lib32-libldap
            - lib32-libpulse
            - lib32-libxtst
            - lib32-mesa
            - lib32-mpg123
            - lib32-openal
            - libatomic_ops
            - libffi
            - libmpc
            - libtool
            - m4
            - make
            - mesa
            - mpfr
            - mplayer
            - networkmanager-openvpn
            - nmap
            - nodejs
            - npm
            - openssh
            - openvpn
            - patch
            - pkgconf
            - python-xdg
            - redis
            - redshift
            - samba
            - spectacle
            - sslscan
            - synergy
            - tar
            - texinfo
            - the_silver_searcher
            - tmux
            - ufw
            - vagrant
            - virtualbox
            - wget
            - which
            - wine
            - wine_gecko
            - wine-mono
            - winetricks
            - xclip
            - xdg-utils
            - yakuake
        - refresh: True

# While I could use https://docs.saltstack.com/en/latest/ref/states/all/salt.states.user.html
# I would rather specify exactly how this user is created.
Add a "notroot" user:
    cmd.run:
        - name: |
            sudo useradd -m notroot
            echo 'notroot ALL = NOPASSWD: /usr/sbin/makepkg, /usr/sbin/pacman, /usr/sbin/trizen' | sudo EDITOR='tee -a' visudo
        - unless: id -u notroot

Install trizen:
    cmd.run:
        - name: |
            mkdir -p /tmp/trizen
            chown -R notroot /tmp/trizen
            cd /tmp/trizen
            sudo -u notroot git clone https://aur.archlinux.org/trizen.git
            cd trizen
            sudo -u notroot makepkg -si --noconfirm
        - unless:
            - command -v trizen

# 2018-08-20: sslyze package is broken
{% for pkg in [
    'google-chrome',
    'imagewriter',
    'slack-desktop',
    'visual-studio-code-bin'
] %}

Install {{ pkg }} from AUR:
    cmd.run:
        - name: sudo -u notroot trizen -Syu --needed --noconfirm {{ pkg }}
        - runas: {{ salt['user.current']() }}

{% endfor %}

{% elif grains['os'] == 'Kali' %}

Install Kali software:
    pkg.installed:
        - pkgs:
            - kali-defaults
            - kali-root-login
            - desktop-base
            - kde-plasma-desktop

{% endif %}
