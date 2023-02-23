#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::generate_ssl_certificate() {
  local _password _server_key _subject
  _server_key="${UCLD_PG_PATH[database]}/server.key"
  _password="$(_ucld_::key_gen)"
  _subject="/C=FR/ST=IDF/L=/O=JV conseil - Internet Consulting/OU=/CN=JV conseil/emailAddress=contact@jv-conseil.net"

  # unalias cp &>>logfile.log
  # _password="$(openssl rand -base64 15)"
  # _server_key="server.key"

  # create an ssl certificate key
  openssl genrsa -aes128 -passout pass:"${_password}" -out "${_server_key}" 2048 &>>logfile.log
  openssl rsa -in "${_server_key}" -passin pass:"${_password}" -out "${_server_key}" &>>logfile.log
  chown ucloud "${_server_key}"
  openssl req -new -x509 -days 365 -key "${_server_key}" -out "${_server_key/.key/.crt}" -subj "${_subject}" 2>>logfile.log
  cp "${_server_key/.key/.crt}" "${_server_key/server.key/root.crt}" &>>logfile.log
  cat "${_server_key}" >"${_server_key/.key/.crt.pem}"
  cat "${_server_key/.key/.crt}" >>"${_server_key/.key/.crt.pem}"
}

# <https://www.postgresql.org/docs/current/sql-altersystem.html>
_ucld_::pg_alter_system() {
  local _psql_commands
  _psql_commands=(
    "ALTER SYSTEM SET ssl = on ;"
    "ALTER SYSTEM SET ssl_ca_file = 'root.crt' ;"
    "ALTER SYSTEM SET ssl_cert_file = 'server.crt' ;"
    "ALTER SYSTEM SET ssl_crl_file = '' ;"
    "ALTER SYSTEM SET ssl_key_file = 'server.key' ;"
    "ALTER SYSTEM SET ssl_ciphers = 'HIGH:MEDIUM:+3DES:!aNULL' ;"
    "ALTER SYSTEM SET ssl_prefer_server_ciphers = on ;"
  )

  for _cmd in "${_psql_commands[@]}"; do
    echo "${_cmd}"
    psql --dbname=postgres --command="${_cmd}"
  done
}

_ucld_::pg_conf_ssl() {
  local _server_key _password
  _server_key="${UCLD_PG_PATH[database]}/server.key"
  _password="$(_ucld_::key_gen)"

  cat <<EOF


Configure SSL on PostgreSQL
---------------------------

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  if [[ ! -d ${UCLD_PG_PATH[database]} ]]; then
    _ucld_::exception "${UCLD_PG_PATH[database]} database directory not found... exiting"
    return
  fi

  _ucld_::generate_ssl_certificate
  _ucld_::pg_alter_system

  cp "${UCLD_PG_PATH[database]}/pg_hba.conf" "${UCLD_PG_PATH[database]}/pg_hba.conf.bkp" &>>logfile.log
  cat postgresql/pg_hba.conf.txt >"${UCLD_PG_PATH[database]}/pg_hba.conf"
  psql --dbname=postgres --command="SELECT pg_reload_conf() ;"

  # shellcheck disable=SC1090
  . "${UCLD_PG_PATH[.env]}"
  psql --host=localhost

}
