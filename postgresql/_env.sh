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

# for key in ".pgpass" ".env"; do
#   UCLD_PG_PATH["${key}"]="${UCLD_PG_PATH[env]}/${key}"
# done

_ucld_::assign_path

UCLD_DB_PARAM["password"]="$(_ucld_::key_gen 32)"

{
  export PGPASSFILE="${UCLD_PG_PATH[".pgpass"]}"
  export PGSSLROOTCERT="${UCLD_PG_PATH[env]}/server.cert.pem"
  export PGSSLMODE="${UCLD_DB_PARAM[sslmode]}"
  export PGUSER="ucloud"
  # } 2>>logfile.log &
} 2> >(
  while read -r _line; do
    printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" >>logfile.log
  done >&2
) &
