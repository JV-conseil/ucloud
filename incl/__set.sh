#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2024 JV-conseil
#                 All rights reserved
#
# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
#
# The Set Builtin allows you to change the values of shell options
# <https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html>
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

_ucld_::hack_unbound_variables() {
  # unbound variables
  # shellcheck disable=SC2034
  {
    BP_PIPESTATUS=""
    _PRESERVED_PROMPT_COMMAND=""
  }
}

_ucld_::is_linux() {
  if [[ "$(cat /proc/version 2>/dev/null || :)" == "Linux"* ]]; then
    true
  else
    false
  fi
}

_ucld_::set_show_options() {
  bash --version || :
  cat <<EOF

Bash $(if [[ "${-}" =~ [eu] ]]; then echo "Strict Mode activated"; else echo "Options"; fi) set ${-}

$(echo ${SHELLOPTS} | tr ':' '\n')
$(shopt -s)

EOF
}

_ucld_::set_terminal_mode() {
  set +eu
  set -E -o pipefail
  shopt -s failglob
  IFS=$'\n\t'
}

_ucld_::set_strict_mode() {
  _ucld_::hack_unbound_variables
  _ucld_::set_terminal_mode
  set -eu
}

_ucld_::set_strict_mode
if _ucld_::is_linux; then
  _ucld_::set_terminal_mode
fi
