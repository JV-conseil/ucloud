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

_ucld_::create_superuser() {
  cat <<EOF


Creating a superuser...

EOF
  local _username="ucloud"
  local _password
  _password=$(_ucld_::create_password 32)

  echo "Username: ${_username}"
  echo "Password: ${_password}"

  echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('${_username}', '${_username}', '${_password}');" | python manage.py shell && echo -e "\n\e[0;33mDone!\nYou will be able to test superuser access to the admin panel by visiting https://${UCLOUD_HOST}/admin/login/?next=/admin/\e[0;0m"
}

cat "README.txt"

if [[ "${DEBUG}" == 1 ]]; then
  bash --version
  python --version
  # print environment variables sorted by name
  # <https://stackoverflow.com/a/60756021/2477854>
  env -0 | sort -z | tr '\0' '\n'
else
  python manage.py collectstatic --no-input
fi

cd "${PWD%/*/*}" || exit

echo
read -r -N 1 -p "Do you want to install dependencies? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cat <<EOF


Installing dependencies...

EOF

  python3 -m pip install --upgrade pip
  pip install -r "./requirements.txt"

fi

echo
read -r -N 1 -p "Do you want to run migrations? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cat <<EOF


Running migrations...

EOF

  python manage.py makemigrations
  python manage.py migrate

  _ucld_::create_superuser
else
  python manage.py runserver
fi
