#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

declare -A UCLD_COLORS=(
  [_reset]=$'\e[0m'
  [blue]=$'\e[1;34m'
  [cyan]=$'\e[1;36m'
  [green]=$'\e[1;32m'
  [magenta]=$'\e[1;35m'
  [red]=$'\e[1;31m'
  [white]=$'\e[1;37m'
  [yellow]=$'\e[1;33m'
)

_ucld_::alert() {
  local _bool _message _color
  _bool=false

  _message=${1:-"Error"}
  _color=${2:-"magenta"}

  echo -e "${UCLD_COLORS["${_color}"]}${1}${UCLD_COLORS[_reset]} 🛑"
  echo
}

# read

_ucld_::ask() {
  local _bool _prompt _color
  _bool=false

  _prompt=${1:-"Houston Do You Copy"}
  _color=${2:-"cyan"}

  read -e -r -p "${UCLD_COLORS["${_color}"]}${_prompt}? [y/N]${UCLD_COLORS["_reset"]} " -n 1
  if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
    _bool=true
  fi

  echo "${_bool}"
}

_ucld_::ask_2() {
  _ucld_::ask "$1" "green"
}

# h1, H2, h3...

_ucld_::h1() {
  local _message _color

  _message=${1:-"Title h1"}
  _color=${2:-"magenta"}

  _message="$(echo -e "${UCLD_COLORS["${_color}"]}${_message}${UCLD_COLORS["_reset"]}")"

  cat <<EOF


${_message}

EOF
}

_ucld_::h2() {
  _ucld_::h1 "${1}..." "green"
}

_ucld_::h3() {
  _ucld_::h1 "${1}..." "blue"
}
