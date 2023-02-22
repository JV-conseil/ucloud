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
  _server_key="${PG_PATH_TO_DB}/server.key"
  _password="$(_ucld_::key_gen)"
  _subject="/C=DK/ST=Syddanmark/L=Odense/O=Syddansk Universitet/OU=RIO/CN=JV conseil/emailAddress=contact@jv-conseil.net"

  # unalias cp &>>logfile.log
  # _password="$(openssl rand -base64 15)"
  # _server_key="server.key"

  # openssl genrsa -aes128 2048 >"${PG_PATH_TO_DB}/server.key"
  # openssl rsa -in "${PG_PATH_TO_DB}/server.key" -out "${PG_PATH_TO_DB}/server.key"
  # chown ucloud "${PG_PATH_TO_DB}/server.key"
  # openssl req -new -x509 -days 365 -key "${PG_PATH_TO_DB}/server.key" -out "${PG_PATH_TO_DB}/server.crt"
  # cp "${PG_PATH_TO_DB}/server.crt" "${PG_PATH_TO_DB}/root.crt"

  # create an ssl certificate key
  openssl genrsa -aes128 -passout pass:"${_password}" -out "${_server_key}" 2048 &>>logfile.log
  openssl rsa -in "${_server_key}" -passin pass:"${_password}" -out "${_server_key}" &>>logfile.log
  chown "${USER}" "${_server_key}"
  openssl req -new -x509 -days 365 -key "${_server_key}" -out "${_server_key/.key/.crt}" -subj "${_subject}" # &>>logfile.log
  cp_ "${_server_key/.key/.crt}" "${_server_key/server.key/root.crt}" &>>logfile.log
}

_ucld_::pg_conf_ssl() {
  local _server_key _password
  _server_key="${PG_PATH_TO_DB}/server.key"
  _password="$(_ucld_::key_gen)"

  cat <<EOF


Configure SSL on PostgreSQL
---------------------------

- How to Configure SSL on PostgreSQL: https://www.cherryservers.com/blog/how-to-configure-ssl-on-postgresql
- 19.9. Secure TCP/IP Connections with SSL: https://www.postgresql.org/docs/14/ssl-tcp.html

EOF

  if [[ ! -d ${PG_PATH_TO_DB} ]]; then
    _ucld_::exception "${PG_PATH_TO_DB} database directory not found... exiting"
    return
  fi

  _ucld_::generate_ssl_certificate

  cat postgresql/postgresql.conf.txt
  cat <<EOF

$ nano "${PG_PATH_TO_DB}/postgresql.conf"

EOF

  cat postgresql/pg_hba.conf.txt
  cat <<EOF

$ nano "${PG_PATH_TO_DB}/pg_hba.conf"

EOF

}
