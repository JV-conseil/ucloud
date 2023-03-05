#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

if "$(_ucld_::is_linux)"; then
  # shellcheck disable=SC2034
  BP_PIPESTATUS=("${PIPESTATUS[@]}")
  _PRESERVED_PROMPT_COMMAND=""
fi
