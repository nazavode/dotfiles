#                 ██
#                ░██
#  ██████  ██████░██      ██████  █████
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

# https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292

### Attempt at speeding up the whole experience:
### oh-my-zsh
# This speeds up pasting with autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### zsh
DISABLE_MAGIC_FUNCTIONS=true

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
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME="robbyrussell"

################################################################################
# History, inspired by:
#   http://www.lowlevelmanager.com/2012/04/zsh-history-extend-and-persist.html
################################################################################

HISTFILE="$HOME/.zsh_history"  # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

################################################################################
# Misc configuration
################################################################################

# Disable shell termination on EOF (^D)
setopt ignoreeof

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

# Forces autocompletion to refresh
zstyle ":completion:*:commands" rehash 1

# Start oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

################################################################################
# Aliases and common stuff
################################################################################

# Disable zsh globbing while calling git so stuff like
# 'git add *foo*' is going to be resolved by git itself
# and not by zsh
alias git='noglob git'

# Enable common stuff
if [ -f ~/.commonrc ]; then
    . ~/.commonrc
fi
