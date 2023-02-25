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

declare -a UCLD_INSTALL_PACKAGES UCLD_PUBLIC_LINKS
declare -A UCLD_DB_PARAM UCLD_DIR UCLD_PATH
declare -xi DEBUG

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "env/settings.conf" &>/dev/null
  # more files
}

_ucld_::assign_path() {
  local _key _path _main _msg
  UCLD_PATH=(["main"]="${PWD}" ["work"]="${PWD}")
  _msg=0

  if [[ -d "${PWD%/*}" && $(_ucld_::is_ucloud_execution) == true ]]; then
    UCLD_PATH["work"]="${PWD%/*}"
  fi

  for _key in "${!UCLD_DIR[@]}"; do

    _path="${UCLD_PATH[work]}/${UCLD_DIR[${_key}]}"

    # if [[
    #   (${UCLD_PATH["${_key}"]+x} && "${_path}" != "${UCLD_PATH["${_key}"]}") ||
    #   ! ${UCLD_PATH["${_key}"]+x} ]]; then

    if [[ 
      (-v ${UCLD_PATH["${_key}"]} && "${_path}" != "${UCLD_PATH["${_key}"]}") ||
      ! -v ${UCLD_PATH["${_key}"]} ]]; then

      if [[ "$_msg" -eq 0 ]]; then
        echo -e "\nAssigning path for active job...\n"
        for _main in "main" "work"; do
          echo "UCLD_PATH[${_main}]=${UCLD_PATH[${_main}]}"
        done
        _msg=1
      fi

      UCLD_PATH["${_key}"]="${_path}"
      echo "UCLD_PATH[${_key}]=${_path}"

      if [[ "${_key}" == "data" ]]; then
        eval "export UCLD_PATH_TO_${_key^^}=""${_path}"""
      fi

    fi

  done

}

_ucld_::assign_path
