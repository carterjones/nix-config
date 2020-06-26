[![Build Status](https://travis-ci.org/carterjones/nix-config.svg?branch=master)](https://travis-ci.org/carterjones/nix-config)
[![Maintainability](https://api.codeclimate.com/v1/badges/929b0a915c29e8d5a994/maintainability)](https://codeclimate.com/github/carterjones/nix-config/maintainability)

# Overview

This install script is designed to fully cofigure a *nix-based system to my
personal liking. Rather than downloading, installing, creating config files,
and other activities related to getting a freshly installed system customized,
I run this install script.

# Installation

To download, extract, and run the installer, run the following command:

```bash
mkdir -p ~/src/github.com/carterjones/
pushd ~/src/github.com/carterjones/
git clone https://github.com/carterjones/nix-config
cd nix-config
./install
```

# Supported Operating Systems

The install script is tested against Arch, Manjaro, Ubuntu 18.04, Ubuntu 20.04,
CentOS 8, and macOS.

# Design Philosophy

Rather than just having a "[dotfiles](https://www.google.com/search?q=dotfiles)"
repo, which works great in many cases, I prefer to keep as much in a single
config repo as possible. This means also installing software. I provision
systems for myself constantly and every second where I repeat myself adds up, so
this repo helps me streamline my efforts and be efficient.

For more info about this concept, please see
[http://growsmethod.com/practices/EverythingInVC.html](https://web.archive.org/web/20180508113126/http://growsmethod.com/practices/EverythingInVC.html)
