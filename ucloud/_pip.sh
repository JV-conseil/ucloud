#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


echo
read -r -n 1 -p "Do you want to install dependencies? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    cat << EOF


Installing dependencies...

EOF

    cd "${UCLOUD_APP_DIR}" || exit

    pip install -r ./requirements.txt

    back_to_script_dir_

fi
