#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC2034
declare -a UCLD_PUBLIC_LINKS
declare -ix DEBUG=0
declare -x UCLD_ALLOWED_HOSTS

# shellcheck source=/dev/null
{
  . "/work/ucloud/incl/__colors.sh"
  . "/work/ucloud/incl/__debug.sh"
  . "/work/ucloud/incl/__utils.sh"
  . "/work/ucloud/django/_env.sh"
  . "/work/ucloud/django/_utils.sh"
  # env/ customization
  . "/work/env/.env"
  . "/work/ucloud/settings.conf"
  . "/work/env/settings.conf" 2>>logfile.log || :
  # more files
}

UCLD_ALLOWED_HOSTS="$(
  IFS=$' '
  echo "${UCLD_PUBLIC_LINKS[*]}"
)"

_ucld_::dj_debug
_ucld_::dj_install_dependencies
_ucld_::dj_collectstatic
python manage.py runserver
