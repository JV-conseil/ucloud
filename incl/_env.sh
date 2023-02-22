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

declare -a INSTALL_LINUX_PACKAGES
declare -A DATABASE_PARAM UCLD_FOLDERS

# shellcheck disable=SC1091
{
  . "./settings.conf"
  . "env/settings.conf" 2>>logfile.log
  # more files
}

declare -xi DEBUG

export PATH_TO_SCRIPT_DIR="${PWD}"
export PATH_TO_WORK_DIR="${PATH_TO_SCRIPT_DIR%/*}"
