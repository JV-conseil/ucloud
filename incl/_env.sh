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

declare -a UCLD_INSTALL_PACKAGES
declare -A UCLD_DB_PARAM UCLD_DIR UCLD_PATH UCLD_PG_PATH
declare -xi DEBUG

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "env/settings.conf" &>/dev/null
  # more files
}

UCLD_PATH["main"]="${PWD}"
UCLD_PATH["work"]="${UCLD_PATH[main]%/*}"

# export UCLD_PATH[main]="${PWD}"
# export UCLD_PATH[work]="${UCLD_PATH[main]%/*}"

for key in "${!UCLD_DIR[@]}"; do

  _value="${UCLD_PATH[work]}/${UCLD_DIR[${key}]}"
  UCLD_PATH["${key}"]="${_value}"

  # globals
  if [[ "${key}" == "data" ]]; then
    eval "export UCLD_PATH_TO_${key^^}=\"${_value}\""
  fi

done
