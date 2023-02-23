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

declare -A UCLD_PG_PATH

for key in "${!UCLD_DIR[@]}"; do

  _value="/work/${UCLD_DIR[${key}]}"
  UCLD_PG_PATH["${key}"]="${_value}"

done

for key in ".pgpass" ".env"; do
  UCLD_PG_PATH["${key}"]="${UCLD_PG_PATH[env]}/${key}"
done

# DBPASS="$(_ucld_::key_gen 32)"
UCLD_DB_PARAM["pass"]="$(_ucld_::key_gen 32)"

declare -xr PGSSLMODE="${UCLD_DB_PARAM[sslmode]}"
declare -xr PGPASSFILE="${UCLD_PG_PATH[".pgpass"]}"
declare -xr PGUSER="ucloud"

declare -r UCLD_DB_PARAM UCLD_PG_PATH
