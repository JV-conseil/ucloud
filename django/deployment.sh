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
  . "/work/env/.env"
  # more files
}

if [[ "${DEBUG}" == 1 ]]; then
  bash --version
  python --version

  # print environment variables sorted by name
  # <https://stackoverflow.com/a/60756021/2477854>
  env -0 | sort -z | tr '\0' '\n'

  echo
  ls -FGlAhp
  echo
else
  python manage.py collectstatic --no-input
fi

python3 -m pip install --upgrade pip
pip install -r "./requirements.txt"

python manage.py runserver
