#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

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
    "DROP DATABASE IF EXISTS ${DBNAME} ;"
    "DROP USER ${DBUSER} ;"
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

_ucld_::pg_update_superuser_password() {
  __psql_commands=(
    "ALTER ROLE ucloud WITH PASSWORD '${DBPASS}' ;"
  )

  for __cmd in "${__psql_commands[@]}"; do
    echo "${__cmd}"
    psql --dbname=postgres --command="${__cmd}"
  done
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

export DEBUG=1

export DBHOST=\"${DBHOST}\"
export DBNAME=\"${DBNAME}\"
export DBPASS=\"${DBPASS}\"
export DBPORT=\"${DBPORT}\"
export DBUSER=\"${DBUSER}\"

export SECRET_KEY=\"$(openssl rand -base64 32)\"

export UCLOUD_ALLOWED_HOST=\"${UCLOUD_ALLOWED_HOST}\"
" >"${PATH_TO_ENV}"
}

_ucld_::create_pgpass_file() {
  cat <<<"#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# hostname:port:database:username:password
0.0.0.0:5432:postgres:ucloud:${DBPASS}" >"${PATH_TO_PGPASS}"
}
