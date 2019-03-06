base:
    'os:MacOS':
        - match: grain
        - base-packages
        - xcode
        - packer
        - pyenv
    'os:Ubuntu':
        - match: grain
        - base-packages
        - gnome
        - openvpn
        - packer
        - pyenv
    'os:Arch':
        - match: grain
        - base-packages
        - fnmode
        - packer
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
        - ramdisk
        - tmux
        - vagrant
        - vscode
        - zsh
