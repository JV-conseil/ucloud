#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck source=/dev/null
{
  . "incl/all.sh"
  # more files
}

_ucld_::unofficial_bash_strict_mode "on"

_ucld_::debug

cat "README.txt"

_ucld_::startup_check
_ucld_::install_packages

if "$(_ucld_::ask "Do you want to manage GitHub")"; then
  # shellcheck source=/dev/null
  . "github/main.sh"
  echo
fi

if "$(_ucld_::is_postgresql_server_running)"; then

  if "$(_ucld_::ask "Do you want to manage PostreSQL")"; then
    # shellcheck source=/dev/null
    . "postgresql/main.sh"
    echo
  fi

fi

if "$(_ucld_::is_python_installed)"; then

  if "$(_ucld_::ask "Do you want to manage Django")"; then
    # shellcheck source=/dev/null
    . "django/main.sh"
    echo
  fi

  if "$(_ucld_::ask "Do you want to run your Python app")"; then
    # shellcheck source=/dev/null
    . "app/main.sh"
    echo
  fi

fi

if "$(_ucld_::ask "Do you need to generate an SSH key")"; then
  _ucld_::generate_ssh_key
  echo
fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
  _ucld_::show_settings
else
  _ucld_::show_settings
fi

_ucld_::unofficial_bash_strict_mode "off"
