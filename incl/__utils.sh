#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2024 JV-conseil
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
  else
    echo ""
  fi
}

_ucld_::is_debian_running() {
  if [[ "$(cat /etc/issue 2>/dev/null || :)" == "Debian "* ]]; then
    true
  else
    false
  fi
}

_ucld_::is_jq_installed() {
  _ucld_::is_package_installed jq
}

_ucld_::is_package_installed() {
  if type apt-get &>/dev/null; then
    if [ -x "$(command -v "${1}")" ]; then
      true
    else
      sudo apt-get update &>/dev/null
      sudo apt-get install -y "${1}" &>/dev/null
      true
    fi
  else
    false
  fi
}

_ucld_::is_python_installed() {
  if [ -x "$(command -v python)" ]; then
    true
  else
    false
  fi
}

_ucld_::is_ucloud_env() {
  if [[ "${PWD}" == "/work/"* ]]; then
    true
  else
    false
  fi
}

_ucld_::is_xclip_installed() {
  _ucld_::is_package_installed xclip
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
  if [[ "${1}" =~ ^[a-zA-Z0-9_./-]+$ ]]; then
    true
  else
    false
  fi
}

_ucld_::save_job_parameters() {
  local _app _job="/work/JobParameters.json" _path="jobs"
  if [ ! -f "${_job}" ]; then
    return
  fi
  if _ucld_::is_jq_installed; then
    _app="$(cat <"${_job}" | jq -r '.request.application.name')"
    _path="${_path}/${_app^}JobParameters.json"
    cp "${_job}" "/work/${_path}" 2>>logfile.log || :
    cp "${_job}" "../${_path}" 2>>logfile.log || :
  fi
}

_ucld_::save_job_parameters

_ucld_::append_bashrc_profile() {
  local _file
  if grep -q "cd_() " "${HOME}/.profile" &>>logfile.log; then
    return
  fi

  for _file in ".profile" ".bashrc"; do
    {
      cat <<<"


#===================================================="
      cat incl/__aliases.sh
      cat incl/menu.sh
    } >>"${HOME}/${_file}"
    # shellcheck source=/dev/null
    . "${HOME}/${_file}"
  done
}

# DEPRECATED

_ucld_::save_job_parameters_v1() {
  local _app _job="/work/JobParameters.json" _path="/work/jobs"
  if [ ! -f "${_job}" ] || [ ! -d "${_path}" ]; then
    return
  fi
  if _ucld_::is_jq_installed; then
    _app="$(cat <"${_job}" | jq -r '.request.application.name')"
    # mkdir "${_path}" &&
    cp "${_job}" "${_path}/${_app^}JobParameters.json"
  fi
}
