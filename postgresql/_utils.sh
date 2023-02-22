#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

UCLD_DB_PATH="/work/${UCLD_FOLDERS[database]}"
PATH_TO_PGPASS="${PATH_TO_ENV}/.pgpass"

# DB connections strings DBNAME, DBHOST...
for key in "${!DATABASE_PARAM[@]}"; do
  eval "DB${key^^}=\"${DATABASE_PARAM[${key}]}\""
done

DBPASS="$(_ucld_::key_gen 32)"

_ucld_::pg_start() {
  pg_ctl start -D "${UCLD_DB_PATH}"
}

_ucld_::pg_restart() {
  pg_ctl restart -D "${UCLD_DB_PATH}"
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\l+"
  psql postgres
}

_ucld_::pg_create_db() {
  local _psql_commands=(
    "DROP DATABASE IF EXISTS ${DBNAME} ;"
    "DROP USER ${DBUSER} ;"
    "CREATE USER ${DBUSER} WITH PASSWORD '${DBPASS}' ;"
    "CREATE DATABASE ${DBNAME} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${DBNAME} TO ${DBUSER} ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}"
  done

  psql --dbname=postgres --command="\du+"
  _ucld_::pg_list
}

_ucld_::pg_update_su_password() {
  local _psql_commands, _su_pass
  _su_pass="$(_ucld_::key_gen 32)"
  _psql_commands=(
    "ALTER ROLE ucloud WITH PASSWORD '${_su_pass}' ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}"
  done

  cat <<EOF

Creating a .pgpass file...

EOF

  cat "incl/shebang.txt" >"${PATH_TO_PGPASS}"
  echo "0.0.0.0:5432:postgres:ucloud:${_su_pass}" >>"${PATH_TO_PGPASS}"
}
