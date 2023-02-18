#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::delete() {
  echo
  read -r -n 1 -p "All files and folder except 'data' & 'ucloud' will be _ucld_::deleted, do you confirm? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "${PATH_TO_WORK_DIR}" || exit

    find . -not -path "*ucloud*" -and -not -path "*data*" -and -not -path . -type d -exec rm -rf {} +

    ls "${PATH_TO_WORK_DIR}"

    _ucld_::back_to_script_dir_
  fi
}

alias delete="_ucld_::delete"

echo
read -r -n 1 -p "Do you want to delete imported files? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then

  _ucld_::delete

  gh auth logout

  _ucld_::back_to_script_dir_

fi
