#!/bin/bash
set -eux -o pipefail

# Configure extensions.
mkdir -p "${HOME}/Library/Application Support/Code/User/"
cp -R ./configs/* "${HOME}/Library/Application Support/Code/User/"
./install-extensions.sh

# Expose Homebrew binaries to VSCode.
# This is based on https://superuser.com/a/271697
# 1. Copy a script into Visual Studio Code.app that will be used to launch
#    VSCode with a custom PATH variable.
# 2. Update the Info.plist file to run that script rather than Electron.
# 3. Register the updates to the plist file with Launch Services.
cp ./launch-with-path.sh "/Applications/Visual Studio Code.app/Contents/MacOS/"
chmod +x "/Applications/Visual Studio Code.app/Contents/MacOS/launch-with-path.sh"
sed -i '' 's,Electron,launch-with-path.sh,' "/Applications/Visual Studio Code.app/Contents/Info.plist"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "/Applications/Visual Studio Code.app"
