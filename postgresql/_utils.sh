#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::is_postgresql_app_running() {
  if [ -x "$(command -v pg_ctl)" ]; then
    if pg_ctl status -D "${UCLD_PATH[database]}" &>/dev/null; then
      true
    else
      false
    fi
  else
    false
  fi
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\du+"
  psql --dbname=postgres --command="\l+"

  _ucld_::h3 "Checking SSL connection to postgres database"
  echo "... to quit and go back to Terminal type \q"
  echo
  psql --dbname=postgres --host=localhost
}

_ucld_::start_postgresql_server() {
  pg_ctl -D "${UCLD_PATH[database]}" -l logfile start 2>>logfile.log
}

# DEPECATED

# _ucld_::is_postgresql_server_running() {
#   local _bool=false

#   # 1) PostgreSQL Server app running
#   if [ -x "$(command -v pg_ctl)" ]; then
#     if pg_ctl status -D "${UCLD_PATH[database]}" &>/dev/null; then _bool=true; fi

#   # 2) Terminal Unbuntu W/ a connected PostgreSQL Server
#   elif [ -x "$(command -v python)" ]; then
#     if python "${UCLD_PATH[django]}/manage.py" dbshell --database default &>/dev/null || :; then _bool=true; fi

#   # 3) Django app running
#   elif [[ -x "$(command -v python)" && -x "$(command -v psql)" ]]; then
#     _bool=true
#   fi

#   echo ${_bool}
# }
