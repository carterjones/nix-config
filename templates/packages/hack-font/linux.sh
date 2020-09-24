#!/bin/bash
set -eux -o pipefail

if ! sudo test -f /usr/share/fonts/TTF/Hack-Regular.ttf; then
    cd /tmp
    curl -Lo hack-font.zip https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip
    unzip -o hack-font.zip
    sudo mkdir -p /usr/share/fonts/TTF/
    for file in Hack-Bold.ttf Hack-BoldItalic.ttf Hack-Italic.ttf Hack-Regular.ttf; do
        sudo chown root:root "${file}"
        sudo mv "${file}" /usr/share/fonts/TTF/
    done
    fc-cache -f -v 1> /dev/null
fi
