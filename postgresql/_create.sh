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

_ucld_::pg_create_db() {
  local _psql_commands=(
    "DROP DATABASE IF EXISTS ${UCLD_DB_PARAM[name]} ;"
    "DROP USER ${UCLD_DB_PARAM[user]} ;"
    "CREATE USER ${UCLD_DB_PARAM[user]} WITH PASSWORD '${UCLD_DB_PARAM[password]}' ;"
    "CREATE DATABASE ${UCLD_DB_PARAM[name]} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${UCLD_DB_PARAM[name]} TO ${UCLD_DB_PARAM[user]} ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    # echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}" 1>/dev/null 2>>logfile.log
  done

  _ucld_::pg_list
}

_ucld_::dump_env_file() {
  cat "incl/.shebang.txt" >"${UCLD_PG_PATH[".env"]}"
  cat <<<"
export DEBUG=${DEBUG}

export DBHOST=""${UCLD_DB_PARAM[host]}""
export DBNAME=""${UCLD_DB_PARAM[name]}""
export DBPASS=""${UCLD_DB_PARAM[password]}""
export DBPORT=""${UCLD_DB_PARAM[port]}""
export DBSSLMODE=""${UCLD_DB_PARAM[sslmode]}""
export DBSSLROOTCERT=""${PGSSLROOTCERT}""
export DBUSER=""${UCLD_DB_PARAM[user]}""

export SECRET_KEY=""$(_ucld_::key_gen 32)""

export UCLD_PUBLIC_LINK=""${UCLD_PUBLIC_LINK}""
  " >>"${UCLD_PG_PATH[".env"]}"
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\du+"
  psql --dbname=postgres --command="\l+"
  psql postgres
}

_ucld_::pg_update_su_password() {
  local _psql_commands _su_pass
  _su_pass="$(_ucld_::key_gen 32)"
  _psql_commands=(
    "ALTER ROLE ${PGUSER} WITH PASSWORD '${_su_pass}' ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    # echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}" 1>/dev/null 2>>logfile.log
  done

  cat "incl/.shebang.txt" >"${UCLD_PG_PATH[".pgpass"]}"
  echo "localhost:5432:${PGUSER}:${PGUSER}:${_su_pass}" >>"${UCLD_PG_PATH[".pgpass"]}"
  chmod 600 "${UCLD_PG_PATH[".pgpass"]}"
}
