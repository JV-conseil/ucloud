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
set -euf -o pipefail

# shellcheck disable=SC1091
{
  . "incl/_log.sh"
  . "incl/_aliases.sh"
  . "incl/_colors.sh"
  . "incl/_utils.sh"
  . "incl/_path.sh"
  . "incl/_exceptions.sh"
  . "incl/_skeleton.sh"
  . "incl/_settings.sh"
  . "incl/_debug.sh"
  . "incl/_install.sh"
  . "incl/_ssh.sh"
  # more files
}
