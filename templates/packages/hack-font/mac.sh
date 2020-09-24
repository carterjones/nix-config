#!/bin/bash
set -eux -o pipefail

if [ ! -f /Library/Fonts/Hack-Regular.ttf ]; then
    cd /tmp
    wget -O hack-font.zip https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip
    unzip -o hack-font.zip
    for file in Hack-Bold.ttf Hack-BoldItalic.ttf Hack-Italic.ttf Hack-Regular.ttf; do
        sudo chown root "${file}"
        sudo mv "${file}" /Library/Fonts/
    done
fi
