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
  . "postgresql/_utils.sh"
  . "postgresql/_env_file.sh"
  . "postgresql/_ssl.sh"
  # more files
}

cat "postgresql/README.txt"

if [[ "$(_ucld_::is_postgresql_running)" == true ]]; then

  echo
  read -r -n 1 -p "Do you want to create a new User & Database? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then

    _ucld_::pg_create_db
    _ucld_::pg_update_su_password
    _ucld_::create_env_file

  else
    _ucld_::pg_list
  fi

  echo
  read -r -n 1 -p "Do you want to configure SSL on PostgreSQL? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::pg_conf_ssl
  else
    _ucld_::pg_list
  fi

else
  _ucld_::exception psql
fi
