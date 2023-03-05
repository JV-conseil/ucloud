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
set -E
shopt -s failglob
IFS=$'\n\t'

_ucld_::is_linux() {
  local _bool=false
  if [[ "$(cat /proc/version 2>/dev/null || :)" == "Linux"* ]]; then _bool=true; fi
  echo "${_bool}"
}

if ! "$(_ucld_::is_linux)"; then
  set -Eeuo pipefail
fi

if [[ "${-}" == *"e"* ]]; then
  cat <<EOF

=====================================
 Bash Strict Mode activated ${-}
=====================================

$(shopt -s)

EOF
fi
