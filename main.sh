#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# shellcheck source=/dev/null
#
#====================================================

# shellcheck disable=SC1091
. "incl/all.sh"

_ucld_::debug

cat "README.txt"

_ucld_::startup_check

_ucld_::install_packages

# echo
# read -r -n 1 -p "Do you want to manage GitHub? [y/N] "
# if [[ $REPLY =~ ^[Yy]$ ]]; then
if "$(_ucld_::ask "Do you want to manage GitHub")"; then
  . github/main.sh
fi

if [[ "$(_ucld_::is_postgresql_running)" == true ]]; then

  # echo
  # read -r -n 1 -p "Do you want to manage PostreSQL? [y/N] "
  # if [[ $REPLY =~ ^[Yy]$ ]]; then
  if "$(_ucld_::ask "Do you want to manage PostreSQL")"; then
    . postgresql/main.sh
  fi

fi

if [[ "$(_ucld_::is_python_installed)" == true ]]; then

  # echo
  # read -r -n 1 -p "Do you want to manage Django? [y/N] "
  # if [[ $REPLY =~ ^[Yy]$ ]]; then

  if "$(_ucld_::ask "Do you want to manage Django")"; then
    . django/main.sh
  fi

  # echo
  # read -r -n 1 -p "Do you want to run a Python app? [y/N] "
  # if [[ $REPLY =~ ^[Yy]$ ]]; then
  if "$(_ucld_::ask "Do you want to run your Python app")"; then
    . app/main.sh
  fi

fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
fi
