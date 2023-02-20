#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# declare -A _ucld_db

# _ucld_db["name"]="demo"
# _ucld_db["port"]="5432"
# _ucld_db["user"]="manager"

DBPASS="$(_ucld_::key_gen 32)"
export DBPASS

_ucld_::pg_start() {
  pg_ctl start -D "${PATH_TO_DB}"
}

_ucld_::pg_restart() {
  pg_ctl restart -D "${PATH_TO_DB}"
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
  _su_pass="$(_ucld_::key_gen 32)"
  local _su_pass
  local _psql_commands=(
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

_ucld_::pg_conf_ssl() {
  local server_key
  server_key="${PATH_TO_DB}/server.key"

  cat <<EOF


=============================
 Configure SSL on PostgreSQL
=============================

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  if [[ ! -d ${PATH_TO_DB} ]]; then
    echo "${PATH_TO_DB}: No database directory found... exiting"
    return
  fi

  if [[ -f ${server_key} ]]; then
    echo
    read -r -n 1 -p "${server_key} already exists, do you want to delete it? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -v -rf "${server_key}"

      openssl genrsa -aes128 2048 >"${PATH_TO_DB}/server.key"
      openssl rsa -in "${PATH_TO_DB}/server.key" -out "${PATH_TO_DB}/server.key"
      chown ucloud "${PATH_TO_DB}/server.key"
      openssl req -new -x509 -days 365 -key "${PATH_TO_DB}/server.key" -out "${PATH_TO_DB}/server.crt"
      cp "${PATH_TO_DB}/server.crt" "${PATH_TO_DB}/root.crt"
    fi
  fi

  cat postgresql/postgresql.conf.txt
  nano "${PATH_TO_DB}/postgresql.conf"

  cat postgresql/pg_hba.conf.txt
  nano "${PATH_TO_DB}/pg_hba.conf"

}

_ucld_::create_env_file() {
  cat <<EOF

Creating an .env file...

EOF
  cat "incl/shebang.txt" >"${PATH_TO_ENV}"
  cat <<<"
export DEBUG=1

export DBHOST=\"${DBHOST}\"
export DBNAME=\"${DBNAME}\"
export DBPASS=\"${DBPASS}\"
export DBPORT=\"${DBPORT}\"
export DBSSLMODE=\"${DBSSLMODE}\"
export DBUSER=\"${DBUSER}\"

export PGSSLMODE=\"${DBSSLMODE}\"

export SECRET_KEY=\"$(_ucld_::key_gen 16)\"

export UCLOUD_PUBLIC_LINK=\"${UCLOUD_PUBLIC_LINK}\"
  " >>"${PATH_TO_ENV}"
}
