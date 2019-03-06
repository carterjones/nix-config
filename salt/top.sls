base:
    'os:MacOS':
        - match: grain
        - base-packages
        - xcode
        - pyenv
    'os:Ubuntu':
        - match: grain
        - base-packages
        - gnome
        - openvpn
        - pyenv
    'os:Arch':
        - match: grain
        - base-packages
        - fnmode
        - pyenv
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
        - ramdisk
        - tmux
        - vagrant
        - vscode
        - zsh
