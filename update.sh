#!/bin/bash
set -euxo pipefail

# Update VS Code extension list.
pushd templates/packages/vscode
code --list-extensions > /tmp/extensions.new1.txt
cat extensions.txt /tmp/extensions.new1.txt | sort | uniq > /tmp/extensions.new2.txt
mv /tmp/extensions.new2.txt extensions.txt
popd
