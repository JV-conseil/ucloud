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
. "incl/utils.sh"

cat "app/README.txt"

cat <<EOF

Please select a repo with a Python app...

EOF

select _app_repo in $(dirname "${UCLD_PATH[work]}"/*/main.py); do
  test -n "${_app_repo}" && break
  echo ">>> Invalid Selection"
done

if [[ -f "${_app_repo}/main.py" ]]; then

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

  ls "${UCLD_PATH[data]}/output"

else
  # echo "Error: main.py not found in ${_app_repo}... exiting" >&2
  _ucld_::exception "main.py not found in ${_app_repo}... exiting"

fi
