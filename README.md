.dotfiles
=========

My own dotfiles and misc configuration stuff.
Managed via [GNU Stow](https://www.gnu.org/software/stow/).

Installation
------------

To have a configuration deployed, from cloned repo:

```
stow <config>
```

oh-my-zsh
---------

In order to have the `.zshrc` working properly, the following plugins are needed:

```
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
