#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::pg_create_db() {
  local _psql_commands _cmd

  _psql_commands=(
    "DROP DATABASE IF EXISTS ${UCLD_DB_PARAM[name]} ;"
    "DROP USER IF EXISTS ${UCLD_DB_PARAM[user]} ;"
    "CREATE USER ${UCLD_DB_PARAM[user]} WITH PASSWORD '${UCLD_DB_PARAM[password]}' ;"
    "CREATE DATABASE ${UCLD_DB_PARAM[name]} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${UCLD_DB_PARAM[name]} TO ${UCLD_DB_PARAM[user]} ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    # echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}"
  done

  # _ucld_::pg_list
}

_ucld_::dump_env_file() {
  local _env_file="${UCLD_PATH[env]}/.env"
  cat "incl/.shebang.txt" >"${_env_file}"
  cat <<<"
export DBHOST=""${UCLD_DB_PARAM[host]}""
export DBNAME=""${UCLD_DB_PARAM[name]}""
export DBPASS=""${UCLD_DB_PARAM[password]}""
export DBPORT=""${UCLD_DB_PARAM[port]}""
export DBSSLMODE=""${UCLD_DB_PARAM[sslmode]}""
export DBSSLROOTCERT=""${PGSSLROOTCERT}""
export DBUSER=""${UCLD_DB_PARAM[user]}""

export SECRET_KEY=""$(_ucld_::key_gen 32)""

export UCLD_PATH_TO_DATA=\"${UCLD_PATH[data]}\"" >>"${_env_file}"
}

_ucld_::pg_update_su_password() {
  local _psql_commands _su_pass _cmd

  _su_pass="$(_ucld_::key_gen 32)"
  _psql_commands=(
    "ALTER ROLE ${PGUSER} WITH PASSWORD '${_su_pass}' ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    # echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}"
  done

  cat "incl/.shebang.txt" >"${PGPASSFILE}"
  # echo "localhost:5432:${PGUSER}:${PGUSER}:${_su_pass}" >>"${PGPASSFILE}"
  echo "localhost:5432:*:${PGUSER}:${_su_pass}" >>"${PGPASSFILE}"
  chmod 600 "${PGPASSFILE}"
}
