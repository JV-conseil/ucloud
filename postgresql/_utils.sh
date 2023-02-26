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

_ucld_::pg_list() {
  psql --dbname=postgres --command="\du+"
  psql --dbname=postgres --command="\l+"
  psql --dbname=postgres --host=localhost
}
