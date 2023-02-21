#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

alias ls='ls -FGlAhp'

# if [[ $(cd_ "$@" &>>logfile.log) -ne 0 ]]; then
if ! [ -x "$(command -v cd_)" ]; then
  # alias cp='cp -iv'                # Preferred 'cp' implementation
  alias cp='cp -v'        # Preferred 'cp' implementation
  alias mv='mv -iv'       # Preferred 'mv' implementation
  alias mkdir='mkdir -pv' # Preferred 'mkdir' implementation

  # ls() { command ls -FGlAhp "$@"; }

  cd_() { builtin cd "$@" || exit; } # Silent cd with no list directory
  # Always list directory contents upon 'cd'
  cd() {
    builtin cd "$@" || exit
    ls
  }
fi

nano() {
  command nano --linenumbers "$@"
}

if ! grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
  cat incl/_aliases.sh >>"${HOME}/.profile"
fi
