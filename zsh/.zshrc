#                 ██
#                ░██
#  ██████  ██████░██      ██████  █████
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

# Default user, to be set for some themes to work correctly
DEFAULT_USER="$USER"

################################################################################
# Theme
################################################################################

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
VIRTUAL_ENV_DISABLE_PROMPT=1  # needed by theme

################################################################################
# History, inspired by:
#   http://www.lowlevelmanager.com/2012/04/zsh-history-extend-and-persist.html
################################################################################

HISTFILE="$HOME/.zsh_history"    # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

################################################################################
# Misc configuration
################################################################################

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
# WARINING: zsh-syntax-highlighting
# This plugin doesn't play nice with zsh-autosuggestions, when both are loaded
# a lot of weird things happen. Waiting for this to be released:
# https://github.com/zsh-users/zsh-autosuggestions/pull/218

# Forces autocompletion to refresh
zstyle ":completion:*:commands" rehash 1

# Start oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# Colors
# eval `dircolors ~/.dircolors/solarized`

# autosuggestion color (value reference: colortest-python -n)
# and buffer size. Override values set by plugin during loading.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

################################################################################
# ENV: common stuff
################################################################################

EDITOR="vim"

# dot executable (for PyCharm PlantUML plugin)
GRAPHVIZ_DOT="$(which dot)"

# Locale enforcing to be consistent across systems
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8

################################################################################
# ENV: linux specific stuff
################################################################################

# Linuxbrew
if [[ -d "$HOME/.linuxbrew" ]]; then
  PATH="$HOME/.linuxbrew/bin:$PATH"
  MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
fi

# Manually installed applications, not handled by a package manager
if [[ -d "$HOME/Apps" ]]; then
  # protobuf
  PATH="$HOME/Apps/grpc-1.0.0/bin:$PATH"
  # grpc
  PATH="$HOME/Apps/protoc-3.2.0-linux-x86_64/bin:$PATH"
fi

# golang
if [[ -d "$HOME/go" ]]; then
  GOPATH="$HOME/go"
  GOBIN="$GOPATH/bin"
  PATH="$GOBIN:$PATH"
fi

################################################################################
# ENV: MacOSX specific stuff
################################################################################

# GNU coreutils provided by brew, overwrite Apple counterparts
if [[ -d /usr/local/opt/coreutils/libexec/ ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Manually installed applications, not handled by a package manager
if [[ -d "$HOME/Documents/Apps/bin" ]]; then
  PATH="$HOME/Documents/Apps/bin:$PATH"
fi

# golang
if [[ -d "$HOME/Documents/Hacking/go" ]]; then
  GOPATH="$HOME/Documents/Hacking/go"
  GOBIN="$GOPATH/bin"
  PATH="$PATH:/usr/local/opt/go/libexec/bin:$GOBIN"
fi

################################################################################
# ENV: exports
################################################################################
export ZSH
export EDITOR
export PATH
export MANPATH
export INFOPATH
export XDG_DATA_DIRS
export LC_ALL
export LANG
export LANGUAGE
export GRAPHVIZ_DOT
export GOPATH
export GOBIN

################################################################################
# Aliases
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
################################################################################

# Detect which `ls` flavor is in use,
# we need to tweak aliases for both GNU ls and Apple (BSD) ls.
# 1. Colors
#   Fix found here:
#   https://github.com/mathiasbynens/dotfiles/pull/451
# 2. GNU ls disable quote (-N)
if ls --color > /dev/null 2>&1; then # GNU `ls`
	lsflags="--color -N"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	lsflags="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'  # Solarized
	# LSCOLORS='Gxfxcxdxbxegedabagacad'  # MacOSX default
fi

alias ls="ls ${lsflags}"
alias la="ls -ltrha ${lsflags}"
alias ll="ls -ltrh ${lsflags}"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
# Disable zsh globbing while calling git so stuff like
# 'git add *foo*' is going to be resolved by git itself
# and not by zsh
alias git='noglob git'
