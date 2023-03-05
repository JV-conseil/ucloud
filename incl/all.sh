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
  . "incl/_set.sh"
  . "incl/_aliases.sh"
  . "incl/_debug.sh"
  . "incl/_utils.sh"
  . "incl/_colors.sh"
  # below this line depends on ./settings.conf
  . "incl/_path.sh"
  . "incl/_exceptions.sh"
  . "incl/_skeleton.sh"
  . "incl/_settings.sh"
  . "incl/_install.sh"
  . "incl/_ssh.sh"
  # more files
}
