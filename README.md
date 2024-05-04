[![ci](https://github.com/carterjones/nix-config/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/carterjones/nix-config/actions/workflows/ci.yml?query=branch%3Amain)
[![maintainability](https://api.codeclimate.com/v1/badges/a93650c7bfb759fe346e/maintainability)](https://codeclimate.com/github/carterjones/nix-config/maintainability)

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

The install script is tested against Debian 12, Ubuntu 22.04, CentOS Stream 9,
and macOS.

# Design Philosophy

Rather than just having a "[dotfiles](https://www.google.com/search?q=dotfiles)"
repo, which works great in many cases, I prefer to keep as much in a single
config repo as possible. This means also installing software. I provision
systems for myself constantly and every second where I repeat myself adds up, so
this repo helps me streamline my efforts and be efficient.

For more info about this concept, please see
[http://growsmethod.com/practices/EverythingInVC.html](https://web.archive.org/web/20180508113126/http://growsmethod.com/practices/EverythingInVC.html)
