#
# Color configuration
#

STAKANOV_CONTEXT_COLOR="yellow"
STAKANOV_DIR_COLOR="white"
STAKANOV_GIT_CLEAN_COLOR="green"
STAKANOV_GIT_DIRTY_COLOR="009"
STAKANOV_EXIT_SUCCESS_COLOR="white"
STAKANOV_EXIT_ERROR_COLOR="red"
STAKANOV_VIRTUALENV_COLOR="magenta"

#
# Internal functions
#

function stakanov::echo() {
  local content="$1"
  local color="$2"
  echo -n "%{%F{${color}}%}${content}"
}

function stakanov::git::ref() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
    return 0
  echo -n "${ref#refs/heads/}"
}

function stakanov::git::isdirty() {
  local -a flags
  flags=('--porcelain')
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    flags+='--ignore-submodules=dirty'
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    flags+='--untracked-files=no'
  fi
  echo "$(command git status ${flags} 2> /dev/null | tail -n1)"
}

#
# Section functions
#

function stakanov::context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    local host
    if [[ -n "$CINECA_CLUSTER" ]]; then
      host="$CINECA_CLUSTER"
    else
      host="%m"
    fi
    stakanov::echo "%n@${host}:" "$STAKANOV_CONTEXT_COLOR"
  fi
}

function stakanov::git() {
  (( $+commands[git] )) || return
  local ref="$(stakanov::git::ref)"
  if [[ -n "$ref" ]]; then
    local color="$STAKANOV_GIT_CLEAN_COLOR"
    local isdirty="$(stakanov::git::isdirty)"
    if [[ -n "$isdirty" ]]; then
      color="$STAKANOV_GIT_DIRTY_COLOR"
    fi
    stakanov::echo "[${ref}]" "$color"
  fi
}

function stakanov::virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path ]]; then
    stakanov::echo "[`basename $virtualenv_path`]" "$STAKANOV_VIRTUALENV_COLOR"
  fi
}

function stakanov::pwd() {
  stakanov::echo "%~" "$STAKANOV_DIR_COLOR"
}

stakanov::status() {
  local retval=$1
  local uid=$2
  local njobs=$3
  local symbols
  symbols=()
  [[ $retval -ne 0 ]] && symbols+="%{%F{red}%}●"
  [[ $uid -eq 0 ]] && symbols+="%{%F{yellow}%}●"
  [[ $njobs -gt 0 ]] && symbols+="%{%F{cyan}%}●"

  [[ -n "$symbols" ]] && echo -n "{${symbols}%{$reset_color%}}"
}

function stakanov::main() {
  local retval=$?
  local uid=$UID
  local njobs=$(jobs -l | wc -l)
  stakanov::status $retval $uid $njobs
  stakanov::echo [ yellow
  stakanov::context
  stakanov::pwd
  stakanov::echo ] yellow
  stakanov::virtualenv
  stakanov::git
  stakanov::echo ' »' white
}

PROMPT='$(stakanov::main)%{$reset_color%} '