#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# The Unofficial Bash Strict Mode
# These lines deliberately cause your script to fail.
# Wait, what? Believe me, this is a good thing.
# <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
_ucld_::unofficial_bash_strict_mode() {
  case "${1:-""}" in

  "off" | "reset")
    export UNOFFICIAL_BASH_STRICT_MODE=0
    set +euo pipefail errtrace functrace verbose xtrace
    shopt -u failglob extdebug
    ;;

  *)
    # shellcheck disable=SC2034
    export UNOFFICIAL_BASH_STRICT_MODE=1

    # settings to write safe scripts
    # <https://sipb.mit.edu/doc/safe-shell/>
    set -euo pipefail errtrace functrace verbose xtrace
    # Shopt builtin allows you to change additional shell optional behavior
    # <https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html>
    shopt -s failglob extdebug
    # IFS=$'\n\t'
    ;;
  esac
}

_ucld_::debug() {
  if [[ "${DEBUG}" -eq 0 ]]; then
    return
  fi

  cat <<EOF


===============
 DEBUG LEVEL ${DEBUG}
===============

EOF

  cat /proc/version 2>/dev/null || :
  cat /etc/issue 2>/dev/null || :
  bash --version || :
  python --version || :

  if [[ "${DEBUG}" -gt 1 ]]; then

    _ucld_::unofficial_bash_strict_mode

    if [[ "${DEBUG}" -gt 2 ]]; then

      echo "$(
        set -o posix
        set | sort
      )"

    else

      echo
      env -0 | sort -z | tr "\0" "\n"
      echo

    fi

    echo
    alias
  fi

}
