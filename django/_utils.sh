#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::dj_collectstatic() {
  if [[ "${DEBUG}" -gt 0 ]]; then
    return
  fi
  _ucld_::h2 "Collecting Static files"
  python manage.py collectstatic --no-input
  echo
}

_ucld_::dj_create_superuser() {
  local _password _user

  _user=${USER:-"ucloud"}
  _password=$(_ucld_::key_gen 32)

  if echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('${_user}', '${_user}', '${_password}');" | python manage.py shell; then

    cat <<EOF

Username: ${_user}
Password: ${_password}

You will be able to test superuser access to the admin panel by visiting
https://${UCLD_HOSTNAME}/admin

EOF
  fi
}

_ucld_::dj_debug() {
  local _host _array

  if [[ "${DEBUG}" -eq 0 ]]; then
    return
  fi

  _ucld_::debug

  if [[ "${DEBUG}" -gt 1 ]]; then

    ls -FGlAhp
    echo

    _ucld_::h2 "Curl commands to test your server"

    echo "# curl https://$(_ucld_::clean_app_hostname) --verbose"

    IFS=' ' read -ra _array <<<"${UCLD_ALLOWED_HOSTS}"
    for _host in "${_array[@]}"; do
      echo "# curl https://${_host} --verbose"
    done

  fi

}

_ucld_::dj_install_dependencies() {
  _ucld_::h2 "Installing dependencies"
  sudo python3 -m pip install --upgrade pip
  # sudo pip3 install -r requirements.txt
  sudo python3 -m pip install -r requirements.txt
  echo
}

_ucld_::dj_running_migrations() {
  _ucld_::h2 "Running migrations"
  python manage.py makemigrations
  python manage.py migrate
  echo
}

_ucld_::dj_run_command() {
  python manage.py help
  read -e -r -p "Type the command to run, e.g.: xloader " -n 25
  if [[ "${REPLY}" =~ ^[a-z_]{4,25}$ ]]; then
    python manage.py "${REPLY}"
  else
    _ucld_::alert "${REPLY} does not seem like a valid Django command"
  fi
}

# TODO: NOT WORKING
# _ucld_::is_django_connected_to_postgresql() {
#   local _bool=false

#   # 2) Python W/ a connected PostgreSQL Server
#   if [ -x "$(command -v python)" ]; then
#     # if python "${UCLD_PATH[django]}/manage.py" dbshell --database default &>>logfile.log || :; then _bool=true; fi
#     if python manage.py dbshell --database default || :; then _bool=true; fi
#   fi

#   echo ${_bool}
# }
