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
. "incl/all.sh"

cat "app/README.txt"

cat <<EOF

Please select a repo with a Python app...

EOF

select _app_repo in $(dirname "${PATH_TO_WORK_DIR}"/*/manage.py); do
  test -n "${_app_repo}" && break
  echo ">>> Invalid Selection"
done

if [[ -d "${_app_repo}" ]]; then

  cat <<EOF


Installing dependencies...

EOF

  pip install -r "${_app_repo}/requirements.txt"

  cat <<EOF


Running the app...

EOF

  python3 "${_app_repo}/main.py"

  cat <<EOF


Displaying the output folder...

EOF

  ls "${PATH_TO_DATA_DIR}/output"

fi
