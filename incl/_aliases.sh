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

if ! [ -x "$(command -v cd_)" ]; then
  # alias cp='cp -iv'     # Preferred 'cp' implementation
  alias cp_='cp'          # Silent 'cp'
  alias cp='cp -v'        # Preferred 'cp' implementation
  alias mv='mv -iv'       # Preferred 'mv' implementation
  alias mkdir='mkdir -pv' # Preferred 'mkdir' implementation
  alias rm='rm -vrf'      # Preferred 'rm' implementation

  # Silent cd with no list directory
  cd_() { builtin cd "$@" || exit; }
  # Always list directory contents upon 'cd'
  cd() {
    builtin cd "$@" || exit
    ls
  }

  nano() {
    command nano --linenumbers "$@"
  }
fi

if ! grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
  cat <<<"


#====================================================
" >>"${HOME}/.profile"
  cat incl/_aliases.sh >>"${HOME}/.profile"
fi
