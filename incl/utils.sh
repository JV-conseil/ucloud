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
  . "incl/_env.sh"
  . "incl/_exceptions.sh"
  # more files
}

_ucld_::back_to_script_dir_() {
  cd_ "${UCLD_PATH[main]}"
}

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

_ucld_::build_skeleton() {
  if [[ 
    "$(_ucld_::is_ucloud_execution)" == false ||
    "$(_ucld_::is_ubuntu_job)" == false ]] \
    ; then
    return
  fi

  for key in "${!UCLD_PATH[@]}"; do
    value="${UCLD_PATH["${key}"]}"
    if [ ! -d "${value}" ]; then
      mkdir "${value}"
    fi
  done
}

_ucld_::is_postgresql_running() {
  local _bool=false
  if [ -x "$(command -v psql)" ]; then _bool=true; fi
  echo ${_bool}
}

_ucld_::is_ucloud_execution() {
  local _bool=false
  if [[ "${PWD}" == "/work/"* ]]; then _bool=true; fi
  echo ${_bool}
}

_ucld_::is_ubuntu_job() {
  local _bool=true
  if [[ -d "/work/${UCLD_DIR[database]}" ]]; then _bool=false; fi
  echo ${_bool}
}

_ucld_::update_bashrc() {
  if grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
    return
  fi
  for _file in ".profile" ".bashrc"; do
    cat <<<"


#====================================================" >>"${HOME}/${_file}"
    cat incl/_aliases.sh >>"${HOME}/${_file}"
  done
}
