#!/bin/bash

eval "$(ssh-agent)"
export SSH_ASKPASS="$(command -v ksshaskpass)"
ssh-add < /dev/null
