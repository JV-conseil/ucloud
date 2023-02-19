#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

export PATH_TO_APP_DIR="${PWD%/*/*}"

_ucld_::dependencies() {
  pip install -r "${PATH_TO_APP_DIR}/requirements.txt"
}

_ucld_::run_app() {
  python3 "${PATH_TO_APP_DIR}/main.py"
  ls "${PATH_TO_DATA_DIR}/output"
}

alias run_app="_ucld_::run_app"

cat "README.txt"

echo
read -r -n 1 -p "Do you want to install dependencies? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then

  cat <<EOF


Installing dependencies...

EOF

  _ucld_::dependencies

fi

echo
read -r -n 1 -p "Do you want to run the app? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then

  cat <<EOF


Running the App...

EOF

  _ucld_::run_app

fi
