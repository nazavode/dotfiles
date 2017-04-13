#!/bin/bash

# ██╗  ██╗ ██████╗ ███╗   ███╗███████╗██████╗ ██████╗ ███████╗██╗    ██╗
# ██║  ██║██╔═══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗██╔════╝██║    ██║
# ███████║██║   ██║██╔████╔██║█████╗  ██████╔╝██████╔╝█████╗  ██║ █╗ ██║
# ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║███╗██║
# ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗██████╔╝██║  ██║███████╗╚███╔███╔╝
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝

# This is intended to bootstrap a brew-based MacOSX environment,
# including ZSH, GNU utils overrides and various stuff.

################################################################
# ZSH
################################################################
brewZsh = (
    zsh
)

################################################################
# GNU utils overrides
################################################################
brewCore = (
    coreutils
    findutils --with-default-names
    grep --with-default-names
    gnu-sed --with-default-names
)

################################################################
# Misc stuff
################################################################
brewStuff = (
    vim --with-override-system-vi
    stow
    git
    htop
    wget
    cmake
    rclone
    hugo
    python
    python3
    plantuml
)

################################################################

# 1. Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 2. Install stuff
brew update
brew upgrade --all
brew install "${brewZsh[@]}"
brew install "${brewCore[@]}"
brew install "${brewStuff[@]}"
