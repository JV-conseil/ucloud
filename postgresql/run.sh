#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

export DBHOST="0.0.0.0"
export DBNAME="welcome"
DBPASS="$(openssl rand -base64 32)"
export DBPASS
export DBPORT="5432"
export DBUSER="manager"

export PATH_TO_DATABASE="/work/database"
export PATH_TO_ENV="${PWD%/*/*}/.env"

_ucld_::pg_start() {
  pg_ctl -D "${PATH_TO_DATABASE}"
}

_ucld_::pg_list() {
  psql --dbname=postgres --command="\l+"
  psql postgres
}

_ucld_::pg_create_db() {
  _ucld_::pg_start

  __psql_commands=(
    # "DROP DATABASE IF EXISTS ${DBNAME} ;"
    # "DROP USER IF EXISTS ${DBUSER} ;"
    "CREATE USER ${DBUSER} WITH PASSWORD '${DBPASS}' ;"
    "CREATE DATABASE ${DBNAME} ;"
    "GRANT ALL PRIVILEGES ON DATABASE ${DBNAME} TO ${DBUSER} ;"
  )

  for __cmd in "${__psql_commands[@]}"; do
    echo "${__cmd}"
    psql --dbname=postgres --command="${__cmd}"
  done

  psql --dbname=postgres --command="\du+"
  _ucld_::pg_list
}

_ucld_::create_env_file() {
  cat <<<"#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

export DBHOST=\"${DBHOST}\"
export DBNAME=\"${DBNAME}\"
export DBPASS=\"${DBPASS}\"
export DBPORT=\"${DBPORT}\"
export DBUSER=\"${DBUSER}\"
export DJANGO_DEBUG=\"True\"

# Django Syntax coloring
# <https://docs.djangoproject.com/en/3.1/ref/django-admin/#syntax-coloring>
export DJANGO_COLORS=\"dark;http_info=white\"" >"${PATH_TO_ENV}"
}

cat "README.txt"

echo
read -r -n 1 -p "Do you want to create a new User & Database ? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then

  _ucld_::create_env_file
  _ucld_::pg_create_db

else
  _ucld_::pg_list
fi
