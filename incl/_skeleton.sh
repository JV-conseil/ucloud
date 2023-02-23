#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# shellcheck disable=SC2034
#
#====================================================

for key in "${!UCLD_PATH[@]}"; do

  value="${UCLD_PATH["${key}"]}"

  # folder creation
  if [[ 
    ! -d "${value}" &&
    "$(_ucld_::is_ucloud_execution)" == true &&
    "$(_ucld_::is_ubuntu_job)" == true ]]; then
    mkdir "${value}"
  fi

done
