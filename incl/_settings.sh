#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

declare -a UCLD_SETTINGS_DIR

UCLD_SETTINGS_DIR=("app" "django")

_ucld_::edit_settings() {
  nano "${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::show_settings() {
  cat "${UCLD_PATH[env]}/settings.conf"
}

_ucld_::source_settings() {
  # shellcheck disable=SC1091
  . "${UCLD_PATH[env]}/settings.conf"
  _ucld_::assign_path
}

_ucld_::reset_settings() {
  local _path
  rm -v "${UCLD_PATH[env]}/settings.conf"
  for _key in "${UCLD_SETTINGS_DIR[@]}"; do
    unset "UCLD_PATH[${_key}]"
  done
  cp -v "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::update_settings() {
  echo "${1}" >>"${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::init_settings() {
  if [[ ! -f "${UCLD_PATH[env]}/settings.conf" ]]; then
    cp -v "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  fi
}
