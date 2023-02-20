#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC1091
{
  . "_install.sh"
  . "_utils.sh"
  # more files
}

# alias cp='cp -iv'                # Preferred 'cp' implementation
alias cp='cp -v'                   # Preferred 'cp' implementation
alias mv='mv -iv'                  # Preferred 'mv' implementation
alias mkdir='mkdir -pv'            # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'              # Preferred 'ls' implementation
alias ls='ll'                      # Preferred 'ls' implementation
cd_() { builtin cd "$@" || exit; } # Silent cd with no list directory
# Always list directory contents upon 'cd'
cd() {
  builtin cd "$@" || exit
  ll
}
nano() {
  command nano --linenumbers "$@"
}

if [[ "${DEBUG}" == 1 ]]; then
  _ucld_::debug
fi
