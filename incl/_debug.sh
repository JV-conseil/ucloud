#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
#
# Shopt builtin allows you to change additional shell optional behavior
# <https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html>
#
# The Unofficial Bash Strict Mode
# These lines deliberately cause your script to fail.
# Wait, what? Believe me, this is a good thing.
# <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
#
# Safer bash scripts with 'set -euxo pipefail'
# <https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/>
#
#====================================================

_ucld_::strict_mode() {
  set -Eeuo pipefail
  shopt -s failglob
  IFS=$'\n\t'
  echo "The Unofficial Bash Strict Mode is on"

  if [ "${1:-""}" == "reset" ]; then
    set +euo pipefail errtrace functrace verbose xtrace
    shopt -u failglob extdebug
    echo "The Unofficial Bash Strict Mode is off"
  fi
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
  _ucld_::set_show
  python --version || :

  if [[ "${DEBUG}" -gt 1 ]]; then

    if [[ "${DEBUG}" -gt 2 ]]; then

      if [[ "${DEBUG}" -gt 3 ]]; then
        _ucld_::debugger
      fi

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

# Usage:
# DEBUGGER=1 TRACE=1 BASH_ENV=utilities/debugger.sh ./main.sh
_ucld_::debugger() {
  _ucld_::strict_mode

  PS4='+[$0:$LINENO] '

  if [[ -v DEBUGGER ]]; then
    # if type bashdb &>/dev/null || :; then
    shopt -s extdebug
  else
    set -o errtrace
    set -o functrace
  fi

  if [[ -v TRACE ]]; then
    echo "Running TRACE mode..."
    exec 4>./xtrace.out
    BASH_XTRACEFD=4
    set -o xtrace # same as set -x
  fi

  if [[ -v NOOP ]]; then
    echo "Run NOOP mode"
    set -o noexec # same as set -n
  fi

  # shellcheck disable=SC2145,2317
  debug() {
    echo "[ DEBUG ]| BASH_COMMAND=${BASH_COMMAND}"
    echo "         | BASH_ARGC=${BASH_ARGC[@]} BASH_ARGV=${BASH_ARGV[@]}"
    echo "         | BASH_SOURCE: ${!BASH_SOURCE[@]} ${BASH_SOURCE[@]}"
    echo "         | BASH_LINENO: ${!BASH_LINENO[@]} ${BASH_LINENO[@]}"
    echo "         | FUNCNAME: ${!FUNCNAME[@]} ${FUNCNAME[@]}"
    echo "         | PIPESTATUS: ${!PIPESTATUS[@]} ${PIPESTATUS[@]}"
  }

  trap 'echo ERR trap from ${FUNCNAME:-MAIN} context. $BASH_COMMAND failed with error code $?' ERR
  trap 'debug' DEBUG
}
