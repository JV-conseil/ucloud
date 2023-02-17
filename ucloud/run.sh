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
    . "./_env"
    . "./_utils.sh"
    # more files
}


cat "README.txt"


. "./_install.sh"
. "./_github.sh"
. "./_postgresql.sh"
. "./_pip.sh"
. "./app.sh"
. "./_erase.sh"
