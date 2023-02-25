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


===================
 DEBUG information
===================

EOF

  cat /proc/version &>/dev/null
  cat /etc/issue &>/dev/null
  bash --version
  python --version

  if [[ "${DEBUG}" -gt 1 ]]; then

    # echo
    # env
    # echo

    echo "$(
      set -o posix
      set | sort
    )"

    echo
    alias
  fi

}
