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

  readonly PATH_TO_DATA_DIR="${PATH_TO_WORK_DIR}/${UCLD_DATA_DIR}"
  readonly PATH_TO_INSTALL_DIR="${PATH_TO_WORK_DIR}/${UCLD_INSTALL_DIR}"
  readonly PATH_TO_ENV="${PATH_TO_WORK_DIR}/${UCLD_ENV_DIR}/.env"
  readonly PATH_TO_PGPASS="${PATH_TO_WORK_DIR}/${UCLD_ENV_DIR}/.pgpass"

fi
