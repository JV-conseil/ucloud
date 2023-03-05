#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

if [ "${BASH_STRICT_MODE}" -gt 0 ]; then
  _ucld_::set_strict_mode
fi

_ucld_::edit_settings() {
  nano "${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::show_settings() {
  cat "${UCLD_PATH[env]}/settings.conf"
}

_ucld_::source_settings() {
  # shellcheck source=/dev/null
  . "${UCLD_PATH[env]}/settings.conf"
  _ucld_::build_path
}

_ucld_::reset_settings() {
  local _path
  rm -v "${UCLD_PATH[env]}/settings.conf"
  cp -v "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::update_settings() {
  local _add="${1}" _file="${UCLD_PATH[env]}/settings.conf"
  if grep -F -q "${_add}" "${_file}"; then
    return
  fi
  echo "${1}" >>"${_file}"
  _ucld_::source_settings
}

_ucld_::init_settings() {
  if [[ ! -f "${UCLD_PATH[env]}/settings.conf" ]]; then
    cp -v "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  fi
}
