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

_ucld_::key_gen() {
  # e.g.: $(_ucld_::key_gen 15)
  local _size=${1:-15}
  openssl rand -base64 "${_size}"
}

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
    "DROP DATABASE IF EXISTS ${DB_NAME} ;"
    "DROP USER ${DB_USER} ;"
    "CREATE USER ${DB_USER} WITH PASSWORD '${DBPASS}' ;"
    "CREATE DATABASE ${DB_NAME} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER} ;"
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

  cat "../incl/shebang.txt" >"${PATH_TO_PGPASS}"
  echo "0.0.0.0:5432:postgres:ucloud:${_su_pass}" >>"${PATH_TO_PGPASS}"
}

_ucld_::pg_conf_ssl() {
  cat <<EOF


=============================
 Configure SSL on PostgreSQL
=============================

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  cd "${PATH_TO_DB}" || exit

  openssl genrsa -aes128 2048 >server.key
  openssl rsa -in server.key -out server.key
  chown ucloud server.key
  openssl req -new -x509 -days 365 -key server.key -out server.crt

  cat <<EOF


======================
 edit postgresql.conf
======================

listen_addresses = '*'

# In the SSL section, uncomment the following parameters and set the values as shown.

ssl = on
ssl_ca_file = 'root.crt'
ssl_cert_file = 'server.crt'
ssl_crl_file = ''
ssl_key_file = 'server.key'
ssl_ciphers = 'HIGH:MEDIUM:+3DES:!aNULL' # allowed SSL ciphers
ssl_prefer_server_ciphers = on

EOF
  nano "postgresql.conf" || return

  cat <<EOF


==================
 edit pg_hba.conf
==================

host    ${DB_NAME}         all          0.0.0.0/0    md5
hostssl ${DB_NAME}         all          0.0.0.0/0    md5

EOF
  nano "pg_hba.conf" || return

  _ucld_::back_to_script_dir_
}

_ucld_::create_env_file() {
  cat <<EOF

Creating an .env file...

EOF
  cat "../incl/shebang.txt" >"${PATH_TO_ENV}"
  cat <<<"
  export DEBUG=1

  export DB_HOST=\"${DB_HOST}\"
  export DB_NAME=\"${DB_NAME}\"
  export DBPASS=\"${DBPASS}\"
  export DB_PORT=\"${DB_PORT}\"
  export DBSSLMODE=\"require\"
  export DB_USER=\"${DB_USER}\"

  export PGSSLMODE=\"${DBSSLMODE}\"

  export SECRET_KEY=\"$(_ucld_::key_gen 32)\"

  export UCLOUD_PUBLIC_LINK=\"${UCLOUD_PUBLIC_LINK}\"
  " >>"${PATH_TO_ENV}"
}
