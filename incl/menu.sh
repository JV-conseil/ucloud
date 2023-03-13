#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

ucl() {
  local _root="/work/ucloud"

  if [ -n "${UCLD_PATH[main]}" ] &>/dev/null || :; then
    _root="${UCLD_PATH[main]}"
  fi

  case "${1:-}" in

  "django")
    # shellcheck source=/dev/null
    . "${_root}/postgresql/main.sh"
    ;;

  "postgresql" | "pg")
    # shellcheck source=/dev/null
    . "${_root}/postgresql/main.sh"
    ;;

  *)
    cat <<EOF


Bash Commands Lines ucl
----------------------

e.g.: wl pg


options:
django      Django commands to startproject, startapp and set up PostgreSQL for this repository.
postgresql  PostgreSQL CLI terminal and commands to create a Database and DB User for this repository (alias pg).


author:
JV conseil — Internet Consulting
contact@jv-conseil.net
@JV-conseil

version:
2023-03-11
EOF

    # shellcheck source=/dev/null
    . "${_root}/main.sh"
    ;;

  esac
}
