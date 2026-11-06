#!/bin/bash
set -eux -o pipefail

# UEFIExtract is the command-line companion to UEFITool. The uefitool cask only
# ships the GUI, and homebrew has no formula for it.
version="A76"
marker="${HOME}/bin/.UEFIExtract-version"

if [[ -x "${HOME}/bin/UEFIExtract" ]] && [[ "$(cat "${marker}" 2> /dev/null)" == "${version}" ]]; then
    exit 0
fi

work_dir=$(mktemp -d)
trap 'rm -rf "${work_dir}"' EXIT

curl -sSfL -o "${work_dir}/UEFIExtract.zip" \
    "https://github.com/LongSoft/UEFITool/releases/download/${version}/UEFIExtract_NE_${version}_universal_mac.zip"
unzip -q "${work_dir}/UEFIExtract.zip" -d "${work_dir}"

mkdir -p "${HOME}/bin"
install -m 755 "${work_dir}/UEFIExtract" "${HOME}/bin/UEFIExtract"
echo "${version}" > "${marker}"
