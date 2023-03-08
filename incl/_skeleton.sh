#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
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

_ucld_::save_job_parameters() {
  local _app _job="/work/JobParameters.json"
  if [ ! -f "${_job}" ]; then
    return
  fi
  _app="$(cat <"${_job}" | jq -r '.request.application.name')"
  cp -pv "${_job}" "${UCLD_PATH[jobs]}/${_app^}JobParameters.json"
}

_ucld_::startup_check() {
  _ucld_::update_bashrc
  _ucld_::build_skeleton
  _ucld_::save_job_parameters
  _ucld_::init_settings
  echo
}
