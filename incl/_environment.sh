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
. "settings.conf"

export DEBUG

export UCLOUD_PUBLIC_LINK
export UCLOUD_DB_HOSTNAME
export UCLOUD_DB_PATH

export PATH_TO_SCRIPT_DIR="${PWD}"
export PATH_TO_WORK_DIR="${PATH_TO_SCRIPT_DIR%/*}"
export PATH_TO_DATA_DIR="${PATH_TO_WORK_DIR}/data"
export PATH_TO_INSTALL_DIR="${PATH_TO_WORK_DIR}/install"
export PATH_TO_ENV="${PATH_TO_WORK_DIR}/env/.env"
export PATH_TO_PGPASS="${PATH_TO_WORK_DIR}/env/.pgpass"
