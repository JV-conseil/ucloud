#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::reset_settings() {
  rm -v "${UCLD_PATH[env]}/settings.conf"
  cp "./settings.conf" "${UCLD_PATH[env]}/settings.conf"
  _ucld_::assign_path
}

_ucld_::update_settings() {
  local _add="${1}"
  echo "${_add}" >>"${UCLD_PATH[env]}/settings.conf"
  _ucld_::assign_path
}
