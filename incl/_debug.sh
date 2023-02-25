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
  local _key
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
    # # env -0 | sort -z | tr '\0' '\n'
    # env
    # echo

    echo "$(
      set -o posix
      set | sort
    )"

    # for _key in "${!UCLD_PATH[@]}"; do
    #   echo "UCLD_PATH[${_key}]=${UCLD_PATH[${_key}]}"
    # done

    echo
    alias
  fi

}
