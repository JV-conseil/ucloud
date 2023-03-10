#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck source=/dev/null
{
  . "incl/all.sh"
  . "github/_utils.sh"
  # more files
}

cat "github/README.txt"

. "github/_install.sh"
. "github/_auth.sh"
. "github/_clone.sh"
