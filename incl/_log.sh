#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::logfile() {
  local _logfile=./logfile.log

  # TODO

  # add timestamp & log stdout and stderr
  # exec > >(while read -r _line; do printf "%s %s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a ${_logfile}; done)
  # exec 2> >(while read -r _line; do printf "%s %s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a "${_logfile}"; done >&2)

  # Almost stable
  # exec 2>&1 | tee >(while read -r _line; do printf "%s %s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a "${_logfile}"; done >&2)

  # exec 2> >(while read -r _line; do printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a "${_logfile}"; done >&2)

  # exec 2> >(while read -r _line; do printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a "${_logfile}"; done >&2)

  # exec 3>&1 4>&2
  # trap 'exec 2>&4 1>&3' 0 1 2 3
  # exec 1>"${_logfile}" 2>&1

  # exec 3>&1 4>&2
  # trap 'exec 1>&3 2>&4' 0 1 2 3
  # exec 2> >(while read -r _line; do printf "\n%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" | tee -a "${_logfile}"; done >&2)

  # GOOD!
  # exec 2> >(while read -r _line; do printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" >>"${_logfile}"; done >&2)

  exec 2> >(while read -r _line; do printf "%s\t%s\n" "$(date "+%Y-%m-%d %H:%M:%S")" "${_line}" >>"${_logfile}"; done >&2)

  # exec 3>&1 4>&2
  # trap 'exec 2>&4 1>&3' 0 1 2 3
  # exec 2>"${_logfile}"
}

# _ucld_::logfile
