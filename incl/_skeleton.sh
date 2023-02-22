#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# shellcheck disable=SC2034
#
#====================================================

_ucld_::is_ubuntu_job() {
  local _bool=false
  if [[ "${PWD}" == "/work/"* ]]; then
    _bool=true
    if [[ -d "/work/database" ]]; then
      _bool=false
    fi
  fi
  echo ${_bool}
}

declare -A UCLD_SKELETON

for key in "${!UCLD_FOLDERS[@]}"; do

  value="${PATH_TO_WORK_DIR}/${UCLD_FOLDERS[${key}]}"
  UCLD_SKELETON["${key}"]="${value}"

  # .env file
  if [[ "${key}" == "env" ]]; then
    UCLD_SKELETON["env_file"]="${value}/.env"
  fi

  # globals
  eval "export PATH_TO_${key^^}=\"${value}\""

  # folder creation
  if [[ ! -d "${value}" && "$(_ucld_::is_ubuntu_job)" == true ]]; then
    mkdir "${value}"
  fi

done
