#!/bin/bash

wget -nc "https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip"
unzip -u Hack-v2_020-ttf.zip
sudo cp -f Hack-*.ttf /usr/share/fonts/TTF/
fc-cache -f -v
