#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::source_settings() {
  # shellcheck disable=SC1091
  . "${UCLD_PATH[env]}/settings.conf"
  _ucld_::assign_path
}

_ucld_::reset_settings() {
  rm -v "${UCLD_PATH[env]}/settings.conf"
  cp -v "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::update_settings() {
  if [[ "${DEBUG}" -gt 0 ]]; then
    _ucld_::h3 "Appending ${1} to ${UCLD_PATH[env]}/settings.conf"
  fi
  echo "${1}" >>"${UCLD_PATH[env]}/settings.conf"
  _ucld_::source_settings
}

_ucld_::show_settings() {
  if [[ "${DEBUG}" -eq 0 ]]; then
    return
  fi
  _ucld_::h3 "Your settings can be modified with\nnano ${UCLD_PATH[env]}/settings.conf"
  cat "${UCLD_PATH[env]}/settings.conf"
}
