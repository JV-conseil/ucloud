#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC2034
declare -a UCLD_INSTALL_PACKAGES UCLD_PUBLIC_LINKS
declare -A UCLD_DB_PARAM UCLD_DIR UCLD_PATH
declare -ix DEBUG=0 BASH_STRICT_MODE=0

UCLD_PATH=([main]="${PWD}" [work]="${PWD}")

if "$(_ucld_::is_ucloud_env)" && [ -d "${PWD%/*}" ]; then
  UCLD_PATH["work"]="${PWD%/*}"
fi

UCLD_DIR=([app]="" [env]=env [data]="" [database]="" [django]="" [install]="" [jobs]=jobs)

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
      eval "export UCLD_PATH_TO_${_key^^}=\"${_path}\""
    fi
  done
}

# shellcheck source=/dev/null
{
  . "./settings.conf"
  . "${UCLD_PATH[env]}/settings.conf" 2>>logfile.log || :
  # more files
}

_ucld_::build_path
