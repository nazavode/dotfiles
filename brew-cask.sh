#!/bin/bash

# ██████╗ ██████╗ ███████╗██╗    ██╗    ██╗ ██████╗ █████╗ ███████╗██╗  ██╗
# ██╔══██╗██╔══██╗██╔════╝██║    ██║   ██╔╝██╔════╝██╔══██╗██╔════╝██║ ██╔╝
# ██████╔╝██████╔╝█████╗  ██║ █╗ ██║  ██╔╝ ██║     ███████║███████╗█████╔╝
# ██╔══██╗██╔══██╗██╔══╝  ██║███╗██║ ██╔╝  ██║     ██╔══██║╚════██║██╔═██╗
# ██████╔╝██║  ██║███████╗╚███╔███╔╝██╔╝   ╚██████╗██║  ██║███████║██║  ██╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝ ╚═╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

# This is intended to bootstrap a brew-based MacOSX environment
# with the needed casks.

apps = (
    google-chrome
    google-drive
    dropbox
    atom
    iterm2
    pycharm-ce
    evernote
    vlc
    spotify
    skype
    slack
    transmission
    google-play-music-desktop-player
    google-nik-collection
    malwarebytes-anti-malware
)

################################################################

brew tap caskroom/cask
brew cask install "${apps[@]}"
brew cask cleanup
