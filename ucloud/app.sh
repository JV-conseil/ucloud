#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


run_app () {
    cd "${UCLOUD_APP_DIR}" || exit

    python3 main.py

    ls "${UCLOUD_DATA_DIR}/output"

    back_to_script_dir_
}


echo
read -r -n 1 -p "Do you want to run the app? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    cat << EOF


Running the App...

EOF

    run_app

fi
