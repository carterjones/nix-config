#!/bin/bash
set -eux -o pipefail

source ./common.sh

# Upgrade everything from the App Store when not running on CI.
if [[ -z "${CI:-}" ]]; then
    softwareupdate -i --all
fi

# Install XCode before running brew commands.
install_pkg_for_env xcode mac

brew update
brew upgrade

brew install \
    git \
    go \
    jq \
    reattach-to-user-namespace \
    packer \
    pyenv \
    pyenv-virtualenvwrapper \
    shellcheck \
    the_silver_searcher \
    tmux \
    tree \
    vagrant-completion \
    wget \
    zsh

brew cask install \
    docker \
    hyper \
    vagrant \
    visual-studio-code

brew cleanup 1> /dev/null

# Install additional packages.
install_pkg_for_env docker mac
install_pkg_for_env hack-font mac
install_pkg_for_env hyperjs mac
install_pkg_for_env keybase mac
install_pkg_for_env vscode mac

# Hide all icons from the desktop.
defaults write com.apple.finder CreateDesktop -bool false

# Don't copy/paste formatting from the terminal.
defaults write com.apple.Terminal CopyAttributesProfile com.apple.Terminal.no-attributes

# The PATH variable is a funny thing. It means a lot of things to a lot of
# processes. It can be manipulated lots of ways. People have lots of strong
# opinions about it.
#
# One program, sysctl, has a variable that modifies this value for userland
# processes: `USER_CS_PATH` or `user.cs_path`. According documentation found
# using `man 3 sysctl`, the `user.cs_path` value will "Return a value for the
# PATH environment variable that finds all the standard utilities."
#
# You may be asking yourself, "Why does any of this matter to me?" It matters
# because the value of `user.cs_path` is used when launching programs via
# Spotlight. This means that any application launched via Spotlight will get
# its PATH variable set using the value of `user.cs_path`, as opposed to
# anything set in things like `.bashrc`, `.bash_profile`, `/etc/profile`, and
# many similar configuration files. All of those files are very relevant when
# interacting with terminals, but are completely ignored when launching
# programs from Spotlight. Therefore, `user.cs_path` matters.
#
# The default value of `user.cs_path` is `/usr/bin:/bin:/usr/sbin:/sbin`.
# However, if you use homebrew, which puts soft links in `/usr/local/bin`, then
# those homebrew-managed applications may be unavailable to programs launched
# via Spotlight.
#
# For example, consider the case of launching Visual Studio Code via Spotlight.
# With the default configuration, you may get an error indicating that some
# extenions could not find programs that you installed via homebrew. Yet when
# you launch Visual Studio Code from the command line, which may have a
# different PATH variable set, then all your extensions may work just fine. By
# adding `/usr/local/bin` to `user.cs_path`, we can make homebrew programs
# available to programs launched via Spotlight.
#
# Therefore, we set a new value of `user.cs_path` here.
current_path=$(launchctl getenv PATH)
desired_path="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
if [[ "${current_path}" != "${desired_path}" ]]; then
    sudo launchctl config user path "${desired_path}"
    echo "A restart is required for the new user.cs_path value to take effect."
fi
