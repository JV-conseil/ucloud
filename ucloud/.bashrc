#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# alias cp='cp -iv'                # Preferred 'cp' implementation
alias cp='cp -v'                   # Preferred 'cp' implementation
alias mv='mv -iv'                  # Preferred 'mv' implementation
alias mkdir='mkdir -pv'            # Preferred 'mkdir' implementation
alias ls='ls -FGlAhp'              # Preferred 'ls' implementation
cd_() { builtin cd "$@" || exit; } # Silent cd with no list directory
# Always list directory contents upon 'cd'
cd() {
  builtin cd "$@" || exit
  ls
}

cat /proc/version || :
cat /etc/issue || :
bash --version

if [[ "${DEBUG}" == 1 ]]; then
  # print environment variables sorted by name
  # <https://stackoverflow.com/a/60756021/2477854>
  env -0 | sort -z | tr '\0' '\n'
fi
