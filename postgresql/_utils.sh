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

UCLD_DB_PATH="/work/${UCLD_DATABASE_DIR}"
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

_ucld_::generate_ssl_certificate() {
  local _password _server_key _subject
  _server_key="${UCLD_DB_PATH}/server.key"
  _password="$(_ucld_::key_gen)"
  _subject="/C=DK/ST=Syddanmark/L=Odense/O=Syddansk Universitet/OU=RIO/CN=JV conseil/emailAddress=contact@jv-conseil.net"

  # unalias cp &>>logfile.log
  # _password="$(openssl rand -base64 15)"
  # _server_key="server.key"

  # openssl genrsa -aes128 2048 >"${UCLD_DB_PATH}/server.key"
  # openssl rsa -in "${UCLD_DB_PATH}/server.key" -out "${UCLD_DB_PATH}/server.key"
  # chown ucloud "${UCLD_DB_PATH}/server.key"
  # openssl req -new -x509 -days 365 -key "${UCLD_DB_PATH}/server.key" -out "${UCLD_DB_PATH}/server.crt"
  # cp "${UCLD_DB_PATH}/server.crt" "${UCLD_DB_PATH}/root.crt"

  # create an ssl certificate key
  openssl genrsa -aes128 -passout pass:"${_password}" -out "${_server_key}" 2048 &>>logfile.log
  openssl rsa -in "${_server_key}" -passin pass:"${_password}" -out "${_server_key}" &>>logfile.log
  chown "${USER}" "${_server_key}"
  openssl req -new -x509 -days 365 -key "${_server_key}" -out "${_server_key/.key/.crt}" -subj "${_subject}" # &>>logfile.log
  cp_ "${_server_key/.key/.crt}" "${_server_key/server.key/root.crt}" &>>logfile.log
}

_ucld_::generate_ssl_certificate

_ucld_::pg_conf_ssl() {
  local _server_key _password
  _server_key="${UCLD_DB_PATH}/server.key"
  _password="$(_ucld_::key_gen)"

  cat <<EOF


Configure SSL on PostgreSQL
---------------------------

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  if [[ ! -d ${UCLD_DB_PATH} ]]; then
    _ucld_::exception "${UCLD_DB_PATH} database directory not found... exiting"
    return
  fi

  _ucld_::generate_ssl_certificate

  cat postgresql/postgresql.conf.txt
  cat <<EOF

nano "${UCLD_DB_PATH}/postgresql.conf"

EOF

  cat postgresql/pg_hba.conf.txt
  cat <<EOF

nano "${UCLD_DB_PATH}/pg_hba.conf"

EOF

}

_ucld_::create_env_file() {
  cat <<EOF

Creating an .env file...

EOF
  cat "incl/shebang.txt" >"${PATH_TO_ENV_FILE}"
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

export UCLD_PUBLIC_LINK=\"${UCLD_PUBLIC_LINK}\"
  " >>"${PATH_TO_ENV_FILE}"
}
