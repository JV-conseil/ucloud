#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::generate_key() {
  __size=${1:-15}

  python --version
  if [[ $? == 2 ]]; then
    openssl rand -base64 "$__size"
  else
    python -c "import secrets; result = ''.join(secrets.choice('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-+') for i in range($__size)); print(result)"
  fi

}

_ucld_::parent_directory() {
  # https://stackoverflow.com/a/24112741/2477854
  echo "$(
    cd_ "$(dirname "${BASH_SOURCE[0]}")" || exit
    pwd -P
  )"
}
