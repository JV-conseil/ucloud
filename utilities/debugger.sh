#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# Usage:
# DEBUGGER=1 TRACE=1 BASH_ENV=utilities/debugger.sh ./main.sh
# bashdb ./main.sh
#
#====================================================

# shellcheck source=/dev/null
{
  . "incl/__debug.sh"
  # more files
}

_ucld_::debugger
