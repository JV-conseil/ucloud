#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "env/settings.conf" &>/dev/null
  # more files
}

declare -xi DEBUG

if [[ -z ${PATH_TO_SCRIPT_DIR} ]]; then

  readonly PATH_TO_SCRIPT_DIR="${PWD}"
  readonly PATH_TO_WORK_DIR="${PATH_TO_SCRIPT_DIR%/*}"

fi

export PATH_TO_DATA_DIR="${PATH_TO_WORK_DIR}/${UCLD_DATA_DIR}"
export PATH_TO_INSTALL_DIR="${PATH_TO_WORK_DIR}/${UCLD_INSTALL_DIR}"
export PATH_TO_ENV="${PATH_TO_WORK_DIR}/${UCLD_ENV_DIR}/.env"
export PATH_TO_PGPASS="${PATH_TO_WORK_DIR}/${UCLD_ENV_DIR}/.pgpass"
