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
  . "../common/.bashrc"
  . "../common/utils.sh"
  . "./.env"
  . "./_utils.sh"
  # more files
}

_ucld_::start() {
  _ucld_::back_to_script_dir_
  # shellcheck disable=SC1091
  . run.sh
}

alias start="_ucld_::start"

cat "README.txt"

. "./_install.sh"
. "./_github.sh"
. "./_delete.sh"
