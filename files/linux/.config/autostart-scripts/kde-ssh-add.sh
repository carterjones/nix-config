#!/bin/bash

eval "$(ssh-agent)"
export SSH_ASKPASS="$(which ksshaskpass)"
ssh-add < /dev/null
