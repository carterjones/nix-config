#!/bin/bash
set -euxo pipefail

if [ ! -f /usr/share/fonts/TTF/Hack-Regular.ttf ]; then
    cd /tmp
    curl -Lo hack-font.zip https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip
    unzip -o hack-font.zip
    mkdir -p /usr/share/fonts/TTF/
    for file in Hack-Bold.ttf Hack-BoldItalic.ttf Hack-Italic.ttf Hack-Regular.ttf; do
        sudo chown root:root "${file}"
        sudo mv "${file}" /usr/share/fonts/TTF/
    done
fi

fc-cache -f -v 1> /dev/null
