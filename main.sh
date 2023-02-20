#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# shellcheck source=/dev/null
#
#====================================================

export DEBUG=0

export UCLOUD_PUBLIC_LINK="app-githubbing.cloud.sdu.dk"
export UCLOUD_DB_HOSTNAME="postgres.database.ucloud.sdu.dk"

export PATH_TO_SCRIPT_DIR="${PWD}"
export PATH_TO_WORK_DIR="${PATH_TO_SCRIPT_DIR%/*}"

export PATH_TO_DATA_DIR="${PATH_TO_WORK_DIR}/data"
export PATH_TO_INSTALL_DIR="${PATH_TO_WORK_DIR}/install"
export PATH_TO_ENV="${PATH_TO_WORK_DIR}/env/.env"
export PATH_TO_PGPASS="${PATH_TO_WORK_DIR}/env/.pgpass"

export PATH_TO_DB="/work/database"

export DBHOST="${UCLOUD_DB_HOSTNAME}"
export DBNAME="demo"
export DBPORT="5432"
export DBUSER="manager"
export DBSSLMODE="require"

# shellcheck disable=SC1091
{
  . "incl/main.sh"
  # more files
}

cat <<EOF

======================
 UCloud initiate apps
======================


The missing repo to start initiate apps on UCloud...

- Start GitHubbing: authenticate, clone, pull your repos.
- PostreSQL: install database and users, activate SSL.
- Django: deployment scripts.


author:
JV-conseil


version:
2023-02-17

EOF

echo
read -r -n 1 -p "Do you want to configure GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . github/main.sh
fi

echo
read -r -n 1 -p "Do you want to configure PostreSQL? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . postgresql/main.sh
fi

echo
read -r -n 1 -p "Do you want to configure Django? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . github/main.sh
fi
