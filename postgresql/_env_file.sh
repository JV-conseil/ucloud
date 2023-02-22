#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::create_env_file() {
  cat <<EOF

Creating an .env file...

EOF
  cat "incl/shebang.txt" >"${PG_PATH_TO_ENV_FILE}"
  cat <<<"
export DEBUG=${DEBUG}

export DBHOST=\"${DBHOST}\"
export DBNAME=\"${DBNAME}\"
export DBPASS=\"${DBPASS}\"
export DBPORT=\"${DBPORT}\"
export DBSSLMODE=\"${DBSSLMODE}\"
export DBUSER=\"${DBUSER}\"

export PGSSLMODE=\"${DBSSLMODE}\"
export PGPASSFILE=\"${PG_PATH_TO_PGPASS}\"

export SECRET_KEY=\"$(_ucld_::key_gen 16)\"

export UCLD_PUBLIC_LINK=\"${UCLD_PUBLIC_LINK}\"
  " >>"${PG_PATH_TO_ENV_FILE}"
}
