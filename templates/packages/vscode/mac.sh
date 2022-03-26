#!/bin/bash
set -eux -o pipefail

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    # Install Visual Studio Code from the Microsoft website rather than homebrew
    # since the update mechanism never seems to work correctly when trying to
    # update Visual Studio Code if it was installed using homebrew.
    pushd /tmp
    curl -Lo code.zip "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
    unzip -q code.zip
    mv "Visual Studio Code.app" /Applications/
    rm code.zip
    popd
fi

# Point "code" to Visual Studio Code. This is based on the resulting effect of
# running the "Shell Command: Install 'code' command in PATH" from within
# Visual Studio Code, which appears to just add a symlink to /usr/local/bin.
ln -nfs /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code

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
