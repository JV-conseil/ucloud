#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::exception() {
  local _error
  _error=${1:-"Oops something went wrong..."}

  case ${_error} in

  psql | postgresql)
    _error="a connected job with a PostgreSQL server running was not found. You should quit this run and start a new one with a running PostgreSQL server connected job identified by the hostname: ${UCLD_DB_PARAM[host]}"
    ;;

  PATTERN_N)
    STATEMENTS
    ;;

  *) ;;
  esac

  echo ""
  # printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_error}" >>logfile.log
  echo "${_error}" >>logfile.log
  cat <<EOF


ERROR: ${_error}

EOF
}

# _ucld_::exception "$@"
