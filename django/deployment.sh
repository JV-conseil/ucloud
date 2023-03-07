#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck source=/dev/null
{
  . "/work/env/.env"
  . "/work/ucloud/incl/__colors.sh"
  . "/work/ucloud/incl/__debug.sh"
  . "/work/ucloud/incl/__utils.sh"
  . "/work/ucloud/django/_utils.sh"
  # more files
}

sudo apt install -y python3.11.2 || :
_ucld_::dj_collectstatic
_ucld_::dj_install_dependencies
_ucld_::dj_runserver
