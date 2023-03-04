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

# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
# set -euf -o pipefail
set +euf -o pipefail

# shellcheck disable=SC1091
{
  . "incl/all.sh"
  . "postgresql/_ssl.sh"
}

_ucld_::debug

cat "utilities/README.txt"

_ucld_::startup_check
_ucld_::install_packages

if "$(_ucld_::ask "Do you need to generate an SSH key")"; then
  _ucld_::generate_ssh_key
  echo
fi

if "$(_ucld_::ask "Do you want to generate a new self-signed certificate for the server")"; then
  _ucld_::generate_ssl_certificate
  echo
fi

if "$(_ucld_::ask "Do you want to reset your settings")"; then
  _ucld_::reset_settings
  _ucld_::show_settings
  echo
elif "$(_ucld_::ask "Do you want to edit your settings")"; then
  _ucld_::edit_settings
else
  _ucld_::show_settings
  echo
fi

if "$(_ucld_::ask "Do you want to check the logs")"; then
  cat logfile.log
  echo
fi

if "$(_ucld_::ask "Do you want to erase everything" magenta)"; then
  if "$(_ucld_::ask "ARE YOU ABSOLUTELY SURE" red)"; then

    read -e -r -p "To confirm type ERASE ALL "
    if [[ "${REPLY}" == "ERASE ALL" ]]; then
      rm -v "${UCLD_PATH["work"]}/"*
    fi

  fi
fi
