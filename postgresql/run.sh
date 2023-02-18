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
  . "../common/.bashrc"
  . "../common/utils.sh"
  # more files
}

export DBHOST="0.0.0.0"
export DBNAME="welcome"
DBPASS="$(_ucld_::generate_key)"
export DBPASS
export DBPORT="5432"
export DBUSER="manager"

export PATH_TO_DATABASE="/work/database"

_ucld_::pg_start() {
  pg_ctl -D "${PATH_TO_DATABASE}"
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\l+"
  psql postgres
}

_ucld_::pg_create_db() {
  _ucld_::pg_start

  __psql_commands=(
    "CREATE USER ${DBUSER} WITH PASSWORD '${DBPASS}' ;"
    "ADD ROLE ucloud TO ${DBUSER} ;"
    "CREATE DATABASE ${DBNAME} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${DBNAME} TO ${DBUSER} ;"
  )

  for __cmd in "${__psql_commands[@]}"; do
    echo "${__cmd}"
    psql --dbname=postgres --command="${__cmd}"
  done

  _ucld_::pg_list
}

cat "README.txt"

echo
read -r -n 1 -p "Do you want to create a new DB User & Database ? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  _ucld_::pg_create_db

else
  _ucld_::pg_list
fi
