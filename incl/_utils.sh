#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::back_to_script_dir_() {
  cd_ "${PATH_TO_SCRIPT_DIR}" || exit
}

_ucld_::debug() {
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
    # print environment variables sorted by name
    # <https://stackoverflow.com/a/60756021/2477854>
    echo
    env -0 | sort -z | tr '\0' '\n'
    echo
  fi

}

_ucld_::key_gen() {
  # e.g.: $(_ucld_::key_gen 15)
  local _size=${1:-15}
  openssl rand -base64 "${_size}"
}

_ucld_::parent_directory() {
  # <https://stackoverflow.com/a/24112741/2477854>
  echo "$(
    cd_ "$(dirname "${BASH_SOURCE[0]}")" || exit
    pwd -P
  )"
}
