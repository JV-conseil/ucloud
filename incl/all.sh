#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC1091
{
  . "incl/_aliases.sh"
  . "incl/_env.sh"
  . "incl/_utils.sh"
  . "incl/_exceptions.sh"
  # more files
}

if [[ "${DEBUG}" -gt 0 ]]; then
  _ucld_::debug
fi
