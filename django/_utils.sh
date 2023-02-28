#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::dj_debug() {
  local _host _array

  if [[ "${DEBUG}" -eq 0 ]]; then
    return 0
  fi

  _ucld_::debug

  if [[ "${DEBUG}" -gt 1 ]]; then

    ls -FGlAhp
    echo

    if [[ -v "${UCLD_ALLOWED_HOSTS}" ]]; then
      _ucld_::h2 "Curl commands to test your server"
      IFS=' ' read -ra _array <<<"${UCLD_ALLOWED_HOSTS}"
      for _host in "${_array[@]}"; do
        echo "# curl https://${_host} --verbose"
      done
    fi

  fi

}

_ucld_::dj_collectstatic() {
  if [[ "${DEBUG}" -gt 0 ]]; then
    _ucld_::dj_debug
  else
    python manage.py collectstatic --no-input
  fi
}

_ucld_::dj_install_dependencies() {
  _ucld_::h2 "Installing dependencies"
  python3 -m pip install --upgrade pip
  pip3 install -r requirements.txt
  echo
}

_ucld_::dj_create_superuser() {
  local _password
  _password=$(_ucld_::key_gen 32)

  echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('${USER}', '${USER}', '${_password}');" | python manage.py shell

  cat <<EOF

Username: ${USER}
Password: ${_password}

You will be able to test superuser access to the admin panel by visiting
https://${UCLD_PUBLIC_LINKS[0]}/admin

EOF
}

_ucld_::dj_running_migrations() {
  _ucld_::h2 "Running migrations"
  python manage.py makemigrations
  python manage.py migrate
  echo
}

_ucld_::is_connected_database() {
  local _bool=false
  if python manage.py check --database default &>>logfile.log; then _bool=true; fi
  echo ${_bool}
}
