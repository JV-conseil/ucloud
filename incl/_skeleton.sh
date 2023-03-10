#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::build_skeleton() {
  local _key _value

  echo -e "\nBuilding skeleton...\n"

  for _key in "${!UCLD_DIR[@]}"; do
    if [[ -z "${UCLD_DIR[${_key}]}" ]]; then
      continue
    fi
    mkdir "${UCLD_PATH["${_key}"]}" || :
  done
}

_ucld_::startup_check() {
  _ucld_::update_bashrc
  _ucld_::build_skeleton
  _ucld_::save_job_parameters
  _ucld_::init_settings
  echo
}
