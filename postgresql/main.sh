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
  . "incl/all.sh"
  . "postgresql/_pg_globals.sh"
  . "postgresql/_utils.sh"
  . "postgresql/_create.sh"
  . "postgresql/_ssl.sh"
  # more files
}

_ucld_::debug

cat "postgresql/README.txt"

if [[ "$(_ucld_::is_postgresql_server_running)" == true ]]; then

  if "$(_ucld_::ask_2 "Do you want to create a new User & Database")"; then
    _ucld_::pg_create_db
    _ucld_::pg_update_su_password
    _ucld_::dump_env_file
    echo
  fi

  if "$(_ucld_::ask_2 "Do you want to configure SSL on PostgreSQL")"; then
    _ucld_::pg_conf_ssl
    echo
  else

    if "$(_ucld_::ask_2 "Do you want to generate a new self-signed certificate for the server")"; then
      _ucld_::generate_ssl_certificate
      echo
    fi

    if "$(_ucld_::ask_2 "Do you want to update the server parameters")"; then
      _ucld_::pg_alter_system
      _ucld_::pg_hba_udpate
      psql --host=localhost --command="\du+ ;"
    fi

  fi

  _ucld_::pg_list

else
  _ucld_::exception postgresql
fi
