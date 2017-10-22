#!/bin/bash

set -euxo pipefail

# Determine if VSCode is installed.
set +e
ls /Applications | grep "Visual Studio Code.app"
readonly VSCODE_INSTALLED=$(echo $?)
set -e
if [[ "$VSCODE_INSTALLED" == "0" ]]; then
    # VSCode is installed.
    echo "VSCode is installed."
else
    # Download and install VSCode.
    pushd /tmp
    readonly TMP_FILENAME="VSCode-darwin-stable.zip"
    curl -s -L "https://go.microsoft.com/fwlink/?LinkID=620882" > $TMP_FILENAME
    unzip $TMP_FILENAME
    mv "Visual Studio Code.app" /Applications
    rm $TMP_FILENAME
    popd
fi

# Set up customizations.
cp ${macos_files}/vscode/* "${HOME}/Library/Application Support/Code/User/"
