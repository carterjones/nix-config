#!/bin/bash
set -eux -o pipefail

readonly TMP_DIR=/tmp/emacs-install
readonly VERSION="25.2"
readonly DL_URL="https://emacsformacosx.com/download/emacs-builds/Emacs-${VERSION}-universal.dmg"
readonly FILENAME="emacs.dmg"

# Download vagrant.
mkdir -p $TMP_DIR
pushd $TMP_DIR
curl $DL_URL > $FILENAME

# Mount the DMG file.
sudo hdiutil attach $FILENAME

# Copy Emacs app to the Applications directory.
cp -R /Volumes/Emacs/Emacs.app $HOME/Applications/Emacs.app

# Clean up the install files.
sudo hdiutil detach /Volumes/Emacs
popd
rm -rf $TMP_DIR
