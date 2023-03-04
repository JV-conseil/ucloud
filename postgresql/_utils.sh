#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::is_postgresql_server_running() {
  local _bool=false
  if [ -x "$(command -v pg_ctl)" ]; then
    if pg_ctl status -D "${UCLD_PATH[database]}" 2>>logfile.log; then _bool=true; fi
  fi
  echo ${_bool}
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\du+"
  psql --dbname=postgres --command="\l+"

  _ucld_::h3 "Checking SSL connection to postgres database"
  echo "To quit type \q"
  echo
  psql --dbname=postgres --host=localhost
}

_ucld_::start_postgresql_server() {
  pg_ctl -D "${UCLD_PATH[database]}" -l logfile start 2>>logfile.log
}
