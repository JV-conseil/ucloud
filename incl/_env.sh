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

declare -a UCLD_INSTALL_PACKAGES UCLD_ALLOWED_HOSTS
declare -A UCLD_DB_PARAM UCLD_DIR UCLD_PATH # UCLD_PATH
declare -xi DEBUG

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "env/settings.conf" &>/dev/null
  # more files
}

export UCLD_ALLOWED_HOSTS

_ucld_::assign_path() {
  local _key
  UCLD_PATH=(["main"]="${PWD}" ["work"]="${PWD}")

  if [[ -d "${PWD%/*}" && $(_ucld_::is_ucloud_execution) == true ]]; then
    UCLD_PATH["work"]="${PWD%/*}"
  fi

  for _key in "${!UCLD_DIR[@]}"; do

    _value="${UCLD_PATH[work]}/${UCLD_DIR[${_key}]}"
    UCLD_PATH["${_key}"]="${_value}"

    # globals
    if [[ "${_key}" == "data" ]]; then
      eval "export UCLD_PATH_TO_${_key^^}=""${_value}"""
    fi

    # UCLD_PATH["${_key}"]="/work/${UCLD_DIR[${_key}]}"

  done

  if [[ "${DEBUG}" -gt 1 ]]; then
    echo -e "\nAssigning path for active job...\n"
    for _key in "${!UCLD_PATH[@]}"; do
      echo "UCLD_PATH[${_key}]=${UCLD_PATH[${_key}]}"
    done
  fi
}

_ucld_::assign_path
