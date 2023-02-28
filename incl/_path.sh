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

UCLD_PATH=([main]="${PWD}" [work]="${PWD}")

if [[ -d "${PWD%/*}" && $(_ucld_::is_ucloud_execution) == true ]]; then
  UCLD_PATH["work"]="${PWD%/*}"
fi

UCLD_DIR=([app]=env [env]=env [data]="" [database]="" [django]="" [install]="")

UCLD_PATH[env]="${UCLD_PATH[work]}/${UCLD_DIR[env]}"

_ucld_::build_path() {
  local _key _path

  for _key in "${!UCLD_DIR[@]}"; do

    if [[ -z "${UCLD_DIR[${_key}]}" ]]; then
      continue
    fi

    _path="${UCLD_PATH[work]}/${UCLD_DIR[${_key}]}"

    UCLD_PATH["${_key}"]="${_path}"

    if [[ "${_key}" == "data" ]]; then
      eval "export UCLD_PATH_TO_${_key^^}=""${_path}"""
    fi
  done
}

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "${UCLD_PATH[env]}/settings.conf" 2>>logfile.log
  # more files
}

_ucld_::build_path

# deprecated

# _ucld_::build_path_v1() {
#   local _key _path _main _msg
#   UCLD_PATH["main"]="${PWD}"
#   UCLD_PATH["work"]="${PWD}"
#   _msg=0

#   if [[ -d "${PWD%/*}" && $(_ucld_::is_ucloud_execution) == true ]]; then
#     UCLD_PATH["work"]="${PWD%/*}"
#   fi

#   for _key in "${!UCLD_DIR[@]}"; do

#     _path="${UCLD_PATH[work]}/${UCLD_DIR[${_key}]}"

#     if [[
#       ! ${UCLD_PATH["${_key}"]+_} ||
#       (${UCLD_PATH["${_key}"]+_} && "${_path}" != "${UCLD_PATH["${_key}"]}") ]]; then

#       if [[ "$_msg" -eq 0 ]]; then
#         echo -e "\nAssigning path for active job...\n"
#         for _main in "main" "work"; do
#           echo "UCLD_PATH[${_main}]=${UCLD_PATH[${_main}]}"
#         done
#         _msg=1
#       fi

#       UCLD_PATH["${_key}"]="${_path}"
#       echo "UCLD_PATH[${_key}]=${_path}"

#       if [[ "${_key}" == "data" ]]; then
#         eval "export UCLD_PATH_TO_${_key^^}=""${_path}"""
#       fi

#     fi

#   done

# }
