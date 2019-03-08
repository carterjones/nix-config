base:
    'os:MacOS':
        - match: grain
        - vscode
        - xcode
    'os:Ubuntu':
        - match: grain
        - gnome
        - openvpn
        - vscode
    'os:Arch':
        - match: grain
        - fnmode
        - vscode
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
        - zsh
