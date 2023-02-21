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
  . "incl/all.sh"
  . "github/_api.sh"
  # more files
}

cat "github/README.txt"

. "github/_install.sh"
# . "github/_delete.sh"
