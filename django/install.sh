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
  . "${PWD%/*/*/*}/env/.env"
  . "./_utils.sh"
  # more files
}

cat "README.txt"

if [[ "${DEBUG}" == 1 ]]; then
  _ucld_::debug
else
  python manage.py collectstatic --no-input
fi

cd "${PWD%/*/*}" || exit

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
