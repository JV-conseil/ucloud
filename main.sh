#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
set -eu -o pipefail
# set -o errtrace
# set -o functrace
# set -o verbose
# set -o xtrace
# Shopt builtin allows you to change additional shell optional behavior
# <https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html>
shopt -s failglob
IFS=$'\n\t'

if type bashdb &>/dev/null; then
  shopt -s extdebug
else
  set -o errtrace
  set -o functrace
  set -o verbose
fi

echo "Run TRACE mode"
exec 4>./xtrace.out
BASH_XTRACEFD=4
set -o xtrace # same as set -x

# shellcheck disable=SC2317
debug() {
  echo "[ DEBUG ]| BASH_COMMAND=${BASH_COMMAND}"
  echo "         | BASH_ARGC=${BASH_ARGC[@]} BASH_ARGV=${BASH_ARGV[@]}"
  echo "         | BASH_SOURCE: ${!BASH_SOURCE[@]} ${BASH_SOURCE[@]}"
  echo "         | BASH_LINENO: ${!BASH_LINENO[@]} ${BASH_LINENO[@]}"
  echo "         | FUNCNAME: ${!FUNCNAME[@]} ${FUNCNAME[@]}"
  echo "         | PIPESTATUS: ${!PIPESTATUS[@]} ${PIPESTATUS[@]}"
}

# trap 'echo ERR trap from ${FUNCNAME:-MAIN} context. $BASH_COMMAND failed with error code $?' ERR
# trap 'debug' DEBUG

# shellcheck source=/dev/null
{
  . "incl/all.sh"
  # more files
}

_ucld_::debug

cat "README.txt"

_ucld_::startup_check
_ucld_::install_packages

if "$(_ucld_::ask "Do you want to manage GitHub")"; then
  # shellcheck source=/dev/null
  . "github/main.sh"
  echo
fi

if "$(_ucld_::is_postgresql_server_running)"; then

  if "$(_ucld_::ask "Do you want to manage PostreSQL")"; then
    # shellcheck source=/dev/null
    . "postgresql/main.sh"
    echo
  fi

fi

if "$(_ucld_::is_python_installed)"; then

  if "$(_ucld_::ask "Do you want to manage Django")"; then
    # shellcheck source=/dev/null
    . "django/main.sh"
    echo
  fi

  if "$(_ucld_::ask "Do you want to run your Python app")"; then
    # shellcheck source=/dev/null
    . "app/main.sh"
    echo
  fi

fi

if "$(_ucld_::ask "Do you need to generate an SSH key")"; then
  _ucld_::generate_ssh_key
  echo
fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
  _ucld_::show_settings
else
  _ucld_::show_settings
fi

exit 0
