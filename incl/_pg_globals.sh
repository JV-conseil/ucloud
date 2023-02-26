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

UCLD_DB_PARAM["password"]="$(_ucld_::key_gen 32)"

export PGPASSFILE="${UCLD_PATH[env]}/.pgpass"
export PGSSLROOTCERT="${UCLD_PATH[database]}/root.crt"
export PGSSLMODE="${UCLD_DB_PARAM[sslmode]}"
export PGUSER="ucloud"
