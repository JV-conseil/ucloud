#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::debug() {
  if [[ "${DEBUG}" -eq 0 ]]; then
    return
  fi
  cat <<EOF


===============
 DEBUG LEVEL ${DEBUG}
===============

EOF

  cat /proc/version &>/dev/null || :
  cat /etc/issue &>/dev/null || :
  bash --version || :
  python --version || :

  if [[ "${DEBUG}" -gt 1 ]]; then

    if [[ "${DEBUG}" -gt 2 ]]; then

      echo "$(
        set -o posix
        set | sort
      )"

    else

      echo
      env
      echo

    fi

    echo
    alias
  fi

}

# The Unofficial Bash Strict Mode
# These lines deliberately cause your script to fail.
# Wait, what? Believe me, this is a good thing.
# <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
_ucld_::unofficial_bash_strict_mode() {
  local _mode=${1:-""}

  case "${_mode}" in

  "on")
    # settings to write safe scripts
    # <https://sipb.mit.edu/doc/safe-shell/>
    set -euo pipefail

    # Shopt builtin allows you to change additional shell optional behavior
    # <https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html>
    shopt -s failglob
    # IFS=$'\n\t'
    ;;

  "off" | "reset")
    set +euo pipefail
    shopt -u failglob
    ;;

  esac

}
