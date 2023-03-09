#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC2034
declare -a UCLD_PUBLIC_LINKS
declare -ix DEBUG=0
declare -x SECRET_KEY UCLD_ALLOWED_HOSTS UCLD_HOTSNAME

# shellcheck source=/dev/null
{
  . "/work/ucloud/incl/__colors.sh"
  . "/work/ucloud/incl/__debug.sh"
  . "/work/ucloud/incl/__utils.sh"
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

UCLD_HOTSNAME="$(_ucld_::clean_app_hostname)"

SECRET_KEY="$(_ucld_::key_gen 32)"

_ucld_::dj_collectstatic
_ucld_::dj_install_dependencies
python manage.py runserver
