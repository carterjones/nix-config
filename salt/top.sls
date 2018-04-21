base:
    'os:MacOS':
        - match: grain
        - xcode
    'os:Ubuntu':
        - match: grain
        - gnome
        - openvpn
    'os:Arch':
        - match: grain
        - fnmode
    '*':
        - base-packages
        - bgrep
        - binfiles
        - docker
        - dotfiles
        - emacs
        - go
        - hack-font
        - nano
        - nmap
        - packer
        - pyenv
        - ramdisk
        - tmux
        - vagrant
        - vscode
        - zsh
