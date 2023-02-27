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
{
  . "incl/all.sh"
  . "postgresql/_ssl.sh"
}

cat "utilities/README.txt"

_ucld_::startup_check
_ucld_::install_packages

if "$(_ucld_::ask "Do you need to generate an SSH key")"; then
  _ucld_::generate_ssh_key
  echo
fi

if "$(_ucld_::ask "Do you want to generate a new self-signed certificate for the server")"; then
  _ucld_::generate_ssl_certificate
fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
  _ucld_::show_settings
  echo
else
  _ucld_::show_settings
  echo
fi
