#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC2034
# declare -x SECRET_KEY UCLD_HOSTNAME
declare -x UCLD_HOSTNAME

UCLD_HOSTNAME="$(_ucld_::clean_app_hostname)"

# SECRET_KEY="$(_ucld_::key_gen 32)"
