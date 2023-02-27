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

if "$(_ucld_::ask "Do you want to manage GitHub")"; then
  . github/main.sh
  echo
fi

if [[ "$(_ucld_::is_postgresql_running)" == true ]]; then

  if "$(_ucld_::ask "Do you want to manage PostreSQL")"; then
    . postgresql/main.sh
    echo
  fi

fi

if [[ "$(_ucld_::is_python_installed)" == true ]]; then

  if "$(_ucld_::ask "Do you want to manage Django")"; then
    . django/main.sh
    echo
  fi

  if "$(_ucld_::ask "Do you want to run your Python app")"; then
    . app/main.sh
    echo
  fi

fi

if "$(_ucld_::ask "Do you need to generate an SSH key")"; then
  _ucld_::generate_ssh_key
  echo
fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
  echo
else
  _ucld_::show_settings
  echo
fi
