#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::back_to_script_dir_() {
  cd_ "${UCLD_PATH[main]}"
}

_ucld_::clean_hostname() {
  local _hostname="${HOSTNAME}"
  if [ -z "${_hostname}" ]; then
    return
  fi
  _hostname="${_hostname/-job/}"
  _hostname="${_hostname/j-/}"
  if [ -n "${_hostname}" ]; then
    echo "${_hostname}"
  fi
}

_ucld_::clean_app_hostname() {
  local _hostname
  _hostname="$(_ucld_::clean_hostname)"
  if [ -n "${_hostname}" ]; then
    echo "app-${_hostname}.cloud.sdu.dk"
  fi
}

_ucld_::is_debian_running() {
  local _bool=false
  if [[ "$(cat /etc/issue 2>/dev/null || :)" == "Debian "* ]]; then _bool=true; fi
  echo "${_bool}"
}

_ucld_::is_jq_installed() {
  local _bool=false
  if [ -x "$(command -v jq)" ]; then
    _bool=true
  else
    sudo apt-get update && sudo apt-get install -y jq
    _bool=true
  fi
  echo "${_bool}"
}

_ucld_::is_python_installed() {
  local _bool=false
  if [ -x "$(command -v python)" ]; then _bool=true; fi
  echo ${_bool}
}

_ucld_::is_ucloud_env() {
  local _bool=false
  if [[ "${PWD}" == "/work/"* ]]; then _bool=true; fi
  echo ${_bool}
}

# e.g.: $(_ucld_::key_gen 128)
_ucld_::key_gen() {
  local _size=${1:-15}
  if type python &>/dev/null; then
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

_ucld_::save_job_parameters() {
  local _app _job="/work/JobParameters.json" _path="/work/jobs"
  if [ ! -f "${_job}" ] || [ ! -d "${_path}" ]; then
    return
  fi
  if "$(_ucld_::is_jq_installed)"; then
    _app="$(cat <"${_job}" | jq -r '.request.application.name')"
    # mkdir "${_path}" &&
    cp "${_job}" "${_path}/${_app^}JobParameters.json"
  fi
}

_ucld_::save_job_parameters

_ucld_::update_bashrc() {
  local _file
  if grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
    return
  fi

  for _file in ".profile" ".bashrc"; do
    cat <<<"


#====================================================" >>"${HOME}/${_file}"
    cat incl/__aliases.sh >>"${HOME}/${_file}"
  done
}
