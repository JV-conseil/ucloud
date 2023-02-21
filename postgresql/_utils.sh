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

DBHOST="${UCLOUD_DB_HOSTNAME}"
DBPASS="$(_ucld_::key_gen 32)"

_ucld_::pg_start() {
  pg_ctl start -D "${UCLOUD_DB_PATH}"
}

_ucld_::pg_restart() {
  pg_ctl restart -D "${UCLOUD_DB_PATH}"
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
  server_key="${UCLOUD_DB_PATH}/server.key"

  cat <<EOF


Configure SSL on PostgreSQL
---------------------------

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  if [[ ! -d ${UCLOUD_DB_PATH} ]]; then
    echo "Error: ${UCLOUD_DB_PATH} database directory not found... exiting"
    return
  fi

  if [[ -f ${server_key} ]]; then
    echo
    read -r -n 1 -p "${server_key} already exists, do you want to delete it? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -vrf "${server_key}"

      openssl genrsa -aes128 2048 >"${UCLOUD_DB_PATH}/server.key"
      openssl rsa -in "${UCLOUD_DB_PATH}/server.key" -out "${UCLOUD_DB_PATH}/server.key"
      chown ucloud "${UCLOUD_DB_PATH}/server.key"
      openssl req -new -x509 -days 365 -key "${UCLOUD_DB_PATH}/server.key" -out "${UCLOUD_DB_PATH}/server.crt"
      cp "${UCLOUD_DB_PATH}/server.crt" "${UCLOUD_DB_PATH}/root.crt"
    fi
  fi

  cat postgresql/postgresql.conf.txt
  cat <<EOF

nano "${UCLOUD_DB_PATH}/postgresql.conf"

EOF

  cat postgresql/pg_hba.conf.txt
  cat <<EOF

nano "${UCLOUD_DB_PATH}/pg_hba.conf"

EOF

}

_ucld_::create_env_file() {
  cat <<EOF

Creating an .env file...

EOF
  cat "incl/shebang.txt" >"${PATH_TO_ENV}"
  cat <<<"
export DEBUG=${DEBUG}

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
