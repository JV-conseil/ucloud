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
  cd_ "${PATH_TO_SCRIPT_DIR}"
}

_ucld_::debug() {
  cat <<EOF


===================
 DEBUG information
===================

EOF
  cat /proc/version 2>>logfile.log
  cat /etc/issue 2>>logfile.log
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
  # e.g.: $(_ucld_::key_gen 128)
  local _size=${1:-15}
  # if [[ $(python --version &>>logfile.log) -ne 0 ]]; then
  if [ -x "$(command -v python)" ]; then
    python -c "import secrets; result = ''.join(secrets.choice('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-+') for i in range($_size)); print(result)"
  else
    openssl rand -base64 "${_size}"
  fi
}

_ucld_::parent_directory() {
  # <https://stackoverflow.com/a/24112741/2477854>
  echo "$(
    cd_ "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
  )"
}

_ucld_::is_postgresql_running() {
  local _bool=false
  if [ -x "$(command -v psql)" ]; then _bool=true; fi
  echo ${_bool}
}
