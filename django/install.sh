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
  . "${PWD%/*}/env/.env"
  . "incl/main.sh"
  . "django/_utils.sh"
  # more files
}

cat "django/README.txt"

printf "Please select a valid Django repository:\n"
select _dj_repo in $(dirname "${PATH_TO_WORK_DIR}"/*/manage.py); do
  test -n "${_dj_repo}" && break
  echo ">>> Invalid Selection"
done

if [[ -d "${_dj_repo}" ]]; then

  cd_ "$_dj_repo" && pwd

  if [[ "${DEBUG}" == 1 ]]; then
    _ucld_::dj_debug
  else

    echo
    read -r -N 1 -p "Do you want to collectstatic? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      python manage.py collectstatic --no-input
    fi

  fi

  echo
  read -r -N 1 -p "Do you want to install dependencies? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::dj_install_dependencies
  fi

  echo
  read -r -N 1 -p "Do you want to run migrations? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::dj_running_migrations
    _ucld_::dj_create_superuser
  else
    python manage.py runserver
  fi

  _ucld_::back_to_script_dir_
fi
