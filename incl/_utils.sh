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
  cd_ "${UCLD_PATH[main]}"
}

_ucld_::is_postgresql_server_running() {
  local _bool=false
  if [ -x "$(command -v pg_ctl)" ]; then
    if pg_ctl status -D "${UCLD_PATH[database]}" &>/dev/null; then _bool=true; fi
  elif [ -x "$(command -v python)" ]; then
    if python manage.py check --database default &>/dev/null; then _bool=true; fi
  fi
  echo ${_bool}
}

_ucld_::is_python_installed() {
  local _bool=false
  if [ -x "$(command -v python)" ]; then _bool=true; fi
  echo ${_bool}
}

_ucld_::is_ucloud_execution() {
  local _bool=false
  if [[ "${PWD}" == "/work/"* ]]; then _bool=true; fi
  echo ${_bool}
}

# e.g.: $(_ucld_::key_gen 128)
_ucld_::key_gen() {
  local _size=${1:-15}
  # if [ -x "$(command -v python)" ]; then
  if "$(_ucld_::is_python_installed)"; then
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

# sanitize input using a regular expression
_ucld_::sanitize_input() {
  local _bool=false
  if [[ "${1}" =~ ^[a-zA-Z0-9_./-]+$ ]]; then _bool=true; fi
  echo "${_bool}"
}

_ucld_::update_bashrc() {
  local _file
  if grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
    return
  fi

  for _file in ".profile" ".bashrc"; do
    cat <<<"


#====================================================" >>"${HOME}/${_file}"
    cat incl/_aliases.sh >>"${HOME}/${_file}"
  done
}
