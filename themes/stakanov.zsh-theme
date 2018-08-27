#
# Color configuration
#

STAKANOV_PROMPT="%{%F{white}%}»"

STAKANOV_STATUS_RETVAL_ERROR="%{%F{red}%}●"
STAKANOV_STATUS_PRIVILEGED="%{%F{yellow}%}●"
STAKANOV_STATUS_HAS_JOBS="%{%F{cyan}%}●"

STAKANOV_COLOR_CONTEXT="yellow"
STAKANOV_COLOR_PWD="white"
STAKANOV_COLOR_GIT_CLEAN="green"
STAKANOV_COLOR_GIT_DIRTY="009"
STAKANOV_COLOR_VIRTUALENV="magenta"
STAKANOV_COLOR_BRACE_DEFAULT="default"

#
# Internal functions
#

function stakanov::echo() {
  local content="$1"
  local color="$2"
  [[ -z "${color}" ]] && color="default"
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
    stakanov::echo "%n@${host}:" "$STAKANOV_COLOR_CONTEXT"
  fi
}

function stakanov::git() {
  (( $+commands[git] )) || return
  local ref="$(stakanov::git::ref)"
  if [[ -n "$ref" ]]; then
    local color="$STAKANOV_COLOR_GIT_CLEAN"
    if [[ -n "$(stakanov::git::isdirty)" ]]; then
      color="$STAKANOV_COLOR_GIT_DIRTY"
    fi
    stakanov::echo "[${ref}]" "$color"
  fi
}

function stakanov::virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    local venv="$(basename ${virtualenv_path})"
    stakanov::echo "[${venv}]" "$STAKANOV_COLOR_VIRTUALENV"
  fi
}

function stakanov::pwd() {
  stakanov::echo "%~" "$STAKANOV_COLOR_PWD"
}

stakanov::status() {
  local retval=$1
  local uid=$2
  local njobs=$3
  local symbols
  symbols=()
  [[ $retval -ne 0 ]] && symbols+="$STAKANOV_STATUS_RETVAL_ERROR"
  [[ $uid -eq 0 ]] && symbols+="$STAKANOV_STATUS_PRIVILEGED"
  [[ $njobs -gt 0 ]] && symbols+="$STAKANOV_STATUS_HAS_JOBS"

  if [[ -n "$symbols" ]]; then
    stakanov::echo "%{%F{${STAKANOV_COLOR_BRACE_DEFAULT}}%}{${symbols}%{%F{${STAKANOV_COLOR_BRACE_DEFAULT}}%}}"
  fi
}

function stakanov::main() {
  local retval=$?
  local uid=$UID
  local njobs=$(jobs -l | wc -l)
  stakanov::status $retval $uid $njobs
  stakanov::echo [ "$STAKANOV_COLOR_BRACE_DEFAULT"
  stakanov::context
  stakanov::pwd
  stakanov::echo ] "$STAKANOV_COLOR_BRACE_DEFAULT"
  stakanov::virtualenv
  stakanov::git
  stakanov::echo " $STAKANOV_PROMPT"
}

PROMPT='$(stakanov::main)%{$reset_color%} '