#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
set -eu -o pipefail
shopt -s failglob

# shellcheck disable=SC1091
{
  . "incl/all.sh"
  . "github/_utils.sh"
  # more files
}

cat "github/README.txt"

# shellcheck disable=SC1091
{
  . "github/_install.sh"
  . "github/_auth.sh"
  . "github/_clone.sh"
}
