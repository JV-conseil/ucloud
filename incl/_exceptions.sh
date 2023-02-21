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
  local _error _code
  _error=${1:-"Oops something went wrong..."}
  declare -i _code=${2:-1}

  case ${_error} in

  psql | postgresql)
    _error="a connected job with a PostgreSQL server running was not found. You should quit this run and start a new one with a running PostgreSQL server connected job identified by the hostname: ${UCLOUD_DB_HOSTNAME}"
    ;;

  PATTERN_N)
    STATEMENTS
    ;;

  *) ;;
  esac

  echo "ERROR: ${_error}"
  # printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_error}" >>logfile.log
  echo "${_error}" >>logfile.log
  exit "${_code}"
}

# _ucld_::exception "$@"
