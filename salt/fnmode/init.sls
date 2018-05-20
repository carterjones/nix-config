/etc/systemd/system/fnmode.service:
    file.managed:
        - source: salt://fnmode/fnmode.service

Make sure fnmode is running:
    cmd.run:
        - name: systemctl start fnmode
        - stateful: True
        - unless: systemctl is-active --quiet fnmode

# TODO(carter): add `GRUB_CMDLINE_LINUX_DEFAULT="quiet hid_apple.fnmode=2"` to /etc/default/grub.cnf & run `grub-mkconfig -o /boot/grub/grub.cnf`
