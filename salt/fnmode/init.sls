/etc/systemd/system/fnmode.service:
    file.managed:
        - source: salt://fnmode/fnmode.service

fnmode:
    service.enabled

# TODO(carter): add `GRUB_CMDLINE_LINUX_DEFAULT="quiet hid_apple.fnmode=2"` to /etc/default/grub.cnf & run `grub-mkconfig -o /boot/grub/grub.cnf`
