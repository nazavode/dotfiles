#!/bin/bash

# ██████╗ ██╗  ██╗      ███╗   ███╗██╗   ██╗    ███████╗███████╗██╗  ██╗
# ██╔═══██╗██║  ██║      ████╗ ████║╚██╗ ██╔╝    ╚══███╔╝██╔════╝██║  ██║
# ██║   ██║███████║█████╗██╔████╔██║ ╚████╔╝█████╗ ███╔╝ ███████╗███████║
# ██║   ██║██╔══██║╚════╝██║╚██╔╝██║  ╚██╔╝ ╚════╝███╔╝  ╚════██║██╔══██║
# ╚██████╔╝██║  ██║      ██║ ╚═╝ ██║   ██║       ███████╗███████║██║  ██║
# ╚═════╝ ╚═╝  ╚═╝      ╚═╝     ╚═╝   ╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝

# Bootstrap oh-my-zsh and plugins

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
