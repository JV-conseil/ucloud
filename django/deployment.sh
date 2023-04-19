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
declare -x UCLD_ALLOWED_HOSTS UCLD_HOSTNAME

# shellcheck source=/dev/null
{
  . "/work/ucloud/incl/__set.sh"
  . "/work/ucloud/incl/__colors.sh"
  . "/work/ucloud/incl/__debug.sh"
  . "/work/ucloud/incl/__utils.sh"
  . "/work/ucloud/django/_utils.sh"
  # env/ customization
  . "/work/env/.env" || :
  . "/work/ucloud/settings.conf"
  . "/work/env/settings.conf" 2>>/work/ucloud/logfile.log || :
  # more files
}

UCLD_ALLOWED_HOSTS="$(
  IFS=$' '
  echo "${UCLD_PUBLIC_LINKS[*]}"
)"

UCLD_HOSTNAME="$(_ucld_::clean_app_hostname)"

_ucld_::dj_debug
_ucld_::dj_install_dependencies
_ucld_::dj_collectstatic

sudo python manage.py check --deploy 2>&1 | tee -a /work/ucloud/logfile.log
# python manage.py runserver 2>>/work/ucloud/logfile.log
sudo python manage.py runserver 2>&1 | tee -a /work/ucloud/logfile.log
