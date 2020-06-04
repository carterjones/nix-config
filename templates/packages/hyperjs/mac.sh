#!/bin/bash
set -eux -o pipefail

# https://github.com/vercel/hyper/issues/51#issuecomment-507747736
defaults write co.zeit.hyper CGFontRenderingFontSmoothingDisabled 0
defaults write co.zeit.hyper.helper CGFontRenderingFontSmoothingDisabled 0
defaults write co.zeit.hyper.helper.EH CGFontRenderingFontSmoothingDisabled 0
defaults write co.zeit.hyper.helper.NP CGFontRenderingFontSmoothingDisabled 0
